Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B9143C4B
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043950; cv=none; b=RKrSL+RjW+4ogKVf29IK7/5dwq8NZM5ooW4fLB7Cz5rjy/WKtespgXUABvvwwlB928hqV5aIui6hV0BFlYLYXclE6edcrmF5OPvsBNCh0VJZQLK9eadmUm9aCQLOb9iP1uOEigMG/XE8MdilzguTIBrNzq3wUCD2C/8vKsDGzzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043950; c=relaxed/simple;
	bh=IWHJUzTXv6Cjhzb/vODNN0dt0XoR9wYrxMq8iGiZuEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ukxGEBZvMhIUC7ZBWWgUQxPWc4oF9Um6TxxzcS8kL49I5zEhkpoeowpydy076SQdy4h8mSA/G+8L58vYj80O+fhodGplGg5H8ukkAbsqxi1Aga8XPRs8gKIiXDCXQ51ptURDXac5xLn3EMHiQ1DKH+/tVVkCICQmi7tj5DOgacs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJof+iH7; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJof+iH7"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d23a22233fso44428371fa.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043947; x=1709648747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7ce2zN6Ul4JT61mH5TxRRs43U1bjQuWeBVN7EUR3KE=;
        b=cJof+iH7d2x+N056E/de4J+mmDiPJjOr+YG2zZw4ci88g0cDxcBTZu0hQoG54MN8To
         oK2KJSrka2+bI6hH1nanVETkpY7kJGY2Xnti08myujslBTsvrhvKj3j6GdDYsL5JlVk6
         +mzBvWPQUdzmI9c5y65HJTH+7IYBC0ah3+ht8L6/H432mO6T/94bnHFuBCWh3MPvL7p0
         lbmzLSg/I5qiA09Rww8Oav4etqj/mAll5yixa0nu9RyGfskFqK7QrYEjGOi4/ZSbastS
         fuzupqZKDHTPV/SKVyk8J3Dl9A/WGaSxv3wTDRh5cpJ04KJEP09A5HHXstRVFnISD1ZU
         55/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043947; x=1709648747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7ce2zN6Ul4JT61mH5TxRRs43U1bjQuWeBVN7EUR3KE=;
        b=vKmu7nzwcG32/+ZQdFs7t4zE7MWiLeabQ9mvtBAXFgGnrNmQa19JHkseKj82avk1AY
         AbwCmnf/YyHQbNK94fKRyNsgTUXHXzGvF/OHJQuiog05e/YnhJ1WEvHdfKnjXQ6wDLjX
         IIOmDFC9LuJR9+SPenVbIMxG1dsgid/o8P1IgbrosRdz2rANCfTRXAeXJzyVR9/TPlXF
         F+fEtXTG9ve5ADpGAn5uC1HDJftgOl8i8gE9nEHfHJuDZ+4goFuVf1MrHDh2RMbO/AM/
         BMSsZTsO7xxzPA62v1XLViPC78Z9HbE8DeoKjF72IDh8z2JXK0muxzU7XESWzkQSgMOd
         VTvg==
X-Gm-Message-State: AOJu0YwI7NlLQLjjUEkwbiOc0POP77F1OrgHc8TzSPvI9qwg6K/IJtB8
	T8rYKnd78n1/QcfGalHVcq7jAMETkJYorF5j+SyKBPNiYbnXTmS0
X-Google-Smtp-Source: AGHT+IG8BuXzQ3uYq0RPDdyZBQf2SsCWC/0ATg5JP4c5hCnbYsqfNMYsN0rPvC96YI1pwwJFO+dGrA==
X-Received: by 2002:a05:651c:1a21:b0:2d2:3aea:bc78 with SMTP id by33-20020a05651c1a2100b002d23aeabc78mr7843545ljb.38.1709043946783;
        Tue, 27 Feb 2024 06:25:46 -0800 (PST)
Received: from host-sergy.. ([154.72.153.213])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00412a2060d5esm8459255wmo.23.2024.02.27.06.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:25:46 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH 0/2] Add builtin patterns for userdiff in JavaScript, as Microproject.
Date: Tue, 27 Feb 2024 15:25:37 +0100
Message-ID: <20240227142540.73972-1-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergius Nyah <sergiusnyah@gmail.com>

Firstly, I'm so sorry for the delay between selecting the Microproject and sending the patch series.
Learning about regular expressions took me a bit longer than I expected, but it was all worth it.
I'm very grateful for the opportunity to work on this project and I'm looking forward to contributing more to Git.

This patch series adds builtin patterns for JavaScript function detection in userdiff, as 
my Microproject for GSOC. The first patch adds a regular expression for detecting JavaScript
functions in Git diffs while the second adds a test for JavaScript function detection in Git diffs.
This new pattern looks for lines that start with optional whitespace, followed by 'function' and any 
characters (for function declarations), or valid JavaScript identifiers, equals sign '=', 'function'
keyword and any characters (for function expressions). It also considers functions defined inside blocks with '{...}'.


 t/t4018-diff-funcname.sh | 25 +++++++++++++++++++++++--
 userdiff.c               | 17 +++++++++++++++--
 2 files changed, 38 insertions(+), 4 deletions(-)
 

base-commit: c5b454771e6b086f60c7f1f139025f174bcedac9
-- 
2.43.2

I would greatly appreciate any feedback on the patch series.
Best, 
Sergius.

