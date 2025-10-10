Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FC4222587
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 10:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760092040; cv=none; b=Af/I5pXiwqty1xf+c7fagSmOEBnktrAFp2zYREheHtuOdJ4aMyD6A6/sPCAYL7ogJr0qxKbb7lPLYe2H507Z9F4lkFZ06rbiKXdpvSapWFCEhzPlw8zvuxEZVA4g9W2WySUE/I7xw6UgryspP5r8unEj7ZZ7OSdqhrRHmBLWguU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760092040; c=relaxed/simple;
	bh=CGxutGxEL/oXo74jMvLlb8v4yK+INk7Vb4paO1uIpmM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kf3Ge9/ZfL6LHYONlmJ65yOVun0OndBNefmf636VTcIiirAa7CJb8lwUriYEf0yI3E/zMNoJEGj+IiaoyKZYFSBTpYejYMvxkfJICfLT9JRBNLzbngu6pWRoPRCE5ErbjlAvOhRTQgXi28HAU/fk5BhuY60ruXv2lWcy5fTi82I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JpmwQl0o; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JpmwQl0o"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-631787faf35so3683575a12.3
        for <git@vger.kernel.org>; Fri, 10 Oct 2025 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760092037; x=1760696837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avqAklbx/7V3zVNAnQnixEi8d10lb/n/Ffro5W+6Kso=;
        b=JpmwQl0oIL+ztpikkj6/iRPQfAHxvLDmWizIakyYIl87I88Gat/4f2iK7flmN0pc2r
         Xo2EQNAXk23bTPpo3siSSQTJL7d9Q40xZ0MZwfgSPmzBxxJG8wAXv2JOitvHdF2GS5CA
         i+FqfVHwnA2dLjiO7bjhetz7VrnrzpE6tlqGGD8fEIhM1ogf+g3cJD4mpygAOrwjRIJa
         DSZ11k1neJnonWqwWD8IpFYv9cBV1yhysl6+YxfEZD1ULIByeeYpMaQEFutA5HEfbfyP
         ePjppyMC8WicAlHXEo3SP2x7NxHACggYxosow7Sedgqj2TDVCkl2ktSaY/6WHj752wtt
         wR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760092037; x=1760696837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=avqAklbx/7V3zVNAnQnixEi8d10lb/n/Ffro5W+6Kso=;
        b=XfLHDkv7k702NXsso3CKDvy5+2nG9fmA5X68huVr61TvL4rkeX/6aSU2K+A5CpNW5z
         Gn2MuRVSYW+yWRFZsydw/4rNCZEM8mEYCmBTB64zt4q9n9zcpfo3dqmachqXoOPIYem/
         Ut0XwJmnxca7u8NYdy/0eDQ6Dyp6wwkDEfddyQJ/m1cpe/LzFrtHL8N8eX+eZ7IQcv1i
         HFeYKp+XRLxeiuwb0pGMDY9tzfS/RYWZH6po0q0+cSGE0OadtslkVW9jqKLAtbiTeq+e
         dlLcJxneTQiBIbetnNVeup377sD1gcRFZo2iSb01Z6kkI61RY5HIV8+QYsano+Yr8WxL
         XJeQ==
X-Gm-Message-State: AOJu0Ywa58wxorj17Xc3jyGU5oO9et+X1QUkmDctOwshASI47kBXdCP9
	6vBstJVnaugJrF+aWf+UZdTQl7tfNQQhSXMc7i5WEBmVXeye+unUyzJH5ZpBcdbW
X-Gm-Gg: ASbGncu2T9ZO5nqpbervIPnn7QUPVC8JXGMwgNtenOc4/zUon8bFe7SFkltxvgd/h3w
	HLOgycKmz5ARg0XXC6h3alI4Aj3m/4uzbKb/9Qx9nmDccSMpwInX61VE69IO1p7CvgnhaBqowF8
	LBsKZR8Vy0oipfuJQaFZOQjXrKl77NqZoRX3vw10NgNssNxbSp7YAw8j22uCVAg6d+Xn1dPqEFJ
	vNkrk8hBy9ZiSixHDiiHdHbj9g+oA/bd6zAeiY5emB+IUvrPDJ3SGfaR2f5h5MS3kLILLt/BtJc
	juN3sYoe3ssZsSp5W+TJ2+BcQeKbPzbA3P29JyMLvG9pUzZcQ4hie9yPimq4WcJ5PU8yi1atvXq
	WjekUGaYIQC531kER/ZFQ4ohNw/UZ3sjerL0wtOgi/2JKMOw=
X-Google-Smtp-Source: AGHT+IH2011rQbqbziMIeiYnGhHE9o7H0lp2fIt4bhrsa778ZAcBOpYsPYvL8lv7bWVkx+iUYDD83g==
X-Received: by 2002:a05:6402:40d1:b0:639:ef26:a01d with SMTP id 4fb4d7f45d1cf-639ef26a47emr6958455a12.11.1760092036907;
        Fri, 10 Oct 2025 03:27:16 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2455:8268:bc00:70de:2d8a:d550:c37c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63a52b0f750sm1960729a12.14.2025.10.10.03.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 03:27:16 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 10 Oct 2025 12:27:09 +0200
Subject: [PATCH 5/9] t/t0450: split whitespace consistency check per
 subcommand
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-5-c7962be584fa@gmail.com>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
In-Reply-To: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=3371; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=CGxutGxEL/oXo74jMvLlb8v4yK+INk7Vb4paO1uIpmM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGjo338n+VqBvKrA0+K34xNGWyWMkA4jTJWnR
 KpwWEKjqdAWQIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJo6N9/AAoJED7VnySO
 Rox/W8YL/RFVGtQGthxAhQMLd74zxwHnfN3P5bdwQtg618MZ+J692DjRfLdTfEqx95kjndeoiyh
 5ltCGhi4Xs7EF+Nn9Mi/W903+J0kALrjeBv0q5tCr3sNsy8/ee2mlaVXqCJNWuOndnMYA7TJZgp
 JBvquBAieiVVUM2SnLr8vCE/1ru/ABrI1VtH/dY/egID28IDxgmWDbOxsYCqF5kuG0g7diq9yYM
 62TzeX2cT/NxmYVrDwZoCLvqCZVLriWqCfT1u9y+0anpsnzJwIQ9IJR5DABaXX1wEVsgZvZqUu9
 mBnoffHNEFm+np8jaUp9DbABGlKRrbi202+oHV5zBDCfy9sDQBylx5B5lwIt9554ZkRC3VNl5O1
 tSev4JPM2NnDkynFn9NyLIdk2fr03KyHu6b9WG9TMtl7K0dGGox+KtpBZekL4XGhLEjRJYPRWI3
 TOo+qAPl2NtJ1DKlAyMkFPLrqI5PAafiZqwaLvQzT0c74a+SvWb98jd5nbVDZLoMB9idj3IP9M8
 P4=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The test t0450 contains a test to ensure that leading whitespaces within
a commands help text is consistent. This would catch issues such as:

  usage: git show-ref [--head] [-d | --dereference]
                         [-s | --hash[=<n>]] [--abbrev[=<n>]] [--branches] [--tags]
                      [--] [<pattern>...]

where the second line has inconsistent leading whitespaces. However this
considers that all lines within a command will be aligned similarly.
This works for most commands, however when dealing commands which
include subcommands, this assumption doesn't hold. Consider the help
text for 'git-refs(1)':

  usage: git refs migrate --ref-format=<format> [--no-reflog] [--dry-run]
     or: git refs verify [--strict] [--verbose]
     or: git refs list [--count=<count>] [--shell|--perl|--python|--tcl]
                                  [(--sort=<key>)...] [--format=<format>]
                                  [--include-root-refs] [--points-at=<object>]
                                  [--merged[=<object>]] [--no-merged[=<object>]]
                                  [--contains[=<object>]] [--no-contains[=<object>]]
                                  [(--exclude=<pattern>)...] [--start-after=<marker>]
                                  [ --stdin | (<pattern>...)]
     or: git refs exists <ref>
     or: git refs optimize [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]

With the current implementation of this test, any flags added to 'git
refs optimize' in a newline would require it to be aligned with the
flags of 'git refs list'. Which is incorrect, since we'd want it to be
aligned with the flags already added to 'git refs optimize'.

Let's modify the test to work with subcommands. Do this by swapping out
the old logic. The old logic simply counts the number of spaces for all
lines with leading spaces and checks to make sure they're equal.
Instead, now we create a list of (subcommand number, leading space) and
then ensure that there are only unique values per subcommand.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 t/t0450-txt-doc-vs-help.sh | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
index e12e18f97f..150655f9f0 100755
--- a/t/t0450-txt-doc-vs-help.sh
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -94,19 +94,23 @@ do
 		check_dashed_labels "$(help_to_synopsis "$builtin")"
 	'
 
-	test_expect_success "$builtin -h output has consistent spacing" '
+	test_expect_success "$builtin -h output has consistent spacing for each subcommand" '
 		h2s="$(help_to_synopsis "$builtin")" &&
-		sed -n \
-			-e "/^ / {
-				s/[^ ].*//;
-				p;
-			}" \
-			<"$h2s" >help &&
-		sort -u help >help.ws &&
-		if test -s help.ws
-		then
-			test_line_count = 1 help.ws
-		fi
+
+		# For each subcommand, capture the number of whitespaces
+		# specific to that subcommand.
+		awk "
+		    /^[^ ]/ { subcommand++ } # Count the number of subcommands
+		    /^ / {
+		       match(\$0, /^ */);
+		       print subcommand, RLENGTH;
+		    }
+		" <"$h2s" \
+		| sort -u \
+		| cut -d" " -f1 \
+		| uniq -d > help.inconsistent &&
+
+		test_must_be_empty help.inconsistent
 	'
 
 	adoc="$(builtin_to_adoc "$builtin")" &&

-- 
2.51.0

