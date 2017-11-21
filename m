Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A040202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 01:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbdKUBKY (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 20:10:24 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:40941 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdKUBKX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 20:10:23 -0500
Received: by mail-io0-f193.google.com with SMTP id d123so1645587iog.7
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 17:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=84u1xaonovsmUV2/yVKrcpnufmWay7r5vezKEXx+LAM=;
        b=KluBF1CraTsLzYjCsBPEFIu/NHrlQMW/dvXpzJ8qw/TLySKI9U5jGWpIJhWFs7Wryh
         tQ7hFy3LSpWtGyE1e6XNuvHmrgaE86QQEwS0L1YnxtM1VJF3c2P9wib6prtv/BXzUyJ+
         EmUuV/lhQfZloH+rLHoDUFokVe1Eq4XECRxkwjmgMmnJardYanOQAlab7NO/sMQacGNO
         xeSdtTkDjH4X8iGFrnpep09Dedw//SWw5Wd6BfvN0cITNr5HVN1qazu4ivMvxF/Xf6oX
         gQlh8QaEBqJzwGV9tFQhultEpz2X4iLWkjNDOiKyS83JwXhltnxsg4Wi+TbaxIrjZ3q+
         qprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=84u1xaonovsmUV2/yVKrcpnufmWay7r5vezKEXx+LAM=;
        b=i1vcMOQrbuocb5IQYbioPgQIZgzXTMp301qUVwa7IJMg/0XLGg5lYUWiBV2cFUSqEc
         ZB4N6BRa+sSpzbt04iwQ03g2r1oscylBztV4zphZqptBsdzUWJTVdDjbD0fwRZ2/bgsX
         ww6AaKkUP3lLLi+CorGf6keUJJ3YEOY99G+e8gOnl+Mk/HGIoasx9PkeRRRZsHunsE2U
         RGBd0vEQ3NwqhQB+yTIGmFeXzQWWN6IJTsKbhZ0kce6q7v4YiXLXHVM3BfHQop24dLse
         52RFz9WSHoDhEmhcRAvVGXHSKIKlV8D8CWUosecrLKRQ7iB9sZ+gLG7yAGdwohRMqD63
         V08Q==
X-Gm-Message-State: AJaThX7TBFRjz/x8PnGxwKX0obLwTpOFSx6V5fKlM0rNCAHi/x/nbBrY
        7yNWKwlYZDRWaQZDa6MXu4M=
X-Google-Smtp-Source: AGs4zMYo/AGy4qlqpWSFQylvhhdvDQ/g+SqUXWe+ZHBgWFAH3rZT7fQbkJ9Znk3V8/nTnYmYCIM0dQ==
X-Received: by 10.107.53.98 with SMTP id c95mr566551ioa.199.1511226621322;
        Mon, 20 Nov 2017 17:10:21 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f3sm4856137iob.70.2017.11.20.17.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Nov 2017 17:10:20 -0800 (PST)
Date:   Mon, 20 Nov 2017 17:10:17 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Yubin Ruan <ablacktshirt@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Ross Kabus <rkabus@aerotech.com>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Charles Bailey <charles@hashpling.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: Draft of Git Rev News edition 33
Message-ID: <20171121011017.e2aac53zfo2n2whc@aiede.mtv.corp.google.com>
References: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
 <CAJYFCiOj1DwgMMrFRxV315CB7xuvXMFRbRAkbx6s14oPm3ui1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJYFCiOj1DwgMMrFRxV315CB7xuvXMFRbRAkbx6s14oPm3ui1Q@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Yubin Ruan wrote:
> 2017-11-20 16:33 GMT+08:00 Christian Couder <christian.couder@gmail.com>:

>> A draft of a new Git Rev News edition is available here:
>>
>>   https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-33.md
>>
>> Everyone is welcome to contribute in any section either by editing the
>> above page on GitHub and sending a pull request, or by commenting on
>> this GitHub issue:
>>
>>   https://github.com/git/git.github.io/issues/262
>>
>> You can also reply to this email.
[...]
> For the CRLF issue: I am not really that concerned with this issue
> because I mostly develop all my project on Linux. But can't git treat
> CRLF and LF just as the same thing? That will solves the problem
> gracefully.

Do you mean that it should ignore line ending changes?  What line
endings should a user get when they "git clone" or "git checkout"?

That said, I believe that the gitattributes(5) manpage does an okay
job of covering this and that that thread came to a clear conclusion:

  https://public-inbox.org/git/20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com/

I commented at [1] that I found the conclusion of the rev news entry
misleading and confusing but it doesn't appear that there is anything
I can do about that.  It's disappointing because if there is something
that was not covered in that thread, then it would be good to revive
it so we can improve the program's behavior or docs, but I wasn't able
to find out what was missed.

Thanks,
Jonathan

[1] https://github.com/git/git.github.io/issues/262#issuecomment-345804038
