Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AFA921F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 13:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbcG3Nyu (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 09:54:50 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:38057 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbcG3Nyt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 09:54:49 -0400
Received: by mail-it0-f51.google.com with SMTP id j124so133068957ith.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 06:54:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=oO+cpayYk2ab8B35+xsXDmkQKaKrBu++pWz7D0TUbas=;
        b=q+zNXtyuPuAzCDs4g+Oqrqd9n7PGqs+zl1cPnfXYNoGYqGecGCqNp40+Jqb54oF+T2
         HLe87OghNNnSb0v+yaMxbjo/2lyBej/wJBtnwvL4iA/9S1urlIf2R3mumCF9+Q8v5v/M
         kKuD1E6y22PURA1HwhTgD0riGzhZMmCIC/XQhErM9f9q+2AnWEKJrXWOKznZue/8CPur
         Dkm5+Vn7OahyI8CjCn35PujaGGOkUVqKbwb0rC6T0LPjF1bygh8tif8KCYspcqVcVrH+
         aKpGq673suXf/t4nD2hdMBL7OMD51d8jRY2czOWGcs51PcJKsvzoM7ksDF+oiGSYQTMd
         ejmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=oO+cpayYk2ab8B35+xsXDmkQKaKrBu++pWz7D0TUbas=;
        b=fj9lZUanwJXW7i3B6BCiPocjL9dSb5Qk+Kw8oeb9y1/tOUFJXJNS9PE8TQuA5VbzDd
         idLWIQYHkGiIr3YDABQi7sY3U3XJ1LxL3x6tRBWezquEsF5RG/Z4nPjSqzFTm8QJjmqB
         Z4gOIiwOIgLRfOi7wEhKPg5tlPIhELTrcxBOFP9RMjVAbEaUNqjZKuCMS5gc2bTi7jrz
         5KnXZY+Qfnbclpoa58NmhNG3Ok5xR+5GiJAJbR9+p1Zo1FXkS9DaBVSj0Qdh3sQFBv52
         dC3khfEJiPTyc+CCsSpaZIBh6Df8rfTUtpcitTY+5hvlEonu2VWQlVRFp+gDGCDn3RWK
         G6wA==
X-Gm-Message-State: AEkooutdO8PFDZj/9YyQx7MYrHgzWsGOr3mJPaisg/sp1jpJPvbDqURakpvf6y17k1t1oDEw41CxlKgwRU17tg==
X-Received: by 10.36.43.88 with SMTP id h85mr6273311ita.57.1469886888555; Sat,
 30 Jul 2016 06:54:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 30 Jul 2016 06:54:19 -0700 (PDT)
In-Reply-To: <20160730133102.GA4871@duynguyen>
References: <20160718223038.GA66056@plume> <20160718225424.GA813@plume>
 <CACsJy8CRHsyT8YLPYoHZnxCuMvF1W=S5iayy2eoHZhbSe_qmDg@mail.gmail.com>
 <CACsJy8D9Cy1bjzXddCTOOT7X3smBBB3xccEg7CHaOKAZruHVag@mail.gmail.com> <20160730133102.GA4871@duynguyen>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 30 Jul 2016 15:54:19 +0200
Message-ID: <CACsJy8Dof=KW1Y4h9NpQAAXBEAX4=v3jQSL0N3_CZm7hxFt9qg@mail.gmail.com>
Subject: Re: t7063 failure on FreeBSD 10.3 i386/amd64
To:	Eric Wong <e@80x24.org>
Cc:	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	Stefan Beller <sbeller@google.com>,
	David Turner <novalis@novalis.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Sat, Jul 30, 2016 at 3:31 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> I give up.

I lied. Sleeping 30 seconds in that test case works, but there is no
way I'm sending a patch to delay 30 seconds. FreeBSD must have some
delayed mtime update "feature" in its vfs layer somewhere.

Now I give up.
-- 
Duy
