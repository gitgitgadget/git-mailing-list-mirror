Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E883220A2C
	for <e@80x24.org>; Sun,  1 Oct 2017 15:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751027AbdJAPEC (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 11:04:02 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34511 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdJAPEC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 11:04:02 -0400
Received: by mail-pg0-f66.google.com with SMTP id u27so3278607pgn.1
        for <git@vger.kernel.org>; Sun, 01 Oct 2017 08:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hnWx8ndwDRHwpvK9wNtiih6n9aj1fFr4NkfxRZuCPP8=;
        b=rhh+lGOF9vwGMLSlS8zUL+6mLEyGofnqwu74hqZ3tF6u84WK9XiROeBexGcxltCtzr
         8QtxlnpYieS09yuWUV4PVBkZA+EQZ0hazDaqEcX89AKGsVKwZJw1nIxT1/KOBqBO3Ij9
         AFxdDskXJj9NMSC4yjvsekrbaWmIsa6bsbFQViOmCHI7VsfIaot7xpGSwBjGPy5mXDbH
         BKcH77mC60MGTgy6KDk3znFqFrfvjr4X8CdFoM6gT86EshJJhPTtaXTcKX+zEbpNWYFx
         Ld0trmx6COvIuhzhi6L+6frqXEv++NMmpptswtXbbnptpQ7Wdpfy3irnCrWp3TfbuiOa
         PhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hnWx8ndwDRHwpvK9wNtiih6n9aj1fFr4NkfxRZuCPP8=;
        b=etcsbsm358X2lnGXBp/8LwrjEs9Li9zCvOTNV1XGkv+cDAd8+IIs1ps8y3lVft0cvt
         5S6dP40mcdbSW8vR8aW0UHDOAClbP6B446yKmlBTTlhH1Yht1LHfpUi/UBvNYAXqvNFo
         q1k6MiptChRjlhixLfeFyLQVArYPzyo7d73G69YOMTh5hdQj/JBjkOCZ/yLYjcJA79fz
         NblSfT7PNm1GGh6YPFp3SJ7bQM+uD203BhaP1zabJbc1ftM+V17/KVNKbOAqRhbE7V2h
         f/fneBCbXCJwXduy0GGAVDJHNsEhdCOaJuiqFgzIxkacnnr6UAYNW7D2RrstjDQdLsCx
         ElZQ==
X-Gm-Message-State: AHPjjUjHtd5J1ctUCUTXS8q0wPEZv2g0CfVjLT2bq8s6AGm7mYbTtBhS
        99olatmecNkWqzuGGzOQO19H5EaCU6Ey9J8CMFA=
X-Google-Smtp-Source: AOwi7QAqQ610XbxFOebaeU2i8I9kU3DmSsBe61mhujUPgpBgUP3+ZEc07ABEIY28oTxB4oJIa/bzjZMN2NEtvKcZvl0=
X-Received: by 10.84.185.106 with SMTP id e39mr11767532plg.333.1506870241470;
 Sun, 01 Oct 2017 08:04:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.156.137 with HTTP; Sun, 1 Oct 2017 08:04:00 -0700 (PDT)
In-Reply-To: <20170925160835.aoomjaqrn2o2aosi@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com> <20170923043701.4s3xuytp5hdjwmsy@sigill.intra.peff.net>
 <CAN0heSrPBDi4q9fqr=qoTbjRHpFS_VEL0O8=MFFJ4DLCuJwahA@mail.gmail.com>
 <20170923161316.yntnccqrhv5d3jza@sigill.intra.peff.net> <20170923163817.7ltmkav2ytk7n43k@sigill.intra.peff.net>
 <CAN0heSqQ3Etj1mkGhuft8JzKA8SNhpF0jcnVEdFeKX5NHpyqTw@mail.gmail.com> <20170925160835.aoomjaqrn2o2aosi@sigill.intra.peff.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 1 Oct 2017 17:04:00 +0200
Message-ID: <CAN0heSrZVJpc-usGZZeyF7juKDZOvnS8m5p8pT4fuF1CYoQ9UA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] reroll ma/plugleaks; more `object_array`-fixes
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25 September 2017 at 18:08, Jeff King <peff@peff.net> wrote:
> On Sun, Sep 24, 2017 at 09:59:28PM +0200, Martin =C3=85gren wrote:
>
>> > I'm not sure of the best way to count things.
>>
>
> But at least on the topic of "how many unique leaks are there", I wrote
> the script below to try to give some basic answers. It just finds the
> first non-boring entry in each stack trace and reports that. Where
> "boring" is really "this function is not expected to free, but hands off
> memory ownership to somebody else".

Thanks. I combined your script with this:

-- >8 --
#!/usr/bin/perl -w

# Extract the stacktraces and identify them
# by their SHA hashes (these identifiers are
# not guaranteed to be stable across
# re-compilations of the Git binaries).

use Digest::SHA qw(sha1 sha1_hex);

my $ctx =3D Digest::SHA->new("SHA-1");
my $stage =3D 0;

while (<>) {
  my $collect =3D 0;
  if ($stage =3D=3D 0 && /irect leak of \d+ byte.*allocated from:$/) {
    $stage++;
    $collect =3D 1;
  } elsif($stage =3D=3D 1 && /^\s*\#\d+\s+/) {
    $collect =3D 1;
  } elsif ($stage =3D=3D 1 && /^\s*$/) {
    $digest =3D $ctx->hexdigest;
    printf "Stacktrace-hash: %s\n", $digest;
    $ctx =3D Digest::SHA->new("SHA-1");
    $stage =3D 0;
  } elsif ($stage =3D=3D 1) {
    print "warning: unidentified string '$_'\n";
  }
  if ($collect) {
    $ctx->add_bits($_);
    print;
  }
}
-- >8 --

Then I report various ad-hoc metrics:

-- >8 --
#!/bin/bash

for d in "$@"
do
  echo $d

  echo -n "  direct leaks: "
  grep "Direct leak" "$d"/* | wc -l

  echo -n "  indirect leaks: "
  grep "Indirect leak" "$d"/* | wc -l

  echo -n "  allocating places: "
  perl leaks.pl "$d"/* | sort -u | wc -l

  echo -n "  most common allocating place: "
  perl leaks.pl "$d"/* | sort \
       | uniq -c | sort -nr | head -1 | awk '{print $1;}'

  echo -n "  size of leak-reports: "
  cat "$d"/* | wc -l

  echo -n "  unique leaking stacktraces: "
  perl extract-traces.pl "$d"/* | grep "Stacktrace-hash" | sort -u | wc -l

  echo -n "  most common stacktrace: "
  perl extract-traces.pl "$d"/* | grep "Stacktrace-hash" | sort \
       | uniq -c | sort -nr | head -1 | awk '{print $1;}'
done
-- >8 --

If PIDs of leaking processes collide, reports are lost. Something like
this as root helps: `echo 4194303 > /proc/sys/kernel/pid_max`

Still, the numbers vary for back-to-back runs. Here are two runs on
master and two runs on master plus the lockfile-patches I just sent.
(I don't run all tests.)

lsan_ea220ee4
  direct leaks: 127165
  indirect leaks: 83897
  allocating places: 504
  most common allocating place: 10212
  size of leak-reports: 3662204
  unique leaking stacktraces: 83265
  most common stacktrace: 55
lsan_ea220ee4-rerun
  direct leaks: 127172
  indirect leaks: 83903
  allocating places: 504
  most common allocating place: 10212
  size of leak-reports: 3662334
  unique leaking stacktraces: 83644
  most common stacktrace: 57
lsan_ea220ee4+lockfile_fixes
  direct leaks: 118678
  indirect leaks: 83908
  allocating places: 493
  most common allocating place: 10212
  size of leak-reports: 3545563
  unique leaking stacktraces: 99834
  most common stacktrace: 32
lsan_ea220ee4+lockfile_fixes-rerun
  direct leaks: 118678
  indirect leaks: 83902
  allocating places: 491
  most common allocating place: 10212
  size of leak-reports: 3545463
  unique leaking stacktraces: 82171
  most common stacktrace: 40

> So I don't know how useful any of that will be, but it at least should
> give _some_ metric that should be diminishing as we fix leaks.

Indeed.

Martin
