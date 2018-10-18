Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77A591F453
	for <e@80x24.org>; Thu, 18 Oct 2018 02:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbeJRKHo (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 06:07:44 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41007 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbeJRKHo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 06:07:44 -0400
Received: by mail-wr1-f65.google.com with SMTP id q7-v6so3938550wrr.8
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 19:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=72OT0D/H5MAq/jAG6YGEEpQmvajJWLUYCy9mscNTy3Q=;
        b=j4gdm/efYlpIBZcEL07pDkz8ySxhejZVHAsDupgOuJybmOWCMKCcYtofWoCCAGdLBM
         oiSMGgqUsFozjjAZY+qqeDQcSQ3uURoC9o49aWs1HN2AtvStGZ1DswxzCGviCeaxaSzD
         KEHzSMwMGXgTX+ZjspnanOCW8GgwymOLqH+SPX2nKx4BbcG5SaWrdNP4tirfN8lUfngL
         hoVlIkL4pI4TtmPmUcrUDYdKCqGzrjnFEy5aboq5UxMTxApmhqdQFWvvsXlct25kTCHC
         IxqtEVwJ6rmTqOTi6Y7uOA8mSIJnWlQKJidvkk9UozYrDZCWwqABAAVTfwLd36JxNkIr
         s1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=72OT0D/H5MAq/jAG6YGEEpQmvajJWLUYCy9mscNTy3Q=;
        b=buGp8RYFg94qGav1d2Mnjp1CgXmCI74qUdz0U0vS1BJubvMVlhY+r3AEXK/oIbBngO
         DA2b5lVuXygkX7vmNfZq8ccGsXmke1irs5XowJTKVoYLERFrZyCCFJ4DXVn4M23pBz5a
         AvTF2qUpX8Xwa9LX0YiHsTeXnU/IEnt70OeiZB6I4Xrcd2SJASe9sC90POxIoXsaexQi
         xq4/t3aqq4IggLZ6ETWNJ4fCRC7paK9OX8WQHkvM2oJc2QnXFzh8OHgmS9JyAtII4h1Z
         ZCGI9jmx04iPaDPf8QquJ5P/maLzny7UCL0AosXI5BzTU9sZe1pWV8Fob8Uq7jUNP5n5
         K11Q==
X-Gm-Message-State: ABuFfoj9U7knQnkAEloOG7x721b/pM/OYRop0lKJPbh4U5dBKVLekMuJ
        h/OPR6/65uGQs3p3qrSNo3E=
X-Google-Smtp-Source: ACcGV61Ei68J3qDvLQQn2myaOvnhByZMtFBQj41YSFwpzGeUUi6r5BPpgIF0NLrWE2O2BefA5q9uEA==
X-Received: by 2002:adf:fd83:: with SMTP id d3-v6mr25892006wrr.25.1539828547896;
        Wed, 17 Oct 2018 19:09:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 18-v6sm3884048wmw.26.2018.10.17.19.09.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 19:09:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Christian Hesse <list@eworm.de>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] subtree: make install targets depend on build targets
References: <xmqq8t2y1o4y.fsf@gitster-ct.c.googlers.com>
        <20181016075624.30176-1-list@eworm.de>
        <20181017024503.GA117170@aiede.svl.corp.google.com>
Date:   Thu, 18 Oct 2018 11:09:06 +0900
In-Reply-To: <20181017024503.GA117170@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Tue, 16 Oct 2018 19:45:03 -0700")
Message-ID: <xmqqftx4vwe5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> The rule says
>
>  install-html: html
> 	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
> 	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
>
> and $^ substitutes to "html" after this change.

Sorry about that.

From: Junio C Hamano <gitster@pobox.com>
Date: Thu, 18 Oct 2018 11:07:17 +0900
Subject: [PATCH] Revert "subtree: make install targets depend on build targets"

This reverts commit 744f7c4c314dc0e7816ac05520e8358c8318187a.

These targets do depend on the fact that each prereq is explicitly
listed via their use of $^, which I failed to notice, and broke the
build.
---
 contrib/subtree/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 4a10a020a0..6906aae441 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -69,11 +69,11 @@ install: $(GIT_SUBTREE)
 
 install-doc: install-man install-html
 
-install-man: man
+install-man: $(GIT_SUBTREE_DOC)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
 
-install-html: html
+install-html: $(GIT_SUBTREE_HTML)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
 
@@ -98,4 +98,4 @@ clean:
 	$(RM) $(GIT_SUBTREE)
 	$(RM) *.xml *.html *.1
 
-.PHONY: FORCE man html install-man install-html
+.PHONY: FORCE
-- 
2.19.1-450-ga4b8ab5363


