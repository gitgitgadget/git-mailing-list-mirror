Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4786B1F406
	for <e@80x24.org>; Mon, 15 Jan 2018 14:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934190AbeAOOeg (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 09:34:36 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:35710 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933726AbeAOOee (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 09:34:34 -0500
Received: by mail-it0-f52.google.com with SMTP id e1so993234ita.0
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 06:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AjBMjbZoQS//FXnWX6Wt+7G5YSAcszA7Z40eYJDsGp4=;
        b=DN1V/kL90oLYAyS6bvgZ4GwvyY6T50Y6Q7BWCFCV78vDWK+RDPk168a1iTBh4lJXIK
         r9KBV0HAIRY4183vKlhGsqubQzha4DUhTPEAba9oCPsrdHfQXeVI/KsTheiFoDvPojh3
         YJdTq8+cML90SOq3CDJT4Mnp0K3gWssUDYBndGHTA48ub9g/YXqoVf+cWy+3vNL1QeQ7
         9ZvRnbNPRaPGcbj2XsNJ9gFTFwNUNFHzoWYgds04n3U9Cu95t+DgXWtz+RpL3jrko06n
         9KoJFWRhd5q0Pw9xPcK+2AkfODk0zkx8V+6+m0JuCtsuxSoEbla9esR8tCodRVXNa+7U
         AAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AjBMjbZoQS//FXnWX6Wt+7G5YSAcszA7Z40eYJDsGp4=;
        b=Ct4J7nIPXRvLg3WXALgcg24PT2yOO9EgY8XYcW/FTw/PfbIFGFc4HA6p2YeM4i3VK9
         QRnfvrdAbe9DRFzgDmbrk0ngD9B4h/ufzzk3DyBWuaayhr+Imi82+bNUoc/a2frvp1mE
         /MbeIv9oj0FU+M+FiRgsquU2yyGvY9pPnuyY/3fXv4R7FdNrCzDZZl7ovsyvuwefbRRz
         NKPJb3aRkSdwRcWpEAstOHgcD9FLTMPW53n9Un2AKaYx4brWXJEJTL3bQ/pCiBOhMEft
         f3h2vAWXOqT8u4GmHIoCVG2+7Grk9mjV4qVeKb4Q5W/a60Jb+1AAcvrRDPL6rExPOCk+
         FGrQ==
X-Gm-Message-State: AKwxyterfUO4wQHuZ6UXWFfLSjN0oU57QjykOcVCr2Qm6+su5O7p7ZKO
        pP+8hBzZ6XH2kmNUwpDXJmH6GvdaK4HyqKIX1oE=
X-Google-Smtp-Source: ACJfBovoJkFMaOA8sTpTl2erdIglKKp216aw46g+Y4d1/M4nc7wWiZaRsM9eACQZU2bNXCYNY1SYk4PuDDOZjV2jmOM=
X-Received: by 10.36.101.2 with SMTP id u2mr6835976itb.55.1516026873490; Mon,
 15 Jan 2018 06:34:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.113.199 with HTTP; Mon, 15 Jan 2018 06:34:33 -0800 (PST)
In-Reply-To: <96c60f40-052c-b098-f58f-e39e308694f0@jeffhostetler.com>
References: <20180103163403.11303-1-chriscool@tuxfamily.org>
 <20180103163403.11303-2-chriscool@tuxfamily.org> <96c60f40-052c-b098-f58f-e39e308694f0@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 15 Jan 2018 15:34:33 +0100
Message-ID: <CAP8UFD0L5UFg5NgvfY84VnHsJZr9iq=R5d_+ZvGBEJw2NouJpA@mail.gmail.com>
Subject: Re: [PATCH 01/40] Add initial external odb support
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

On Thu, Jan 4, 2018 at 8:59 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
>
>> diff --git a/odb-helper.h b/odb-helper.h
>> new file mode 100644
>> index 0000000000..9395e606ce
>> --- /dev/null
>> +++ b/odb-helper.h
>> @@ -0,0 +1,24 @@
>> +#ifndef ODB_HELPER_H
>> +#define ODB_HELPER_H
>> +
>> +struct odb_helper {
>> +       const char *name;
>> +       const char *dealer;
>> +
>> +       struct odb_helper_object {
>> +               unsigned char sha1[20];
>
>
> Should this be "struct object_id" ?

Yeah, I changed this in my current version.

I cannot change all the functions to take a struct object_id though as
some are called inside sha1_file.c where there are only sha1.
