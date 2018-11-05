Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7E3F1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 11:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbeKEVAP (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 16:00:15 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:36443 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKEVAP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 16:00:15 -0500
Received: by mail-ed1-f42.google.com with SMTP id x2-v6so7211403eds.3
        for <git@vger.kernel.org>; Mon, 05 Nov 2018 03:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=6DsaTdrKYv5F0wEUFHjXXMg2aN0rVoZTtiIMjvzxrZk=;
        b=RGBoxzcfAGQQUxBG9f5PJ+z7yPFhxs82fmG0ed6Yeqz7YMAuOGVF9w3dR02gHOiTMY
         UV1eO+xctlJJiHlBbMfJpsyQpwIYVOYWwHz5sbQL06f2v0q2Fy0JAc1BVa29G6VpXolF
         4Zy3DltEzPFTrYTokvFH7jagYghygrRfbjLsajYrrzJYj6ichq0RB+zeNZv34z57Zua9
         Pak37nOQbK4rEct/AHX/bRXgWDUEwWOeqO7XUXAFf+j/hig/LJeG1OLp3YBJH1DDiPph
         u0ZBhwf5XSQ8fWZFULTUG4A0s7dUTPdegmPLc4AHumfOKA6TMZBk8uwyVbJNkupDF/E8
         mEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=6DsaTdrKYv5F0wEUFHjXXMg2aN0rVoZTtiIMjvzxrZk=;
        b=b/Oy5PcdQWePFAYxOqWqoRE3VrOcEMY1CBaSYsh5wf/enhiVgE/+BzVtly65Q5ny2+
         fRUrBTopj73Xo/Syj5o9MevZBirUdjyGHJPZF3IFBWdOnGCp68RZdc6+wCBUuvcoRvUc
         pIjqi8DqfqYakEf1gNfLCnpzC8nqXY5LtmT15UYfsVrA5of5GJAj6yJU5uglSmcNGLCh
         fjmcP48yYIlCW60/yYiTniyA1RjJZC59IDuKcxViD3KdnTbMf0GnZLWDK8IEtJwg4LXA
         Ti+QQ+bUk2D6r8UvFXgZFm5oeGOOx5JJVy7sj7JBCvfGcipceZK3KvW7Z1Wci2byup7v
         b5SA==
X-Gm-Message-State: AGRZ1gIq+tMlpwdJk155RcuBmTds4i0a8/UCHN8Tqz5z9LnsSdzLiOZz
        NddJCvT88IcUWw0TSqWQgVDPju3k
X-Google-Smtp-Source: AJdET5cC0zp2fRcpBQtu89kPYpKn4BNGj+ShQhwpAuXqcfLCpfqT3M0X0JEQ5ZdU6ph92l6DAaV4CQ==
X-Received: by 2002:a17:906:4f09:: with SMTP id t9-v6mr13916983eju.153.1541418054592;
        Mon, 05 Nov 2018 03:40:54 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id p26-v6sm1669608ejd.15.2018.11.05.03.40.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Nov 2018 03:40:53 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Peart <benpeart@microsoft.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
References: <20181030191608.18716-1-peartben@gmail.com> <CACsJy8DbiVZYmY11Nt4c_+egSi5tz0iVq7rNv2BiVdyJ4htgvw@mail.gmail.com> <1f7efd07-4881-daa7-cd1d-145bbf3ffcc8@gmail.com> <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8BqWu0YG_Q8EFNeDgrRhYCCKBU+zPJjrhAWFU_gTDCoXg@mail.gmail.com>
Date:   Mon, 05 Nov 2018 12:40:53 +0100
Message-ID: <87ftwf7nwa.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 04 2018, Duy Nguyen wrote:

> On Wed, Oct 31, 2018 at 9:53 PM Ben Peart <peartben@gmail.com> wrote:
>> >> +core.virtualFilesystem::
>> >> +       If set, the value of this variable is used as a command which
>> >> +       will identify all files and directories that are present in
>> >> +       the working directory.  Git will only track and update files
>> >> +       listed in the virtual file system.  Using the virtual file system
>> >> +       will supersede the sparse-checkout settings which will be ignored.
>> >> +       See the "virtual file system" section of linkgit:githooks[6].
>> >
>> > It sounds like "virtual file system" is just one of the use cases for
>> > this feature, which is more about a dynamic source of sparse-checkout
>> > bits. Perhaps name the config key with something along sparse checkout
>> > instead of naming it after a use case.
>>
>> It's more than a dynamic sparse-checkout because the same list is also
>> used to exclude any file/folder not listed.  That means any file not
>> listed won't ever be updated by git (like in 'checkout' for example) so
>> 'stale' files could be left in the working directory.  It also means git
>> won't find new/untracked files unless they are specifically added to the
>> list.
>
> OK. I'm not at all interested in carrying maintenance burden for some
> software behind closed doors. I could see values in having a more
> flexible sparse checkout but this now seems like very tightly designed
> for GVFS. So unless there's another use case (preferably open source)
>  for this, I don't think this should be added in git.git.

I haven't looked at the patch in any detail beyond skimming it, and
you're more familiar with this area...

But in principle I'm very interested in getting something like this in
git.git, even if we were to assume GVFS was a 100% proprietary
implementation (which it's not, it's open source[1] and there's work on
a non-Windows port[2]).

By some definition we already support at least one "virtual filesystem",
or two. I.e. we check files into a *.git repository where everything's
trees & blobs, and then we need to ferry it back & forth between that
and a POSIX-like fs using readdir(), stat(), open() and the like. Of
course this isn't "virtual" in the fs sense, but it's a foreign virtual
FS as far as git is concerned.

Our other "virtual filesystem" (although this is a stretch) is what we
expose via the plumbing commands.

Both of these, as covered at length in various GVFS design docs /
background info, aren't a good fit for some implementation where you'd
like a file-like view that works with the index/status etc. but doesn't
involve checking out everything. There's a huge gap to bridge between
our plumbing & the features we expose that require a POSIX-like fs.

I can see such an ability being very useful for things that aren't the
massive repo Microsoft is interested in supporting. E.g. even for a
~500MB repo it's a stretch to clone that, edit it, and submit a PR on
something like an iOS/Android device.

Once we have something in git to support the likes of GVFS supporting
use-cases like that also becomes easier. Between shallow cloning, the
various object filters & this it would be great to be able to get a 1MB
clone of git.git on my phone and submit a patch to it.

The only potential downside I see is that there's currently exactly one
implementation of this sort of thing in the wild, so we risk any such
API becoming too tied up with just what GVFS wants, and not what we'd
like to support with such a thing in general. This is what e.g. the w3c
tries to avoid with having multiple browser implementations before
something is standardized.

But I think that's easy to work around. E.g. we can document any such
API saying that it's an experimental v1 and is on probation until we get
more users of the feature and figure out the warts & limitations. If it
does end up being too GVFS-specific we could make a breaking change at
some point and eventually drop the v1 version.

1. https://gvfs.io/
2. https://arstechnica.com/gadgets/2017/11/microsoft-and-github-team-up-to-take-git-virtual-file-system-to-macos-linux/
