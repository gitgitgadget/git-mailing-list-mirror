Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 137221F453
	for <e@80x24.org>; Tue, 22 Jan 2019 15:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729767AbfAVP0H (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 10:26:07 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34514 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729696AbfAVP0F (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 10:26:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id q8so14479055qke.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 07:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUP6/veKFuO92RsR7Liw70gYvnY9ULnUIo8+xYY8c/Q=;
        b=pimyP63GnQdKNJBRyjqzTa9sEjNH1rhdTHmb4qdtJ2Eid2q/k3VATBJEfTVEwRid3m
         aWIf1J9szU+b0kQOBYh+zbyeKioIQRjiAy76LmCYZh5jVjWuuUVtJxj6p0ie0aT5h0Yy
         4o7b/FtNDCAvb1ptzZFDiOhf9VXcENzM++EoQ3UMk1MMhauIEGzc1vvnAE3iRt5mSn2d
         +Rdchw3PJnSi4W/9RJ542qFWuSleLbRCcuD7Ldcc3D4YpN2qmb+4N7uzqakeB5kasJLe
         sgRWEieKf1Oy2RA+m/B+wNiqs1rfukXxctelSZBAVkIhx/ZxkpnSwEdiY8OHZdHKrUxQ
         4sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUP6/veKFuO92RsR7Liw70gYvnY9ULnUIo8+xYY8c/Q=;
        b=EkZpvIQYrETEjtJpEuhWkqxXYDXd3b/Tm5TYQNam1zl2VesS8LSvK8+ZA5gG7rEnSb
         MLQTi5qcTdlo4wqcD/FGhQK1vXYZQzOaIsKGHYQZDltpP0lIr34rr8rVwJvcUu6Vr8T7
         EjEoVVZc4F3xZ3gTNrooCW6WKBu/184zyzVLdeFyf6Gl7vIMZ7kfPsVW9x8In0jliEnV
         TugJ0vBsi9HiBhtsLG46EvW5eLzKvsK8bP4p2PKOoeKluvnCoFzBdVSue2sI7mjqY4v5
         alHhtJZmoSZ9VgZfbmj5mrMUQndJKcv5C05nSEWyHGrW1naycTgpNuTenpC5e650v9BB
         Cf4Q==
X-Gm-Message-State: AJcUukcME9O30k4wqBRUDeoWrJfwnP7pM4OUYs0iq4dKi42bbH78mB9I
        HoTS2ISzvNqk5TP42ddhgxB0Lxl6JMKJ8Q==
X-Google-Smtp-Source: ALg8bN4D+kYBXdABF8CD4HdoN2CPQFljo5O3L61n3A8Q9A/qEPzqNG4rs7t11iV5laE7bOLmrBfWbA==
X-Received: by 2002:a37:9d10:: with SMTP id g16mr27436425qke.53.1548170764331;
        Tue, 22 Jan 2019 07:26:04 -0800 (PST)
Received: from brho.roam.corp.google.com ([2620:0:1004:a:6e2b:60f7:b51b:3b04])
        by smtp.gmail.com with ESMTPSA id 189sm55164532qkh.9.2019.01.22.07.26.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 07:26:04 -0800 (PST)
Date:   Tue, 22 Jan 2019 10:26:01 -0500
From:   Barret Rhoden <brho@google.com>
To:     =?UTF-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] blame: add the ability to ignore commits and
 their changes
Message-ID: <20190122102601.24426c8e@brho.roam.corp.google.com>
In-Reply-To: <f5170cb1-4109-4ae3-7722-8e3b62fb0b92@web.de>
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-3-brho@google.com>
        <f5170cb1-4109-4ae3-7722-8e3b62fb0b92@web.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-20 at 19:19 Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> Am 17.01.2019 um 21:29 schrieb Barret Rhoden:
> > The blame_entry will get passed up the tree until we find a commit that
> > has a diff chunk that affects those lines.  If an ignored commit added
> > more lines than it removed, the blame will fall on a commit that made a
> > change nearby.  There is no general solution here, just a best-effort
> > approach.  For a trivial example, consider ignoring this commit:
> >
> > Z: "Adding Lines"
> >  foo
> > +No commit
> > +ever touched
> > +these lines
> >  bar =20
>=20
> Wouldn't it make more sense to assign such lines to unknown, perhaps
> represented by an all-zero commit ID, instead of blaming a semi-random
> bystander?

I don't know if we can algorithmicly determine whether or not an
assignment was the commit the user wanted.  Maybe we could add a set
of heuristics, like "any diff hunk that only added", as in my
example.  Maybe if count_a =3D=3D 0 in blame_chunk_cb, that would work for
that case; I'm not too familiar with that code.

Either way, in my next commit I provide the option to mark the commit
with a '*', which could serve the same purpose as the all-zero commit
ID: flag the commit so the user knows it might not be correct.

Barret

