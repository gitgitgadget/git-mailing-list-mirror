Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B13A72013A
	for <e@80x24.org>; Wed, 15 Feb 2017 13:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbdBONKm (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 08:10:42 -0500
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33153 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdBONKk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 08:10:40 -0500
Received: by mail-wr0-f180.google.com with SMTP id i10so190828873wrb.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 05:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bzkS8GgTWr2i+sr73ngCgo3+h+thbWhNFXlhdhvo2Z4=;
        b=IZW5RvlMpZQ+nWYtU2rUMOeruin7fVG0hdUxk9Q16FX3OweL+wWOzMiw4hUeSXi1+e
         MzXxp6Fkk4ZWGLGlgCH8iR8fORpIy+kUMxyWWH9TKZvTRJ72rtO8h3rjuyzmRGfohHZg
         bJldMRdPDdOusYCvAg9aYmiGvnWoXFguKtLJUzr6ScAqYhAbsCE2AjT2WWuJG+rjHYvf
         taJQtEhfmjdR2CNMN2Qw/NQ7DzexmrazcFzS+4VfUj5WgAYmfXOjOvNLKVj4urvUE6ug
         PcFpZyC6gSenBvq5d7qheGWK2VYbBX50nD+lbMT5EnV4nvnV5Sn1O6eri+z/bOMj0oHB
         6Org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=bzkS8GgTWr2i+sr73ngCgo3+h+thbWhNFXlhdhvo2Z4=;
        b=nsbsCy3SybnimgIzNuf2HbMSi6DrtgB7WHom/WCYzORAh5MTZtOIhRjNYB2/DiW8/8
         XdEN9MT8GWL4MMpq30KdKFM7gRwBP6SocIWVHECgSmPLIsmJrS6Rk+lgS/EQJ9CVvNDo
         /JYN7aO37+R9QOZzLO2wNbfiUDDCzhWlX+G+ELyrztVVbAlax96XgiqlRCOzSl7UeOZR
         Y2W0pLNx1ZbCjKDAumjPJkFOiCHL2HdORciFXiSmT6hW2454riqvWeADm0ipLhRw5pos
         4hgBJhQdr48BGYU/1OzNpTp1XnGMb95RgZaCReOpCG4J5DXhZXgalepjRBKvZVg6qDlk
         17ow==
X-Gm-Message-State: AMke39nr9pudy8U2nFaNE1O3pPBqe4IjwttwAbFY4sXMd0s+d09xwDNSi0qw/EZV+AQrOw==
X-Received: by 10.223.128.5 with SMTP id 5mr29532280wrk.163.1487164239244;
        Wed, 15 Feb 2017 05:10:39 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id h75sm4849258wrh.37.2017.02.15.05.10.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 05:10:38 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: git-p4.py caching
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAG2PGsqs2dQM0SJ25ocHJ+Nex_m2NC5yQQuROxcF6SG2e93wCQ@mail.gmail.com>
Date:   Wed, 15 Feb 2017 14:10:37 +0100
Cc:     Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
        George Vanburgh <george@vanburgh.me>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A8AD20AC-C069-4572-9C6A-519E1855220F@gmail.com>
References: <CAG2PGsqs2dQM0SJ25ocHJ+Nex_m2NC5yQQuROxcF6SG2e93wCQ@mail.gmail.com>
To:     Martin-Louis Bright <mlbright@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 14 Feb 2017, at 19:16, Martin-Louis Bright <mlbright@gmail.com> =
wrote:

[CC'ing Luke and George]=20


> hi!
>=20
> I am using git-p4.py to migrate a lot of medium and large Perforce
> depots into git. I almost exclusively go one way: from Perforce to
> git. I also frequently re-clone/re-migrate as the Perforce migration
> client spec is refined.
>=20
> For this, I have added rudimentary caching in git-p4.py so that
> Perforce requests are not repeated over the network.

Martin implemented an on disk cache and "requests not repeated" applies=20=

mostly for re-migrations. Re-migrations are multiple test migrations =
("git-p4 clone")=20
with minor client spec changes until we find the right client spec for =
the
production migration.

> I have it working and tested on a ~150MB repo and the migration time =
was halved.
>=20
> Is this something that would be of interest to the larger community?

I like the idea!
Disclaimer: I work together with Martin on the P4 -> Git migrations :-)

Cheers,
Lars

