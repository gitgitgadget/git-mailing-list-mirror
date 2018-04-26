Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D72A1F42D
	for <e@80x24.org>; Thu, 26 Apr 2018 15:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756434AbeDZPrA (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 11:47:00 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:44870 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755871AbeDZPq7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 11:46:59 -0400
Received: by mail-oi0-f42.google.com with SMTP id e80-v6so17109913oig.11
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XssUDws7B7VFcCmZxf17yzHfwt1Cayu2qZMZZNAMWpQ=;
        b=EY1qKLyQ3w7wdSS3HTvVZRAxi04DqG6vx4aLmKCX5hU/IJRnSQ04kwvcFMJD3F8GDW
         mIgwQFq60kXkCELQbIzwX9dynCq7XD/f25kzY2QWO/tpHcv/7jv13YzxAIgGPOsDqUjK
         q4FEql52pY3RxXp/kECGcmuFGrGqoRX2Rwkxrsxbt6VKsWvgnNjy7OWXxFBTE9cIjPYH
         /zugi9JkcInJjjqpsbjrMp70oconPadyQPcLez1IG70a1NidVkMG3DCDJyihJrOXdizg
         Wk2vIJkHFZ0dMQJldYUsFxqLUQ2DkLc77JxH7EXp+9dcPzl8dJijQ9bcz85TjVp5rDTW
         czZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XssUDws7B7VFcCmZxf17yzHfwt1Cayu2qZMZZNAMWpQ=;
        b=MqLL7kvRg8ZYB+QMPTikt+tNcSWHIzyJTlahW8IN8XDUbGsorVPRZs+X9X37tmqVgE
         EnlKrznxv1znVYsbZnIbYv+IA7btnpPFm61kMBSXoUUxjbR//X7cnUd+bDuPtpt37dxA
         UUj/SNAy02DdIVas37yc3PnIVkwKxCmoU41H78L90XIHcaSKfObCDW+rSCIQpchh0cCX
         zwIIELGvb66R54x1GEEkif/rAQLhqaJtlIq66n5b5zaFye7KPZs0nfV0gpEKOTHmK31h
         B13707sU2cLpHYJOHKfzwUpEdYbyAtvHkJ1d7IdqJfzgj4ey0j+xrgOcgs781ks1po8i
         EuCA==
X-Gm-Message-State: ALQs6tCegJoGvZtfCoeTpDwaGRGlt1Ey0zYnmYhHeiyTwnyMvLvyQULJ
        62mG4+hvUCZeCRl9hf2EYombdwznVQfCDH+dDxI=
X-Google-Smtp-Source: AB8JxZp1aUh0vNWcNI6Dv4JR9TKihHxRwbiAjEbX2m/M01FCM5UG5aj13vHoXPh+bA9ek4qln/dH5yilKQ+HlsOFJaw=
X-Received: by 2002:aca:2813:: with SMTP id 19-v6mr1504231oix.281.1524757618799;
 Thu, 26 Apr 2018 08:46:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.198.152 with HTTP; Thu, 26 Apr 2018 08:46:28 -0700 (PDT)
In-Reply-To: <CAN0heSqpj9JfTrnMFRbquraxve9iTwoowgWRUhcD-gXHMg3V=g@mail.gmail.com>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net>
 <20180423233951.276447-19-sandals@crustytoothpaste.net> <CAN0heSouHbAj8TbiROe=XRsBJ788Vi6P4a_Wvv=7OrdsXqQXHw@mail.gmail.com>
 <20180424235150.GD245996@genre.crustytoothpaste.net> <CAN0heSqpj9JfTrnMFRbquraxve9iTwoowgWRUhcD-gXHMg3V=g@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 26 Apr 2018 17:46:28 +0200
Message-ID: <CACsJy8DUsFLDb786FmsR+eTriXaWGXEE+ZG8kCjq7JoipN1Phg@mail.gmail.com>
Subject: Re: [PATCH 18/41] index-pack: abstract away hash function constant
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 25, 2018 at 8:49 PM, Martin =C3=85gren <martin.agren@gmail.com>=
 wrote:
>> I agree that pack v2 is not going to have anything but SHA-1.  However,
>> writing all the code such that it's algorithm agnostic means that we can
>> do testing of new algorithms by wholesale replacing the algorithm with a
>> new one, which simplifies things considerably.
>
> Ok. I do sort of wonder if a "successful" test run after globally
> substituting Hash-Foo for SHA-1 (regardless of whether the size changes
> or not) hints at a problem. That is, nowhere do we test that this code
> uses 20-byte SHA-1s, regardless of what other hash functions are
> available and configured. Of course, until soon, that did not really
> have to be tested since there was only one hash function available to
> choose from. As for identifying all the places that matter ... no idea.
>
> Of course I can see how this helps get things to a point where Git does
> not crash and burn because the hash has a different size, and where the
> test suite doesn't spew failures because the initial chaining value of
> "SHA-1" is changed.
>
> Once that is accomplished, I sort of suspect that this code will want to
> be updated to not always blindly use the_hash_algo, but to always work
> with SHA-1 sizes. Or rather, this would turn into more generic code to
> handle both "v2 with SHA-1" and "v3 with some hash function(s)". This
> commit might be a good first step in that direction.

I also have an uneasy feeling when things this close to on-disk file
format get hash-agnostic treatment. I think we would need to start
adding new file formats soon, from bottom up with simple things like
loose object files (cat-file and hash-object should be enough to test
blobs...), then moving up to pack files and more. This is when we can
really decide where to use the new hash and whether we should keep
some hashes as sha-1.

For trailing hashes for example, there's no need to move to a new hash
which only costs us more cycles. We just use it as a fancy checksum to
avoid bit flips. But then my assumption about cost may be completely
wrong without experimenting.

> Long rambling short, yeah, I see your point.

So yeah. It may be ok to move everything to "new hash" now. But we
need a closer look soon.
--=20
Duy
