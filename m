Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679C71F404
	for <e@80x24.org>; Mon, 26 Mar 2018 02:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751087AbeCZCKX (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 22:10:23 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:39369 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751035AbeCZCKW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 22:10:22 -0400
Received: by mail-qk0-f171.google.com with SMTP id j73so18557920qke.6
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 19:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=KjjRrP42pLrUPpa5FHFijG+k1izdRgQUlf6ShOZYHxo=;
        b=MDyeKM/8T3Us2Xv8IibpmjVUPQHqdgKuu/3s/nYRQniPlIAeIDeGwNZaaKG6Xk/2Ul
         kHWmmeCcySCMXTnS29xBpccWaVBgcbhZUZIcPUiq3l3Jj3oPAG8AwOu5rmPvyWzhBYF4
         X7fqhieL0gGZLbnT+LDZu7i9Ghqu8IVElLz/dYuLMf7rNKpQ0LtuSo0xkndSz/DNeXsh
         H35jvdM3tKN6sE69qrDh4wf29vYEg9pINvQp1qn6F2Uh2g0AorPJWbfbAL3V+//SDClh
         gTi3ka6EIEtNr/xz6ZDmu/HO4x8xR6LPuSi1Pp0aKfhdDVhtemERr6pd9BMXiYL5Lt8d
         FvJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=KjjRrP42pLrUPpa5FHFijG+k1izdRgQUlf6ShOZYHxo=;
        b=VWYlrbRv1PV5AwOhvUYJQl2wqcMcgBZb1dgQiKgwL4xMF9BvTGTqfmt0GhyYPfWgP7
         0tMwRCRH1naAUj3MpL68fcqN7KorygVRIyYeFVSwP85FSmi7cPGuS+CbSrpc6+c22Vxm
         b3gverJ0XM0YZ1ZbghNl3krcNfljaRI08Yu4nRo1v5jyz90chl9yvoAFJsK94uwRDpdn
         1tXg62wbtJ6pg6sMp8MJX48mSplo9Olm0oXRtoSNIfkGFzt8ujnr8lujjgtpblXpyCl7
         Q57aKK0L45lBqLUFPYbCDE1v6GYtfp6JdDH9Efqf1iEc2WwGxGxqq6J1u+dUbxt8suOe
         daoQ==
X-Gm-Message-State: AElRT7GDaAfDm5VixJRK+Cj1UY8kAU0HVQFqTh3nDyOSmuINNXUkTQB+
        VZs15kpVCYORwGIfCYHK9NnDDOIU6PYvJ3MNgTs=
X-Google-Smtp-Source: AIpwx48K1C8wrR4bXmxCMtvPkojsaEyh7HEltACnpkw8K/KOW9vlRVQCmkuZI5wbDj9Acu2Dw5PgNMZRbPnbLOccflQ=
X-Received: by 10.55.182.70 with SMTP id g67mr13401055qkf.314.1522030221919;
 Sun, 25 Mar 2018 19:10:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Sun, 25 Mar 2018 19:10:21 -0700 (PDT)
In-Reply-To: <20180325192055.841459-1-sandals@crustytoothpaste.net>
References: <20180325192055.841459-1-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 25 Mar 2018 22:10:21 -0400
X-Google-Sender-Auth: SBnJ7E8PqJoF5hv9QGEs1YUhVCE
Message-ID: <CAPig+cR==SNfGdhwqPdvW75fUxXg-VSQ5Tz_OR7Sy_c0L94axQ@mail.gmail.com>
Subject: Re: [PATCH 00/10] Hash-independent tests (part 1)
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 3:20 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> This is a series to make our tests hash-independent.  Many tests have
> hard-coded SHA-1 values in them, and it would be valuable to express
> these items in a hash-independent way for our hash transitions.
>
> The approach in this series relies on only three components for hash
> independence: git rev-parse, git hash-object, and EMPTY_BLOB and
> EMPTY_TREE.  Because many of our shell scripts and test components
> already rely on the first two, this seems like a safe assumption.
>
> For the same reason, this series avoids modifying tests that test these
> components or their expected SHA-1 values.  I expect that when we add
> another hash function, we'll copy these tests to expose both SHA-1 and
> NewHash versions.

What's the plan for oddball cases such as 66ae9a57b8 (t3404: rebase
-i: demonstrate short SHA-1 collision, 2013-08-23) which depend
implicitly upon SHA-1 without actually hardcoding any hashes? The test
added by 66ae9a57b8, for instance, won't start failing in the face of
NewHash, but it also won't be testing anything meaningful.

Should such tests be dropped altogether? Should they be marked with a
'SHA1' predicate or be annotated with a comment as being
SHA-1-specific? Something else?
