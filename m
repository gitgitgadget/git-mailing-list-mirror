Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C4AA202DD
	for <e@80x24.org>; Mon, 30 Oct 2017 17:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbdJ3RkG (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:40:06 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:53311 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932137AbdJ3RkF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:40:05 -0400
Received: by mail-qt0-f177.google.com with SMTP id n61so17422441qte.10
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5Cmg3zmwkblbRz0W/oG19HVMfviFhIDUcLd/6CXdnRc=;
        b=Vg5BNdV5AGbr9Hl5IE62uvC4P3avlHWQOH8TYvW7mdPzjPpjqSINfqTVcX4+xr7rQ5
         f92ToBUX5ARDzHz/+AXvkzVH4XPnxm62Qwsw213CYd6joCyXlehlA58/wk5OV79zaCDD
         eXzwCpmM3dT/24CBJA5utlNPQKra6n1Z4fSB5DTkAbhwUHO9Iagn+ML1rWArQzoVcZTE
         VzQrAoKqvDyv0HmO1ExyftvxA1NN8sl4U0dpeQuwkdZ1tB5cDYbGajd05kV0Iwai+Akg
         4Bshjisr6CqTgBQAqHUGI5lEE6TW2J9NTiq1PCPEWJKk1gx2aIF20dpFpXrWqwwMkN3I
         hb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5Cmg3zmwkblbRz0W/oG19HVMfviFhIDUcLd/6CXdnRc=;
        b=jWiYbFec4oaVQLrvgVhFltP7bYNn1EouJ+/nWZzfN5h4XOYXB9xvNd711/hlVzzZFO
         LQM/RIWsw8X5loNc5TsiBpAhAfDQmIkwfdeaSKLVLHrC414iWx1emCZt31KJiD9WHIII
         OpNkt+S14AyLlRDLugmOV4cUWmR3wgqXa1I3ddhx+fS8g905Rf7fQsmVLoL421IFt7W/
         3AW0BO+eC6gkz8kDGuHiZ8LdT0CS/Bhb8SeT9jlOKYnjfMFaf11HEoWiBZl/3OOSccp9
         VjUztTuM+fTghtidN47278mTKiNZS4olnwjt4rHCVVPrNv9JIj2jEGnyeU46px4R72ug
         w1ng==
X-Gm-Message-State: AMCzsaWohArDCj+EiqArAh/pYO/GcgXyNZPCpaIu2/gSnxdShRbfEGQ7
        /RwdriYWmKWdvA9T1eScdTEtw3jrlFkKREOuiKaGsQ==
X-Google-Smtp-Source: ABhQp+SEWkD15wGRKXQgYn8TlRUaV1zHTqqa1OzdiFKc4ZkwyrysR8lRvetSPVNLFmo4Q3cvHcN9kE1UkZbAcCuAJXg=
X-Received: by 10.200.40.146 with SMTP id i18mr15265227qti.79.1509385204884;
 Mon, 30 Oct 2017 10:40:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 30 Oct 2017 10:40:04 -0700 (PDT)
In-Reply-To: <20171029151228.607834-1-cmn@dwim.me>
References: <20171029151228.607834-1-cmn@dwim.me>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Oct 2017 10:40:04 -0700
Message-ID: <CAGZ79kb5-6_jQmEqiX4cb+GQzOqCcS8Fqw7Wu4D2YPdmx83pxQ@mail.gmail.com>
Subject: Re: [PATCH] diff: --indent-heuristic is no longer experimental
To:     =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>
Cc:     git <git@vger.kernel.org>, Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 29, 2017 at 8:12 AM, Carlos Mart=C3=ADn Nieto <cmn@dwim.me> wro=
te:
> This heuristic has been the default since 2.14 so we should not confuse o=
ur
> users by saying that it's experimental and off by default.
>
> Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@dwim.me>

Looks good to me,

Thanks,
Stefan
