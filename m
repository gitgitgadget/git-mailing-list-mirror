Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060F320562
	for <e@80x24.org>; Mon, 30 Oct 2017 16:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbdJ3QOQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 12:14:16 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:55297 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752545AbdJ3QOP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 12:14:15 -0400
Received: by mail-qk0-f193.google.com with SMTP id x82so16781084qkb.12
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 09:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=EBkOaDQJHvqBDxRJvlLLcfKpppaIv7PdECv4b2VOSFs=;
        b=ax56g1UDODx5ljLwa5PhsBtbGlqqc40cUWnRn1Hibeyo833EhAeCiPrS3hzW0d8v1g
         Sbok4vQmGaCngKzVsdizLZyYBi83mruc08j+Qg81+WMQhEhT4M0mSBts1FHmym9O4THi
         +Y0QJbYXUV6oupwxZegd4AmqW8GU7IBHFWuR2PGIQmaMot9S8jiEmtLwGanDAu3fYWgl
         x8moo0P5vRIzD9tZEcAZRk25Zz12FXTYtgeQUYgIasgqvNCmQf21CvgoHUHy/W4JUYW9
         rR409IwKbtkhoKYmWR1GJnb0XLtibKEcSMTyuN2CWZS79WMMyLSdNntiXk9460bwZX3n
         aT7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=EBkOaDQJHvqBDxRJvlLLcfKpppaIv7PdECv4b2VOSFs=;
        b=T8B3kaa+QL/3YIEgNKdq8htGHgGWEvy9MrhzybfR6dwsVmEeqN31EtgHJ37jfR9PRv
         Oc+8NbLI4oHhqiH4xArd8wLM1I2UtmxKZat0V3zEMsQ6aMeLFjxaQ9i3peZngXn0gsvy
         gnaLoMq51BXmcYneJjsPn3sJr6GuCeXIkKlQN4bqHxF5/FFIsJfQzlXMUtI09kI1vx65
         1yTG2NO8wVYk4Ub+sohCStKzfMA1tZFMxg90H3pfpXG/26hCs8Ocm3Vp6qEgd8rgmi0M
         hC7yPhrKhM+cWrQPIlhgfHcZquWNkjKWJ8Lq85xIkmMiK2aPCvUoLG4PHlKk146X38u5
         82Rw==
X-Gm-Message-State: AMCzsaXbT/rupbvsxg5l4K0s6vcC8EHq+BywhljcOP7sg2DsOAo21Bl+
        yohNHwfSO80LCMwRT5+sAyjnlNAl4vbHNxCJO05kkA==
X-Google-Smtp-Source: ABhQp+RSx+bil/X9qpUGEd5kj1mTKqcv3zxeDwlKXf4jlms05ZXGf4O+eKGq5mnM61eQssMhosCEH7ed/XgtC10gp0g=
X-Received: by 10.55.18.165 with SMTP id 37mr13612567qks.352.1509380054748;
 Mon, 30 Oct 2017 09:14:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 30 Oct 2017 09:14:07 -0700 (PDT)
In-Reply-To: <20171028181239.59458-3-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net> <20171028181239.59458-3-sandals@crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Oct 2017 09:14:07 -0700
Message-ID: <CAGZ79kb-+DFz2m-8arh+RDJibBMc_9vjTC5ZoXbojBBcThrBdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Add structure representing hash algorithm
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 11:12 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Since in the future we want to support an additional hash algorithm, add
> a structure that represents a hash algorithm and all the data that must
> go along with it.  Add a constant to allow easy enumeration of hash
> algorithms.  Implement function typedefs to create an abstract API that
> can be used by any hash algorithm, and wrappers for the existing SHA1
> functions that conform to this API.
>
> Expose a value for hex size as well as binary size.  While one will
> always be twice the other, the two values are both used extremely
> commonly throughout the codebase and providing both leads to improved
> readability.
>
> Don't include an entry in the hash algorithm structure for the null
> object ID.  As this value is all zeros, any suitably sized all-zero
> object ID can be used, and there's no need to store a given one on a
> per-hash basis.
>
> The current hash function transition plan envisions a time when we will
> accept input from the user that might be in SHA-1 or in the NewHash
> format.  Since we cannot know which the user has provided, add a
> constant representing the unknown algorithm to allow us to indicate that
> we must look the correct value up.

Cool.


> +
> +const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
> +       {
> +               NULL,
> +               0x00000000,
> +               0,
> +               0,
> +               0,
> +               NULL,
> +               NULL,
> +               NULL,
> +               NULL,
> +               NULL,

If we are fancy we could provide an appropriate die() call
as the function pointers. That way if you call these functions
by accident, you get a well worded warning instead of a segfault.
