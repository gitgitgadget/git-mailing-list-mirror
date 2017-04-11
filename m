Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A86120970
	for <e@80x24.org>; Tue, 11 Apr 2017 20:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbdDKUBH (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 16:01:07 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35628 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752580AbdDKUBF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 16:01:05 -0400
Received: by mail-wr0-f193.google.com with SMTP id l44so1207771wrc.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 13:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Eqj2RaMVjWYYzENL6+mJMN3iokFLWoe+Rh/5ehuUZWQ=;
        b=kdqJPDkF1NKrhFZ1y+nEL5Dy0rtVZU+5zqzp58CZZzQ4n1N5hcxJNqKi19JzbYVyea
         9zm4Lhg3NGuknfcsdGL41UZQUdsjPPESdx0z3HeQAD6yAO9GFmb9uS/kyiJPhHKKDPUI
         32XS9f/DpYNvMHC8akNvOjWQGIyhMrHsRVr1u5H8uNQ00hTXnJptjO5OMHoYluqw6Ga1
         Au0x/PTDyorzQlbgHbURD7QgE72p/EOcJgf9J8auTobPsuI6PdVHYNpJ7uG++SmEiv59
         ntRy+5R1x0RZVmOe/6unzPqr/wlZfQan4zKRRoUMZTEdsmCAXaB09+8eGYQCLxWi23+H
         z5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Eqj2RaMVjWYYzENL6+mJMN3iokFLWoe+Rh/5ehuUZWQ=;
        b=evaZse60AiysjcDfN600tkyVNexOjGF7Km5Z29vgeEnH6/lGlnIIhH0JLHFRP7/AA0
         jfZut5xz/e38t1mhc/UdY2m7hIlvmWjJzhkVkxod+FRwk0l0hbMAuT90gMdTPLwq48Bx
         Ni+WqarfdaaRtcRh4bnmvfQDvcD6IeV3ORk9alTZeAKzJc83ZT7LyEJdZNfknL9/LIaJ
         fmJMeOkNYD9DHsvNchkuGHIYU+ah7Fop7csCqRw3wSwzHiwGxPfXTdKSjbYyiWJiknVh
         Eg+XZykkaoZW58O6ZRzQGHUJG/mto9y8B8Q1U2pLjqLEoR7n4n7nj4E0oQikhCmBMz1g
         v27Q==
X-Gm-Message-State: AFeK/H2i2yZfzYBR+otjenoqyX4pjxWvMAjGHh8DqdeDYH9RfPqdA7UOOh+vaWVdtKqiyQ==
X-Received: by 10.223.172.129 with SMTP id o1mr48884162wrc.121.1491940864313;
        Tue, 11 Apr 2017 13:01:04 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB53F4.dip0.t-ipconnect.de. [93.219.83.244])
        by smtp.gmail.com with ESMTPSA id c8sm22768417wrd.57.2017.04.11.13.01.03
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 13:01:03 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 3/8] convert: Split start_multi_file_filter into two separate functions
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170411193709.w5tz3i3vg5mnnhfe@sigill.intra.peff.net>
Date:   Tue, 11 Apr 2017 22:01:02 +0200
Cc:     Ben Peart <peartben@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <629B2192-FD64-422E-9361-C182303582DC@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com> <20170407120354.17736-4-benpeart@microsoft.com> <20170411161617.fyu5pmzgplscoozz@sigill.intra.peff.net> <FD58071A-4DC7-4AB7-8B6B-56B71E715144@gmail.com> <20170411193709.w5tz3i3vg5mnnhfe@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 11 Apr 2017, at 21:37, Jeff King <peff@peff.net> wrote:
>=20
> On Tue, Apr 11, 2017 at 09:29:36PM +0200, Lars Schneider wrote:
>=20
>>> 1. Do we need to save errno before calling sigchain_pop()? It's =
making
>>>    syscalls (though admittedly they are unlikely to fail).
>>=20
>> What if we add the following right before sigchain_pop() ?
>>=20
>> 	if (errno =3D=3D EPIPE)
>> 		err =3D -1;
>=20
> Yes, that would be fine (though again, this runs against point 2 =
below).
>=20
>>> 2. If err is 0, then nothing failed. Who would have set errno? =
Aren't
>>>    we reading whatever cruft happened to be in errno before the
>>>    function started?
>>=20
>> Yeah, looks like you're right:
>> =
https://www.securecoding.cert.org/confluence/pages/viewpage.action?pageId=3D=
6619179
>>=20
>> According to this article we shouldn't even check *only* for errno.=20=

>> At least we should add
>> 	errno =3D 0;
>> at the beginning of the function, no?
>=20
> If you initialize errno to 0 right before a syscall, then yes, you can
> trust it without checking the return value of the syscall. I wouldn't
> trust it before calling more complicated functions, though. Not even
> xwrite(), which may see EINTR and keep going (which is OK for checking
> for EPIPE, but not checking generally for errno values).

Should we remove all the errno checks here as we don't have any direct=20=

"write" etc syscalls anyways then?


- Lars=
