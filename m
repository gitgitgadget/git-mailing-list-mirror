Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0934B1F404
	for <e@80x24.org>; Tue,  4 Sep 2018 21:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbeIEBjI (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 21:39:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:47052 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeIEBjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 21:39:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so4365654edr.13
        for <git@vger.kernel.org>; Tue, 04 Sep 2018 14:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VPgnNv2uOs78GVZ3k4IyVhPqlthsRrboZYNU1r/xzR4=;
        b=Z2XJzXdba9t8YPlvswU035OIEf9M0HfstJT1bzYsAwZ3WUk6UHBhCGIjlxZNtSiKyL
         nXhOQFCf07UUW1VKbCYr50PGFlND2Yjr1Nc18TzEsbYeuVyvtpFzw7PpwBKnD+pRy+3J
         X04E8XJ4s7qZ8djCD+lvfTG1RJ6nLR41AvPKhux/RUWSuyI2N6wMJVHiTDy+D2Eezalw
         Whqj13cizEv8kOfyKzHQN08CocEhfvYKvjrIZX2V/dJDKyf3gVDSYlykUP2+DncNZgMW
         rIq/P3W/MFtVG/lhnfGkGTnV5g+h+PFZWbFt5Ncy/7O7nl2TMGhsUkFLat7W3ErwkWfI
         MMgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VPgnNv2uOs78GVZ3k4IyVhPqlthsRrboZYNU1r/xzR4=;
        b=rNhc8siW4cV/kQ6jFA0WJTe754BvPY9nujrb8eGlfslvj69LcNHiRDoJYWegT2QOuL
         xyeLpYrmn1vEuC3ijreHbSspDEGQRsbIc9FHosVWXHYNUoS41inRixN1pfBTTjgWDfDn
         tnFuTt2c3lR+n/m7PXXsE9elD8CICrd6X4Ajr6jp0iYRfwdLIlYBY8WiyNhvrJWiSiJr
         2Ctbbaz3VKc+uMIwh7MZ7LMssUMWaDiV/eP3NzePt1oqQIr+/NyhlR0GWyDxc6f6I3et
         QAQIWQayiIFquWmFDsPfENJC2utuix3yKj+9NlUSAOnFILp3kmMU9ADPym3zOsW5d7yo
         RWDw==
X-Gm-Message-State: APzg51DcgJz2rQrQ32O6vkkmd5Y/xhJw0Ntd9NvVa3k6X2f5MeVw4Qfe
        clvXKQtNcQo5LnHWq6TuZTFOQneOPtwEfc/ABE1TtQ==
X-Google-Smtp-Source: ANB0VdZcSK+ZAdjIoGvX+IZMoWsKaA4lUG1PjW/iacD5XffIGlRGXboWqcofs2zvXohj73Qj3z6s6xFD7UhGSfYVF1I=
X-Received: by 2002:aa7:c314:: with SMTP id l20-v6mr37676417edq.53.1536095533527;
 Tue, 04 Sep 2018 14:12:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180826100314.5137-1-pclouds@gmail.com> <20180903180932.32260-1-pclouds@gmail.com>
 <20180903180932.32260-25-pclouds@gmail.com> <xmqqo9dd6kx1.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqo9dd6kx1.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Sep 2018 14:12:02 -0700
Message-ID: <CAGZ79kZhQJ7TbTuuDO_k-p80rGnOTjVcHf0aoq2+=pG4bwetNA@mail.gmail.com>
Subject: Re: [PATCH v2 24/24] Rename functions to avoid breaking in-flight topics
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 4, 2018 at 1:57 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
>
> > The three functions init_revisions(), diff_setup() and rerere() are
> > prefixed temporarily with repo_ to avoid breaking other topics which
> > add new call sites for these functions. This is a temporary
> > measure. Once everything is merged, it will be reverted and the new
> > call sites fixed.
>
> That's a sensible thing to do, but isn't it too late at 24/24 stage?
> IOW, doesn't in-flight topics break if up to 23/24 of this series is
> merged?

Presumably you merge the tip of this series (which contains 24/24)
with the other in-flight topics, that make new uses of
init_revisions(revs, prefix), which 24/24 allows. Going on either
parent side of such a merge will have working commits, that compile.

So from that POV it doesn't matter when the #define is introduced.

> IOW, the one that teaches "work in this repository" to rerere(int)
> for example should have introduced
>
>         repo_rerere(struct repository *, int);
>         #define rerere(x) repo_rerere(the_repository, x)
>
> in its own step, not this late in the series, no?

That might make for a better presentation to reviewers
now and here, but at some later date, we would want to
'git revert 24/24' after fixing all in-flights of today. And with
that in mind it makes sense to separate out all these changes
into this patch, as that allows us to have the revert rename
back to easy names.

You may be asking this question as it was done differently in
the series sb/object-store-lookup. But there the #define's served
a different purpose. That series used the #define to aid
author&reviewer to know where dependencies to the_repository
are and which function is done already.

This series solely uses the #define after the main series is done
to aid the maintainer to merge it which as you noted was one
of the problems with that other approach. The downside of the
series as it is presented here is that it is very easy to miss some
hidden dependency, that leads to a bug only discovered later
(e.g. some function still uses the_repository, when working on
a submodule for example, but as that function is used in some
corner case our test suite would not find it).

So why don't we try this approach as well and see how
well it goes over time?

Thanks,
Stefan
