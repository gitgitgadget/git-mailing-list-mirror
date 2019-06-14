Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89A3C1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 06:51:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfFNGu7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 02:50:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37146 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbfFNGu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 02:50:58 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so1673480otp.4
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hSovXS+rZ84ozHD1zjbHHZjsjicH9cdpEGDfU+yKOXo=;
        b=rhuZjWbG8sK49aDsvBBRmncWibkBReD3sTvh4kqh/XovDkuLKVHaKf1l7u/LfxH5P/
         ZijFWABwNqby4A3WPK2IGjZLdxnUc6OedrwRmBpzIIAG6wq2HXw4Tx6lsKKeQiFsWkqQ
         6GVUJSaI4fosBfLpG9FCEDje6qOdba27R3b6bJe7aXw4HuiihU5mi27ROqdAw+uPyKTA
         +m3xhLpUSWPncJpR/a+cdR6jD7Nfo7iRYHWy05YKk7q2pMTI5tAqjkvddap7LyRBU7hq
         vFU0VBzdgi7akExGbwAcFh/SJ9ebGvxg5QXhJ8Qvi/t8lhezHRFtK64T4j5jVlPNlsLZ
         cCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hSovXS+rZ84ozHD1zjbHHZjsjicH9cdpEGDfU+yKOXo=;
        b=Kil+P1td7/JyHM45jjPnrsjJpHuDbBGt3QatUMem7fHpS20Wbeo59M+s543EDlNut5
         Y6CCwTwHJ74LpoeGGo9ZcwbOic+nayTPj6mYJ9aOKpR0IDf+Jm++wPZ+nlX883MGZx+z
         TAkYaEHfvypWPgVBLR8Qu2iQFrvpz0psXufvgz1OtGADVrIbtIbFOoabmXcpl5iqJ6Y7
         eu3Ysu/hPEt4Zdc5IG/sjN/XDvdBkweiM6EUtLtq9gD8YLM3cTGC2OhfPiuPmiksaUBw
         3CBkmwNDWqLJNNuhPBse2QsLt/jC/WXjTE70SlP8gK96ojhrjiUO7HuowhobnbOzk6vA
         C05w==
X-Gm-Message-State: APjAAAXxRqzgt5usFAbiG/+1XukxwagEjj9Ool8pisXTnTdBhs3yuKEJ
        jPZkjhXf4GqNBo4EBMpfI4/GukLAjK8=
X-Google-Smtp-Source: APXvYqxk9z2HKC7i72NEqEFlRonvNaeewR3om2nQR26tCEiPVknPjW4kerzjEuCYER+R058I9Q37og==
X-Received: by 2002:a9d:66d5:: with SMTP id t21mr23559780otm.130.1560495057553;
        Thu, 13 Jun 2019 23:50:57 -0700 (PDT)
Received: from localhost (200-52-42-156.reservada.static.axtel.net. [200.52.42.156])
        by smtp.gmail.com with ESMTPSA id q12sm833845oth.25.2019.06.13.23.50.56
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 23:50:57 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Mark Lodato <lodato@google.com>
Subject: [PATCH 3/5] completion: remove zsh hack
Date:   Fri, 14 Jun 2019 01:50:49 -0500
Message-Id: <20190614065051.17774-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.22.0.rc2.dirty
In-Reply-To: <20190614065051.17774-1-felipe.contreras@gmail.com>
References: <20190614065051.17774-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't want to override the 'complete()' function in zsh, which can be
used by bashcomp.

Reported-by: Mark Lodato <lodato@google.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 1 +
 contrib/completion/git-completion.zsh  | 6 ------
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f71bcde96..57cced3f51 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -3066,6 +3066,7 @@ __git_func_wrap ()
 # This is NOT a public function; use at your own risk.
 __git_complete ()
 {
+	test -n "$ZSH_VERSION" && return
 	local wrapper="__git_wrap${2}"
 	eval "$wrapper () { __git_func_wrap $2 ; }"
 	complete -o bashdefault -o default -o nospace -F $wrapper $1 2>/dev/null \
diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 067738d93f..58b3b5c27d 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -18,12 +18,6 @@
 #  zstyle ':completion:*:*:git:*' script ~/.git-completion.bash
 #
 
-complete ()
-{
-	# do nothing
-	return 0
-}
-
 zstyle -T ':completion:*:*:git:*' tag-order && \
 	zstyle ':completion:*:*:git:*' tag-order 'common-commands'
 
-- 
2.22.0.rc2.dirty

