Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3211FF40
	for <e@80x24.org>; Sat,  3 Dec 2016 18:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751494AbcLCSr5 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 13:47:57 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36285 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751400AbcLCSr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 13:47:56 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so7513081wma.3
        for <git@vger.kernel.org>; Sat, 03 Dec 2016 10:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HXQsCs2/DDXZNeA6bJTuHDdl0fwuJBCUka8PLHDow5U=;
        b=DPH/9f3A0Ik2kbax7EpCN424J/YK22fNqlcZr1bhvq/k5bA/Y1CjSNdySiixcvvVFP
         Zafh7SEId4emxBJ2ybb7bqo2Lf5Li/sU1XrVZpnMKyj7PNk8/kSMvVJmWE+PWbLiqo5j
         YgCoLKBK/9vg4qNwATnmnNiobaUIhjKyMxy/a2LPLrjTeles+L8VHg/oamXtDwYHUt9f
         f1I4mtHczV6VZXbV2ZrURz/JqMAA281n6IAXjpAGKaaR+shASNTL/m/vPdR+382AuE2/
         y9CefOHLlcYQyV/jeZx6BhGbvTN6gdUveoI2G2YH/TOxwtMk9YfbI4e14grt0Z209sFO
         G6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HXQsCs2/DDXZNeA6bJTuHDdl0fwuJBCUka8PLHDow5U=;
        b=FkdOUvEJWBuEAr/2cHSIKyCGslQjfC7qmdnSUG0oisTZa2xtdIFeql0g3ApBf1qkQt
         nRhJIbz9DdhK1a7Ci/qz85qjT9T54gELUtTNMFnazMRFe2KttdmAIUbSk/p9i5cEFxOH
         WTKExOo9vnVPaw1KBzix1BEYwiCANcn2pUJGW8nAwuioYnhHl5476vdzSq8t6SyTs1pq
         fdFt7mYnwY2e3xy25RZpEEUo9z++iu7GWyb7xtA4tvTcpEls2iGhK/cCo+qz3nHTQXOh
         wm79bZ6FB/TpChFQ22aYdy3gbYok1WkJ9e2S2ZgnNNMiUhXK6KDWb544DDYzY5g2NQdQ
         dcJg==
X-Gm-Message-State: AKaTC01Q6IYiDmo2KQ9W2leFpuWut4crQ+P7ZK5JAXL7hWUEozyuhJ5hkqVBI4xq+Jlohw==
X-Received: by 10.28.49.193 with SMTP id x184mr2631311wmx.44.1480790869744;
        Sat, 03 Dec 2016 10:47:49 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB4BB7.dip0.t-ipconnect.de. [93.219.75.183])
        by smtp.gmail.com with ESMTPSA id f3sm9459191wmf.10.2016.12.03.10.47.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Dec 2016 10:47:49 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [RFC/PATCH v3 00/16] Add initial experimental external ODB support
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161130210420.15982-1-chriscool@tuxfamily.org>
Date:   Sat, 3 Dec 2016 19:47:51 +0100
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>, Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A5ABBF3E-BED9-4FF3-9DE5-B529DEF0B8E8@gmail.com>
References: <20161130210420.15982-1-chriscool@tuxfamily.org>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Nov 2016, at 22:04, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> Goal
> ~~~~
>=20
> Git can store its objects only in the form of loose objects in
> separate files or packed objects in a pack file.
>=20
> To be able to better handle some kind of objects, for example big
> blobs, it would be nice if Git could store its objects in other object
> databases (ODB).

This is a great goal. I really hope we can use that to solve the
pain points in the current Git <--> GitLFS integration!
Thanks for working on this!

Minor nit: I feel the term "other" could be more expressive. Plus
"database" might confuse people. What do you think about
"External Object Storage" or something?


> Design
> ~~~~~~
>=20
>  - "<command> have": the command should output the sha1, size and
> type of all the objects the external ODB contains, one object per
> line.

This looks impractical. If a repo has 10k external files with
100 versions each then you need to read/transfer 1m hashes (this is
not made up - I am working with Git repos than contain >>10k files
in GitLFS).

Wouldn't it be better if Git collects all hashes that it currently=20
needs and then asks the external ODBs if they have them?


>  - "<command> get <sha1>": the command should then read from the
> external ODB the content of the object corresponding to <sha1> and
> output it on stdout.
>=20
>  - "<command> put <sha1> <size> <type>": the command should then read
> from stdin an object and store it in the external ODB.

Based on my experience with Git clean/smudge filters I think this kind=20=

of single shot protocol will be a performance bottleneck as soon as=20
people store more than >1000 files in the external ODB.
Maybe you can reuse my "filter process protocol" (edcc858) here?


> * Transfer
>=20
> To tranfer information about the blobs stored in external ODB, some
> special refs, called "odb ref", similar as replace refs, are used.
>=20
> For now there should be one odb ref per blob. Each ref name should be
> refs/odbs/<odbname>/<sha1> where <sha1> is the sha1 of the blob stored
> in the external odb named <odbname>.
>=20
> These odb refs should all point to a blob that should be stored in the
> Git repository and contain information about the blob stored in the
> external odb. This information can be specific to the external odb.
> The repos can then share this information using commands like:
>=20
> `git fetch origin "refs/odbs/<odbname>/*:refs/odbs/<odbname>/*"`

The "odbref" would point to a blob and the blob could contain anything,
right? E.g. it could contain an existing GitLFS pointer, right?

version https://git-lfs.github.com/spec/v1
oid =
sha256:4d7a214614ab2935c943f9e0ff69d22eadbb8f32b1258daaa5e2ca24d17e2393
size 12345


> Design discussion about performance
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Yeah, it is not efficient to fork/exec a command to just read or write
> one object to or from the external ODB. Batch calls and/or using a
> daemon and/or RPC should be used instead to be able to store regular
> objects in an external ODB. But for now the external ODB would be all
> about really big files, where the cost of a fork+exec should not
> matter much. If we later want to extend usage of external ODBs, yeah
> we will probably need to design other mechanisms.

I think we should leverage the learnings from GitLFS as much as =
possible.
My learnings are:

(1) Fork/exec per object won't work. People have lots and lots of =
content
    that is not suited for Git (e.g. integration test data, images, =
...).

(2) We need a good UI. I think it would be great if the average user =
would=20
    not even need to know about ODB. Moving files explicitly with a =
"put"
    command seems unpractical to me. GitLFS tracks files via filename =
and
    that has a number of drawbacks, too. Do you see a way to define a=20
    customizable metric such as "move all files to ODB X that are gzip=20=

    compressed larger than Y"?


> Future work
> ~~~~~~~~~~~
>=20
> I think that the odb refs don't prevent a regular fetch or push from
> wanting to send the objects that are managed by an external odb. So I
> am interested in suggestions about this problem. I will take a look at
> previous discussions and how other mechanisms (shallow clone, bundle
> v3, ...) handle this.

If the ODB configuration is stored in the Git repo similar to
.gitmodules then every client that clones ODB references would be able
to resolve them, right?

Cheers,
Lars

