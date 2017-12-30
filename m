Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F96A1F406
	for <e@80x24.org>; Sat, 30 Dec 2017 08:28:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750855AbdL3I2T (ORCPT <rfc822;e@80x24.org>);
        Sat, 30 Dec 2017 03:28:19 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:37793 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750815AbdL3I2S (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Dec 2017 03:28:18 -0500
Received: by mail-wm0-f48.google.com with SMTP id f140so50811170wmd.2
        for <git@vger.kernel.org>; Sat, 30 Dec 2017 00:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:mime-version
         :content-transfer-encoding;
        bh=wujB0ukYzNW504sGIHuGABIysqp3bTUNnx+acxwY5vE=;
        b=l4wUKZQnXcl0mT1Ff6UZrSxilWoGkrTZSFX9fJDYuP5jcLMvXm1paC9cJiRO4ub6aA
         fYRl65ZqGtQ5yXGsaN9sSHnigkT3PmrEJpaZZRJjRUixBY01+J1ZiHs7V11i+hdDMe8z
         fgBEdyQ9MAxOt4VL+pRept/H3pCcqhE/9bf9aac8/0yeeLPdrdXdkde0pYhq36vANxCI
         zQaRXMnbHgsBftgsfv5WGqNchk5hfC+akrpEPsOsu+FSxpAaAVHTZscloGfMmqMtxZQD
         P6nbcBoaj/6kL08JR9pRJJ8LoWItpTG1P9dezSUhmGwt1TOc61oGod3Gl9T3qZ0TM5Ge
         rX+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :mime-version:content-transfer-encoding;
        bh=wujB0ukYzNW504sGIHuGABIysqp3bTUNnx+acxwY5vE=;
        b=ubnaFRYJ39EzW6q0TAFC+KGi850F16KXLOVK1gTQQ0tURENWnAQEEBQ2cSuu1ftmoF
         bd8EA/hWtBDFp1v/3RK7Z3nU1gPRIgNoJAcwS7Ct0UrJJLRwrEkiyFzAf/DNfMPspRzT
         giue0b6skr7JL4b1pnvSL2KRj5ZZB6u0yVLqU4IFbUkrdHizhJP8yUsl0FK/k0/zUoLp
         wfWQyT8p/n4qtfmnFti78k7WKVYV77WWkYPPXt9EYBl7MIzZApL0HMcihTbZwwicCyP2
         vIEOJBXiUNknYy8NiqOfvn2goH6C4p0XXB2clpY5PMVbTRIG3QJJbd7J5nIhomnipSG2
         0cbw==
X-Gm-Message-State: AKGB3mJ7duUciM3bA63zbMOFJcwTjHErwOGHOzONe+5D50gsUA4DfhT2
        Yeadb7Kz3lpnwkOHn/b5yik=
X-Google-Smtp-Source: ACJfBouWSFqv1HaL//v4W5wdlWZEdsIvcliivQ25JtHlHwtgGXaIwjZ52E+/MVIArKHm6cgG4jWhig==
X-Received: by 10.28.224.137 with SMTP id x131mr29793183wmg.49.1514622497319;
        Sat, 30 Dec 2017 00:28:17 -0800 (PST)
Received: from localhost.localdomain (94-21-23-100.pool.digikabel.hu. [94.21.23.100])
        by smtp.gmail.com with ESMTPSA id p17sm20932126wma.23.2017.12.30.00.28.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Dec 2017 00:28:16 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Ernesto Alfonso <erjoalgo@gmail.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: possible completion bug with --set-upstream-to=
Date:   Sat, 30 Dec 2017 09:28:06 +0100
Message-Id: <20171230082806.6303-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.67.g3a46dbca7
In-Reply-To: <87bmih83iu.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Whenever I type the last <TAB> to complete origin/master, as in below:
> 
> > git branch --set-upstream-to=orig<TAB>
> 
> what I get is:
> 
> > git branch origin/master

Yeah, this shouldn't happen. 

> instead of the expected:
> 
> > git branch --set-upstream-to=origin/master

And indeed this is the expected behavior.

> git version and OS:
> 
> >git version 2.1.4

I couldn't reproduce the wrong behavior you saw using v2.1.4 in a
regular setup.
 
However, I could reproduce it after I removed the '=' character from
the set of characters in $COMP_WORDBREAKS, but then all completions
after an '--option=' are affected, e.g. 'pulseaudio --daemonize=t<TAB>
becomes 'pulseaudio true', too.

Could you tell us the content of your $COMP_WORDBREAKS using the
output of the following command (to make the included space, tab and
newline visible):

  printf "$COMP_WORDBREAKS" |tr ' \t\n' STN ; echo

If it's indeed the case that $COMP_WORDBREAKS is missing the '=', then
you should add it back and check whether it fixed the issue.  If it
did fix it, then you should try to figure out how the '=' got removed
from there.  Perhaps you used a program that ships its own completion
script whose developers changed $COMP_WORDBREAKS to their liking, not
knowing about its effect on other completion scripts.


Gábor

