Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC0161F576
	for <e@80x24.org>; Fri,  9 Feb 2018 11:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeBILFu (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 06:05:50 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35531 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbeBILFt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 06:05:49 -0500
Received: by mail-pg0-f67.google.com with SMTP id o13so3405081pgs.2
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 03:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IYtFkMFNHs5kiEdOmihML20t6CaIrqdZIMaNF7Oz5i0=;
        b=lLcSVLhjLx/y/3Cz3mIQi7vfhrAlnbDuiQI5MoDdsb38mQsm8eQbx+AX2kxVF90p4x
         SFedm7ejSJ8JpcXNgUwIhM9Uj3pq7RYLTgSDUGR2+FwNK23TiGfMvqCQsSVcDcnHvzvE
         1JzdHVhub8hQOUjjpvlOqmAxvaxbTTlH3qljGodSpfkHedMbuN0Drrt/Jr8JGHaOZe5A
         YEfzbcRHyJBB+oXc8rnSoHGNubuZG5V2HAEzFQbIJyAyzobk8wO1NaWXuUfaLSmvK92Q
         nJUbY0uj70iEtNm+QKqFT30angI4XdOoRtGC/LS9jUCLaxFka5z1kuavfG9MXFdMuC59
         qRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IYtFkMFNHs5kiEdOmihML20t6CaIrqdZIMaNF7Oz5i0=;
        b=W0iw5NlkIizgxwOkhmrcS9XMVFhQbF2mMT4DuROGfS7LlVbxspqN8KL2nfI/xx95zT
         /J1V4qrsdQ4kAXNOLVoj1i+Pyq1byb3DuouLBEimPiTwhEoFVoAhTlvGlqgDBMQsJI50
         XJD1aj2+aQ858h3iBQreGz+rqGmfVH/VayXpUxqDKArZJe59UVfrZrJDcBvMXFSl21wr
         7Saz7HpgdUXYqT9ZrdvipiTlmuN5CSCDnplLuQpqzjkUIl3q9wRroMw3EC9Y8x57+xWr
         In2JU9nR8wlIAKiR1xRg0BOJIK+af3Cau8+ErTWDMD3hv5NeZz/6B/Wo+2ao61ePHgQS
         vxhA==
X-Gm-Message-State: APf1xPAZy5Fdhirm72AhAsnUkgdn6VqbDd8/F7GCbWr2YKfb4qFp6AQM
        unegR2xPZsboNb9rd0KzryAPsQ==
X-Google-Smtp-Source: AH8x227zF7Ky70KRVs+92wQwTvm/4sjOiONRVJQjtG8Mm3lEFtog/tqVqRv2G6r33aVoC32hpcdMag==
X-Received: by 10.101.67.135 with SMTP id m7mr2007867pgp.301.1518174348576;
        Fri, 09 Feb 2018 03:05:48 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id j12sm13067700pfa.95.2018.02.09.03.05.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Feb 2018 03:05:48 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Fri, 09 Feb 2018 18:05:43 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 36/42] completion: use __gitcomp_builtin in _git_revert
Date:   Fri,  9 Feb 2018 18:02:15 +0700
Message-Id: <20180209110221.27224-37-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.207.gedba492059
In-Reply-To: <20180209110221.27224-1-pclouds@gmail.com>
References: <20180131110547.20577-1-pclouds@gmail.com>
 <20180209110221.27224-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new completable option is --gpg-sign

In-progress options like --continue will be part of --git-completion-helper
then filtered out by _git_revert() unless the operation is in
progress. This helps keep marking of these operations in just one place.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 contrib/completion/git-completion.bash | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9aca05d01e..e63f2f2741 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2692,19 +2692,19 @@ _git_reset ()
 	__git_complete_refs
 }
 
+__git_revert_inprogress_options="--continue --quit --abort"
+
 _git_revert ()
 {
 	__git_find_repo_path
 	if [ -f "$__git_repo_path"/REVERT_HEAD ]; then
-		__gitcomp "--continue --quit --abort"
+		__gitcomp "$__git_revert_inprogress_options"
 		return
 	fi
 	case "$cur" in
 	--*)
-		__gitcomp "
-			--edit --mainline --no-edit --no-commit --signoff
-			--strategy= --strategy-option=
-			"
+		__gitcomp_builtin revert "--no-edit" \
+			"$__git_revert_inprogress_options"
 		return
 		;;
 	esac
-- 
2.16.1.207.gedba492059

