Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B002320323
	for <e@80x24.org>; Sun, 19 Mar 2017 14:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbdCSO04 (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Mar 2017 10:26:56 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:35457 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbdCSO04 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2017 10:26:56 -0400
Received: by mail-it0-f49.google.com with SMTP id y18so8827069itc.0
        for <git@vger.kernel.org>; Sun, 19 Mar 2017 07:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jVBu/exmoIRaTZIUfVavVBWJX7Npv5anuidAPjQtV9o=;
        b=c2AbG+VR4FDbZ/0G72EM8wUPOaL8EWQBOj05PCzMbzKRyUG1IoPEiF2TTwy3Ba8CyT
         rDWnJYz92sub2kuT4pjjh6X7tQytB8d1groaP4rmyO5FrGGkOhtMaUnF8uYR4blglJYM
         BKl5p/XWefmL6ghRX37SyefAsBfnQ/d+qd8KCBNYmNeCHB2Fj32+UGPsuZVjhm7L8OVZ
         pzl6vi8XSivTFr7301u8Iwm+KJuHLTzTHZVOZWMaYXo53qlYVqpRnjl8ZIoWoG7zPDZm
         HGp6N+Ro2EZYb/ypMk7JYsgFbLECeJoj0S6jMhp5zabCurbAEMuody/VtDjm0fthAtjD
         xfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jVBu/exmoIRaTZIUfVavVBWJX7Npv5anuidAPjQtV9o=;
        b=MBpzPj5RiFHnA8tOxR9ozS/5KAdi5Dh+iKifzFR1gaWtR2Roo/90zdycdnY67DYNF7
         hLowlnesTR/KP5ascH1UERMzLgHlT9Uye/isepquOv7u7Pxvnwl4/V0hDYly++Wkbv84
         bVo01J2dWdHX6pvs66ATVLkYyrrpnkevmhjBkT/yaO9JwU/jeP8x/tjOVFiumWMo15L3
         Y6aOe2xn5gVA0GmKKu/NO/Jn0L2SNg6s6VtzHTthx5rF9CMWLJeGE3n3a3HTCeHTZQTD
         IdtJ1+eNgmQsZi5aUc/gWOQGqeOV2BxT7mqWkQvvg2/q5ZnFIPBmDR30EdYALSFHQAmd
         D9GQ==
X-Gm-Message-State: AFeK/H2dwgUNDLWqHrBGqrk5+QaIFUUU52SUoB/zAnJzaF0zEFqGJNLtpmhWw0FiG3SwbA7rw5oAuMJj4u8NXA==
X-Received: by 10.107.150.201 with SMTP id y192mr26956262iod.33.1489933614504;
 Sun, 19 Mar 2017 07:26:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sun, 19 Mar 2017 07:26:33 -0700 (PDT)
In-Reply-To: <xmqqtw6pzarq.fsf@gitster.mtv.corp.google.com>
References: <20170318223409.13441-1-avarab@gmail.com> <xmqqtw6pzarq.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sun, 19 Mar 2017 15:26:33 +0100
Message-ID: <CACBZZX5P3eWxF0qMoi4u+Suct61PXP-hS+gd0s7b+hmMvJpS=w@mail.gmail.com>
Subject: Re: [PATCH] rev-parse: match @{u}, @{push} and ^{<type>} case-insensitively
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Conrad Irwin <conrad.irwin@gmail.com>,
        Sitaram Chamarty <sitaramc@gmail.com>,
        Michael J Gruber <git@drmicha.warpmail.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>, Richard Hansen <rhansen@bbn.com>,
        "Brian M . Carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 1:55 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
> > Change the revision parsing logic to match @{upstream}, @{u}, @{push},
> > ^{commit}, ^{tree} etc. case-insensitively. All of these cases
> > currently emit "unknown revision or path not in the working tree"
> > errors.
> >
> > This change makes them equivalent to their lower-case versions, and
> > consistent with other revision format specifications, e.g. 'master@{6
> > hours ago}', which is equivalent to 'master@{6 HoUrS aGo}'.
>
> Approxidate is not just case insensitive, but it takes random
> non-word characters (e.g. a dot and a slash in "@{4.minutes/}") that
> are not spaces at word boundaries, and I do not think you want to
> accept @{.Upstream.} for consistency.
>
> It is an odd-man-out and "consistency" with it is a nonsense
> justification.


I'm not suggesting that we make all the options accept garbage like
the date option in the name of consistency.

I found it helpful to make a table out of this. Key CI =3D Case
Insensitive (now)?, CIP =3D Case Insensitive Possible (without
ambiguities)?, AG =3D Accepts Garbage (.e.g. @{./.4.minutes./.})?

Before this patch:

|----------------+-----+------+-----|
| What?          | CI? | CIP? | AG? |
|----------------+-----+------+-----|
| sha1           | Y   | -    | N   |
| describeOutput | N   | N    | N   |
| refname        | N   | N    | N   |
| @{<date>}      | Y   | Y    | Y   |
| @{<n>}         | N/A | N/A  | N   |
| @{<n>}         | N/A | N/A  | N   |
| @{upstream}    | N   | Y    | N   |
| @{push}        | N   | Y    | N   |
| ^{<type>}      | N   | Y    | N   |
| ^{/regex}      | N   | N    | N   |
|----------------+-----+------+-----|

After:

|----------------+-----+------+-----|
| What?          | CI? | CIP? | AG? |
|----------------+-----+------+-----|
| sha1           | Y   | -    | N   |
| describeOutput | N   | N    | N   |
| refname        | N   | N    | N   |
| @{<date>}      | Y   | Y    | Y   |
| @{<n>}         | N/A | N/A  | N   |
| @{<n>}         | N/A | N/A  | N   |
| @{upstream}    | Y   | -    | N   |
| @{push}        | Y   | -    | N   |
| ^{<type>}      | Y   | -    | N   |
| ^{/regex}      | N   | N    | N   |
|----------------+-----+------+-----|

I.e. now we have 3x forms that could without any ambiguity be case
insensitive, this patch makes that so. We have one option that's very
loose about accepting garbage (@{<date>}). I don't see any reason to
try to pursue making the other options accept similar garbage.

>
> > The use-case for this is being able to hold the shift key down while
> > typing @{u} on certain keyboard layouts, which makes the sequence
> > easier to type, and reduces cases where git throws an error at the
> > user where it could do what he means instead.
>
> This, on the hand, is a sane justification that can be sympathized.


It's the reason I wrote the patch, and I'm not using consistency as
some argument for the change, I just had to take an inventory of all
these special forms and found out that these were the odd ones out in
the sense that everything else that can be case insensitive is.

>
> > The objection from Junio at the time[2] was that by lower-casing
> > {...}:
> >
> >     [The door would be closed on] allow[ing] @{/regexp} to find a
> >     reflog entry that matches the given pattern, and in such a use
> >     case we would certainly want to take the pattern in a case
> >     sensitive way.
> >
> > This appears to be an objection related to the code structure at the
> > time,...
>
> This objection, which is not about code structure but about design,
> still applies, I would think, if your justification is "consistency
> by making everything case-insensitive".
>
> Whoever is doing @{/<pattern>} cannot add the feature in a case
> sensitive way without violating the declaration you are making here:
> "everything inside @{...} is case-insensitive".

That's a quote from Duy's E-Mail. I don't think we should document
document anything like that, and my patch doesn't do that.

It is a legit question whether we document things as "unless otherwise
noted everything's case insensitive", and then list the exceptions, or
"unless otherwise noted everything's case sensitive", and then list
the exceptions. My patch does the former, Duy was suggesting the
latter.

I don't have any strong preference for either really, but neither
locks us into any future promises. It's just a matter of how the
current documentation phrases things.

>
> And if you extend that declaration to say "everything inside ^{...},
> too, is case-insensitive", I think it already is broken as I think
> "^{/<pattern>}" is case sensitive, by the way.

Yes, I agree that phrasing things like Duy suggested offhand in that
E-Mail would be broken.

> So don't pretend that this is about consistency.  You are making a
> choice for one class of strings that can go inside @{...} and the
> choice does not depend on the case sensitivity of different classes
> of strings that can go the same place.

I think this too is really just a reply to what Duy said...

> [...]
> I think "immediately after typing '{', you often have SHIFT
> pressed", even though it may sound lame, is a much better
> justification.  At least, it is an honest one.  And I do not mind
> too much if the way this feature is sold to the users were "these
> keywards inside @{...} can be spelled in any case: push, upstream.
> Type names in the peel-onion operator ^{<type>} can be too", not as
> a general rule but as special cases.  Unlike end-user supplied
> strings taken from an unbounded set (e.g. /<search patterns>), there
> is no strong reason to insist that a set of keywords taken from a
> limited vocabulary has to be spelled in one case, as long as it does
> not introduce ambiguity or limit our possible future.  It's not like
> we may want to keep the door open to make @{push} and @{PUSH} mean
> different things later.

*nod*

> Even in that case, however, I'd strongly prefer to spell all the
> examples in lowercase and declare that lowercase is the canonical
> spelling in our documentation.  What I want to avoid is to have
> three Git textbooks, that use @{UPSTREAM}, @{Upstream}, and
> @{upstream} in their samples and descriptions, and have the readers
> waste their time wondering, and waste our time by asking here, where
> the different preferences of the authors of these three books come
> from and which one the canonical way to spell it is.

So do you mean you'd like me to change the documentation to be more
like "While this is canonically lower case this form is case
insensitive so e.g. so-and-so also work" ?
