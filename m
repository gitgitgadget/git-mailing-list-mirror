Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B089D1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 13:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeCZNDz (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 09:03:55 -0400
Received: from mail-ot0-f172.google.com ([74.125.82.172]:43658 "EHLO
        mail-ot0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750984AbeCZNDz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 09:03:55 -0400
Received: by mail-ot0-f172.google.com with SMTP id m22-v6so20487706otf.10
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 06:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PVGLXpHet2GrD5uONzN9fagaY66c27GI1O2L8kH+H54=;
        b=gsivH90+YgfAV84JdUd2qxQB00PWT1ufgnmaDREXA1wEj5sXuE/Of6lygQPowgFcnN
         sG9yaGTei+xvo4I/RgOsJ0wzGJyFQlSe4xz+aspYPPMW4euCHEwvKShvcoXUr+hjodr3
         UKtqBVz1jYeQq0kuZ/xAFhriDyOLU0zN21snvTminzGqWvBvFj8vqP0eG7hAWTcctYyn
         dYWJkKZh06KyUbtm36Bq4WT/26Pc09TYarhe0beCWCIVCmNp6B8nRNtDfAPrD60KxUYx
         tWb1FajE+Xt/psty/TMccExIRBl3fQ1xy5voeV/LZL+4yeAIE1+HE6+CLZcxxEBYvbbf
         d0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PVGLXpHet2GrD5uONzN9fagaY66c27GI1O2L8kH+H54=;
        b=J2hitmr4ko4wvbUDkWvwwqrTTNqKSSLQpIOTYVBEybuX+JIfqA7Kp3+z4MQ8+3EzHB
         Jv6GWcXpD2knmdZTace3zPwPFQo/deTq8vjETGKmOQ+4KHG+TJgLwqGPGdRErDKTfkzt
         TsSC4Y77Q++HJvWskcrIMnYxlOnHi61fdCLV7YP/OJKUzUqN5dfQa3M8ZI6VRJvzFECR
         jJVLtpomrzolc6bWu+pbJ711zokxz9i/760zXK5kUDdDBY4yDPqzBJGQNlSjhlQR0r6Y
         XJAlIEMpWr5BexDkTOXALlduFtvqLPCzkeIP+qgQ08k3Zmhc9xyCIFeN+GAPqDFqhibr
         L0Ww==
X-Gm-Message-State: AElRT7HZ6vWNbK0nJp10rAhdOOf0SxiZ319pvh+r2eTgwtVIlKzT9OdC
        IedGCqxHmkBz3DX4pPDnNCJAwzcj8aXk7CJpdappuA==
X-Google-Smtp-Source: AG47ELuh3BpCYW604tdvdF+poHwehf0p+1RXllnh9VH3x2hselAjgipFTjCAptyO3DhhVnSwwrxKHy2ikj/GciBWfF8=
X-Received: by 2002:a9d:ae9:: with SMTP id 96-v6mr26574235otq.75.1522069433822;
 Mon, 26 Mar 2018 06:03:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180325205120.17730-1-dnj@google.com> <877epzyi0b.fsf@evledraar.gmail.com>
In-Reply-To: <877epzyi0b.fsf@evledraar.gmail.com>
From:   Daniel Jacques <dnj@google.com>
Date:   Mon, 26 Mar 2018 13:03:43 +0000
Message-ID: <CAD1RUU-EoitBdoXL_JQoP+Q9BuA_6Fq65Ra-f+Atz8YNOV3Cig@mail.gmail.com>
Subject: Re: [PATCH v7 0/3] RUNTIME_PREFIX relocatable Git
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 25, 2018 at 5:15 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <ava=
rab@gmail.com>
wrote:

> This looks good to me this time around, couple of small nits (maybe
> Junio can amend while queuing):

>   * You add a dependnecy typo in 2/3 but fix it again in 3/3. Should be
>     squashed.

d'oh, I'll fix that in my local copy so that if I do end up needing to
upload a new version, it's available.

>   * s/\Q${gitexecdir_relative}\E$// in 2/3 can be done less verbosely as
>     s/\Q$gitexecdir_relative\E$//. Discussed before in

https://public-inbox.org/git/CAD1RUU-3Q_SYvJorU+vEY2-0CPMZ1eL-41Z6eL7Sq4USi=
J0U+w@mail.gmail.com/
>     seems like something you just forgot about.

Oh sorry, I must have missed that. I have a personal preference for adding
brackets for clarity; it leaked into this patch set. I did implement most
of the suggestion, which was to use the escaped Q/E instead of equals.

Stylistically I still prefer the braces, but I'll defer to you and remove
them in my pending patch set in case I'm asked to submit another version.

Cheers!
-Dan
