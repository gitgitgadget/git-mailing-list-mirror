Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FE052036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751445AbdKVBlU (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:41:20 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:35740 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751353AbdKVBlT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:41:19 -0500
Received: by mail-io0-f194.google.com with SMTP id i38so21551562iod.2
        for <git@vger.kernel.org>; Tue, 21 Nov 2017 17:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6G29Y7k7ArCv6WQrD0kokOBqBrOvsUn/xC6/uo6M4s=;
        b=IW8FIbDuGNiW7jppNmTqsF4IdKyHw2XKV9UmR7MCgEz215n8/ZLUOZ29qQ12hf/Tti
         7QTmUBpLCBd1DdAeLZOHqIUL6FfCDboe+blGenyiFhwjK2IqBVbO5f7kSnvo2fLTmDH1
         9JE62AVgIlnHOGx9ROBWdiaQAyIMDNQKK3h9/WKprBoft3M73lvcGfhxfAhmc6IwyysD
         JunrOJIGDXreyU/r4HZvktyPzBnnnbN86Isc+60/YpR/UlHq4IBhhR8rqnzel+DAcvO4
         RBQwocRlCVfdmq9ecFUWeInSPPzp8PtlMtdkWIptPhMXyjxc0MERIhpThlE+Tad1L4OF
         8Cww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6G29Y7k7ArCv6WQrD0kokOBqBrOvsUn/xC6/uo6M4s=;
        b=puwvyq8aFken5m4OtMBbcBMg2JA9S53o5iH++4nNiI86vId3ICLJ93U3Qabadq83i4
         VhMocQVo/R+nO4XefYlDTxLEJQzrRkoPxOhLcSi+/AXrOkJvHjj44kx/JBa42Rtf0YmT
         mw48OccNZoFPi7wWa6nH3QtkHPd3gE5D6oCpKJjKfEakRPz0v59iCZ6uDNlcyVCocZr7
         AvIeOkcI10OoBwkFV8rUy2MGPbOuYr5bCxRGO5ZqVqjUlT7nhXyj/JuOjVfk3dCef1MZ
         g0yGL7tH4eyfZkqTSGStgTkTqcsPw6dsVs2qpTAs83dF7scBanZqmgEMkCeC5EMvFl/w
         aPZQ==
X-Gm-Message-State: AJaThX4NdrGWFqrjzFa4ujhPZ2TANg5Y0eAM1Hl//iSi77pw7b4RPVLz
        rpKCTwosPRrHc9mv1BvNRjg=
X-Google-Smtp-Source: AGs4zMZsJrna/vtezsfNSRNfvVMivD15KmZKfTkCdVJH6O2KSsI2CqOGuSiftql1iYg6HgNSurtAEg==
X-Received: by 10.107.35.4 with SMTP id j4mr19849335ioj.145.1511314878742;
        Tue, 21 Nov 2017 17:41:18 -0800 (PST)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id o207sm1315136itc.27.2017.11.21.17.41.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Nov 2017 17:41:18 -0800 (PST)
Date:   Tue, 21 Nov 2017 17:41:15 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Yubin Ruan <ablacktshirt@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
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
Message-ID: <20171122014115.GR3429@aiede.mtv.corp.google.com>
References: <CAP8UFD0ggpUGGoOEjAt3sB9=ek+Av+6GemiyqZ4kTCHLC9dWoA@mail.gmail.com>
 <CAJYFCiOj1DwgMMrFRxV315CB7xuvXMFRbRAkbx6s14oPm3ui1Q@mail.gmail.com>
 <20171121011017.e2aac53zfo2n2whc@aiede.mtv.corp.google.com>
 <CAP8UFD0dN2V5GVokvMD-XLDEhPVJrE=m3h8oM5VC_Lq6x3=9=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0dN2V5GVokvMD-XLDEhPVJrE=m3h8oM5VC_Lq6x3=9=A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:
> On Tue, Nov 21, 2017 at 2:10 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:

>> That said, I believe that the gitattributes(5) manpage does an okay
>> job of covering this and that that thread came to a clear conclusion:
>>
>>   https://public-inbox.org/git/20171026203046.fu3z5ngnw7hckfrn@aiede.mtv.corp.google.com/
>>
>> I commented at [1] that I found the conclusion of the rev news entry
>> misleading and confusing but it doesn't appear that there is anything
>> I can do about that.
>
> Well, you could have provided a pull request or otherwise suggested
> what you think would be a better conclusion for the article and why.
>
> If you just say that the above email is the conclusion, when it seems
> to me that another email from someone else is also a conclusion with a
> quite different outcome, it does not help much come to an agreement
> about what should be reported as the conclusion of the thread.

This is something I suspect journalists have to deal with all the
time: when one of the subjects of an article feels misrepresented
(which happens inevitably when writing to a deadline), that comes with
a feeling of powerlessness that can lead to grumpiness and harsh
words.

In the end you ended up improving the text enough that I don't mind
any more.  Sorry for the bumpy road along the way.

Thanks,
Jonathan
