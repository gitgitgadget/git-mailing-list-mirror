Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DAD2E827
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 20:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705610618; cv=none; b=mTtmKKDiW37OUwlp4OQp2ZO9+AWHPPibqo3j38WiBSD37aTtcvKs+Ue/eJ15X0TcGmHoGIG6tolHmsqiIEoXx1BXK6YKkEKu8PhapkfU14cpKZa+q3n8qoCtNLatIEZSV4tLolxpUI0FmPMZYcnpKM/XTRw4g2xsJLvpHLvUyfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705610618; c=relaxed/simple;
	bh=2nJOF6bdDiW/oC2MJ95gSL54DMbkImvSqElscwQjl8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SscOD6bpWWTbeBy1BnKtxg3P2nP7D+tNUJRMBRk+MnsYS6NuZspjgviNx79VmjJ8t63HOdSE+2R1UdPiGgIgqmuplS+cD+JC9AXS8xWey8qfitJ+19soIXyN48vjuE8R6sxoeKjUmVOKo1HHhLIDHO0aCAzNlSmFoo6ifsCzBSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZiB8KV3v; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZiB8KV3v"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d5f1e0e32eso137085ad.3
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 12:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705610616; x=1706215416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CgliPEM4acHgcMDbFwUlT9w93z11KYWyH0jcwn+NClI=;
        b=ZiB8KV3vx4C3retNXzbuAS+Rz8ZfwfjNH1k0jhHSNiNLCZYYq5BRUkpJtReaNxGz5n
         iTI2AwaWns8qR+GjhC16tvw+gWXdWkaN3OCT1N4K++kjWz1K2AoNuI11TDprzpyRbyd3
         8fa1zopiZDToYEoebJrh7M01MVHD5ufOvhxvlSSruz4pdXKV31cZOncKFt5cyuUAiTU7
         H5KIBlYhQiL0mUJEvoqs2NQQ09TGuX8BSPMaCSNUKDkCM/lcXYwzx5nawsCt4PQRxJ7j
         Oh7T6v7PdsyGM7UFDoqPBRj3blIrz+YOawNE5XmHadvY2rRavmyCa8Io2r/o8HxrwEjF
         zK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705610616; x=1706215416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CgliPEM4acHgcMDbFwUlT9w93z11KYWyH0jcwn+NClI=;
        b=MMcUqelmI9YG1onvtghH2sGJHu30eN7yeH5sFFJkK96y6PG4T3ujp18LUh5wrZld3J
         ncTGXIe6XGFQlA38Fa6TRL4edigKc7yAnfIu4S50nuBZjFXwwUooJ/2Ui3Q1IsGWermG
         ZgL1Ue+PkCr8bgiMFZULo4V06zhtLK/QeQX3yJFCArScdBy3d0Sf5fa6XWHalcpVe7t2
         FqdOngysEDxCkeMciKWhMkphodL9NPNB9fG46cne8Ad2neeECk+vcPx3780O5/vP/M1z
         4+GbwTPbzI81eWtQo8wzlB168RSEXzfreBUWu6U4ZNO4uG0jgrM46+ngqeH9zMBMz4Sr
         maRQ==
X-Gm-Message-State: AOJu0YzZ9RoUQINvnTIq6pdB3vfM/1ejPFORplKdPA7EncfyRwmJiWNu
	ysNdCq6JipxR2vZofpJYkk8wN6QmCAFn6B2I00CVmgOBdVfTEHjD
X-Google-Smtp-Source: AGHT+IG22HPkBjCVoFmqsHU9deEJzldkju9984RjpqHdUbmqfbypcKBE/4OL9HKHqxpH5OLWDfwIiA==
X-Received: by 2002:a17:903:1209:b0:1d4:9ac9:eac2 with SMTP id l9-20020a170903120900b001d49ac9eac2mr1480781plh.28.1705610616227;
        Thu, 18 Jan 2024 12:43:36 -0800 (PST)
Received: from brittons-large-Vivobook ([2600:380:7029:85ba:9b09:b597:4ed2:ccfb])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f7d100b001d71ae81cbbsm212959plw.190.2024.01.18.12.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 12:43:34 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 1B511520275; Thu, 18 Jan 2024 11:43:33 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v3 2/5] completion: git-log opts to bisect visualize
Date: Thu, 18 Jan 2024 11:43:20 -0900
Message-ID: <20240118204323.1113859-3-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118204323.1113859-1-britton.kerin@gmail.com>
References: <03fe3371-2b0f-4590-90ad-166b8fa4cbbb@smtp-relay.sendinblue.com>
 <20240118204323.1113859-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To do this the majority of _git_log has been factored out into the new
__git_complete_log_opts.  This is needed because the visualize command
accepts git-log options but not rev arguments (they are fixed to the
commits under bisection).

__git_complete_log_opts has a precondition that COMPREPLY be empty.  In
a completion context it doesn't seem advisable to implement
preconditions as noisy or hard failures, so instead it becomes a no-op
on violation.  This should be detectable and quick to debug for devels,
without ever aggravating a user (besides completion failure).

Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>
---
 contrib/completion/git-completion.bash | 30 +++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 15d22ff7d9..c16aded36c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1472,6 +1472,16 @@ _git_bisect ()
 			;;
 		esac
 		;;
+	visualize)
+		case "$cur" in
+		-*)
+			__git_complete_log_opts
+			return
+			;;
+		*)
+			;;
+		esac
+		;;
 	esac
 
 	case "$subcommand" in
@@ -2074,10 +2084,14 @@ __git_diff_merges_opts="off none on first-parent 1 separate m combined c dense-c
 __git_log_pretty_formats="oneline short medium full fuller reference email raw format: tformat: mboxrd"
 __git_log_date_formats="relative iso8601 iso8601-strict rfc2822 short local default human raw unix auto: format:"
 
-_git_log ()
+
+# Check for only porcelain (i.e. not git-rev-list) option (not argument)
+# and selected option argument completions for git-log options and if any
+# are found put them in COMPREPLY.  COMPREPLY must be empty at the start,
+# and will be empty on return if no candidates are found.
+__git_complete_log_opts ()
 {
-	__git_has_doubledash && return
-	__git_find_repo_path
+	[ -z "$COMPREPLY" ] || return 1   # Precondition
 
 	local merge=""
 	if [ -f "$__git_repo_path/MERGE_HEAD" ]; then
@@ -2171,6 +2185,16 @@ _git_log ()
 		return
 		;;
 	esac
+}
+
+_git_log ()
+{
+	__git_has_doubledash && return
+	__git_find_repo_path
+
+        __git_complete_log_opts
+        [ -z "$COMPREPLY" ] || return
+
 	__git_complete_revlist
 }
 
-- 
2.43.0

