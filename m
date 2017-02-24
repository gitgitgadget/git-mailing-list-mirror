Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 957C52022F
	for <e@80x24.org>; Fri, 24 Feb 2017 17:49:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdBXRtd (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:49:33 -0500
Received: from lang.hm ([66.167.227.134]:47827 "EHLO bifrost.lang.hm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751232AbdBXRt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 12:49:28 -0500
Received: from dlang-laptop ([10.2.0.162])
        by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id v1OHjtkq019934;
        Fri, 24 Feb 2017 09:45:55 -0800
Date:   Fri, 24 Feb 2017 09:45:55 -0800 (PST)
From:   David Lang <david@lang.hm>
X-X-Sender: dlang@dlang-laptop
To:     Junio C Hamano <gitster@pobox.com>
cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
In-Reply-To: <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
Message-ID: <nycvar.QRO.7.75.62.1702240943540.6590@qynat-yncgbc>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>        <22704.19873.860148.22472@chiark.greenend.org.uk> <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 24 Feb 2017, Junio C Hamano wrote:

> *1* In the above toy example, length being 40 vs 64 is used as a
>    sign between SHA-1 and the new hash, and careful readers may
>    wonder if we should use sha-3,20769079d22... or something like
>    that that more explicity identifies what hash is used, so that
>    we can pick a hash whose length is 64 when we transition again.
>
>    I personally do not think such a prefix is necessary during the
>    first transition; we will likely to adopt a new hash again, and
>    at that point that third one can have a prefix to differenciate
>    it from the second one.

as the saying goes "in computer science the interesting numbers are 0, 1, and 
many", does it really simplify things much to support 2 hashes vs supporting 
more so that this issue doesn't have to be revisited? (other than selecting new 
hashes over time)

David Lang
