Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5FA1F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 13:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750881AbdBDNnn (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 08:43:43 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:35333 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdBDNnn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 08:43:43 -0500
Received: by mail-yw0-f169.google.com with SMTP id l19so27480899ywc.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 05:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7nlmdfgKZDveRDPs1xbpzyzB0xI+xowkZsl4XUoWp4c=;
        b=Gk7G2eCtl0NoBde6u+NsPrdsZFGZogJkRoi/PZyMKpE0ftO0mmb03cWjSJfvb8EF5V
         0FuUyE87VaPC24JyTwgwVT+BglJ6AUyLjQuiXve3mt1X94HbB8C6i6ASejBT70OLJj47
         pmxJ3gYHpTczI5T1QjGxIBCbE7hpFbHD2qB93RBM6dK9aLtPuyx09TTwkJXZEZeG9Bya
         X5pHVPTX5zHHGA26tIeyYrRfpbHnahSFKNILtmNFEP+xQEhXJJ3lYJyMkw562g3bL9/n
         s5RcfoZbP0ZZYcp7IDC8CmfItuPKGcaGNaeqh296MdNEwTSNOnVp4JKCBiO3AWZRG/1X
         DZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7nlmdfgKZDveRDPs1xbpzyzB0xI+xowkZsl4XUoWp4c=;
        b=Olr+zHZ5wEHsZRPOkp7BwqeV3vhuiwi590jjLX4XsXa/UgiNfzDqXyiEXVtyh+Wcyh
         754W88JBRvm2nlSObEHBqv58cCj9SXObPNqqqCjKbO4U3zVMULIE6tLBO5QFQ1I1LBST
         farvojQiwUh96fxHBmilYrhMTVh36r62bj3EKyW0wqnrW4xPsbsbhu+pl1Rxez3tZFxi
         vkeNi9JkoCPe5HXvvKUyF39V0ttcxWOtV6c7lfgxt+gmSd8RyGbheBZfNRUsQ2urcxUD
         JPdc06233o1uJ6paoC6IBw4UOXeNKDUuleRY0DMcJerOSS4hmZ3sy9/VSfBjhSRBuBIp
         oJCw==
X-Gm-Message-State: AIkVDXKoQmrQ4AstxLp9nm3jXnImqjnsfGsu97zOMbVSq464+x85UL3nJvaiWlBNmQNrrtidCN+vRODT1my8eg==
X-Received: by 10.129.65.72 with SMTP id f8mr1265968ywk.280.1486215822041;
 Sat, 04 Feb 2017 05:43:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.83.25.12 with HTTP; Sat, 4 Feb 2017 05:43:01 -0800 (PST)
In-Reply-To: <20160720130231.GB17469@sigill.intra.peff.net>
References: <f15a14a5-f39d-9c41-16b9-fe0a48d7450b@syntevo.com>
 <CAPc5daVC-+0Vr30L_pbcL0GN2OmnGm-+V4tE2WTos_vPRb_S1g@mail.gmail.com>
 <CAGZ79kY6Ry+DfO90wza_RrVbCRAgNB4N=0W6svuJgvGNxeFh5Q@mail.gmail.com>
 <xmqqk2h73f2i.fsf@gitster.mtv.corp.google.com> <20160629205647.GA25987@sigill.intra.peff.net>
 <5774426F.3090000@gmail.com> <20160629220049.GA4416@sigill.intra.peff.net>
 <578EC0CA.8060501@gmail.com> <20160720130231.GB17469@sigill.intra.peff.net>
From:   =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Date:   Sat, 4 Feb 2017 14:43:01 +0100
Message-ID: <CANQwDwfk2k+qGtx-_RqoLKObAgyV+ebE57UAd-VXDv86HDw2vg@mail.gmail.com>
Subject: Re: topological index field for commit objects
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20 July 2016 at 15:02, Jeff King <peff@peff.net> wrote:
> On Wed, Jul 20, 2016 at 02:07:38AM +0200, Jakub Nar=C4=99bski wrote:
>> W dniu 2016-06-30 o 00:00, Jeff King pisze:
>>> On Wed, Jun 29, 2016 at 11:49:35PM +0200, Jakub Nar=C4=99bski wrote:
>>
>>>> Do Git use EWAH / EWOK bitmaps for reachability analysis, or is it sti=
ll
>>>> limited to object counting?
>>>
>>> At GitHub we are using them for --contains analysis, along with mass
>>> ahead/behind (e.g., as in https://github.com/gitster/git/branches). My
>>> plan is to send patches upstream, but they need some cleanup first.
>>
>> Ping. have you got time to clean up those patches?
>
> No, I haven't. Don't hold your breath; it's something I hope to work on
> in the next 6 months, not the next 6 weeks.

Ping, Was there any progress on this front? It is now almost 6 months
later...

Could those patches be made available in a "dirty" form?

TIA,
--=20
Jakub Nar=C4=99bski


--=20
Jakub Narebski
