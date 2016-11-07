Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E7DE2022C
	for <e@80x24.org>; Mon,  7 Nov 2016 09:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752217AbcKGJjC (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 04:39:02 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:36549 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbcKGJi4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 04:38:56 -0500
Received: by mail-it0-f43.google.com with SMTP id q124so10982096itd.1
        for <git@vger.kernel.org>; Mon, 07 Nov 2016 01:38:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1phlefGLLbJWS0VGe3R/vaWQq2NcuJBtk/QjORa9Azg=;
        b=QI5LxJqg6fXJ+lbiRFxLRK2DjvNifCNs3u1e1FaRP1x14R2cxBRk0TEBP4nZZ81Ra0
         1tZJ4uwL+nDqXBBLl3kQcl6MEdROBXDDca5/dVsrfq9VhGQK+3MXe6rBwYQSV23fKF0d
         C8W84Uk1HuMQH9MNQz6i+cwmqCwfS980FL83nz6LkylxF+h/Kz5z+xQoEHHa2zOeg2S7
         3d83o1AKI+LXsakkG48w+56DIBzak/rousX9BUOVNRv5i2Q9xBwRCBFMEwWCPptEOMAu
         CHos0HBvkj0xFZorUYotgN8nuOVJou/g/wx6LeMmMLUVvS+7SeXm0AicG5MyGVUNezMo
         nLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1phlefGLLbJWS0VGe3R/vaWQq2NcuJBtk/QjORa9Azg=;
        b=KUgWLGZgCJFgpSjd7EbJhOIM0zRyEQQCTRyPXmx1aqjzlxdOTgsZ1cHIvlNz1T2ksf
         ao9zEfANN26vKwrgPOVkbUU5JWu56cgzUNmNDp0zxHWaK8ceiUMpGyycbBU5sL/WM+C9
         9iZy8n3OklF150a7/SkSlipRFiPEny1xHTT13fwX0BJ3mSADbbcYCUMiPAlXnG9ZXBR0
         XiLiFBvw3bYQ6WN32tawJUIRQM9IkVJqf17xo/xO6KKdEDNqoUf1ULcfFaYQfsvmKfUY
         hfv51n17WRp1JqiBeNuuMXgAQeLyk/5lgmzUYtimGL49A9dIJuvNSLpdJWT7AjQB8aQA
         Cueg==
X-Gm-Message-State: ABUngvcVU9usq74QieKXzOIBXHxZgUtnSBGfxBMFbRpYkD342Pek1NPTf9OS68XxBcjiMtlTW53lgDOlIMixmA==
X-Received: by 10.107.44.137 with SMTP id s131mr6301795ios.212.1478511535039;
 Mon, 07 Nov 2016 01:38:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.164.102 with HTTP; Mon, 7 Nov 2016 01:38:24 -0800 (PST)
In-Reply-To: <CAP8UFD1YL+RgdqbV0V1OnC=sJHJFc_an02Q9JeDNapW+u1CZcA@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-13-chriscool@tuxfamily.org> <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2H6rZNQqg1VGNkes65KAk-4P160rjQSjFY3NjgZydZmA@mail.gmail.com>
 <xmqqoa1scyuy.fsf@gitster.mtv.corp.google.com> <CAP8UFD1YL+RgdqbV0V1OnC=sJHJFc_an02Q9JeDNapW+u1CZcA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 7 Nov 2016 16:38:24 +0700
Message-ID: <CACsJy8BZNfESmFv=V89Cq-b+aMJWLH=qhXHNE8inZZRjvXB33Q@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(sorry I got sick in the last few weeks and could not respond to this earli=
er)

On Mon, Nov 7, 2016 at 4:44 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Le 6 nov. 2016 09:16, "Junio C Hamano" <gitster@pobox.com> a =C3=A9crit :
>>
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>> > I think it is easier for user to be able to just set core.splitIndex
>> > to true to enable split-index.
>>
>> You can have that exact benefit by making core.splitIndex to
>> bool-or-more.  If your default is 20%, take 'true' as if the user
>> specified 20% and take 'false' as if the user specified 100% (or is
>> it 0%?  I do not care about the details but you get the point).
>
> Then if we ever add 'auto' and the user wants for example 10% instead of =
the
> default 20%, we will have to make it accept things like "auto,10".

In my opinion, "true" _is_ auto, which is a way to say "I trust you to
do the right thing, just re-split the index when it makes sense", "no"
is disabled of course. If the user wants to be specific, just write
"10" or some other percentage.(and either 0 or 100 would mean enable
split-index but do not re-split automatically, let _me_ do it when I
want it)
--=20
Duy
