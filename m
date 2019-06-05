Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF9E51F462
	for <e@80x24.org>; Wed,  5 Jun 2019 20:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfFEUuM (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jun 2019 16:50:12 -0400
Received: from smtp-o-2.desy.de ([131.169.56.155]:48085 "EHLO smtp-o-2.desy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfFEUuL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jun 2019 16:50:11 -0400
Received: from smtp-buf-2.desy.de (smtp-buf-2.desy.de [IPv6:2001:638:700:1038::1:a5])
        by smtp-o-2.desy.de (Postfix) with ESMTP id C767B160511
        for <git@vger.kernel.org>; Wed,  5 Jun 2019 22:50:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp-o-2.desy.de C767B160511
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=desy.de; s=default;
        t=1559767809; bh=QFnrfwgds4xqwQ1j8aFggr7vjc62prwU0X1P213p0zY=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=PBuCLMycJCkOCEQWl8JHpv71mN4WGVPQw7DCTmsUD2qnQGv4IV0T3ZVoBO56h4HuG
         ogEMWKiWEqjQLBvr8m7bif/FiRh0k3ZYMDeRPiX2o/1LI4Px25sWs4LYabaBSj+MzL
         eSSUNLZCs1ZJ8gtK38AnSZSbUn5WMaEYAcVrLnP4=
Received: from smtp-m-2.desy.de (smtp-m-2.desy.de [131.169.56.130])
        by smtp-buf-2.desy.de (Postfix) with ESMTP id C02391A00B8;
        Wed,  5 Jun 2019 22:50:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at desy.de
Received: from z-mbx-2.desy.de (z-mbx-2.desy.de [131.169.55.140])
        by smtp-intra-1.desy.de (Postfix) with ESMTP id 922C0C003B;
        Wed,  5 Jun 2019 22:50:09 +0200 (CEST)
Date:   Wed, 5 Jun 2019 22:50:09 +0200 (CEST)
From:   "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <327924049.10494298.1559767809461.JavaMail.zimbra@desy.de>
In-Reply-To: <xmqqblzbsquq.fsf@gitster-ct.c.googlers.com>
References: <139144069.10140489.1559664262817.JavaMail.zimbra@desy.de> <20190605155300.26506-1-tigran.mkrtchyan@desy.de> <xmqqv9xkroc5.fsf@gitster-ct.c.googlers.com> <1933659713.10490718.1559765529240.JavaMail.zimbra@desy.de> <xmqqblzbsquq.fsf@gitster-ct.c.googlers.com>
Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags
 be GPG-signed
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.10_GA_3781 (ZimbraWebClient - FF67 (Linux)/8.8.10_GA_3786)
Thread-Topic: add tag.gpgSign config option to force all tags be GPG-signed
Thread-Index: uNIIUhQ+leSAp9TtJtpWMreifOcOeA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for clarification. I will update the patch and re-send it.

Tigran.

----- Original Message -----
> From: "Junio C Hamano" <gitster@pobox.com>
> To: "Tigran Mkrtchyan" <tigran.mkrtchyan@desy.de>
> Cc: "git" <git@vger.kernel.org>, "Jonathan Nieder" <jrnieder@gmail.com>, "Johannes Schindelin"
> <Johannes.Schindelin@gmx.de>
> Sent: Wednesday, June 5, 2019 10:46:05 PM
> Subject: Re: [PATCH v3] tag: add tag.gpgSign config option to force all tags be GPG-signed

> "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de> writes:
> 
>>> But more importantly, I think we should justify why this "not
>>> allowed" makes sense as the design of the feature. A plausible
>>> alternative design would simply follow the "last one wins" paradigm,
>>> ...
>> This is matter of convention.
> 
> Oh, if you put it that way, it is quite clear that we should redo
> this part, as the rest of Git command line processing all pretty
> much follow "last one wins".  I was mostly curious if there was any
> strong reason why this combination has to be different.
