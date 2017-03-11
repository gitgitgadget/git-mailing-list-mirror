Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BAD201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 00:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932694AbdCKA0V (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 19:26:21 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33245 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750922AbdCKA0T (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 19:26:19 -0500
Received: by mail-pg0-f67.google.com with SMTP id 77so11793068pgc.0
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 16:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=wf9VEvlGN3G3hQqql4rCG6WUWu/1TBWSRscF3/DzJng=;
        b=tvf/U43CJOgvPO0BdhlN3tGNRvLJjlAkv83+Q+MgqKTGRvj8CeajApEfY+YwtdsMoB
         NUB35M5kjiz+AGNKaM1bxC7QOyPiJKWTK2wPIj7tuk+dIMREEk6+mnnFIlGFgHz48iWw
         BcVxg7i65msbwNzfl/E9pv3ny1eSCvL2uQTNVEj4K5RC5Opjxu3DJApZuRuiY18FHBTP
         8NQGqZGewIxhmHt0DSHQdlTiqii2qtOnmBWdMAC9fkQGOK5lDKtQiVaMSpzLFIjAujio
         BUL8oPSAihC1qdtvYJkIYJi7/7xXrdAhseOGTKxGGEUfQLk6qhSKQHCo/9aO+hixJ/ZF
         bgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wf9VEvlGN3G3hQqql4rCG6WUWu/1TBWSRscF3/DzJng=;
        b=hqEaC8m3Hgk5YARMQrwCDRE/TutFm8a3Qbqmb4mu7YkowE1bOhTcSvIFYt/M1jmpWa
         pHrScZKyk39aXP2FSp71HNqhWS+/nX9WCz82j69BL4RrL4Wg+EwWVfmXl8ceQkvgKfa/
         FFd8nOHYFdTCsKcIGvYrusABW/eWJpHWu8Nxkw3Yyf+i/YoxsSOQZMjhrMEksEy4Scgi
         iPhjrYPSrgdV9QifV/fGkmwTZFmxExS2UkW55Q70qaLMQXCouzqUi9SHDfFQOCqLrQIL
         Ju530LcoDZxdTOma3NcQvjgnLEIOxLAjKRfY0K552pxKmVunAc9uJdV2Pv6G5eo43juM
         gppA==
X-Gm-Message-State: AMke39lOJYds+rlQ8S0jh75MetwxO7q1tWYlozIVe2Ttl+BfsdJXl4ZttOrdrBn0Di1ILQ==
X-Received: by 10.98.16.11 with SMTP id y11mr24499599pfi.84.1489191977699;
        Fri, 10 Mar 2017 16:26:17 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:1000:5b10:9cce:1925:a4e:f6c5])
        by smtp.gmail.com with ESMTPSA id 80sm20647784pfy.67.2017.03.10.16.26.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Mar 2017 16:26:17 -0800 (PST)
Date:   Fri, 10 Mar 2017 16:26:15 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Devin Lehmacher <djl329@cornell.edu>
Cc:     git@vger.kernel.org,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: [GSoC] Move ~/.git-credential-cache to ~/.cache/git
Message-ID: <20170311002615.GG26789@aiede.mtv.corp.google.com>
References: <8BE1A361-32BB-4164-AD54-949555855C52@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8BE1A361-32BB-4164-AD54-949555855C52@cornell.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+cc: npostavs)
Hi Devin,

Devin Lehmacher wrote:

> I started working on this microproject and am not quite sure what is
> necessary for backwards compatibility. Since the socket is recreated
> whenever the credential daemon exits backwards compatibility
> shouldn’t really be a concern with regard to where the socket is
> located in the filesystem.
>
> However, contrib/persistent-https depends on the socket being at
> ~/.git-credential-cache/socket, so changing the default location
> would break this. However, if we need to keep the socket at that
> location for cases like this I don’t understand how this change
> would be helpful in any way.

That's a good question.  If I'm reading contrib/persistent-https/
correctly, it uses the same directory but doesn't rely on the socket
there, so it should not be a problem.

However, that reminded me to search for other tools that might rely on
the socket.  Using
https://codesearch.debian.net/search?q=%5C.git-credential-cache, I
find that magit does rely on the socket path.

 $ git clone https://github.com/magit/magit
 $ git log -S.git-credential-cache
 commit 0f30dfbb0075ac2e99b65a2c7fac360197a989c1
 Author: Noam Postavsky <npostavs@users.sourceforge.net>
 Date:   Sat Oct 24 15:57:54 2015 -0400

    Start credential daemon on magit-credential-hook

    If we let git start the daemon, Emacs will send a SIGHUP when git
    finishes and closes the pty, killing the daemon.  Hence the need to have
    our own daemon running first.

Cc-ing Noam to figure out what a safe transition will look like.

Thanks for noticing,
Jonathan
