Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7957C0502A
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbiH3Jcb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:32:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiH3JcL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:32:11 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF0FA262D
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:59 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id m21-20020a9d6ad5000000b00638df677850so7672885otq.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=48c2N2EyXPtPruhNliOaiDF4uD1lfRJ+2RdzFVO51GA=;
        b=G60gQgd9RKfvo9jjs6Mz+2jxWlqHxLQzUPHPrciCG5HIhU7QugQdi4ZnshOXXb+SCs
         RGqbnpPvtsVtkCP36ta+iOkmIIfg1qLQUHK43s683qPvZT+3w2yxLzVcHzaj7Zq39NU9
         ZkxnZ/zeGOxkoL2wvYVaYhovP9rsVSCWIeTb+D3SU4Ajry1oDT3qb+3QgwGznLlUBbcA
         fJvLYyv2KMAFOO9Hbb72rcN52wfg3jaejALtDVsUZDkRk8/1lJte+me8USFw5sdLmVh3
         CGlmnYUGwVtZs7v8k3zTq/RxLXbcbQLL9tNIBiCA/I1JjnISF6FhAeI0ahM6Il0YbDoC
         u1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=48c2N2EyXPtPruhNliOaiDF4uD1lfRJ+2RdzFVO51GA=;
        b=TyuGSNoXyF2xavm3Tmp3jA2gAKHZXlJsZBNsSQ1xbLRef5yxtG2OSKMAiX3N4OXV+l
         D2nAs5/uV7cFUsYugecYcIQDrmcJa6eWuwbCg5i4SAp08BNeqAbbuZsAELQW7uBcGkEy
         /I85N05ks8lSGR7CvkccC3igRw7Ojkkx3/Xp8YNs6Bk1BNngapvBpZptEmiYNKV/ynWj
         jQj8WDKTCYGSGr7rRA2NEj8+4ZmcMvqAN+5U3CnnuR3JvXtNxCP8lLGlm9kffkrwa9vC
         c5gzB3JJRFqsATkr5XgaV8SGadXfEICXAVZfD5vyGC0c/nWtk9r4S5zRnMlVvL4ruvXe
         6XVA==
X-Gm-Message-State: ACgBeo3O5UnYrgGEjbdxSjXNgAof8b/ubSxuLm0ZoGL7em2kqgbEX9tR
        CLnKS89V9QGzIk2l29iGWsSOSoym/lk=
X-Google-Smtp-Source: AA6agR4EX5A06Fp/pYTZxocI33NzKYy1lMGshdSUkIRUCw5HKPB2Ag3k7S/lCIM2yNNPp7y5/F34RA==
X-Received: by 2002:a9d:7495:0:b0:639:5528:9f1 with SMTP id t21-20020a9d7495000000b00639552809f1mr8237570otk.12.1661851918455;
        Tue, 30 Aug 2022 02:31:58 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bl2-20020a056808308200b00334c2e81dfbsm6022761oib.0.2022.08.30.02.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:58 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 11/51] completion: zsh: trivial improvement
Date:   Tue, 30 Aug 2022 04:30:58 -0500
Message-Id: <20220830093138.1581538-12-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

$words has basically all the words we need, except the first one: git.

Lets simply add that instead of passing the original, which contains
options we don't want to pass downstream (like -c and -C).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 1905ff98b7..4d81ca73b5 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -220,9 +220,6 @@ __git_zsh_main ()
 {
 	local curcontext="$curcontext" state state_descr line
 	typeset -A opt_args
-	local -a orig_words
-
-	orig_words=( ${words[@]} )
 
 	_arguments -C \
 		'(-p --paginate --no-pager)'{-p,--paginate}'[pipe all output into ''less'']' \
@@ -262,7 +259,7 @@ __git_zsh_main ()
 
 		(( $+opt_args[--help] )) && command='help'
 
-		words=( ${orig_words[@]} )
+		words=( git ${words[@]} )
 
 		__git_zsh_bash_func $command
 		;;
-- 
2.37.2.351.g9bf691b78c.dirty

