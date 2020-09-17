Return-Path: <SRS0=cV3L=C2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D190CC433E2
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 19:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A52020663
	for <git@archiver.kernel.org>; Thu, 17 Sep 2020 19:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIQTzw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Sep 2020 15:55:52 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:43663 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727806AbgIQO41 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Sep 2020 10:56:27 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MQeDw-1k6CwD0h2k-00Nkvk; Thu, 17 Sep 2020 16:02:55 +0200
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id C1B6E1E01E7;
        Thu, 17 Sep 2020 14:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id G6D9kLVSVzG3; Thu, 17 Sep 2020 16:02:54 +0200 (CEST)
Received: from pflmari.corp.cetitec.com (unknown [10.10.5.94])
        by mail.cetitecgmbh.com (Postfix) with ESMTPSA id 7DEDA1E01E6;
        Thu, 17 Sep 2020 16:02:54 +0200 (CEST)
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 5C03F8051A; Thu, 17 Sep 2020 16:02:54 +0200 (CEST)
Date:   Thu, 17 Sep 2020 16:02:54 +0200
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200917140254.GA28281@pflmari>
References: <20200915135428.GA28038@pflmari>
 <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
 <xmqqk0wtv204.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk0wtv204.fsf@gitster.c.googlers.com>
X-Provags-ID: V03:K1:4vAzDZf0dLs3pLt7eR5RYFMysLuJzeU/o0DqkDrVhndIOtvHLUy
 +VM+MfBI/Xh5yox5vmvxSOEGPvGhDApgBRr3z6W40saG34fGieOmekwC2OP895Nw54iC1a1
 87revqlyjZyAbnCvOvpfJjhO75nOBUXnuqqzpxqDwjuah8R4nnNfMtAK4PJi7ZH5XHYcQT0
 wAHfVXYxxKjW/ZoMy6/dQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K9HXNMCObws=:cctfYZ5YieJCNJWiQQpBUq
 KZN5DG0NG6XVCtFPXsu/BcE8BLpJ5IFxyHRTByJ+NUdARikc6xpSzOtI1lHXNhVStHC1xYG9E
 yda4G36g822a1Qyp1u4TCeWjT5Bg1kcMZsLWfgKDvAtuAkJSPswJWlzE7UGj5BAO88vOzsTtU
 nNVxDpFpwGmviaa23QeKPgKtU9tjn9NMiXsIsTEGUM2JIGaDY89AF1CChTdBmGgoAw8YCtC0Z
 vp/z6a2/WaQGUA50K7lU9R7nbdCeOzsr8i+ZJJE4jPeoo/BgYr7fy04fugxF59gyi437m+zcm
 ILlgiAdnvDpC4ji2B4ZOgBPmNCFRZzBYrn5fMAKu3biMDURA6QwiulhwdNp3QizINEvr8dkdU
 iLKJmSXXVogLpCcTMCuReGedJ3HnChMcNkb2g+ZGnnFueMRR7gIlVuVoX+r8nsMmR0v+im20Y
 NUXqRSiyxSSix9nd1eNHhvRLeyxTxaYoUKFatiU7nNxbECs04GopVwJ63+ngw+A+5YUSHY04s
 DGXsizmcW8coMAQfviMvvqTtXwM541d2Sc40iwe/GGPmTZa8GcOYuUPJ5JN28TortAbVHa6A4
 4KyHUO6oVXZ7erDn8cEd+2T94g8QfKfgUSjW2EiMHNmS9d5d8jqOL8EFv8LtnC0dfEAz9MJi6
 oExQIpxp9DAd23WnKRb5crt7wMOIlkYsJIOmhs6ABk/uOoq4IbeodS1EZXVpHg5wMRGOYU+n/
 +EHVcMsjr3o5zNSeDJg2W8z10LdEyPFfL/ZfeD5Ur7RHfHOGJfzikdbElxNqRTqXMYrcC1Qu9
 KDdufFiNuGia7gk6ezj+Azi/Vc5z7F8IKc7472E3FdnwZNwxEm64u4xCQsZmJeheJWwnpd3Rj
 BlBESZAMcebzcgbngtsw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Wed, Sep 16, 2020 23:35:23 +0200:
> Junio C Hamano <gitster@pobox.com> writes:
> > Would we regret to choose 'ipversion' as the variable name, by the
> > way?  On the command line side, --transfer-protocol-family=ipv4
> > makes it clear that we leave room to support protocols outside the
> > Internet protocol family, and existing --ipv4 is grandfathered in
> > by making it a synonym to --transfer-protocol-family=ipv4.  Calling
> > the variable "transfer.ipversion" and still allowing future protocols
> > outside the Internet protocol family is rather awkward.
> >
> > Calling "transfer.protocolFamily" would not have such a problem,
> > though.
> 
> In case it wasn't clear, I consider the current TRANSPORT_FAMILY_ALL
> a misnomer.  It's not like specifying "all" will make us use both
> ipv4 and ipv6 at the same time0---it just indicates our lack of
> preference, i.e. "any transport protocol family would do".
> 
> I mention this because this topic starts to expose that 'lack of
> preference' to the end user; I do not think we want to use "all"
> as the potential value for the command line option or the
> configuration variable.

If the configuration variable is allowed to be set to that "lack of
preference" value, we kind of have a command line option for it:

    git -c transfer.protocolFamily=any fetch ...


