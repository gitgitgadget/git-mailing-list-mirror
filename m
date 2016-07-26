Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30564203E3
	for <e@80x24.org>; Tue, 26 Jul 2016 20:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757741AbcGZUlN (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 16:41:13 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:34425 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756109AbcGZUlM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 16:41:12 -0400
Received: by mail-yw0-f194.google.com with SMTP id j12so2246411ywb.1
        for <git@vger.kernel.org>; Tue, 26 Jul 2016 13:41:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZDNssF8QwXEr4N+IYUMadftgH4Akx0YZRJbIFD/eyXo=;
        b=B33qcWd3YJVREC75+TWLptWZU8e1v2yO6xz+NTzwi4q7QDW4QQ7UMR634Y1MaStfu9
         3FDHVzsUoieXEE44TtN7jPEyMcz+ntFxP2tfTEqiKk/XaTxqxCm9g3DTHTA8Tg+lmKkm
         +a4FKCaLZkgrH0kQmL+v808D7Pv9p+bvhyS+sLqfYFaHRAsqU1tpONk3GnAFPolVKlVP
         TP3qm4qdDi51snCukGt6YPvSqSQq4/aibzLuV7PyejLEKW4K7l4TPMkcmmY1ghn4cTjI
         4NRiMLFSRueoilpiLTTGIjQNgXRBkmuGnJ/lCR0zPzp4HbhIYC9vh486wOsn5fjPpjoP
         bcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZDNssF8QwXEr4N+IYUMadftgH4Akx0YZRJbIFD/eyXo=;
        b=Uj5z0YiUSPyp6DfE3gItK2hhjuqQXb+r8aVBn4XuSRg7ZI8di4Wi46oPZz99hLsSsR
         G7LaT+OIuD4SAS52AFGbRVEohJEzPmwXhxiMPmLQzxYqs1kaak0ENFE93a2AM+fLzEUx
         0bcvTzLGtJRYl3t6Iyzg9c+z+/PtB/1F+TOgL6lwQbZY6/o5ZI+uIbi/ZufRvYwpPBAh
         5D9pQISSzUUsJV5AQzQ1GCO4vq9oNqfk/R0zvZdHGom0/33Uw3capJ5UT7KKEhIsAb78
         4JZHqfgoE2n9l+cwlVkacsCH+z0cIyEk2ji0Jiv1LrEIt97aVCccFQJdRYuHLB4Pxp6/
         JuOg==
X-Gm-Message-State: AEkoouuEcf2zmriOyMbvVy6Ix5VjPq/RlqTEhniSJxL7caNnGi1Xfc5GfBXjx2Xw016f9azlcC4mJvFl/0xz1A==
X-Received: by 10.13.251.66 with SMTP id l63mr22176671ywf.69.1469565671183;
 Tue, 26 Jul 2016 13:41:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Tue, 26 Jul 2016 13:40:51 -0700 (PDT)
In-Reply-To: <323759193.1122705.1469546329160.JavaMail.zimbra@ensimag.grenoble-inp.fr>
References: <20160722154900.19477-1-larsxschneider@gmail.com>
 <20160722154900.19477-3-larsxschneider@gmail.com> <323759193.1122705.1469546329160.JavaMail.zimbra@ensimag.grenoble-inp.fr>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Tue, 26 Jul 2016 13:40:51 -0700
X-Google-Sender-Auth: zHOvz59A6kK6mNlL8ffgr0_UarY
Message-ID: <CAPc5daXj9vafDDRFmXHCOoMoaHQ_YJgzCF2z9f9frCZceZuJ-A@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] convert: modernize tests
To:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Cc:	Lars Schneider <larsxschneider@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 26, 2016 at 8:18 AM, Remi Galan Alfonso
<remi.galan-alfonso@ensimag.grenoble-inp.fr> wrote:
> Considering how close it is to your patch, you might also want to
> remove spaces after '<'.
>
> There is only one occurrence in this file and it's in a line you are
> already modifying.

Good eyes.
