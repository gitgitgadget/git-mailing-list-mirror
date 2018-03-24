Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 251471F404
	for <e@80x24.org>; Sat, 24 Mar 2018 17:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752486AbeCXRKE (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 13:10:04 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:42677 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeCXRKD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 13:10:03 -0400
Received: by mail-pf0-f169.google.com with SMTP id a16so5914936pfn.9
        for <git@vger.kernel.org>; Sat, 24 Mar 2018 10:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=ITMpTgWR8wxFxHAnUFNSzp7JL9ZZmS/d95jb7NlVCG0=;
        b=vCnNnLt5rObj7A1jQll9EgvatOONn/nNadd5KxcNGvK00zsD/N9wXCgjSVv3ILR2Yl
         hsy+TWafcifvdrjnYRHGS7KEZobjR7gU8WUs2U9CG3JONjRcCxmMthXA7UPHqzVmdGE5
         pL9gJmdDhKEfeX3vo2iLP+5dKFatOus78Qp0hj2Z36KXLLNrGZ/64zIjTpYcUMCrNQRY
         8DMNy1cgXd+rQq1pirZOltW+9XLHkqnKXm0NhuMn2cDjnR7MrhwbpbFEbA7EC90RexX3
         eG6cZsyNvHiSlatZ2IStZ2yaLPufUYki3ooMfn/C+4muLev+TDMoyqcAbgD7RkYYMs3/
         5gAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=ITMpTgWR8wxFxHAnUFNSzp7JL9ZZmS/d95jb7NlVCG0=;
        b=c2IuF14be5VyGG6eQZYewx8j/8ZX8F+dVjgwTf1tT5GRk+emzfmC/MInyu16Y3LA7h
         Jr2UjS+9Db96f6QEIQI4KkI7EHcsV7AHiqSLJkITR6Qe1Epih4HU9FmpFtpQ8FtSl4Lc
         KY9GcyIWy6/8mN4cMDdLWaHD1V2Y7dS4EdFJLn4xp/GbI4fKwpG+/Xke12+N6549z4lm
         Mx3VM2XMOf7APKNzXS36xsj0nljyb13RFyMKid9W7eMbVoyaxnh9cMF5F7tctENsv7hP
         7pZYPL+Sts40QT4uNasPQpDZmIRF9B7VUu3Fv6WjhLo9fegXwIIVq21js1t1u20tC0t6
         OD1g==
X-Gm-Message-State: AElRT7HSqA0UIPtVCeTE8xPJbNE46kgsJhmQj1YG/6qTuqNjJ6qy7X7F
        G3S5xI9jVO4yQgEYOwDQwXE=
X-Google-Smtp-Source: AG47ELs2oFwmx0ytrVkr7STe6aPQj2w9KAOv5TGXDroZY9jidtkbYq9J3SD7cMkTwcdqYqdsKnP8Kg==
X-Received: by 10.98.18.70 with SMTP id a67mr27848722pfj.213.1521911403222;
        Sat, 24 Mar 2018 10:10:03 -0700 (PDT)
Received: from [192.168.206.100] ([117.251.231.152])
        by smtp.gmail.com with ESMTPSA id t20sm22472374pfh.182.2018.03.24.10.09.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Mar 2018 10:10:02 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] builtin/branch: give more useful error messages
 when renaming
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-3-kaartic.sivaraam@gmail.com>
 <xmqqlget3wqa.fsf@gitster-ct.c.googlers.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <3d5aa4f7-de4a-15d4-9987-13524dc40c59@gmail.com>
Date:   Sat, 24 Mar 2018 22:39:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqlget3wqa.fsf@gitster-ct.c.googlers.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="vHt0hQy0yv7fpcnJ1n4XLYigufPqxdb2T"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vHt0hQy0yv7fpcnJ1n4XLYigufPqxdb2T
Content-Type: multipart/mixed; boundary="WsE7y7SEqly86g9J87KkRu3K17VOQpfMb";
 protected-headers="v1"
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>,
 Eric Sunshine <sunshine@sunshineco.com>
Message-ID: <3d5aa4f7-de4a-15d4-9987-13524dc40c59@gmail.com>
Subject: Re: [PATCH v4 2/3] builtin/branch: give more useful error messages
 when renaming
References: <20171102065407.25404-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-1-kaartic.sivaraam@gmail.com>
 <20180310155416.21802-3-kaartic.sivaraam@gmail.com>
 <xmqqlget3wqa.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlget3wqa.fsf@gitster-ct.c.googlers.com>

--WsE7y7SEqly86g9J87KkRu3K17VOQpfMb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On Friday 16 March 2018 02:03 AM, Junio C Hamano wrote:
> Quite honestly, I am not sure if this amount of new code that
> results in sentence lego is really worth it.

Speaking specifically about the new code for the sentence lego: I
currently lack knowledge of a better way to achieve the same outcome the
new code does. Let me know if there is a better way.


> Is it so wrong for
> "branch -m tset master" to complain that master already exists so no
> branch can be renamed to it?
>

Speaking in general about the patch itself: though I still find the fact
that "the error about an inexistent source branch seconds the error
about an existing destination branch" to be a little unintuitive, I
actually went on to reboot this after a long time as this also seems to
bring consistency in the error messages related to moving a branch. It
seems that the commit message requires an update as it currently seems
to be misleading as it currently doesn't specify the motivation completel=
y.

That said, I won't be against dropping the patch if it seems to be
adding less value at the cost of more code.

--=20
Kaartic


--WsE7y7SEqly86g9J87KkRu3K17VOQpfMb--

--vHt0hQy0yv7fpcnJ1n4XLYigufPqxdb2T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJPBAEBCAA5FiEEmrp5T6QugsbUnN0Nveda2sPWGWkFAlq2hlwbHGthYXJ0aWMu
c2l2YXJhYW1AZ21haWwuY29tAAoJEL3nWtrD1hlpsRIP/1l108FYLG/1mhKHeBgG
3Yt+HcyBah6oQKB2lV2ypH/rC3gqsM4DPdIFvvpAi8bjxhQmxZrfz+J2wP8nR2Ko
Mlbm7LTJjgxk4yE1o2kY8q7T3FNsOmHUHStJrklmhGR/ZksaAPeKGhIO350dcpLJ
6aoBnnHMpPZDZMczhtS5nY4kfHH84UaRhaTE8/j1hZq78j7wpDl4XqYi0ZFLbVU/
P4uYIMtHW7srfpJtg6KBN5kiCtMZp4TG7qY32MgEXzJmVakl21L3vWVjw/Cgkwyr
f3hNiFeaq0vZvUMMphrCLmzGKFFmbHbIhBl6LPQ6m5ioJEWu78ab1HUeLPh1lIzr
U3InYWwBvnPvDUCi4Yr0SmzI+OEeWQjI0+qB62EZcStfsB/ezp3aY5Wl+kkkItx8
o1vrIu6WmmBkKJ8Wq08oQrZ3JGPWBdbJj3b0y4k5h59sjBqMzeVEE3GD5Bqvt80+
aOA/AkJwSTbB4HNezmvYhe9QyOmInCcweBdKgcJlUqTohr4gZwSIduyzDfY80LXO
EImAT1E6gGpklKtyF4X6we9LQ6p54ryFzC2XOIiOZuHmHf/85+e06pdpRhJTd2ZK
VTYA8KuCaCmkmY3lImUMbjdBLJrjVZxAIySeyFanAdhl+f3JP5G2U2esUfM2v1yC
u1inJoBVe8dkU6W1yvNeIU3X
=ZOvY
-----END PGP SIGNATURE-----

--vHt0hQy0yv7fpcnJ1n4XLYigufPqxdb2T--
