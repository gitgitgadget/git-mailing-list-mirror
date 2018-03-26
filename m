Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C9CA1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:05:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeCZRF1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:05:27 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35465 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeCZRFZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:05:25 -0400
Received: by mail-oi0-f67.google.com with SMTP id x20-v6so16451619oie.2
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7jILYWggd/AVCfTtn4ebogwRSLgvuR8GkkodyVrEnNc=;
        b=HB98PHnVCAtfNIuo0woCs8qUucgTh5rQLCrxX7OWjrDW844s3xO18YV3SYWFGeafGh
         G5gsZ5nFO4MSQrGU7+2cUWqHvTVSzIyn0ze6uVm8GD5hi5Bhh/I8fgCyvie0kAaP2FB9
         CvYrR1Bf1BrMNDsfdbd2T/n/gQUK6Z6l1dCXBAGZDuxdrVTzpbTlSTQlwRoFbbNpDgll
         K1czRQRsIU4RcX6EaXY9Trq0ND5O9qBANgx1TeW/D+H9QQfYs71wlvt44GhWbcL8aq2y
         M2iFmueRJ2p6bAyfDyOUSzI21nxTtzjmt1b28j2SpkugfeKh9yFnHAD81AHgZGq9xqiC
         mSAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7jILYWggd/AVCfTtn4ebogwRSLgvuR8GkkodyVrEnNc=;
        b=TQ3pdgCwrmpjo1xVLoItGC2m6wysrGLKJggrcbEMUUGmx7W1uDcKfQgUwHYxBZ9sxt
         R8j+nB1UeMQ1wcsoY1f/HwwPpPcL/LFm49gcVpgMf4ghcA0HHjh/A7mVkWRYFls3vufv
         5piERST5fZgN+YiuzPpm8p9UaHph+em1VpzIzTw2d7EqnZJMxfnND606eEJSlr9T3x9G
         R+vtu76qys0tfCv7wYARDnxJNjrLmnHW/mKqxpe9IVlNZwFpNdLtLMSUGtmIQdGyXbIH
         OUcQ3QNe1ryKUu69SSsBc5nGvNIoSTJnMULc6YRJRsFfMPx2PfDeibZN8Mj8IeojcakU
         nNmw==
X-Gm-Message-State: AElRT7FCsL29cEc3al4BcMF3Xul7SkLlJG4l6dR0pd83blzl+U8PPrpf
        fLxnSsXV6hhOqJA0FnR4FQ9i842V40ur7G5GCgA=
X-Google-Smtp-Source: AG47ELvFLJ7cCr2wMJEeWAcLxqsSf/3Lilq9a0pO5M9b/43CtDqpd7DZiJSLnUdESslQKZ7W1bPAhnAQs3PX4imKrII=
X-Received: by 10.202.241.65 with SMTP id p62mr14728678oih.56.1522083924716;
 Mon, 26 Mar 2018 10:05:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.211.131 with HTTP; Mon, 26 Mar 2018 10:04:54 -0700 (PDT)
In-Reply-To: <20180326151317.GA24425@sigill.intra.peff.net>
References: <20180318142526.9378-1-pclouds@gmail.com> <20180324063353.24722-1-pclouds@gmail.com>
 <20180326151317.GA24425@sigill.intra.peff.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Mar 2018 19:04:54 +0200
Message-ID: <CACsJy8Br0+PGauEYLUarOFrq4bPbnE5u95XemzFyyn_riBZ_xA@mail.gmail.com>
Subject: Re: [PATCH v7 00/13] nd/pack-objects-pack-struct updates
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 5:13 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Mar 24, 2018 at 07:33:40AM +0100, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>
>> +unsigned long oe_get_size_slow(struct packing_data *pack,
>> +                            const struct object_entry *e)
>> +{
>> +     struct packed_git *p;
>> +     struct pack_window *w_curs;
>> +     unsigned char *buf;
>> +     enum object_type type;
>> +     unsigned long used, avail, size;
>> +
>> +     if (e->type_ !=3D OBJ_OFS_DELTA && e->type_ !=3D OBJ_REF_DELTA) {
>> +             read_lock();
>> +             if (sha1_object_info(e->idx.oid.hash, &size) < 0)
>> +                     die(_("unable to get size of %s"),
>> +                         oid_to_hex(&e->idx.oid));
>> +             read_unlock();
>> +             return size;
>> +     }
>> +
>> +     p =3D oe_in_pack(pack, e);
>> +     if (!p)
>> +             die("BUG: when e->type is a delta, it must belong to a pac=
k");
>> +
>> +     read_lock();
>> +     w_curs =3D NULL;
>> +     buf =3D use_pack(p, &w_curs, e->in_pack_offset, &avail);
>> +     used =3D unpack_object_header_buffer(buf, avail, &type, &size);
>> +     if (used =3D=3D 0)
>> +             die(_("unable to parse object header of %s"),
>> +                 oid_to_hex(&e->idx.oid));
>> +
>> +     unuse_pack(&w_curs);
>> +     read_unlock();
>> +     return size;
>> +}
>
> It took me a while to figure out why this treated deltas and non-deltas
> differently. At first I thought it was an optimization (since we can
> find non-delta sizes quickly by looking at the headers).  But I think
> it's just that you want to know the size of the actual _delta_, not the
> reconstructed object. And there's no way to ask sha1_object_info() for
> that.
>
> Perhaps the _extended version of that function should learn an
> OBJECT_INFO_NO_DEREF flag or something to tell it return the true delta
> type and size. Then this whole function could just become a single call.
>
> But short of that, it's probably worth a comment explaining what's going
> on.

I thought the elaboration on "size" in the big comment block in front
of struct object_entry was enough. I was wrong. Will add something
here.

>> +Running tests with special setups
>> +---------------------------------
>> +
>> +The whole test suite could be run to test some special features
>> +that cannot be easily covered by a few specific test cases. These
>> +could be enabled by running the test suite with correct GIT_TEST_
>> +environment set.
>> +
>> +GIT_TEST_SPLIT_INDEX forces split-index mode on the whole test suite.
>> +
>> +GIT_TEST_FULL_IN_PACK_ARRAY exercises the uncommon pack-objects code
>> +path where there are more than 1024 packs even if the actual number of
>> +packs in repository is below this limit.
>> +
>> +GIT_TEST_OE_SIZE_BITS=3D<bits> exercises the uncommon pack-objects
>> +code path where we do not cache objecct size in memory and read it
>> +from existing packs on demand. This normally only happens when the
>> +object size is over 2GB. This variable forces the code path on any
>> +object larger than 2^<bits> bytes.
>
> It's nice to have these available to test the uncommon cases. But I have
> a feeling nobody will ever run them, since it requires extra effort (and
> takes a full test run).

I know :) I also know that this does not interfere with
GIT_TEST_SPLIT_INDEX, which is being run in Travis. So the plan (after
this series is merged) is to make Travis second run to do something
like

make test GIT_TEST_SPLIT...=3D1 GIT_TEST_FULL..=3D1 GIT_TEST_OE..=3D4

we don't waste more cpu cycles and we can make sure these code paths
are always run (at least on one platform)

> I see there's a one-off test for GIT_TEST_FULL_IN_PACK_ARRAY, which I
> think is a good idea, since it makes sure the code is exercised in a
> normal test suite run. Should we do the same for GIT_TEST_OE_SIZE_BITS?

I think the problem with OE_SIZE_BITS is it has many different code
paths (like reused deltas) which is hard to make sure it runs. But yes
I think I could construct a pack that executes both code paths in
oe_get_size_slow(). Will do in a reroll.

> I haven't done an in-depth read of each patch yet; this was just what
> jumped out at me from reading the interdiff.

I would really appreciate it if you could find some time to do it. The
bugs I found in this round proved that I had no idea what's really
going on in pack-objects. Sure I know the big picture but that's far
from enough to do changes like this.
--=20
Duy
