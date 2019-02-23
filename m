Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.8 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79E6920248
	for <e@80x24.org>; Sat, 23 Feb 2019 09:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfBWJya (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Feb 2019 04:54:30 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42330 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfBWJya (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Feb 2019 04:54:30 -0500
Received: by mail-yw1-f65.google.com with SMTP id v201so1805578ywa.9
        for <git@vger.kernel.org>; Sat, 23 Feb 2019 01:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZlPI5gq4+weZBgqWnZfrgoQj5MIXWLmPs/ILS550Tng=;
        b=shvH70GFFbcoxKSRziO3Q/dnooLJ5Dp/7lyzM89cinhTeX7iV9UjaBFfpfT4FAwZ8I
         Zsjh2DHVURp7bc3rKwdLD+imkTwq/ZCJilrCJam1do9KflgtCTQz1pcuU+igtrN+dBvR
         AnKYnm/E1FLbv0NcFgtwmOzjKG915OTgokAC7Y/Ky4pEG7XaDm4P3Pat0+fuHb79oeWm
         pr7bsT0qYA5+scCThixa9c5+c3n+xc5kvr206i+6D7nAJDWPTNnjHXAEkOMjyVQ0fGjD
         MWuH8a/gkJECCnsX1TphvFAp8zQHi8i4++dlpXhC6hxviex4+5HAEYKgw2hKeh/tnHuq
         RrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZlPI5gq4+weZBgqWnZfrgoQj5MIXWLmPs/ILS550Tng=;
        b=dROp+0/ois2WidvX5xr4cxg7Vpbm7oY3paKBsbdAIJmOmxulD/l0ZbaEiNuZuj8Go1
         SWiIZNmSD7WZ5qlavy7y8UPk4KhyBUT3FCpJw3KK7U+PN2VDLkA49f3oIzjz0VALygYx
         zGl324BIvuNjrJA2wQFHW7lzRTuLHrgBGHrmUIvHZthQ2ViB+3SVLB2Lb56Fe9+7RMZS
         MP90r2lUJHHxdqarpQO+pK1MISt1+ToW4AX06G9tMWBhapdxnangPh8LDRPoEuw0KqsX
         PyR2audi5FeBabetsfVuXDNwZNVozDhYjZkiuAdwiZ8deyvSmLMScAocZOh8UHe9K8y3
         gY4A==
X-Gm-Message-State: AHQUAuYjUS4jEIMHNr5sMN4FW3297ZW1q5doGyaMzEUeXkSau5ruBJKw
        uTN9QLlQKVr35ro1Kv5+dSaWbM+C2/Qz+lVTz4s=
X-Google-Smtp-Source: AHgI3IaaHpgi0UNbZunN0Tvz1Qyng5KhdJddMfaB3ozv2C4CqMbRlpqZswasYuxS72aZE1C35/XJhdLVzX6l/BFKX+4=
X-Received: by 2002:a0d:df50:: with SMTP id i77mr6728976ywe.392.1550915668933;
 Sat, 23 Feb 2019 01:54:28 -0800 (PST)
MIME-Version: 1.0
References: <CAHMHMxVdpOnTkf9RHzCa+YjjvpqJApsSE03Jjyb_VbJp_4q-jw@mail.gmail.com>
 <CAHMHMxUfjnNXFikVD=rys_t5BUho=7uRw4LsXgAphFwSf3xOnw@mail.gmail.com>
 <xmqqpnrksobq.fsf@gitster-ct.c.googlers.com> <20190222001145.GD488342@genre.crustytoothpaste.net>
 <xmqqva1bpq9d.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqva1bpq9d.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>
Date:   Sat, 23 Feb 2019 11:53:50 +0200
Message-ID: <CAHMHMxXxo4zXcriBJE2k3mWgwAj7KGA_AChuEmyciESGOC_7Bg@mail.gmail.com>
Subject: Re: git format-patch can clobber existing patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=CE=9D=CF=84=CE=AD=CE=BD=CF=84=CE=BF=CF=82 =CE=A3=CF=84=CE=B1=CF=8D=CF=81=
=CE=BF=CF=82
On Fri, Feb 22, 2019 at 9:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
> > On Thu, Feb 21, 2019 at 03:40:09PM -0800, Junio C Hamano wrote:
> >> =CE=A3=CF=84=CE=B1=CF=8D=CF=81=CE=BF=CF=82 =CE=9D=CF=84=CE=AD=CE=BD=CF=
=84=CE=BF=CF=82  <stdedos@gmail.com> writes:
> >> > Would it make sense / be easy enough to have some clobbering check /=
 flag?
> >>
> >> Given that use of '-o' to redirect to a fresh/new directory would
> >> reduce the risk of such clobbering, and use of '-v' to force
> >> different filenames would reduce the risk of such clobbering,
> >> it seems to me that aborting the operation when we fail to open
> >> the output, without any option to override and allow clobbering,
> >> would make sense.  If existing files record 4 patch series
> >> 0001-x.patch, 0002-y.patch, 0003-z.patch, and 0004-w.patch, and you
> >> generate with "format-patch --allow-clobbering" a three-patch series,
> >> it would overwrite 0001 thru 0003 but will not remove 0004, so the
> >> end result will still be confusing.

There might be a handful of complexities / undefined behaviors coming
out of this; however, I think "not" overwriting a file to be a higher
directive (given that then, it is unrecoverable).
Using any of the '-o', '-v' might be helpful - if you are re-running
commands from history, however, it wouldn't necessarily provide any
protection ;-)

> > I think a flag for this would be useful. For people that store tarballs
> > (or pristine-tar files) and patches in their repository, overwriting th=
e
> > existing files is definitely desired.
> >
> > My personal preference is that the flag be --no-clobber, but I can see
> > arguments for the other side as well.

On my head, I was thinging that preferably `git config
format-patch.no-clobber true` could be set, instead of (continuously)
carrying around a `--no-clobber` flag.
I should've probably be more clear about that. However, any way is "as
good as any".

> That's actually simpler, which is good, as we do not have to worry
> about adjusting the existing tests that rely on the clobbering
> behaviour ;-).
>
> I'll find time before I leave for my offline week, but this
> obviously will not be merged before the upcoming release.
>
> Thanks.  I think I've mostly outlined a three-patch series to do
> this ready.
>
>
>
>
>
>
>
