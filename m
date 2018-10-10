Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED0A1F97F
	for <e@80x24.org>; Wed, 10 Oct 2018 02:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJJJqa (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 05:46:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38827 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbeJJJqa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 05:46:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id a13-v6so3866617wrt.5
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=cnAO38NfFrEfy+z2YJqr+p84hmv6kS+M1fHOHaaY22o=;
        b=oi8ehecCPEnbRwP0Ji56BI+GDB7L/HsnEPo/9kIAbrbgLOZJTPx3kcRNhcpfD8wqxD
         CP5ZUI5SvYlewcuwt/DnEROg61pqtP1gmHxq0MW43iVyl395j0HFoVDy6CHVFRMaTf8m
         u3sTVLv+ojIkOIslE28p1HNYxkWmx20YlDD/Pv222Evx0gNf7HQOCUy/FxXeY8Eb22E9
         Q8Ur8eALTJGktsq3MZl77yU6lesHQyN50VQS1GuCukWgxU04f6QM5ddmblcnevR0A/CL
         EBfMXq3JEAkGHjfs+AYTQom8wwiuKQMSZdSJXvQeAfruEpnk4gA6YQYHN0I2ReVPDaFg
         Oqfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=cnAO38NfFrEfy+z2YJqr+p84hmv6kS+M1fHOHaaY22o=;
        b=GGg8GzmE0N0bTcPYm7EZfcMUkLVEik5b+ahyFtO259IU30iUir35NTpeDNduPWY8wd
         k28m99VdK2lteX6kk+7aWotND8cZcbijcC8B9FQRy2H8kt+ZCzd5VlrCgxGF1aTNsZ81
         PVujulMG0a3LTrJR1Q54cur1TlVpQccC257SXpVt+kaHeHPLzuGd6qxfMIR/JbwOuBx+
         FNKAmPS/zueTCgD+V8uwXcK53WNjheN2VeXVraz3w2P/sBkjRDRfWp0o7Sl3ItpWjjdS
         bG6YJ/Mvvye8f1eGqQ9Cs5acQoQ/Nmw8YEcu/d9fU52tjr3G/2N/ykk5dGe5xNmL90KQ
         w9BA==
X-Gm-Message-State: ABuFfog97CnaCy39oxdQUKZGan4TGbkRgJP26WJMjWREln7wE3Xi/8pL
        UsEdEejlLaWCD7sVurDkKKs=
X-Google-Smtp-Source: ACcGV61zUSOtSEekXGT6BeTpjqcLL3uzEl3oQ8Gfj7csoiaXKLzBPWsclpg+YG4e/LxiVHrjso+zYA==
X-Received: by 2002:adf:9426:: with SMTP id 35-v6mr21909149wrq.54.1539138394678;
        Tue, 09 Oct 2018 19:26:34 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 65-v6sm16606057wmm.36.2018.10.09.19.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 19:26:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Hesse <list@eworm.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] subtree: add build targets 'man' and 'html'
References: <20181007073036.30643-1-list@eworm.de>
Date:   Wed, 10 Oct 2018 11:26:32 +0900
In-Reply-To: <20181007073036.30643-1-list@eworm.de> (Christian Hesse's message
        of "Sun, 7 Oct 2018 09:30:36 +0200")
Message-ID: <xmqqmurmmt9j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Hesse <list@eworm.de> writes:

> From: Christian Hesse <mail@eworm.de>
>
> We have targets 'install-man' and 'install-html', let's add build
> targets as well.
>   ...
> +man: $(GIT_SUBTREE_DOC)
> +
> +html: $(GIT_SUBTREE_HTML)
> +

As 'contrib' material without real maintenance, I do not care too
deeply, but shouldn't this change be more like this to avoid
duplicating the list of targets?


diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 5c6cc4ab2c..4a10a020a0 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -59,17 +59,21 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
 
 doc: $(GIT_SUBTREE_DOC) $(GIT_SUBTREE_HTML)
 
+man: $(GIT_SUBTREE_DOC)
+
+html: $(GIT_SUBTREE_HTML)
+
 install: $(GIT_SUBTREE)
 	$(INSTALL) -d -m 755 $(DESTDIR)$(gitexecdir)
 	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(gitexecdir)
 
 install-doc: install-man install-html
 
-install-man: $(GIT_SUBTREE_DOC)
+install-man: man
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
 
-install-html: $(GIT_SUBTREE_HTML)
+install-html: html
 	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
 
@@ -94,4 +98,4 @@ clean:
 	$(RM) $(GIT_SUBTREE)
 	$(RM) *.xml *.html *.1
 
-.PHONY: FORCE
+.PHONY: FORCE man html install-man install-html

