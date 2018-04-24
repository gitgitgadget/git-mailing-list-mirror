Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999291F424
	for <e@80x24.org>; Tue, 24 Apr 2018 02:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932739AbeDXCLo (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 22:11:44 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37025 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932688AbeDXCLn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 22:11:43 -0400
Received: by mail-wr0-f194.google.com with SMTP id c14-v6so6123453wrd.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 19:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=fmDeGZfG3ATGZ0FEpsF9ObvTWAkRfocvAb1bYyGYmYo=;
        b=V7lgJpzC0sX2Bb9k/5fnhzpi2y2FjqMIiPoLrf+R9+ZPHmuJrJ7DE8X/Bc4S6gZ4AP
         NxFxT6JlhZBsBKjAO6DYFkq9wRaEgL0Ijx3koMk/nCMqUy8MlnILwjK3HJU6PYEg0Uh1
         mLHyax4BxzQ3eVxxB+pY2jmcTZsz+hMNrrwlPDiEnwPnAAbJnx4vCrELDmhs7Cpfu4Vj
         V6D2OCwS+SeBXmtjW2Bsx6EgeHMimGgV3bleged71lOqJ4TZwrxa2rIfiRvzXka645yw
         L4RVe7gJCACmFSp1asD6l5Ytt9FLH73tR7ReKRoYCM3kBe1FGiFVw0W9sZsDFLMwN41H
         ilmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=fmDeGZfG3ATGZ0FEpsF9ObvTWAkRfocvAb1bYyGYmYo=;
        b=R3tf1U3luqf99u4AP8XzUJ7nQneQU+cxy2VssVLb1fhIkP/L5Th9kgrwCPLJQyjMLF
         VvwGnndvGdS10CJw22QnYhAk1HxaDlpEFVJFHxaHoYjQKrNUdZhl1k6ADHjc5I0K986L
         11eg2UDJ6Qzi4HC/mH0EMR8PvDC0IWWs61LyjXAnmRPaJdKVVV6KKdPt4cuQlf50OQ+e
         BLME6jSTD9Q+vpwdKVbSJ9REW25xquIgepuIlc7qi833s1kLs8HpXftVWJkaRQ3smT7n
         Gy6RxC9uzTAx8APIWour10jPUJyL8JRF2dBYzYcnDaBxtr1XiU9lFS0V6gMogURf2oGL
         TmoQ==
X-Gm-Message-State: ALQs6tD3YTlNluvSjgTApRk76lCSae9m9FDhWhcanAfr84Y46WbqgJl9
        3zcyH5CPdPfaowbpc16tuaI=
X-Google-Smtp-Source: AB8JxZqh6x8/MMfei0L0UJeCoVBA8Cxy0Wu2yrLzbZ2uMq2GptyjvhbQbA+cA0QpahiexQKPiSB6bQ==
X-Received: by 10.28.94.201 with SMTP id s192mr11232212wmb.42.1524535902139;
        Mon, 23 Apr 2018 19:11:42 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p33-v6sm19384999wrc.14.2018.04.23.19.11.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Apr 2018 19:11:41 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Dan Jacques <dnj@google.com>,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, git@vger.kernel.org,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 1/2] Makefile: remove unused @@PERLLIBDIR@@ substitution variable
References: <f0ad1ad4-67d8-21e2-fdd0-0a08328c1eaa@kdbg.org>
        <20171205212625.6616-1-dnj@google.com>
        <xmqq7eu0j1th.fsf@gitster.mtv.corp.google.com>
        <e0a22ee4-9503-760f-293c-be56fa46fa04@kdbg.org>
        <20180423232326.GB25128@aiede.svl.corp.google.com>
        <20180423232422.GC25128@aiede.svl.corp.google.com>
Date:   Tue, 24 Apr 2018 11:11:40 +0900
In-Reply-To: <20180423232422.GC25128@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Mon, 23 Apr 2018 16:24:22 -0700")
Message-ID: <xmqqin8h73qb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio noticed that this variable is not quoted correctly when it is
> passed to sed.  As a shell-quoted string, it should be inside
> single-quotes like $(perllibdir_relative_SQ), not outside them like
> $INSTLIBDIR.

Spreading credit is very much appreciated, but in this case the
above belongs below the three-dash fold, I would think, as the
incorrect quoting become irrelevant.

Will queue.  Thanks.

> In fact, this substitution variable is not used.  Simplify by removing
> it.
>
> Reported-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> An unrelated cleanup noticed while looking over this code.
>
>  Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 154929f1c8..8f4cb506ff 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2109,7 +2109,6 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
>  	INSTLIBDIR="$$INSTLIBDIR$${INSTLIBDIR_EXTRA:+:$$INSTLIBDIR_EXTRA}" && \
>  	sed -e 's=@@PATHSEP@@=$(pathsep)=g' \
>  	    -e 's=@@INSTLIBDIR@@='$$INSTLIBDIR'=g' \
> -	    -e 's=@@PERLLIBDIR@@='$(perllibdir_SQ)'=g' \
>  	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
>  	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
>  	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
