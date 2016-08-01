Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3C351F855
	for <e@80x24.org>; Mon,  1 Aug 2016 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbcHAM35 (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 08:29:57 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32802 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753452AbcHAM3y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2016 08:29:54 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so25945122wme.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 05:28:39 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aiUDxF/wF0nuqgVrkcPGVETIoLwfPTVPmIkj/3aHQv8=;
        b=XKpmlmml1ybCuaV3TDKZb0rMBAJ4QP1uJ9iRbTB0wdL/bHuRvRH4Vn5JepgjhqgNR8
         Fzsky2sT2Y6ZDZBAOr94ZXa6VbTNum2NbZx/L3UIEJfGZFMmZiD9IHYphICuRv0I7vj1
         oUYv1vWisJvKPTwG0fFImDidJjgvWS9YKWyw4mvJCQ9K0B2RnCCx4jhliMCZO0AFoeRw
         J8jnj/D8vEDDnxRxFRlbUUGPp6N82Hx9kpiZY2NhYw/ntHQpi55tL25xN0ZofVUzbKTW
         St/A7vaXkofwSXPvWtiEJ4xKO8UXM+7FlRsWya/cd+pFz/r1lE9x8POeDOqfsbq923VU
         ZyKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=aiUDxF/wF0nuqgVrkcPGVETIoLwfPTVPmIkj/3aHQv8=;
        b=UBQx+an3EGTA9yt7b+ykjcas7PV56qY5LsVUYSNjBatW/Etea9PoYOPb4JQsUzJoPo
         zUFT79un8T0C/gPFdQlh+M/1G0b7lDQcUG8zeKbeySFY3vw365pHwHbiex8ujRBaa51w
         Fy996aJrrHnbUhmloQzEq4x6Rd2aJxCCn5czhqs44AgyzxQ3UlRfb9xyRNWh4E66Akr2
         zZqLwSjgf/Z3FE8e/H1L2FL6LSPZ4yOS1EnFyyfc21Jjvp1lCPYOCorF8weuWnl7T/n3
         GL9x+UllqaBfKcSKQP9dN/7KyDIqZpl1AMBkynHMp9+p/6uJ7N+8Z+G9PN50pPMGPxpI
         WCsA==
X-Gm-Message-State: AEkoouvjNCB7r2uIdINpwF25YKXJzAM77P1Gi0L+oU29MM11yZGMVOBj5jdE4N0bJZd5LA==
X-Received: by 10.194.87.66 with SMTP id v2mr56223817wjz.40.1470054518974;
        Mon, 01 Aug 2016 05:28:38 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id 207sm16841240wmb.7.2016.08.01.05.28.36
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 01 Aug 2016 05:28:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 03/10] pkt-line: add packet_flush_gentle()
From:	Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <41184531-d3c2-43c0-d3b8-23cc913dbf86@gmail.com>
Date:	Mon, 1 Aug 2016 14:28:35 +0200
Cc:	Git Mailing List <git@vger.kernel.org>, gitster@pobox.com,
	tboegi@web.de, mlbright@gmail.com, e@80x24.org, peff@peff.net
Content-Transfer-Encoding: 8BIT
Message-Id: <4CDC1706-33FD-4525-8B32-800005F5855B@gmail.com>
References: <20160727000605.49982-1-larsxschneider%40gmail.com/> <20160729233801.82844-1-larsxschneider@gmail.com> <20160729233801.82844-4-larsxschneider@gmail.com> <41184531-d3c2-43c0-d3b8-23cc913dbf86@gmail.com>
To:	=?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


> On 30 Jul 2016, at 14:04, Jakub Narębski <jnareb@gmail.com> wrote:
> 
> W dniu 30.07.2016 o 01:37, larsxschneider@gmail.com pisze:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> packet_flush() would die in case of a write error even though for some callers
>> an error would be acceptable. Add packet_flush_gentle() which writes a pkt-line
>> flush packet and returns `0` for success and `1` for failure.
> 
> I think it should be packet_flush_gently(), as in "to flush gently",
> but this is only my opinion; I have not checked the naming rules and
> practices for the rest of Git codebase.

Agreed. This would match:

object.c:int type_from_string_gently(const char *str, ssize_t len, int gentle)

Thanks,
Lars

> 
>> 
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
> 

