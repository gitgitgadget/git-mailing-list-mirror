Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937BCC4338F
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 03:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC2C60FC4
	for <git@archiver.kernel.org>; Tue,  3 Aug 2021 03:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbhHCDkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 23:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbhHCDkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 23:40:14 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14C3C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 20:40:02 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id a19so26724407oiw.6
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 20:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8UZJO+hf76svKB3fvrS3J6y8778qLtHnjee6EotlLzw=;
        b=Y/0P1Q+2J9Shf9L/lZAv1PEmX8eUNbFwLQp7utrRkdA57L6ndpyHhK8eEDFEyVMw6m
         psbvRfpURRae/m2Q7HPaN9uunwNnDalqzbmttfc8kmi7MjkN8UQp2HedhSwBHbNn5Dpd
         K51u7lfXmcu9pJMWv2g8UeXDhxCGtCmaofogYqrmnzIZ/BRq+Qqpnwvr0O/UQkiJL10w
         +qfKx4qUX9zHtncXAPIH4Nc0b4pBK0JFuO9Y/7dFqtH4DUHRB+Uwlayl68wbQTDFkSs8
         Q8jatCkkAe5InZE7609fZYyQu5hK+CLsrCwo5f0GV9JXxnxfzOY/pvbQC7y0SRstEJKq
         +p3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8UZJO+hf76svKB3fvrS3J6y8778qLtHnjee6EotlLzw=;
        b=sf9nc5FKd8oSn88ND6MMyjNEiUbL2B9GrhOfc4RFb08v6v7roEDQZ3Z1amkg42LqHf
         XLllNNWrC3kn9InMq2I2JATm4EJAYZnH51DWF6EHCpDqqDBGadWKUf9KEG82Rm2a1hgw
         XWSLPvSbV4XpXJmrhE0/1UurB8KNn502H3tfrijndHwqcwA12ZVbHcsHMiLm2BD3xyLH
         ykr61K2Rscgb1WByXwiFVQObBD9893zsjalFKUL5bTAhv5B8N3rSHEseJ2HcUg7bGTSn
         /CecJo9biGWOLJbZZNYIqYtLh0VrF/6b3PYlf+jJDTpV1VgY+PU3PiwPtRlNfikyYaqV
         VE2A==
X-Gm-Message-State: AOAM530k/+y8lmrJNJTspUlbkSYOoHcLJ2X4r2siIDhNdHABX3A3wjaw
        2oHu7Aw5YNhQYDoq7NQMhr0anuGRZ6iCbriJacg=
X-Google-Smtp-Source: ABdhPJyYbVjXfioN3Mronn/H3OFY/k31kXnDq0zi+1KEOp7AlcLG16Gs2Ydnhfm1srGxwkzW5EgbXtoxzg6HcDoon34=
X-Received: by 2002:aca:c0c3:: with SMTP id q186mr1609797oif.39.1627962002311;
 Mon, 02 Aug 2021 20:40:02 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1055.git.git.1627776461.gitgitgadget@gmail.com>
 <8f6af8d494e0924aef4ae6963b8dca2228dad9b1.1627776462.git.gitgitgadget@gmail.com>
 <49b61447-06b7-9c43-fdd6-25adc45f2a88@gmail.com>
In-Reply-To: <49b61447-06b7-9c43-fdd6-25adc45f2a88@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 2 Aug 2021 21:39:51 -0600
Message-ID: <CABPp-BGJ_ZfOPRdsjxnT8q9r9YPZUsnSmPoT0xuwJRJ3TN4wWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Change default merge backend from recursive to ort
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Mon, Aug 2, 2021 at 8:56 PM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
>
> Hi Elijah,
>
> Le 2021-07-31 =C3=A0 20:07, Elijah Newren via GitGitGadget a =C3=A9crit :
> > From: Elijah Newren <newren@gmail.com>
> >
> >
> >    * `git diff AUTO_MERGE` -- ability to see what changes the user has
> >      made to resolve conflicts so far (see commit 5291828df8 ("merge-or=
t:
> >      write $GIT_DIR/AUTO_MERGE whenever we hit a conflict", 2021-03-20)
> >
> >
> > The last three have been implemented already (though only one has been
> > submitted upstream so far;
>
>  From what I could find this indeed only refers to your 5291828df8 (merge=
-ort:
> write $GIT_DIR/AUTO_MERGE whenever we hit a conflict, 2021-03-20).
> This is a very nice improvement, but I noticed it is not mentioned in the=
 doc.
> Do you plan to update the 'git diff' doc to mention that special ref ?
> (And maybe also gitrevisions(5), where most of the special refs are liste=
d ?)
>
> Do you plan to implement a new '--auto-merge' option to 'git diff' as a s=
hortcut
> to 'git diff AUTO_MERGE', in order to hide a bit the special ref from use=
rs ?

Fair point, it probably does deserve to be documented somewhere, at
least once ort is the default merge algorithm.

I don't think it'd make sense to include a reference to it in
gitrevisions(5), since $GIT_DIR/AUTO_MERGE is a reference to a tree
rather than to a revision.  But documenting that special ref in
Documentation/git-diff.txt, and perhaps linking to it from other
conflict-related options (e.g. --base, --ours, --theirs) may make
sense.  Your --auto-merge idea may also make sense, and it'd be
somewhat similar to how git-rebase has a --show-current-patch option
that is shorthand for `git show REBASE_HEAD` and is documented as
such.  However, it might be confusing to users how to combine
--auto-merge with paths, whereas `git diff AUTO_MERGE -- pathname` is
pretty clear once you know that AUTO_MERGE is a tree you can diff
against.  Hmmm....
