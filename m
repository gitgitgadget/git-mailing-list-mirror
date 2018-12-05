Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A74211B3
	for <e@80x24.org>; Wed,  5 Dec 2018 20:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeLEUe6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Dec 2018 15:34:58 -0500
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37565 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbeLEUe5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Dec 2018 15:34:57 -0500
Received: by mail-ed1-f50.google.com with SMTP id h15so18174806edb.4
        for <git@vger.kernel.org>; Wed, 05 Dec 2018 12:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=fpdBph/kvzbzuZW6gFMKHykEjaarxcDlAdzWJ7yqYYE=;
        b=Oc1NKELVxwKgmDEP7hoh6hegsrjyuJKlcOgWt70esRgdAGvX8VegeLBX40+i0LHeif
         pJu7gN4Ue6I1e/ai3tJfandXCFYnhh90oOPJadmWpkn6i23a8KSbkr24pmkWuXgbdEDl
         ldvgBqjYEmc77Guqg/CyBovK9DlKDjIg9UxfYzKaONqvi+mAVHzRpLODKKfgnqRKWGAe
         CiK1hCo/eHUzuTwRZ4nCEcK1T9xmGFSBv35MV131sSqd3FlLun4BUMUB4s4RIAEhpR+H
         JhGxRrAPJHj/LDOeDWx8cHIkIdqvLJmf6b4LqRqsbZVaZIvnG+dmVRWF2uTYamD1R83F
         EhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=fpdBph/kvzbzuZW6gFMKHykEjaarxcDlAdzWJ7yqYYE=;
        b=eY3CrWPrr2hIx7owlTs3Twlf4CMrCvBoB6oNMpsIACi03LzgfX8DalT0i+uzoEJsTc
         1ThaxwgXdx87o2vFE8cAl0Na52vsDsJnwzoIplhnptUPvQKWjKXDssEa/TtmBrobyIeC
         xM4N/RaK8HFtbeIqSHDqq7lao6iwOOYBahUdWW2SWbeZUrxICOdrwniEh8vmAF+j6t0O
         QGKgUbmbExxWvZDeng81vyW/tpsklFaehizl3nKcz9RsChs53X3XqIAH1RpYM2UCmnBg
         vMOO+xO5AsvowTGEIoY1re0EQLzzd5LHqNK8EQd/rsd761Se3j+RAJlq+M+XnFVViNP0
         Z50Q==
X-Gm-Message-State: AA+aEWa1O1uMZsU502pFLL7fost/+8pIDSFwPPV2lZZt/joBp/OgScx4
        iNbOfMi79Mg+rNhXv03oXw8=
X-Google-Smtp-Source: AFSGD/Vebs/jlMDN9W1rcULq3q2Tma+DEqfb0szMdKn76w/LwognJ73qrmqWLP2E801DAgJ143T53Q==
X-Received: by 2002:aa7:d0c5:: with SMTP id u5mr21686752edo.158.1544042095327;
        Wed, 05 Dec 2018 12:34:55 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id v1-v6sm3311093ejq.47.2018.12.05.12.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 12:34:54 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "Coiner\, John" <John.Coiner@amd.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git, monorepos, and access control
References: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <939efd87-b2af-29d7-efdd-9cf8f6de9d10@amd.com>
Date:   Wed, 05 Dec 2018 21:34:53 +0100
Message-ID: <878t13zp8y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 05 2018, Coiner, John wrote:

> I'm an engineer with AMD. I'm looking at whether we could switch our
> internal version control to a monorepo, possibly one based on git and
> VFSForGit.
>
> One obstacle to moving AMD to git/VFSForGit is the lack of access
> control support in git. AMD has a lot of data whose distribution must be
> limited. Sometimes it's a legal requirement, eg. CPU core designs are
> covered by US export control laws and not all employees may see them.
> Sometimes it's a contractual obligation, as when a third party shares
> data with us and we agree only to share this data with certain
> employees. Any hypothetical AMD monorepo should be able to securely deny
> read access in certain subtrees to users without required permissions.
>
> Has anyone looked at adding access control to git, at a per-directory
> granularity? Is this a feature that the git community would possibly
> welcome?
>
> Here's my rough thinking about how it might work:
>   - an administrator can designate that a tree object requires zero or
> more named privileges to read
>   - when a mortal user attempts to retrieve the tree object, a hook
> allows the server to check if the user has a given privilege. The hook
> can query an arbitrary user/group data base, LDAP or whatever. The
> details of this check are mostly in the hook; git only knows about
> abstract named privileges.
>   - if the user has permission, everything goes as normal.
>   - if the user lacks permission, they get a DeniedTree object which
> might carry some metadata about what permissions would be needed to see
> more. The DeniedTree lacks the real tree's entries. (TBD, how do we
> render a denied tree in the workspace? An un-writable directory
> containing only a GITDENIED file with some user friendly error message?)
>   - hashes are secret. If the hashes from a protected tree leak, the
> data also leaks. No check on the server prevents it from handing out
> contents for correctly-guessed hashes.
>   - mortal users shouldn't be able to alter permissions. Of course,
> mortal users will often modify tree objects that carry permissions. So
> the server should enforce that a user isn't pushing updates that alter
> permissions on the same logical directory.
>
> I would welcome your feedback on whether this idea makes technical
> sense, and whether the feature could ever be a fit for git.
>
> You might ask what alternatives we are looking at. At our scale, we'd
> really want a version control system that implements a virtual
> filesystem. That already limits us to ClearCase, VFSForGit, and maybe
> Vesta among public ones.  Am I missing any? We would also want one that
> permits branching enormous numbers of files without creating enormous
> amounts of data in the repo -- git gets that right, and perforce (our
> status quo) does not. That's how I got onto the idea of adding read
> authorization to git.

All of what you've described is possible to implement in git, but as far
as I know there's no existing implementation of it.

Microsoft's GVFS probably comes closest, and they're actively
upstreaming bits of that, but as far as I know that doesn't in any way
try to solve this "users XYZ can't even list such-and-such a tree"
problem.

Google has much the same problem with Android, i.e. there's some parts
of the giant checkout of multiple repos the "repo" tool manages that
aren't available to some of Google's employees, or only to some partners
etc. They solve this by splitting those at repo boundaries, and are
working on moving that to submodules. Perhaps this would work in your
case? It's not as easy to work with, but could be made to work with
existing software.

In case you haven't, read "SECURITY" in the git-fetch(1) manpage,
although if that could be fixed to work for the case you're describing.

In a hypothetical implementation that does this, you are always going to
need to have something where you hand off the SHA-1 of the
"secret-stuff-here/" top-level tree object to clients that can't access
any of the sub-trees or blobs from that directory, since they're going
to need it to construct a commit object consisting of
"stuff-they-can-access/" plus the current state of "secret-stuff-here/"
to push upstream. But you can hide the blobs & trees under
"secret-stuff-here/" and their SHA-1s.

Note also that in the general case your "is this blob secret to user
xyz" or "is this tree secret to user xyz" will need to deal with there
happening to be some blob or tree in "secret-stuff-here/" that just so
happens to share the exact same tree/blob as something they need under
"stuff-they-can-access/". Think a directory that only contains a
".gitignore" file, or a BSD "LICENSE" file.
