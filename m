Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3F91F424
	for <e@80x24.org>; Mon, 23 Apr 2018 23:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932615AbeDWXY0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 19:24:26 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:41798 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeDWXYZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 19:24:25 -0400
Received: by mail-pf0-f194.google.com with SMTP id v63so1007151pfk.8
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kZCCjjOX/iac9xoJ1mYbkz1KO5l/rJO/V4yfCOodFHE=;
        b=AJGpxzUgOOHniUxYsFK0nIoBe3jWAlE3K6wZOdBmFL6dSwchkWVRbE8s18sklrD5/Q
         Jc0fLbbE3Y9QV+aHhgMtYsnL0xM3OD/6hbHjDFEHIwJul3xGu8kZYIUq6IwcDQxtsKp2
         Ueuafq2u7QPHJCAchEBygLHEoeuC+u88HxksfMQWv6JSQfQ4GB9+yRSsU/EaBVWvJIjg
         0dFgDfhkadVMmognwbCdCiDHT0zMnOn4jE3le3u9mQK0Ulc+T90wV8Mhr5yBezxtVo5U
         IIMUgxKFFjzTmyseeybBYhsQWSVFiNEqz4lHFuay4zLdVbLd4ztp4vZ6MyHzvdzKhaFO
         NoTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kZCCjjOX/iac9xoJ1mYbkz1KO5l/rJO/V4yfCOodFHE=;
        b=NOi1etlfUOO/7M5mCjIifxAsp6vuV6a4joudYoUQfycIRYbA4IO7XSc368oE6GG9s9
         lnVXM2ZueilxX2B4jrpDRCu3FrUy1gB8NKqwjIkPvrVeJrE3flze9GFAkr+YzzHsCK/3
         qwN4tfok5AWsGkBy7Tq5Nni9yRQC2ESU2GPWmOXN3A9AYFlMv7cfWSAAJEacI0MHfvDX
         1VFOgVvDs65eywl4QmsUpyF6PrerZS+x/7bFt6STWJkIqBabNyCTkHjnc1Q50Y/zTbFH
         7Up5omGvBrv1By+bE8AcYcxUPnD8oOzXhCw4V+itJmPZQ9OEV9oclpd/IlMZTwWi7wmJ
         gP9Q==
X-Gm-Message-State: ALQs6tBnr8TIfwpF8FEwKLlGTJNu9dDDHcuk2Qy2ru7Ay8mRA7HnHGCJ
        q4jKz/gM0Ha4Ml0yZwcKP+o=
X-Google-Smtp-Source: AIpwx4/2UNzyiQvkAiLxcdk48mEYd3X5eWgHkln3V8EqREjN0A283rcaRMldLpNFhnlCOf0aoE4ZRw==
X-Received: by 2002:a17:902:bcc8:: with SMTP id o8-v6mr22095712pls.84.1524525864892;
        Mon, 23 Apr 2018 16:24:24 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id m185sm28081023pfc.88.2018.04.23.16.24.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 16:24:24 -0700 (PDT)
Date:   Mon, 23 Apr 2018 16:24:22 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Dan Jacques <dnj@google.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 1/2] Makefile: remove unused @@PERLLIBDIR@@ substitution
 variable
Message-ID: <20180423232422.GC25128@aiede.svl.corp.google.com>
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
 <20171205212625.6616-1-dnj@google.com>
 <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
 <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
 <20180423232326.GB25128@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423232326.GB25128@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio noticed that this variable is not quoted correctly when it is
passed to sed.  As a shell-quoted string, it should be inside
single-quotes like $(perllibdir_relative_SQ), not outside them like
$INSTLIBDIR.

In fact, this substitution variable is not used.  Simplify by removing
it.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
An unrelated cleanup noticed while looking over this code.

 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 154929f1c8..8f4cb506ff 100644
--- a/Makefile
+++ b/Makefile
@@ -2109,7 +2109,6 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
 	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
 	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
-	    -e 's=@@PERLLIBDIR@@='$(perllibdir_SQ)'=g' \
 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
 	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
-- 
2.17.0.441.gb46fe60e1d

