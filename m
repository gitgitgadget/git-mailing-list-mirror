Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D471F576
	for <e@80x24.org>; Wed, 31 Jan 2018 11:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753630AbeAaLHC (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 06:07:02 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44617 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753606AbeAaLG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 06:06:59 -0500
Received: by mail-pf0-f196.google.com with SMTP id 17so10798490pfw.11
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 03:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m/PtXP2N2cakDpD5BKn4VyHzp7kbxflj6OJGwE26pw4=;
        b=I3BuDtteL11UVRoX2N7N2XYEq+SYIwTOV8cTLnAG1ww08ugjpHNqmUHKyjNiBQy/cV
         dz+Q2q3hp+f3a61o9F6lDjh5xa9wRddBj+4ixM7z23NJUgiI0Uu3cTO4Df2q9woro+C1
         uDU8eaQwuw6xdDcHTzkvAqBLznCDDNY0NTvxR6blfPt3rK2KNvdG3r1VQM3D+x0gIIwK
         WfVmW4Eqngp7maD/JIOeGBAdo73h0aYvN50QRq2ENS4GmlaRhVEPFJavJJvAqdcw3crG
         d9PymxiL7rE0HhODqF6MHo7fcyPcicQv9FwZ8Iu2Z/xkxIxfPAcD040UVQWoIHRn/kja
         JsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m/PtXP2N2cakDpD5BKn4VyHzp7kbxflj6OJGwE26pw4=;
        b=g7lIEfUm5cmCGo6yCmrzMLFk1RSweMjA8CO23A/eLmb8Q23lXFTtyhkSoceAjzHIoI
         meDDbzVRnTZTp2fBat0YVBjAYfSt0dY5CV2V7+LUjl7eFKV1FToYLz8hOMbnW1l/utVr
         UcG5hnW7IY9NxzJZW5tY5XDJLYOHncQqks9MM8fUs1wnCRwlPJYqs/QGZTtbIA5SODAq
         Qz/G+ObSgjJgKBInKXWMX2TQIRO/IM4h3wXATl8Ry3X0UyOm6alU/HIp4rm6gLXPdGjN
         FqbgxBmaUEce3QUneBg1Ep+/jTjctBov3bpO1d7rEI/ZpdpYaCAnI31DzpPoCjv4N5tQ
         sAmw==
X-Gm-Message-State: AKwxyteHP41FjQaDMGt9g/G5LK/DzmJQ8OTAzhcEOFzn99w4o6oPpU4N
        q6qFNbx2BJAkiD8fxv7PC78rTg==
X-Google-Smtp-Source: AH8x227NEbDL+rQkcJK17RViKiSQ3BqIwbnum6UNDzGVX32Gb+uKq7Qk9PiQpVOvBw0oys5l1hRkog==
X-Received: by 2002:a17:902:12f:: with SMTP id 44-v6mr26792973plb.403.1517396819006;
        Wed, 31 Jan 2018 03:06:59 -0800 (PST)
Received: from ash ([171.232.97.171])
        by smtp.gmail.com with ESMTPSA id 3sm13587731pfo.117.2018.01.31.03.06.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 03:06:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 31 Jan 2018 18:06:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 13/41] completion: use __gitcomp_builtin in _git_commit
Date:   Wed, 31 Jan 2018 18:05:19 +0700
Message-Id: <20180131110547.20577-14-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.205.g271f633410
In-Reply-To: <20180131110547.20577-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new comletable options are:

--branch
--gpg-sign
--long
--no-post-rewrite
--null
--porcelain
--status

--allow-empty is no longer completable because it's a hidden option
since 4741edd549 (Remove deprecated OPTION_BOOLEAN for parsing arguments
- 2013-08-03)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 393f86619d..8bbe94a94f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1339,16 +1339,7 @@ _git_commit ()
 		return
 		;;
 	--*)
-		__gitcomp "
-			--all --author= --signoff --verify --no-verify
-			--edit --no-edit
-			--amend --include --only --interactive
-			--dry-run --reuse-message= --reedit-message=
-			--reset-author --file= --message= --template=
-			--cleanup= --untracked-files --untracked-files=
-			--verbose --quiet --fixup= --squash=
-			--patch --short --date --allow-empty
-			"
+		__gitcomp_builtin commit "--no-edit --verify"
 		return
 	esac
 
-- 
2.16.1.205.g271f633410

