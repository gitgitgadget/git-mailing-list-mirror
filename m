Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729AC3446AD
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889481; cv=none; b=TC2W7kcc8/6+T8i70vN1NCrwSvO6ga0CBTdPcmeEQWospXJliqe6fsfvXuzWk3xi6jigX1NAUtf75CkTbknpX5pS2UBIGhZzZoQqccRi+K74VGyOlZwNeHCvOcw2PIvRwlwDjt1pVgcurjqbIGKlPccmT0KiB/qniSlgwQnghB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889481; c=relaxed/simple;
	bh=qOtB43P1n/Lp7XgAuuV2h3lvUsX77IeVndcXxbSQZ98=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gf/DaxOv0q6YRGeTp8zJGcDluEDKx+rwp2ay6zwiJr8BDz1bXPZU6Fsg2/LMtrT/vQzHm//9hqOdE1dPqxgl6aW08riraQzef4AbatmrwHhtog5ya1gktYngfX6dYZfYpCcFWsFHkp3SIszfK9p/UN8DSYNmexoolzfhrpTTqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ast+WI/T; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ast+WI/T"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51c2808dbc3so201411cf.1
        for <git@vger.kernel.org>; Wed, 01 Jul 2026 00:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782889479; x=1783494279; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I5u3EkVVfUbP6QibuTqIJsxZ/DUo/4dv4Yd2X9JE9FU=;
        b=Ast+WI/TpXZyuU+L6Zrj3uZXnId7bFPoTbZbcxhRqbAGWad5ZaTlduRYYsStTfNDHs
         GsZA9wS5K1bf9tM17+e4IFiwvIriS/ekIWtb2yhRhNiAyBUzISdwY0KUS0EwKdl2y9cf
         fzj5m3Zjxsd6Dcz596tcYgy1eFgd8o7Co5HYJ1TDFCLtJhExZk2kqqUTaTP7Bpv0yvkE
         45qDo/3uCnxgqzGCPWwXduaZZ92KzH1mgKop5mk4o3pnBrUTeAx7JphgzgapTHyIzz6I
         2WROQ0veqaxySEhxrEIYeqHoI8OcZ399Nvij2h2HBgqma37yTfmAITweBzBtJbPn3BhP
         gh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782889479; x=1783494279;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I5u3EkVVfUbP6QibuTqIJsxZ/DUo/4dv4Yd2X9JE9FU=;
        b=VyVBbswH/3GF4LCa5+o5480zJXcXjOM5afX2yESTbIzATe/HcBsBppxh3PH7Vm2iW4
         zuocfFcqoIuilBJTasvwpGy+mncNWv9LtJb3XuvPpDIdpPfXHCIZlLXfN9xbFXyQ5Ydj
         EuMqzvznuO+rO/wC0w4OWRXxMee47eKdjpPUS4pCkW03rh5AtzNTssVBZJeiWdp5FD9y
         xhPmIxSDU8nFSQJMLuBXrLgyMm7T5haLMqkncBAJqdWB45Gmr6Rppu4qgkaacLJUWS92
         +XZ6foak+bOKoqKIJtqGy0OYpur4RmcIRe2Rrn/FjlU8olpxPLvFruarB2iFwedVsijo
         aC/A==
X-Gm-Message-State: AOJu0YxhGy8DejXRTl9p2lJntO0qFnoEiz/fpywESDTRFZMUA21UrruR
	WVRQrNSAhtTKV0+dO/dQcH0OVvrKbwgMsxsqfRK06qT7z9UwopDGZi3mEdGTgA==
X-Gm-Gg: AfdE7clSB2QmeBxxspstmcpqueXpagEwFgmgdRX/AUHyX78uIFvHEGlEJEO3wkrf4mG
	dNKSNPEehcwyfrxdfdPSfk7JRtMP1QXbTq4Z8Z2+kFV+0kXd1B1Hn5XIDdtFewNT+6TT67Ji9Ej
	/iI0iHvtBW43rCfY34z/jmDoR/JJnFfiUpJxcnF5jHC6xPniJsu8PidgrGdgG3HIAH5iwHXm1dj
	+R19P92Tv0kF1g+FQouHJ3OMd2yuY178J9JN47Wr1QBVHg5zQHZXnKynHFurKl+QPUo96wnDOs5
	gntt1w7cZWPPZfzF7OvEx2sgvzmtP0TfSZez5wuVqjsRS1DFgd/sQiRUQ866KUkrUuSX8JERoyH
	0Yb8can3arh3upHXzK/kVtvv+Nuvy8r6WaObs8u/LPowDYBS1Nw/xUdTkv2MvDoZW5zUWPG6k5+
	rPEAwgsasWIwEGTns/EFYkPO9lVFQ=
X-Received: by 2002:a05:622a:294:b0:51c:19af:6341 with SMTP id d75a77b69052e-51c26b15361mr6134611cf.36.1782889479439;
        Wed, 01 Jul 2026 00:04:39 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.44.231])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f35e790097sm14625376d6.5.2026.07.01.00.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 00:04:38 -0700 (PDT)
Message-Id: <d7bcdda31276b5a17f11c307deb0f99ae1dc2861.1782889472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 01 Jul 2026 07:04:22 +0000
Subject: [PATCH 04/13] run-command: avoid close(-1) in start_command() error
 paths
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When start_command() fails to set up a pipe partway through, it
rolls back by closing the pipe ends it has already opened. For
descriptors supplied by the caller rather than allocated locally,
that rollback tested `if (cmd->in)` / `if (cmd->out)` before calling
close(). The CHILD_PROCESS_INIT default of -1 ("no descriptor") is
non-zero and so passes the test, meaning a caller that sets
cmd->no_stdin or cmd->no_stdout without supplying a real fd ends up
triggering close(-1) on the error path.

The stdin-pipe failure branch a few lines above already uses the
right idiom, `if (cmd->out > 0)`, which rejects both the -1 sentinel
and 0 (the parent's own standard streams). Apply it to the three
remaining rollback sites.

Reported by Coverity as CID 1049722 ("Argument cannot be negative").

Assisted-by: Opus 4.7
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 run-command.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/run-command.c b/run-command.c
index e70a8a387b..ce84db8782 100644
--- a/run-command.c
+++ b/run-command.c
@@ -706,7 +706,7 @@ int start_command(struct child_process *cmd)
 			failed_errno = errno;
 			if (need_in)
 				close_pair(fdin);
-			else if (cmd->in)
+			else if (cmd->in > 0)
 				close(cmd->in);
 			str = "standard output";
 			goto fail_pipe;
@@ -720,11 +720,11 @@ int start_command(struct child_process *cmd)
 			failed_errno = errno;
 			if (need_in)
 				close_pair(fdin);
-			else if (cmd->in)
+			else if (cmd->in > 0)
 				close(cmd->in);
 			if (need_out)
 				close_pair(fdout);
-			else if (cmd->out)
+			else if (cmd->out > 0)
 				close(cmd->out);
 			str = "standard error";
 fail_pipe:
-- 
gitgitgadget

