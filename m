Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EB321FAA1
	for <e@80x24.org>; Fri, 21 Apr 2017 21:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1041496AbdDUV3F (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 17:29:05 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36591 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425980AbdDUV3E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 17:29:04 -0400
Received: by mail-io0-f195.google.com with SMTP id x86so34544070ioe.3
        for <git@vger.kernel.org>; Fri, 21 Apr 2017 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gWL7MGwpKH5veR++mBTmtb+9cateOkWTW8nNcHFMkmI=;
        b=FXJBLne0qGihb2GwIFW5w0x9Hkkjf0/2QkWDmauIGEz10ZNJyLc0ljKmR591fGDAAq
         eO/YlUTYDSkBuhBmiAlZXixQxrjLRzMk/hnHGE4qdPCZLICwTOtlOU/9VBsLAAIQVGg3
         4ulWAnbUl5h2b9ezX6OQckHK2zb3e9MYgJ/9ShLKnMInSzGkHtZtLaQdadhO5FB3Qn1s
         o0IKkYGBl61K6bDg6lI9MD4h5BIZ+N3WauTPS7llclka3+punCmbvIERE2dGPMZLXFQh
         H7c8FVE+Dic6BUzM3pjQkRjPQXmORb6Mt86QFLec84O6pGyKr5W4TRBwaE6Kp8hLYHv3
         c7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gWL7MGwpKH5veR++mBTmtb+9cateOkWTW8nNcHFMkmI=;
        b=KaFjfL/6JD9j6Gd4tww4yBeDcn0kQovNhwDqJSj97pwG6+2MqpkPFy/twHCkJTuu3h
         oq5qJd4Qn9/rUyHZFJKCRS4tcndriOgfQWHan8a9PuoMXUuUHahKbgSqumFC13FgjMmv
         5ItZb8y8a/IU1IcfERmEFgWUmwjXsA3NcKrPuUBTP7q+D/O2ufNPFYqomycIpMC54KCM
         JlCA0CWHLurYugQtXC5KkU68Zx85gMNESccl82/aI8d82Mf84zk8KYVTnf3060tycJzQ
         nLPKUaVT9ymUMKbYCDwgpn7x/usVdaW/PnDO69+dpj69yvdorELKsOBGZjG3NtdPTgag
         7sOA==
X-Gm-Message-State: AN3rC/5GdXvyE9F/MNazz4XQpQh7guSD5CE81jngBapzBCvswiX54hHZ
        moVY/PdVkb3Xs/nFgbntk7psBsdOx04o9FA=
X-Received: by 10.107.35.200 with SMTP id j191mr19171213ioj.33.1492810143223;
 Fri, 21 Apr 2017 14:29:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.134.97 with HTTP; Fri, 21 Apr 2017 14:28:42 -0700 (PDT)
In-Reply-To: <20170421204154.c5mvmnccxkxdm5aw@sigill.intra.peff.net>
References: <20170421194428.1377-1-avarab@gmail.com> <20170421204154.c5mvmnccxkxdm5aw@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 21 Apr 2017 23:28:42 +0200
Message-ID: <CACBZZX4oMFkZ93YxXrByh-jCK-eVxNBj+UgF77zm5Pq1mzf+WQ@mail.gmail.com>
Subject: Re: [PATCH] t/perf: correctly align non-ASCII descriptions in output
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 21, 2017 at 10:41 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Apr 21, 2017 at 07:44:28PM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Change the test descriptions from being treated as binary blobs by
>> perl to being treated as UTF-8. This ensures that e.g. a test
>> description like "=C3=A6" is counted as 1 character, not 2.
>>
>> I have WIP performance tests for non-ASCII grep patterns on another
>> topic that are affected by this.
>
> Makes sense. As this is purely about test titles in our project,
> choosing utf8 as the only encoding is quite sensible.

*Nod*

>> diff --git a/t/perf/aggregate.perl b/t/perf/aggregate.perl
>> index 924b19dab4..1dbc85b214 100755
>> --- a/t/perf/aggregate.perl
>> +++ b/t/perf/aggregate.perl
>> @@ -88,6 +88,7 @@ for my $t (@tests) {
>>  sub read_descr {
>>       my $name =3D shift;
>>       open my $fh, "<", $name or return "<error reading description>";
>> +     binmode $fh, ":utf8" or die "PANIC on binmode: $!";
>
> I thought there was some "use" flag we could set to just make all of our
> handles utf8. But all I could come up with was stuff like PERLIO and
> "perl -C". Using binmode isn't too bad, though (I think you could
> just do it as part of the open, too, but I'm not sure if antique
> versions of perl support that).

[Debugging perl encoding issues is one of the many perks of my dayjob]

Using binmode like this is about as straightforward as you can get,
the former occurrence could be equivalently replaced by:

    utf8::decode(my $line =3D <$fh>);

But better just to mark the handle as utf8. There's a fancier way to
do it as part of the three-arg-open syntax, but I couldn't remember
whether all the perl versions we support have it.

About the "use" flag, you're probably thinking of the confusingly
named "use utf8", but that's to set your source code to utf8, not your
handles, e.g.:

$ perl -CA -MDevel::Peek -wE 'use utf8; my $=E6=97=A5=E6=9C=AC=E8=AA=9E =3D=
 shift; Dump $=E6=97=A5=E6=9C=AC=E8=AA=9E' =C3=A6
SV =3D PV(0x12cc090) at 0x12cded8
  REFCNT =3D 1
  FLAGS =3D (PADMY,POK,pPOK,UTF8)
  PV =3D 0x12de460 "\303\246"\0 [UTF8 "\x{e6}"]
  CUR =3D 2
  LEN =3D 16

As you can see people got a bit overexcited about Unicode in the 90s.
