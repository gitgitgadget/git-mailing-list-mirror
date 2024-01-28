Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68C33CF1
	for <git@vger.kernel.org>; Sun, 28 Jan 2024 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706472181; cv=none; b=pJhcINyyobnalkXg5xqMXjLK6cjGWakxHeSI4d6keSnLNqNAz/AsQgEyq5A0RlEZDQTOaswHKbpS1bIFXXXXe5q1rXKOD5ZoHRlSroZlDPnsnEuOxGv2zzqFWBB8ZRODzgHHuHO+Wox5X38hth2mbpVpeLZpHIQAU3OU35xTM/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706472181; c=relaxed/simple;
	bh=JvKtPDHJ48vz82xUkRsv3Nv89lW37Os5UFzaCwSGDYk=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hK7vqPB8+Kh7BeFQWtLYwEQbgkNOXSTwCZPvY9E4v/0tbT1FdC2XOykXg5sI0wXdUkskB/l1v43YCzkeU8o7DZDyuKN6fRZ4N0uGgvXJPPxbiv0g3pSpodyTgJBdFbgVzfCrfWVb1bS33HnkzqeU0PESNAnt9SeKUgsOvliU8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXj3yFGc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXj3yFGc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40ef6da20feso1215115e9.0
        for <git@vger.kernel.org>; Sun, 28 Jan 2024 12:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706472177; x=1707076977; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P46ysJSHKd19WYeeO6NfozEmyz/5Wuqmqh4NooshRe8=;
        b=VXj3yFGchUT5x/Y3lHT0bF8VGQnEl5zGP74Cjc+Un+iLFzvvxW/bHkaNQvZU3ofTab
         LsXH2I6uYeMP9blJ8alElmqI6Qa6V8uZHKpiQRcqbnw/Wzp1BJkjrtoIHN9yf+1REWwF
         JMYsA1ryFbG3SmSwijrwdkkw6B9j/8YbMHWjUVJTtGnKTWoqMeL/VZguympjPE8O8rhQ
         STQIQautfYGxV8grH5k+nuKraKITKpn1w55stUiZm+M3KMYjNUq8HQj9DjrXzofZzZVT
         +jSSQJbKZv3tLIiHsFWOvvVVaUnq+cNY1IZBcsASdFoOZqXPbblc2G1WP4bvyNQKusPT
         kMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706472177; x=1707076977;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P46ysJSHKd19WYeeO6NfozEmyz/5Wuqmqh4NooshRe8=;
        b=uXlIMkNcWg0zB5gq1axXm9DbB1X/pYT/ZyeXh/I3YZ9vZ1LJR3qcuakIFCMzf9Rm3f
         L0tPBPqEQ1Lk53g5xD9tQ8/wEkjgFM18bYTHAlgl1v4G5GNxFHPHyYbC/T06Tu56EHeD
         h0qFw0owDSjA7JLWp+rCWvw/QYExEbV5xyuUBsKnswKhS3Wfzb4jFUOKV3PQesI0GtkZ
         xjV99thW5cFk74ZvqWLOzcjx/qUyVXCKtsuM1K7GymSGjnlJke+6VuQYZBZLvyIYTQ7v
         v4zHEftPp7l7d3RCC4Rbp2ijyPuph5cnGvyVwJtM9C74V/QTPHBEaqFHX+iC5BCWjuEi
         8GWQ==
X-Gm-Message-State: AOJu0YwTmBxZ9bAxmnN4hx78kd8W1Q8CVIzxJW1I9rR0vMFnje4/RbHp
	fcn/sfyzZ5iAFKNBHErORPp4ymOEFJUh7okekM8oPu7F193d4HVEeo7zadOY
X-Google-Smtp-Source: AGHT+IF+0ssZgnV2fg6ti8/MiSqmiVpxdyWjo6mO36cPdUDSldjwV3GRvKyu7HhhfV1Emfx2niHQ5Q==
X-Received: by 2002:a05:600c:4743:b0:40e:bf71:f6db with SMTP id w3-20020a05600c474300b0040ebf71f6dbmr2838612wmo.17.1706472176844;
        Sun, 28 Jan 2024 12:02:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c34c700b0040ef67f1f52sm1396404wmq.7.2024.01.28.12.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jan 2024 12:02:55 -0800 (PST)
Message-ID: <2dd3085f8d80fa1f5209cffde60b4ab98766baf9.1706472173.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
References: <pull.1660.git.git.1706472173.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 28 Jan 2024 20:02:50 +0000
Subject: [PATCH 2/5] completion: complete 'submodule.*' config variables
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>,
    Philippe Blain <philippe.blain@canada.ca>

From: Philippe Blain <philippe.blain@canada.ca>

In the Bash completion script, function
__git_complete_config_variable_name completes config variables and has
special logic to deal with config variables involving user-defined
names, like branch.<name>.* and remote.<name>.*.

This special logic is missing for submodule-related config variables.
Add the appropriate branches to the case statement, making use of the
in-tree '.gitmodules' to list relevant submodules.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 159a4fd8add..8af9bc3f4e1 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2803,6 +2803,19 @@ __git_complete_config_variable_name ()
 		__gitcomp_nl_append "pushDefault" "$pfx" "$cur_" "${sfx:- }"
 		return
 		;;
+	submodule.*.*)
+		local pfx="${cur_%.*}."
+		cur_="${cur_##*.}"
+		__gitcomp "url update branch fetchRecurseSubmodules ignore active" "$pfx" "$cur_" "$sfx"
+		return
+		;;
+	submodule.*)
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
+		__gitcomp_nl "$(__git config -f "$(__git rev-parse --show-toplevel)/.gitmodules" --get-regexp 'submodule.*.path' | awk -F. '{print $2}')" "$pfx" "$cur_" "."
+		__gitcomp_nl_append $'alternateErrorStrategy\nfetchJobs\nactive\nalternateLocation\nrecurse\npropagateBranches' "$pfx" "$cur_" "${sfx:- }"
+		return
+		;;
 	url.*.*)
 		local pfx="${cur_%.*}."
 		cur_="${cur_##*.}"
-- 
gitgitgadget

