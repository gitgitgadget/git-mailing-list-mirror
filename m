Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42997211B5
	for <e@80x24.org>; Tue, 22 Jan 2019 19:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfAVTfH (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 14:35:07 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43237 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbfAVTfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 14:35:07 -0500
Received: by mail-pg1-f194.google.com with SMTP id v28so11507508pgk.10
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 11:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UkvvKKKRsdmasotnTpmjZVglGkSsPV1Oct05r53O6OI=;
        b=vXRn9BK7dNR3I8fbMuucMLd94SwqEivYH+22xalBFVK2K8BQv0YqNNWpHu5epa62Gz
         8ckWueeI47PyBJXW/SNnpflZKLvtB6oWdWgNRp8RtFtVYhy3gmJxA5wmepPPNBT05ZNT
         5YYkFuR/qvMn8MMuh0zqxPCimCvqaPjc14OQs5q1f/x4eP5Mn781+lkqEjzwRsKmy29q
         qefSeVGrl7jCJAg/+DgMvsFl7VWyM3EzXfCVsJPRM7ARWRPc8Nrzo6h+172Td0A4KYd+
         La3WUnZxirw7LJ3pzLj6dUvOqLcbxZZDEddBpnUn/14t3dyPhVFL5r0sVQzm38oK16yd
         GlJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UkvvKKKRsdmasotnTpmjZVglGkSsPV1Oct05r53O6OI=;
        b=Or5yMyxPwTV2rmv1GFK06yjJ0J8yioZuQwugWpGw7xcbKuRA6AUY1LLN2K4OoenSDL
         IFY5TeFXe9hjvyMwo7FBuhLq6BLUl2R7REvO5b9h/CxTk1nHQ/53nflLSjKCv+xvH4T0
         JBIa9AlCNbt/dLDK7c1LWg/Ck3+NeyAoh1sAuk7TlJyxLygCBqmcLTKpD8A5yu+vwm03
         bPOk9428aqbBaNtCrKd/C4Tjm/HpZt/pSL3cObF3Jr1azX1O/V1nuTeqRtBzsjGO8kIe
         aWTNAA4z4dIuoqH4tTcelToY98YiTuUSQp0d9jCayPVzczRA7Jl/OyKxyd3qlHWlgXfB
         SLPA==
X-Gm-Message-State: AJcUukdMYP9XGt8feGFWxLunKdfr6dt7rMLT1HbITdOQmauexArHPMEE
        nXiB7s6D8qq7LgZD9/ztgNxNhw==
X-Google-Smtp-Source: ALg8bN4oBAw3Gaa4C4qI7AxeksIeplZhGY/D7MfHvrvuZWNMuXQHGRNcB3bR9bqEHr9VeKDhhp9vNw==
X-Received: by 2002:a63:151f:: with SMTP id v31mr32622390pgl.34.1548185705786;
        Tue, 22 Jan 2019 11:35:05 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id d69sm27939772pfg.168.2019.01.22.11.35.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 11:35:05 -0800 (PST)
Date:   Tue, 22 Jan 2019 14:35:00 -0500
From:   Barret Rhoden <brho@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH v2 2/3] blame: add the ability to ignore commits and
 their changes
Message-ID: <20190122143500.397abc8e@gnomeregan.cam.corp.google.com>
In-Reply-To: <xmqqlg3ch85x.fsf@gitster-ct.c.googlers.com>
References: <20190107213013.231514-1-brho@google.com>
        <20190117202919.157326-1-brho@google.com>
        <20190117202919.157326-3-brho@google.com>
        <f5170cb1-4109-4ae3-7722-8e3b62fb0b92@web.de>
        <xmqqlg3ch85x.fsf@gitster-ct.c.googlers.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-22 at 10:14 Junio C Hamano <gitster@pobox.com> wrote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>=20
> > Am 17.01.2019 um 21:29 schrieb Barret Rhoden: =20
> >> The blame_entry will get passed up the tree until we find a commit that
> >> has a diff chunk that affects those lines.  If an ignored commit added
> >> more lines than it removed, the blame will fall on a commit that made a
> >> change nearby.  There is no general solution here, just a best-effort
> >> approach.  For a trivial example, consider ignoring this commit:
> >>
> >> Z: "Adding Lines"
> >>  foo
> >> +No commit
> >> +ever touched
> >> +these lines
> >>  bar =20
> >
> > Wouldn't it make more sense to assign such lines to unknown, perhaps
> > represented by an all-zero commit ID, instead of blaming a semi-random
> > bystander? =20
>=20
> I share the sentiment.
>=20
> Isn't it, however, showing a bigger problem in the "feature"?
>=20
> Your "a change that adds lines without removing any" is an obvious
> case where these added lines have no corresponding lines in the
> preimage, but most of the time it is unclear what line corresponds
> to what previous line.  If a commit being "ignored" brought a change
> like this:
>=20
>      1
>     -four
>     -three
>     +3
>     +4
>      5
>=20
> did "+3" come from "-three"?
>=20
> Or did "+4" (read: "added '4'") come from "-three" (read: "removed
> 'three'")?  Did it come from "-four"?  Or was it genuinely added by
> that ignored commit?  Your suggestion deals with the case where we
> decide that "+4" had no corresponding lines in the preimage (and
> paint it as "no blame can be assigned").  But when we decide that
> "+4" came from "-four" or "-three", we continue drilling down from
> that ignored commit and assign the blame to either the commit that
> introduced "four" or the commit that introduced "three", which would
> obviously give us different result.  Worse yet, if a reader expected
> us to consider "+4" came from "-four" at that ignored commit, but
> the algorithm decided that "+4" corresponded to "-three", when we
> show the commit that eventually gets blamed for that line that has
> "4" has no "four" (it has "three"), which I suspect would confuse
> the reader of the output.
>=20
> So... I dunno.

I guess if you swap the lines as well as change them, then we're not
going to be able to detect that.  Just to be clear, if you did this:

Commit A:
---------
 other_stuff
+one
 other_stuff

Commit B:
---------
 other_stuff
 one
+two
 other_stuff

Commit C:
---------
 other_stuff
-one
-two
+1
+2
 other_stuff

And ignore commit C, my change will properly identify commit A and B,
e.g.:

OTHER_HASH Author Date 11) other_stuff
*A_HASH    Author Date 12) 1
*B_HASH    Author Date 13) 2
OTHER_HASH Author Date 14) other_stuff

But if you swapped the lines in addition to change names to numbers:

Commit C-swap:
--------------
 other_stuff
-one
-two
+2
+1
 other_stuff

Then it won't have the semantic knowledge that "one" =3D=3D "1".  If a user
is ignoring a commit, we don't have an oracle that knows exactly what
that commit did to determine what commit the user wants blamed.  The
current change attempts to find the last commit that touched a line.

Barret

