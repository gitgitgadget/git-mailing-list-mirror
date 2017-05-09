Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF001FDEA
	for <e@80x24.org>; Tue,  9 May 2017 14:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754342AbdEIOW3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 10:22:29 -0400
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34562 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754334AbdEIOWZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 10:22:25 -0400
Received: by mail-lf0-f52.google.com with SMTP id 99so1910964lfu.1
        for <git@vger.kernel.org>; Tue, 09 May 2017 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Nlz0J4L27/OaCBHDwwMcB2Hc7/HBDfBX2qF5ut3pCJg=;
        b=drFKDyNnsDQs632aQODmkLe7ixzBfUNIz+xOOrJBSY2BPs/DDh4dQcG5nfwoUXqmz7
         d91tjWeGm98NypIGFrqXb5KvzCOV65UWw1q0fKvs6pByGSVA+7xxBXh9PFnduFLfHZ9J
         mviDFq+z+P0qyOEUU/lwdVCq38xPLICXSGVTZE/7KBFxhlLAYcBodGfMvRModecbl68q
         DD/rm6Lz9Ugo+QW8yw+A8uewVtl31KuCYSKcNTM685olcyI2O6cd88uJ/gP0vrPY4K5R
         iXBYGYemAtWkEC1DPiR8y645wA1UdDKwI210skkaEqbCAberA7Cn4eNXVY8+8UPy21Gr
         WAjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Nlz0J4L27/OaCBHDwwMcB2Hc7/HBDfBX2qF5ut3pCJg=;
        b=l3Pe/JN7JWWtfMP8aa+eGfn6cJTd9lCNaojWt4qlJuF0Vy0jcCQpYNhuyGb9oo4wMe
         hNdoKlg9tKfERecKh5meliusACp0ArfpeXd3PT/uGjIYTKd6KpPL0/85s9LZtIYAhOrI
         IhPd/KncRg+3Cdjxwm/4favHCg/JsKcI4VIV0g8hJbr3GkDZ6RseUeThnQlgrSkTK3H9
         8ZTFDrG20lGCNsUZEWbkTRP221knsQrZP4rcEojj86k1mgr5ZAK/7mm1BKbogp5jLggO
         FodfMjAmame6feLXfeP4mV+gGI1mufSQWb9VTbqj8JbeV7jU/JWBrcyFQ9bq0QHCwxMH
         EH5w==
X-Gm-Message-State: AODbwcC+n2IVtFqoXhvukG4wqZ5YxJjKF5FDTG8OKGA8k5tSKYK61rO6
        enbuc9SaU0WVkOD0D+aL+C6gRWzTgQ==
X-Received: by 10.25.19.31 with SMTP id j31mr165137lfi.79.1494339743551; Tue,
 09 May 2017 07:22:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.168.196 with HTTP; Tue, 9 May 2017 07:22:22 -0700 (PDT)
In-Reply-To: <CACBZZX6V8qbnrZAdhRvPthy5Z91iEG8rrJ=Sf9tdkOt52M9j1Q@mail.gmail.com>
References: <CACBZZX6-qZLEGob6CEwpJ7jtEBG6WLPdHQsO4DsbkNZ8di5mjg@mail.gmail.com>
 <alpine.DEB.2.20.1705031139090.3480@virtualbox> <CACBZZX6_5krLp93PmsW639-N4f1efUT5rPnN+5im=d9-66=QbQ@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041104070.4905@virtualbox> <CACBZZX5bPN3vZhE=0TSQNdRvKYuV3635=VCQAppAfcZ_tuGpvg@mail.gmail.com>
 <alpine.DEB.2.21.1.1705041328190.4905@virtualbox> <CACBZZX75nvfQft-gjUG+YP0Y-e-=Knm3bMeDWHSUF=Juz9Ua5Q@mail.gmail.com>
 <xmqqpofj7rim.fsf@gitster.mtv.corp.google.com> <20170508233224.udpuuzlygjpsjogt@genre.crustytoothpaste.net>
 <CACBZZX4G_ThE55Gi53QJt1=9K4jQXqJ3QL8JSGpiSSSDRrKeNA@mail.gmail.com>
 <20170509003714.ylwn5ezvu5h36kj7@genre.crustytoothpaste.net> <CACBZZX6V8qbnrZAdhRvPthy5Z91iEG8rrJ=Sf9tdkOt52M9j1Q@mail.gmail.com>
From:   demerphq <demerphq@gmail.com>
Date:   Tue, 9 May 2017 16:22:22 +0200
Message-ID: <CANgJU+Vc2EC6o9CQ8O_Q52u0Q=3rkQDWafYWs9DzsFACBzX3Lw@mail.gmail.com>
Subject: Re: PCRE v2 compile error, was Re: What's cooking in git.git (May
 2017, #01; Mon, 1)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 May 2017 at 13:12, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com> wrote:
> On Tue, May 9, 2017 at 2:37 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>> On Tue, May 09, 2017 at 02:00:18AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
> * gitweb is vulnerable to CPU DoS now in its default configuration.
> It's easy to provide an ERE that ends up slurping up 100% CPU for
> several seconds on any non-trivial sized repo, do that in parallel &
> you have a DoS vector.

Does one need an ERE? Can't one do that now to many parts of git just
with a glob?

Yves
