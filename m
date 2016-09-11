Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A19207DF
	for <e@80x24.org>; Sun, 11 Sep 2016 11:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932163AbcIKLod (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 07:44:33 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33086 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbcIKLoc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 07:44:32 -0400
Received: by mail-wm0-f68.google.com with SMTP id b187so9548054wme.0
        for <git@vger.kernel.org>; Sun, 11 Sep 2016 04:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zH7JvRj6AsFfjUD+Rdqh1g3O3el+TumCzQRwVDWCDao=;
        b=Pq5do0Td55X1F45tKWKj2fjAIe5XAI25T6LWPn2fE6njBDaJdU8502J0c6gMwV201x
         CNJw88bstcs9+tkXTly8y+1AhB101Q5icEpmZV+TN+Ej8ARgr5cmCDQuNu0enqzY0KEb
         zaF4POpLogPvk1x+HNCizA+vkHehk/9V597y5HiUS534Kn2TYrXU7yutAwaeSZGqbEki
         5x5WeRwD7JlY5asx/7R430q35DJdlK58dADjeFqAy4xDSmBEV5W/DSYsqzJ4GV2Vh3W1
         8A0gv5HhTIJBJ0RH0NWHPADaoWNd0+fVSTHvmcHGgAZNt2ScnvHFhq1T2RJMry5+20EW
         6Lcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zH7JvRj6AsFfjUD+Rdqh1g3O3el+TumCzQRwVDWCDao=;
        b=CaEHXKiLSXpqLat6ajbQr2EAREpRG6ciyNoGHi6Dx81qeHTi6VI+8Igyabr10ThK+C
         5JrfZ5+i19vHNk5ngNvJ31MP02aBYEn+j/nBRJIN8jad5k4N0ea6ipgExH8Urqu74KTg
         Q7rzKtg9f+J6tFxaCVfuAgNtYY+pgeN9FDTdB5BmZnOKXuyKdRrSYSMMMobFIp7dyRee
         D57+B89BnVV8pqWU7IaSxx6g7U8A1NzwiSvAPxa+WYvLp635JVyZlmMgswzIz8YpomUO
         X9e7n4EFvMXLSka5BZYQqwaKrrEeFWlVlfx6SzBjHWG8ZEGxHMViA/JHLRX2Ox0w5zTS
         8m4g==
X-Gm-Message-State: AE9vXwNHTe5GwmyQYwjifr0spWCDbBMCSLCeSTu0EkGisNWpT5ig5239T+DyczFm47dGKQ==
X-Received: by 10.28.68.8 with SMTP id r8mr6628210wma.4.1473594271160;
        Sun, 11 Sep 2016 04:44:31 -0700 (PDT)
Received: from slxbook4.fritz.box (p508BADCF.dip0.t-ipconnect.de. [80.139.173.207])
        by smtp.gmail.com with ESMTPSA id va3sm12638010wjb.18.2016.09.11.04.44.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Sep 2016 04:44:30 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v7 05/10] pkt-line: add packet_write_gently()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAGZ79kZdroDdD5SHP+-9svSTYbJfn2vsFXAwC4aen3hMVEOOPA@mail.gmail.com>
Date:   Sun, 11 Sep 2016 13:44:29 +0200
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Martin-Louis Bright <mlbright@gmail.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7EA8897A-B283-44B3-BC9B-5F0518C9C1CA@gmail.com>
References: <20160908182132.50788-1-larsxschneider@gmail.com> <20160908182132.50788-6-larsxschneider@gmail.com> <CAGZ79kZdroDdD5SHP+-9svSTYbJfn2vsFXAwC4aen3hMVEOOPA@mail.gmail.com>
To:     Stefan Beller <sbeller@google.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Sep 2016, at 23:24, Stefan Beller <sbeller@google.com> wrote:
>=20
> On Thu, Sep 8, 2016 at 11:21 AM,  <larsxschneider@gmail.com> wrote:
>=20
>>=20
>> Add packet_write_gently() which writes arbitrary data and returns `0`
>> for success and `-1` for an error.
>=20
> I think documenting the return code is better done in either the =
header file
> or in a commend preceding the implementation instead of the commit =
message?
>=20
> Maybe just a generic comment for *_gently is good enough, maybe even =
no
> comment. So the commit is fine, too. I dunno.

I agree that this is too verbose as this function follows the standard
Git return value conventions (AFAIK). I'll remove this from all commit
messages.


>> This function is used by other
>> pkt-line functions in a subsequent patch.
>=20
> That's what I figured. Do we also need to mention that in the =
preceding patch
> for packet_flush_gently ?

I'll add this note to all commit messages that introduce new functions =
which
are used later.


Thanks,
Lars=
