Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23C0B20A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbeLMTh6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:37:58 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:42743 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbeLMTh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:37:57 -0500
Received: by mail-pl1-f171.google.com with SMTP id y1so1515351plp.9
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2JRd8jytHQd29gFbAH435KQPchJGyVnZ6tB+7Ncs9AI=;
        b=f+qQxudadBiWPlQjow9ogBGq4AswYYM9XLb/6y2VdaEV4QsG0fJmzMRuK0uT8anNHt
         eQSNeiVnjwHRvIAfrbqjo5MIOYrEkkeiNlGj2HSVYxE2wuVCzGzZWZsflHNZ+94cnxXS
         G9nQGPI8xhbzee6EIUPusSvuuMsAzSFyVFo0Wzo/Y16RsqU57+UKjHUfcqneavygO0W3
         U5E03WnhdbUYtvZx7ZpnDbhpf90iKebjp82gmS0h3LeszwNNhMyVXjIR5H6wrr8a/zpr
         +zPqPTpOfH4w9oijpNKJ+puZiVWnC4hviJt0MM0yENUSzBaoc+c5p/XAnxd+LSxGwhTc
         B9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2JRd8jytHQd29gFbAH435KQPchJGyVnZ6tB+7Ncs9AI=;
        b=IEw7YVb6QPwT3kaaZaK26M55++BbVKsOO1+x3kS091qr3h40SYSesUYNX1dd2qdyck
         b9RWt5Wxp8qFqqgbC87U/f5nfv0Zd99K/z3nJPD5MGkbJ55vj7NUKs7HFUAijBPqBjRQ
         seNWRYYg0qmNkNE6yfYVb2AUlDv0W5pYs1B2VjwxJA8bNik9+gNkz3gdnP/0FGyWJ2oc
         EVY58d5jRmDHAm8WZkXWrDomRydDfEFijz7JejLBd7/sgas5oP9K5NC3v+NRc9nbX3k2
         Fg5dsz1XcZ7ogVhCwrxlSJ8uYxmnjz3BId0czZPIM+zarZIj1Z/LArCFS89sVgv+F88Y
         li5w==
X-Gm-Message-State: AA+aEWZr00Gpm24clmmYTMvm5OqRFwvCEt3jcNhzcOdzZwF4gElQV85n
        Ap80IjbBJ/RPxKxm06cb1r6T8ss7
X-Google-Smtp-Source: AFSGD/VfJhNjcav6d6qwxViuoSfqQnV32+IYhJggpxQxYM6GmHRvfvM6H+fxKvfLjMJERHb4kZCmig==
X-Received: by 2002:a17:902:4025:: with SMTP id b34mr70733pld.181.1544729876855;
        Thu, 13 Dec 2018 11:37:56 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id 15sm3554290pfr.55.2018.12.13.11.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 11:37:56 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:37:54 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     William Hubbs <williamh@gentoo.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, chutzpah@gentoo.org
Subject: Re: enhancement: support for author.email and author.name in "git
 config"
Message-ID: <20181213193754.GA7306@google.com>
References: <20181206181739.GB30045@whubbs1.gaikai.biz>
 <CAN0heSp2g0A82YYvMw-RaERESXFtj3TgPKA3RysC07Lf=tHBcg@mail.gmail.com>
 <20181206191737.GA31091@whubbs1.gaikai.biz>
 <nycvar.QRO.7.76.6.1812062318570.41@tvgsbejvaqbjf.bet>
 <20181207222147.GA22590@whubbs1.gaikai.biz>
 <20181207224428.GE73340@google.com>
 <20181213192930.GA21006@whubbs1.gaikai.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213192930.GA21006@whubbs1.gaikai.biz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

William Hubbs wrote:

> Is the git team on an irc channel somewhere,

Some like to use #git-devel on freenode.

>                                              or should I start sending
> patches that I know are incomplete to the list?

Yeah, that's fine.  Include [WIP/PATCH] in the subject line to set
appropriate expectations. :)

Thanks,
Jonathan
