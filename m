Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AEAA20986
	for <e@80x24.org>; Fri,  7 Oct 2016 19:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755005AbcJGTBP (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 15:01:15 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34262 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbcJGTBN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 15:01:13 -0400
Received: by mail-qt0-f175.google.com with SMTP id q7so25385154qtq.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2016 12:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XX5WVEp8Cyif+omeUD5LrSQ4SPuPP3VRcvWG/zeezE4=;
        b=PTdiuqxri87Xlfob2IeTRW5ZsxxIer3X9/4f48v3NkSJtuIMgKlQNyvMw+5NyOgHNJ
         w94Iy7NUgf1hMpaFHrt/TpU/3O2IhfeJh+JPJi0zfPHmjhj8CCduqOWyTuVJzvnqE1/d
         L+MBkrxo5kGmWdlhVCgq5kHDdbsTbnf3sW47jku95gJUkSXchd9JPopMi1Ku/sGEfCk8
         qpX1lOMlhZOHumpSs/C5Pw8HTtYPRurQaeoga2zaJRdENEUuRzE6A1c9G2Y6KX36S19R
         TgnhbHGHCTWk2pYNh5QFNm5xivwdqA6UONBaK6XjA8l4E77uahtjzmRC1579ec5Zo9T+
         gaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XX5WVEp8Cyif+omeUD5LrSQ4SPuPP3VRcvWG/zeezE4=;
        b=TqLaIrVt2Gwtl36xpTyjgFXmTDaZXEMOFJBdOiovfj8OgzltCAOmlzNSZQ2lSLu7lt
         fLw9pV/Lf9YoaGJOrV2AOOJu7eN0rfTTiws3X5jupiu80ODujEXl+7+AdeSevW9s1e20
         6vboPbDcVNZps/AMwVaks1D4Nej1/0eGgIzcdQDRQW6Vc2ih/XDB9CsTLIrXNpuoylnb
         qllRIqcWgxSqX6ra3hG2WJlVAZ6eUqiQ8Bm1hdkU26xzDmKHYO/5x9XSC0fyEpsMTdQs
         fn5SrNhSOx0jJ/fEkkkIV4v/Jlp9xuuhIAyGQOWjQ3fEhsVeJWbIu3orVv1OTz2lOF1g
         Stmg==
X-Gm-Message-State: AA6/9RnJvk8GXc7xOZAf6UbUSk3GKAEbHI4vNzIafLnw0DyTCA492nvByGQjV2IXH27FxH2J+/+XN4XH8rqjI8nY
X-Received: by 10.237.55.232 with SMTP id j95mr21919942qtb.131.1475866564109;
 Fri, 07 Oct 2016 11:56:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Fri, 7 Oct 2016 11:56:03 -0700 (PDT)
In-Reply-To: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
References: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 7 Oct 2016 11:56:03 -0700
Message-ID: <CAGZ79ka1rJCks5np9Q__HAHYFDrdGDFLtquhb3fY_iL8q9DEkw@mail.gmail.com>
Subject: Re: Uninitialized submodules as symlinks
To:     David Turner <David.Turner@twosigma.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2016 at 11:17 AM, David Turner <David.Turner@twosigma.com> w=
rote:
> Presently, uninitialized submodules are materialized in the working tree =
as empty directories.

Right, there has to be something, to hint at the user that creating a
file with that
path is probably not what they want.

>  We would like to consider having them be symlinks.  Specifically, we'd l=
ike them to be symlinks into a FUSE filesystem which retrieves files on dem=
and.
>
> We've actually already got a FUSE filesystem written, but we use a differ=
ent (semi-manual) means to connect it to the initialized submodules.

So you currently do a

    git submodule init <pathspec>
    custom-submodule make-symlink <pathspec>

?

> We hope to release this FUSE filesystem as free software at some point so=
on, but we do not yet have a fixed schedule for doing so.  Having to run a =
command to create the symlink-based "union" filesystem is not optimal (sinc=
e we have to re-run it every time we initialize or deinitialize a submodule=
).
>
> But if the uninitialized submodules could be symlinks into the FUSE files=
ystem, we wouldn't have this problem.  This solution isn't necessarily FUSE=
-specific -- perhaps someone would want copies of the same submodule in mul=
tiple repos, and would want to save disk space by having all copies point t=
o the same place.  So the symlinks would be configured by a per-submodule c=
onfig variable.

I'd imagine that you want both a per-submodule config variable as
well as a global variable that is a default for all submodules?

    git config submodule.trySymlinkDefault /mounted/fuse/
    # any (new) submodule tries to be linked to /mounted/fuse/<path>
    git config submodule.<name>.symlinked ~/my/private/symlinked
    # The <name> submodule goes into another path.

As you propose the FUSE filesystem fetches files on demand, you
probably want to disable things that scan the whole submodule,
e.g. look at submodule.<name>.ignore to suppress status looking
at all files.

When looking through the options, you could add the value "symlink" to
submodule.<name>.update, which then respects the
submodule.trySymlinkDefault if present, such that

    git clone --recurse-submodules ...

works and sets up the FUSE thing correctly.

How does the FUSE system handle different versions, i.e.
`git submodule update` to checkout another version of the submodule?
(btw, I plan on working on integrating submodules to "git checkout",
so "submodule update" would not need to be run there, but we'd hook
it into checkout instead)

>
> Naturally, this would require some changes to code that examines the work=
ing tree -- git status, git diff, etc.  They would have to report "unchange=
d" for submodules which were still symlinks to the configured location.  I =
have not yet looked at the implementation details beyond this.
>
> Does this idea make any sense?  If I were to implement it (probably in a =
few months, but no official timeline yet), would patches be considered?

I am happy to review patches.
