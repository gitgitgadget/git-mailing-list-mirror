Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BE301F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 22:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbeJJFxi (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 01:53:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42099 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbeJJFxi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 01:53:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id b7-v6so3168044edd.9
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Ppn2Heq5xmkx1ZZ5IVtyTdRCWvLTux+lBkjMccEdr8E=;
        b=J4WCtFrg9wxgpvc1bVKw3t3xwnyrrLzT49LHHbWIzIwF771+j80ZTs6FavMy6GvXTu
         bIc97QJaT+ge0v4cnf22iXiqRYp/3y/ST81hLT990XVVoCh3i5MTK4zAc1K1JspoaACz
         CvX1rbZPvuWamukNeIv26Wb1ggr8/eKzed+Qm6TSlt11i1qwgiWdssN3WgTcDBtuIeqg
         VOILK9ObR/m7f1SkoZ36mIZKh94U+uCFE0JGBfnRVXJ1cDAgEgndxSQJ08y0MRbMgx/R
         XFkYPXclfw/V5lvmINDnsx3tj97fHyT7rrFW1ZAO8f3B2lHYgC85UbLZ50a85plEeiKl
         714A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ppn2Heq5xmkx1ZZ5IVtyTdRCWvLTux+lBkjMccEdr8E=;
        b=C439LFBCkiJ9p7Ebo48yvX81RKlzar2j0yb/iyKZ+5xw8bsaOE6hrPh5P4Sq/mtS/2
         q5F4AuJFHZP3YzNdrc6zZuLGn02YHSNZ7FRluqM9kzvn0IUB2y8vilpvOTaLlKvmgm2p
         xcAo0revI8lwNgeviG9A663OeB4jmipj9E9HiHA08IdTP+e68v4sZZkhOW+b2jYpsVX6
         IbG/r3g8rvRrF4e/HlBbqsTbXBSNTg5HqRWd6QqWHBtuv+1T0rYuZ0dp1Tu4ufHxBFYq
         MSRb6daCV8Xl9iWWo+ktBQXlE2+UXJztlQ0IWEzgqiJW/aKPelOfEksi0SPRyAxNpgne
         mFsQ==
X-Gm-Message-State: ABuFfogTfLtLQMQK4eNXMgDpuPjxyaQsU1BZ3gC3Wl+mfAgor+x28Ggc
        7oMPj9T/4Itg4HNpExqyAZwfMyYcNGvSnXSg8qm2uhFzCYU=
X-Google-Smtp-Source: ACcGV600sV5sM7Kyas0GBoRM9/GwSzsZC4R3LY+xTMgZrDVXkz++Dc6WCdGNflxm/AaPJKJd/ZHikQypn4E4b/GxXRI=
X-Received: by 2002:a17:906:2da9:: with SMTP id g9-v6mr14939649eji.67.1539124468563;
 Tue, 09 Oct 2018 15:34:28 -0700 (PDT)
MIME-Version: 1.0
References: <20181008215701.779099-1-sandals@crustytoothpaste.net>
 <20181008215701.779099-7-sandals@crustytoothpaste.net> <CAGZ79kbirX6i+qkig6R1YOAsv=0BirhAVkar+AdBLyHgkrXYyg@mail.gmail.com>
 <20181009222516.GR432229@genre.crustytoothpaste.net>
In-Reply-To: <20181009222516.GR432229@genre.crustytoothpaste.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 9 Oct 2018 15:34:17 -0700
Message-ID: <CAGZ79kbADWhuwk=7jzht5wZkESgT5ZqhhBOkGYGkC1HSSvExEA@mail.gmail.com>
Subject: Re: [PATCH 06/14] packfile: express constants in terms of the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 9, 2018 at 3:25 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On Mon, Oct 08, 2018 at 03:59:36PM -0700, Stefan Beller wrote:
> > On Mon, Oct 8, 2018 at 2:57 PM brian m. carlson
> > <sandals@crustytoothpaste.net> wrote:
> > >
> > > Replace uses of GIT_SHA1_RAWSZ with references to the_hash_algo to avoid
> > > dependence on a particular hash length.
> >
> > Unlike the previous patches, this is dealing directly with packfiles,
> > which (I would think) carry their own hash function selector?
> > (i.e. packfiles up to version 4 are sha1 hardcoded and version
> > 5 and onwards will have a hash type field. Usually that hash type would
> > match what is in the_repository, but you could obtain packfiles
> > out of band, or the translation table that we plan to have might
> > be part of the packfile/idx file?)
>
> Yeah, the transition plan doesn't specify a format for pack files, but
> we may end up needing one.  We definitely have a specified format for
> index files already, and that's where the translation table will be.
> Anything other than the pack index and the loose object index in the
> .git directory will have the same algorithm as the rest of the
> repository, so technically we could use any pack format as long as it
> lives in the .git directory.
>
> This code is mostly here on an interim basis to let us compile with a
> fully SHA-256 (no SHA-1) Git.  Once that piece is done, we can move on
> to a stage 4 Git, which can do either only SHA-256, or only SHA-1, where
> we'll learn about various pack file formats and detecting the algorithm
> from them.

This second paragraph really helps to put things into perspective, thanks!
I assume this interim base of code only applies to this patch?
(In that case maybe put it into the commit message?)
