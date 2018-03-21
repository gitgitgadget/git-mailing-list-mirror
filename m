Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86F2D1FAE2
	for <e@80x24.org>; Wed, 21 Mar 2018 16:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752613AbeCUQxX (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 12:53:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44942 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeCUQxW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 12:53:22 -0400
Received: by mail-wr0-f194.google.com with SMTP id u46so5893417wrc.11
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 09:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rN+QvNxW1Yjx9mfM2OPnlUoQbKqFOMOyYhrgUV7OKR8=;
        b=XYol2enT9ZtwNqcILZrhXHh/zhbCIw9ppqCndKm6yMe1EjUxsZG+0Mvf3C1GSyt+x9
         I3Sd8+u0Z1PZIWFG+45GE21ZMkhIG7PHAAA6xQgEhw2+MLoAa2xRrIqUu5RB3GVKYXvv
         F9XDzgnf1eH1tbsqzZ2HuZZ65N0a2DfV9a4fwT8BfBl4s6oiSY/qjm9ewYxozrbTx8m9
         DxG90RcFLgd2GbW/68sY2HFKyflA1nVMMRSSnPV++Wd2gA/WoCWFkd01qLzcGD3g9Kc5
         nh/p3wNFDJiiaDLv58NfRKrNBbxDfyxohkSWP/OiZewgP2Rxs+Y1GRgFQPrIA5mu5add
         EU1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rN+QvNxW1Yjx9mfM2OPnlUoQbKqFOMOyYhrgUV7OKR8=;
        b=cVdQ7VxJfmqevUVfmIm+ONFdui31oJgTTBIRx43tPzY/iZucbAl1U7M/RiCZr5+pSk
         xpyspnspgwkKx3mMP8yaXANZLXcvJBkoiLCdqedTgsN/I223/uqgv1jJDOeV5zFEwIsn
         j5D5+92qhkD+AkfIFoF4DZSdxQnye3yEKW+60PBpm8Zxc8eMpWKPWFp0QirYJ8chUcDh
         jbQC9HLdJaQkbPm1Y+iNpyuN8IoEepF/IzEsh4q40XIl6opq00PzwvAUJI2xjD95eGDF
         vx0K9buJVEgWxKZAWiyZR2nX+JpVCOMJT34nb5A88InYfBBcbGcUvgbRCX/kJ/WNlXES
         kpQg==
X-Gm-Message-State: AElRT7HjEpKA0lx67toJLw6A3tZKLzPk6fYv1JnzHlgJMmIF6mdWf1VY
        dmjvoBWzN4TsqjJS8vpJboQ=
X-Google-Smtp-Source: AG47ELuMUnSn5zu07UoDsW9yL/pQRgNV1PgATF+jfvaGYN0nS59xT/S0evS2Az8IHTcHBiFljnCxnw==
X-Received: by 10.223.136.217 with SMTP id g25mr17958162wrg.203.1521651200617;
        Wed, 21 Mar 2018 09:53:20 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s49sm6437764wrc.95.2018.03.21.09.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 09:53:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        e@80x24.org, git@vger.kernel.org
Subject: Re: [PATCH v6 00/11] nd/pack-objects-pack-struct updates
References: <20180317141033.21545-1-pclouds@gmail.com>
        <20180318142526.9378-1-pclouds@gmail.com>
        <20180321082441.GB25537@sigill.intra.peff.net>
        <87tvt9xuel.fsf@evledraar.gmail.com>
Date:   Wed, 21 Mar 2018 09:53:19 -0700
In-Reply-To: <87tvt9xuel.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 21 Mar 2018 17:31:14 +0100")
Message-ID: <xmqq370tqsjk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> That's going to be super rare (and probably nonexisting) edge case, but
> (untested) I wonder if something like this on top would alleviate your
> concerns, i.e. instead of dying we just take the first N packs up to our
> limit:
>
>     diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>     index 4406af640f..49d467ab2a 100644
>     --- a/builtin/pack-objects.c
>     +++ b/builtin/pack-objects.c
>     @@ -1065,8 +1065,9 @@ static int want_object_in_pack(const struct object_id *oid,
>
>             want = 1;
>      done:
>     -       if (want && *found_pack && !(*found_pack)->index)
>     -               oe_add_pack(&to_pack, *found_pack);
>     +       if (want && *found_pack && !(*found_pack)->index) {
>     +               if (oe_add_pack(&to_pack, *found_pack) == -1)
>     +                       return 0;
>
>             return want;
>      }

It is probably a small first step in the right direction, but we'd
need to communicate which packs we ignored with this logic to the
calling program.  I offhand do not know how we would handle the "-d"
part of "repack -a -d" without it.

