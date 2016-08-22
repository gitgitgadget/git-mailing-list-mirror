Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 148841F859
	for <e@80x24.org>; Mon, 22 Aug 2016 12:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbcHVMoW (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Aug 2016 08:44:22 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33090 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbcHVMoV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Aug 2016 08:44:21 -0400
Received: by mail-io0-f172.google.com with SMTP id 38so108338708iol.0
        for <git@vger.kernel.org>; Mon, 22 Aug 2016 05:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LNl2oQZmBII9hBUmvdYjXYZJprE92wxAjlOdYSuJ1HQ=;
        b=rFtr9ppPx5KrTMI6vMfafOND/khgDJp+/RdA25JJ2wzpkb34v2Keu4iETX8YZFYime
         4NzLYdZVfccMQwb0PtTzIJVNS1QOE+LoMoRqC15L+BjZR2dBAesM0UYxyU6d39Tuw+kC
         vE8cgaPKBHc5XIuFR4NrAs7Ae3t5J9wsMX9oUpHDYFX7fpPekopCKh3/JeBEw9pC8ic/
         pUhD5ywC2bvsu/GtNFfMAZHpFU3lGi1sor+FfHYALsAHNOHPcZcp+S4lttSVJXKCiAzq
         UZd3kkvlhiQiOv3o/V5FYixcNGHqhZL2jYnB7LozP7WkVUWpf2sUPsrX4Dwice2NjBZj
         cHHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LNl2oQZmBII9hBUmvdYjXYZJprE92wxAjlOdYSuJ1HQ=;
        b=f/XSx5/rm5HkSfOisQ6O0sehAuiS6YoGcSkzZeQfYFkfAAV3TrimIM7EA+qXOyPyev
         NHAjaHQ+l7jM2regfAPSlk2m0JHYBsv07MIS5TvavGCi5FTj3FVZgEZRyE2JcMMjCuKU
         lALVe+IcJcZI8RZ4cBXdY3ifJV34B27GFMqEu4Uhb4JJVYiukR5soXg8LzSgAfpBFQCI
         Gcic3BeOHGxJ1IWkIk7aROnnmEIT6JCxcUowGIxBncYm5r3sxZCafFIYzHjX3RyH6DLq
         R+qn1+x6vldglSLGSkZK74kJnhmw4u7eoC/yrqoFMAx4cNaNqISbWaKMzYxuv2RytKa5
         K+eQ==
X-Gm-Message-State: AEkooutUUfAxgI+UfyEr52QewbOvSnvgjQLcxTE2zzq+hg/cuTZSV6FjrIhLs38X9K1GUqhrDNR1sMB61UsbEg==
X-Received: by 10.107.2.78 with SMTP id 75mr23413408ioc.128.1471869860233;
 Mon, 22 Aug 2016 05:44:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 22 Aug 2016 05:43:49 -0700 (PDT)
In-Reply-To: <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
References: <20160712164216.24072-1-pclouds@gmail.com> <20160714153311.2166-1-pclouds@gmail.com>
 <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
 <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net> <5c131421-ae7f-8a37-76ab-0fd05cbe3530@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 22 Aug 2016 19:43:49 +0700
Message-ID: <CACsJy8C30=-LGMYQJ6MO17L8Vv1q=iQGC=R8TDhC5qM1f5Lh5A@mail.gmail.com>
Subject: Re: [PATCH v4] config: add conditional include
To:     =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Aug 21, 2016 at 4:08 AM, Jakub Nar=C4=99bski <jnareb@gmail.com> wro=
te:
> W dniu 19.08.2016 o 15:54, Jeff King pisze:
>> On Sat, Aug 13, 2016 at 03:40:59PM +0700, Duy Nguyen wrote:
>>
>>> Ping..
>>
>> There was some discussion after v4. I think the open issues are:
>>
>>   - the commit message is rather terse (it should describe motivation,
>>     and can refer to the docs for the "how")
>>
>>   - the syntax might be more clear as:
>>
>>        [include-if "gitdir:..."]
>>
>>     or
>>
>>        [include "gitdir-is:..."]
>
> Or
>
>          [include "if-gitdir:..."]

I like this one. I can re-roll to address the first two bullet point,
if the last one, the open question, will not become a blocker later
on.
--=20
Duy
