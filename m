Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5503C2B9F4
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 22:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A54661026
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 22:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFVWfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 18:35:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:50245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229675AbhFVWfK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 18:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1624401166;
        bh=Tu1i1CmKXF/tnQkc4DqzH5lCDQr+c2FdwwfUhAncZiQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VuEUMerYrPl9/SnR2awR5sQKje4LeAVxCfZOXRfyWQzxdNCDBR8UMnKaulPdURnGM
         yvEpxVFZDG8uinyn8c9o+P5R0Trip6dREQQRNvm73mfEmNY7osR+DScCZo1o44tutZ
         f/aTLI5zMHMlG4MhP7Za9s1mlKSkue6MANbLm8e8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([213.196.212.83]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MuDXz-1l8fhY3bDh-00ucpv; Wed, 23
 Jun 2021 00:32:45 +0200
Date:   Wed, 23 Jun 2021 00:32:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 3/3] hook-list.h: add a generated list of hooks, like
 config-list.h
In-Reply-To: <648321ed-bda9-d7fc-73e1-7ccf48addf9c@web.de>
Message-ID: <nycvar.QRO.7.76.6.2106221642560.57@tvgsbejvaqbjf.bet>
References: <cover-0.3-0000000000-20210617T100239Z-avarab@gmail.com> <patch-3.3-f343fc7ae6-20210617T100239Z-avarab@gmail.com> <20210618170550.GE6312@szeder.dev> <648321ed-bda9-d7fc-73e1-7ccf48addf9c@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-360727885-1624372997=:57"
Content-ID: <nycvar.QRO.7.76.6.2106230032430.57@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:Abyz0mMqpE9m/lujYLeERaxlbDnN9qHqdcJOr/T9LISYW+MRI7U
 37ckuYCI99z6umdeZiL02cTyoJiFm6uNLBkjbbKwVmQW4JTYdD/Jzw2KIA5H53Hum/qrk5w
 J24A3YjRk6KsLm3gyQWM8ND9v9RBxw4C3EOGEkv3S5z9525NKrIDYyL9brzzoBTlXsznHnl
 gpVj7lfPxU4aWzE0YpRlg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:apMfdL+HawM=:LEPl0zUnIbPKC1Va1G4Gu7
 /6j9PJzDZCQ8IfQB7zydtEXBRp/rklaqTproo8a5xRKUihtRQ+WoASxFTayv/NFpj5hQyrdfD
 vL/aUB5EtEMV+Q6BCbwDsjO5sCGZvPBGizAdH4qIlZ6MLWkJIZ+tBk+mO7OgT/46nXMjvU6uu
 W/mugjQy8OnzUrAzcO6ad5yctWWHB+rcRcWdw5ahfqTsNNYgPG/xG1tkwIbA4xnPB9vQrg1f8
 DbGaNsI1NpSOQLTKZcQq0PeO8Ii/09C0ep8zP5QnaX5snaNAn+33nD9CvkeoINwZuY39SKjOm
 iGse2BiDwJgUTHuszlsin5J/U6kRiYeH7s/WWkid55GF85Ct3L/04bqqyr+muhcoVQMb9mESV
 KVCKpulUKFELgPq9lqQRhw2C4zi8l31f0tPS9dliT7ZSzKuH8RaxYfoBmlSct3BIsxJZowMBt
 DvrTkMQ1qVa0eqmkcHkBdt6Moeus767oLdGMWeUfL6zSNs1sTUwsyX6RqCC9M/hJl4lEbzzqT
 BkmonBI9oNQ0J94MpijWk7q9k+INJhgoGSKIS/3UEwOoVb5uMZ9KNi0vl2jQOOQCxNjpbfu3C
 bGHbJ+TpYYlhli465WOXv70gK0wwYXVXb0J5SH1qzhB2DrkFHgYks6BtxwYiVklLBGOHkczQX
 7WT1UcnWQu/gQ4W2oh85YtVcYzzX+QN0B+Dh7q/HaVmU6kzNYhzSQ6Zmhte93az0iNY4pHvcS
 YFPqUa66/Ot4AeQHJbhUj07jmv9i29ooBeps6YMj+C00M79BSP+OudEZ9HfQl7cHPgiIM0noH
 1B1NAGg3cnjoJDBuZcdd1pdJDPzDHy59vMxEfi0mTwJbtUipX6fYBL1IcsH1zG+Ci6cs2ld3r
 WHZ4u3x6JFoRbfPS4nNfZIImAE8CncpKn4LNM8XH9OH2D3MksUz8sBbmQgnv89rp0dKXLWxOB
 BCAf+kE9XI7GLCrPsTNB6QZpmpY6SIct2YnmgkPgxyvPrxuVVHNLgPq8tUGnkIzTVgKIyE/wA
 xeUaSm+N0SJ35Tw7XbEzbgEubvt8zrJZE3zvXHcfJiJsw+7ruUbDjhakuGpSXiFRmvmSTXRjA
 Y2Sb/YgMZXLdbULzPz4QRf+IOwBbCOflnJJfUfnXl2bz4iTzSDVZBGVOA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-360727885-1624372997=:57
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.2106230032431.57@tvgsbejvaqbjf.bet>

Hi Ren=C3=A9,

On Sun, 20 Jun 2021, Ren=C3=A9 Scharfe wrote:

> Am 18.06.21 um 19:05 schrieb SZEDER G=C3=A1bor:
> > On Thu, Jun 17, 2021 at 12:09:36PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
> >> diff --git a/generate-hooklist.sh b/generate-hooklist.sh
> >> new file mode 100755
> >> index 0000000000..5a3f7f849c
> >> --- /dev/null
> >> +++ b/generate-hooklist.sh
> >> @@ -0,0 +1,24 @@
> >> +#!/bin/sh
> >> +
> >> +echo "/* Automatically generated by generate-hooklist.sh */"
> >> +
> >> +print_hook_list () {
> >> +	cat <<EOF
> >> +static const char *hook_name_list[] =3D {
> >> +EOF
> >> +	perl -ne '
> >
> > Why Perl?
> >
> > At the moment I can run 'make' and get a functioning git even when
> > Perl is not installed.  With this patch that wouldn't work anymore.
> >
> > Both 'generate-cmdlist.sh' and 'generate-configlist.sh' can process
> > the documentation into a header file with a long list in it without
> > resorting to Perl; I'm sure that hooks could be processed without Perl
> > as well.
> >
> >> +		chomp;
> >> +		@l[$.] =3D $_;
> >> +		push @h =3D> $l[$. - 1] if /^~~~+$/s;
> >> +		END {
> >> +			print qq[\t"$_",\n] for sort @h;
> >> +		}
> >> +	' <Documentation/githooks.txt
>
> How about something like this?
>
> 	sed -n '/^~~~~*$/ {x; p;}; x' Documentation/githooks.txt |
> 	sort |
> 	sed 's/^.*$/	"&",/'
>
> sed is already used by generate-configlist.sh.

I do like me a good sed script.

Thanks,
Dscho

>
> >> +	cat <<EOF
> >> +	NULL,
> >> +};
> >> +EOF
> >> +}
> >> +
> >> +echo
> >> +print_hook_list
>
>

--8323328-360727885-1624372997=:57--
