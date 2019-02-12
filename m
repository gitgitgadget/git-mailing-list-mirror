Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D08151F453
	for <e@80x24.org>; Tue, 12 Feb 2019 22:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfBLWNx (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 17:13:53 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34070 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfBLWNx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 17:13:53 -0500
Received: by mail-wm1-f44.google.com with SMTP id y185so428828wmd.1
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 14:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q98t+yyLch8KgK9M1Kd2tVf6e7mmVth43BaLyH7Yn70=;
        b=M7svjO0fhXbbV0jrWZViDN3MqLuXTgh6wBiKRZaLTWZYntEwC0/jKTXrZuwL3qeJBd
         oXDD5kRGcpncIqRXafpDNsDAdanxU+DQKaegyiCZ1j65Ap62RwUE88HIseDhJf5OuMXJ
         GMlWjPQhZKUdRXM52YUIXy8Yn5iv6VWNps95SrdGgMExNp0rpzOiTYGZGghvs+KBkrSX
         rfbgZTQ0a7GyX/vNPp1RcCpvCbWBhU97JxZwVfzYhfRbn5BvnIsnDYvM2+fIhsbrxivW
         qlDzihJwgsKlm3alXzcXP7w5GrXl1UKU6izLVMFOsRHAhoL2WaCD6glaDhw2mzIMWn7d
         efQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q98t+yyLch8KgK9M1Kd2tVf6e7mmVth43BaLyH7Yn70=;
        b=A1/+mJQlNhfhh0uGnYXMY9WMHt4SVawPx1/7p9Jr3D3sL4w7/PEMP/uKr8Hauqaqah
         bIvkLBz0MQH8r0BjUK2sidl4xkO9NP+WMPvu/f036HdfHSnKADKdqh5oe3wbA+z0IJEc
         gF74ulCOtVQuUfNpArBFkUuutC6/8CQXNoA+2g7N214JjfiSwwb0uaZjKXtZYhUxa6uJ
         o4Z8AyOPU0vHBR6TtmUKkj813Gah2jP+yftcCSbLNPApIK2SU3Ycux7642cvL6dbOHeJ
         ly148pRlHOIc6otsjARFVdxNiHRcTqZKPtWm/VVy8DkOlg10mj65iG95AtDTVKNae1pU
         a8kg==
X-Gm-Message-State: AHQUAuZPZO9VdH4EmfMlUaupUlFqFbemXX9QKvOBbxItCPG8hNsT19IL
        WGZX6fPPYs+4Ct2b2hWALvxTXIWb
X-Google-Smtp-Source: AHgI3IY0uMz1+V+9/bPloeh0l+GWixhmkdNqWmNDFQjPyTS1Mv+my5V2uwp2LMZYcwajsq/MttrRyw==
X-Received: by 2002:a1c:80c4:: with SMTP id b187mr730568wmd.23.1550009631112;
        Tue, 12 Feb 2019 14:13:51 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id c18sm21475057wre.32.2019.02.12.14.13.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 14:13:49 -0800 (PST)
Date:   Tue, 12 Feb 2019 22:13:49 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Matthieu Moy <Matthieu.Moy@gmail.com>
Subject: Re: GSoC 2019: Git's application submitted
Message-ID: <20190212221349.GH6085@hank.intra.tgummerer.com>
References: <20190205211736.GD6085@hank.intra.tgummerer.com>
 <CAP8UFD0bFWvXyQYb=EQ7QCPD_Va7CXEueEEtrETuEVO3n2X35g@mail.gmail.com>
 <20190206220942.GE6085@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1902072023250.41@tvgsbejvaqbjf.bet>
 <20190207213326.GF6085@hank.intra.tgummerer.com>
 <CAP8UFD1Rv+nFqDYf33rRw-kWnfqokSG6=tG8XPFyBoVCU6Te=w@mail.gmail.com>
 <20190211221827.GG6085@hank.intra.tgummerer.com>
 <CAP8UFD3s3-mR528FqV3yuMEZBqT0uP+Mp5hGDcN_a1LfAsR0bg@mail.gmail.com>
 <20190212202501.GA17681@hank.intra.tgummerer.com>
 <CAP8UFD19Mhpm4MRjQ3xsPx-_Gc6CweTWC3aHbqyhyy0C0dvR1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD19Mhpm4MRjQ3xsPx-_Gc6CweTWC3aHbqyhyy0C0dvR1g@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/12, Christian Couder wrote:
> On Tue, Feb 12, 2019 at 9:25 PM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> >
> > On 02/12, Christian Couder wrote:
> 
> > > Yeah, using more of the libgit.a API, instead of the run_command API,
> > > and writing technical documentation on the stash commit format look
> > > like good ideas to me. I think I will add those items to the project
> > > description if you don't mind.
> >
> > Sure that sounds good, thanks!  I think using more of the libgit.a API
> > should probably be an optional endeavor, but writing the technical
> > documentation may be a good thing to include in the project.
> 
> Ok, there is now the following at the end of the idea:
> 
> "This will include writing the technical documentation of the stash
> format, and optionally refactoring the `git stash` code to use more of
> the libgit.a API, instead of the run_command API."

Thanks, this sounds good to me.
