Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA5A01F404
	for <e@80x24.org>; Mon, 19 Mar 2018 13:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755565AbeCSN1E (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Mar 2018 09:27:04 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35315 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755556AbeCSN1D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Mar 2018 09:27:03 -0400
Received: by mail-it0-f67.google.com with SMTP id v194-v6so10327691itb.0
        for <git@vger.kernel.org>; Mon, 19 Mar 2018 06:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uu/NnYzqtAzUrtE0kBTGxmPUVUonuicwv+j75AV5Il0=;
        b=vWMDL3z1Nkfj6cqt9OB9meWq/MvJZLd+BOID/pzgbxna8JpkeyVTlMjIkUEEHVSlwg
         Icc2skd/Jrj37WMPl//jw8gSKG+XqicTo+qHSTGYHC8chuqFTi43w3Oy3CpHG8jGvdz+
         T7+I66MosdtLbd45t9Im0lTCgA9w286vnneRXX6JIEBz1aFcW2ON9GK36uCVFznJizUq
         V7tuCuJqmc/eJk0LN6zYZPxLNucNHxtpaY9MKedK5PTokMZac8C/riHlxYhx2F3DwgLu
         MweihVkP88z4c3mUT5CwFG0uK013vOHHBtzvIT0nBz0sV2Gr6frx5bmGIlAeAIHIt45K
         2doQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uu/NnYzqtAzUrtE0kBTGxmPUVUonuicwv+j75AV5Il0=;
        b=e7h7/ODfsaZMohdR5DJKYjJLTKv3mMzJbGoBZFlKQLtgUhk5TgbihMVzJjkx1PYzk9
         yYt3d7UYwdExURPWjEEKQExrnKG5EH8eCZS4bHzaB2sNS2UbOSIseP5EL/TqC7+9viGK
         Ys01mcw5W55zyU5G9udzbxZoh3hahT76YEbaF6iQbXEOeXiyEJedVh/Wf3T2pdacG0ck
         64sucfDXCskZ4CfmjLBDFJpWjN3euCmt7x06VXzrWeC4viUi5CmQPFP6SBQ+Z6+KtZiv
         Aq5BIVaWMJbhmTjX2eIFisvwZcRrTrtdH08rbTJBX4ouF5Dv/qUYA/JeKQVYuKmayaZk
         /sBA==
X-Gm-Message-State: AElRT7HyKUwG3YssUO3nkoz1k71aukMxiYDNc6EwHqtpobYRenix+fwG
        sYIevHiAtz8rZ/Qzj9ZbbB7AaWlsHmNT2d0aeGcjhA==
X-Google-Smtp-Source: AG47ELu33gaVe3ZYDwk3xqhuFU10Ksg9tEakwizesDZpWkXiNnESNa9ngVQhR0EYWnpUQugzkx3FDBxYlEVkSXegwjA=
X-Received: by 2002:a24:ac52:: with SMTP id m18-v6mr11457562iti.21.1521466023076;
 Mon, 19 Mar 2018 06:27:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.146.25 with HTTP; Mon, 19 Mar 2018 06:27:02 -0700 (PDT)
In-Reply-To: <8de3597a-01bd-a721-fffb-20769701d0af@jeffhostetler.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-29-chriscool@tuxfamily.org> <8de3597a-01bd-a721-fffb-20769701d0af@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 19 Mar 2018 14:27:02 +0100
Message-ID: <CAP8UFD2GCUGWg6mmfke=XZ4h2UY2huyLps5Gk-UorvBo42fmvQ@mail.gmail.com>
Subject: Re: [PATCH 28/40] pack-objects: don't pack objects in external odbs
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 4, 2018 at 9:54 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> On 1/3/2018 11:33 AM, Christian Couder wrote:
>>
>> Objects managed by an external ODB should not be put into
>> pack files. They should be transfered using other mechanism
>> that can be specific to the external odb.
>>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>   builtin/pack-objects.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index 6c71552cdf..4ed66c7677 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -28,6 +28,7 @@
>>   #include "argv-array.h"
>>   #include "mru.h"
>>   #include "packfile.h"
>> +#include "external-odb.h"
>>     static const char *pack_usage[] = {
>>         N_("git pack-objects --stdout [<options>...] [< <ref-list> | <
>> <object-list>]"),
>> @@ -1026,6 +1027,9 @@ static int want_object_in_pack(const struct
>> object_id *oid,
>>                         return want;
>>         }
>>   +     if (external_odb_has_object(oid->hash))
>> +               return 0;
>
> I worry about the performance of this in light of my comments
> earlier in the patch series about the expense of building the
> "have" sets.

Building the have set is done only if the cap_have capability is used,
(see my answer to your comments on patch 15/40).

> Since we've already checked for a loose object and we are about
> to walk thru the local packfiles, so if we don't find it in any
> of them, then we don't have it locally.  Only then do we need
> to worry about external odbs.
>
> If we don't have it locally, does the caller of this function
> have sufficient "promisor" infomation infer that the object
> should exist on the promisor remote?   Since you're going to
> omit it from the packfile anyway, you don't really need to know
> if the remote actually has it.

Yeah, I think it works in the same way as how the promisor code works,
but I haven't checked carefully, so I will take a look at that.

Thanks,
Christian.
