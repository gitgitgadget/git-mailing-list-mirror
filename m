Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF50C4743D
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4541A61285
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 07:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhFHHQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 03:16:28 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:40571 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbhFHHQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 03:16:25 -0400
Received: by mail-pl1-f170.google.com with SMTP id e7so10134050plj.7
        for <git@vger.kernel.org>; Tue, 08 Jun 2021 00:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jm4oaFfkmD/+5eIJfHdHuxSE/aJeOl4qQvuhCXxa91I=;
        b=BniP39c6DsVku3ft/H7njRB2n8gjjQiJ/b/DOoOwMlcQCtXj8oUGoNjnAdfdAyrElj
         F60Hy4KxDjuOthCwjuaafWqBucSOZk9gHyXNX1lE8JmNNsPgjHh23WIlTixuNABp0sWT
         vgrRZueezSGYh53LdUctwo6XgVN5Dq/VMcxQpT753h8/4zWSd9Qp9WLbXuZJ7flCGWe7
         hDkue56H61e9kqPCS7sIGZZzsuOq47lCkvTGfyW63NRFwHcjzG/rETtkjRmHV/iO8V2Z
         UoOs5pCbbpQAJeNQAFj801o3JOkgRZ6NrPW1bmj0ibpc9TmFGKfS76SCuhliEJjs0KOE
         Gycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=jm4oaFfkmD/+5eIJfHdHuxSE/aJeOl4qQvuhCXxa91I=;
        b=gKfn4+SPk3IymTw2z4vVvDCFsK3NfEI0zALMoGrJ7XQUA2EthwGj9nAov5/Y0zJnAO
         XcHEX9rP1wDTXaqCj/XnOYyEV1Mc4JDrmTs4me5zK1CQD5ip/cPNJ2SIhgGs2CDXfkXZ
         g2zssrMZ+2pIhY5L1xsNRL5B1F7pYxF8SVvIoEFEhNsJl/ou1GgeNZo7lyOtLZoW/UDH
         NDX+BkDWbw/Nfqsj5WU8aNbiVKrZJWT2IhPzUVm+jmwOfy3DRNNJn6bd8yE6jCHGCE/G
         ST/I7oWPZ+rzXG5oNt/FeIvcLTkdfYOSa47sQqmgoybIHm3C/EuMLQmK3SkGia5sZocp
         /ojw==
X-Gm-Message-State: AOAM530FWFMFlZQ1eDaL2UioTchV+Caij5aClnU2Juo5tjxcLg4MiWH6
        EO3GrAwSpCk4quCmZQpFMvk=
X-Google-Smtp-Source: ABdhPJwPfFjpb1GTP5pQzLR3MLF+7QhB/kzP8gxPfLvwZ/w2XgSKK7LplR4b7z6lvceyAePS/EKKKQ==
X-Received: by 2002:a17:902:6902:b029:106:50e3:b2db with SMTP id j2-20020a1709026902b029010650e3b2dbmr21925991plk.35.1623136399518;
        Tue, 08 Jun 2021 00:13:19 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.107.60])
        by smtp.gmail.com with ESMTPSA id t17sm3531054pfg.1.2021.06.08.00.13.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jun 2021 00:13:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [GSoC] My Git Dev Blog - Week 3
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <4a4a3d6f-7d06-ccdb-7d5a-4057c7549927@gmail.com>
Date:   Tue, 8 Jun 2021 12:43:16 +0530
Cc:     git <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CBC56A4C-2D47-4C96-9621-73BCB1119B90@gmail.com>
References: <FC56DF49-CEC5-4C9F-BDE4-B0119558E4B2@gmail.com>
 <4a4a3d6f-7d06-ccdb-7d5a-4057c7549927@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08-Jun-2021, at 00:25, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> =
wrote:
>=20
> Hi Atharva,
>=20
> On 06/06/21 5:56 pm, Atharva Raykar wrote:
>> Hi,
>> Here is my latest instalment in my weekly Git blog:
>> http://atharvaraykar.me/gitnotes/week3
>=20
> Nice post!
>=20
>> My not-so-well-read guess: Some users want certain submodules
>> active in one worktree, but not the other. For that, there
>> presumably exists a per-worktree configuration, and the current
>> implementation just assumes a configuration that applies to the
>> full repo. Changing this is definitely a patch for some other time.
>=20
> I get to the same presumption. You could try exploring worktrees more =
to
> confirm as you point out. You could also try Cc-ing people who you =
think
> would have an idea of this. 'git blame' could you here.

Yes, I have actually been noting down these "leftover bits" as
things to look into after my GSoC period.

> > A painful merge
>=20
> You don't mention which branches you were trying to merge but
> from the context I sort of figured out it was the
> 'submodule-add-in-c-add-config-v2' and
> 'submodule-add-in-c-add-clone-v3' branches in your repository: =
https://github.com/tfidfwastaken/git/

That is correct. I felt like adding too many details like that
might make it harder for someone to get the big picture about
what happened at a later time (like one year from now).

> You mention trying 'recursive' strategy. Given this isn't a
> fast-forward merge, I would've expected it to be one that would've
> been triggered by default. Was that not the case for you?

This was my bad. I had it mixed up in my head and assumed
'resolve' was the default strategy. Between all the
strategies I tried, 'recursive', ie, the default one worked
best. I'll tweak my post to reflect this.

> Also, which version of Git did you use to do the merge ?

2.31.1

Since I'm now a Git developer, I should probably be running
on a more bleeding edge version, but I have still not got
around to it.

> I tried reproducing the merge and it's indeed interesting that
> even '-Xpatience' didn't do the trick.

Yeah. It looks deceptively straightforward for the human eye,
not so much for algorithms. Most likely because both the
patches have structurally very similar code, and many lines in
between are identical.

>> I still wonder how non-Emacs users deal with situations like these.
>=20
> Git lets you invoke external merge tools which could help you resolve
> merge conflicts in a easy way. See mergetool doc [1] to get an idea
> about it. `git mergetool --tool-help` would give you a list of =
supported
> tools. In your case, I happened to notice that P4Merge[2] does a good
> job of properly resolving the conflict by itself.
>=20
> [1]: https://www.git-scm.com/docs/git-mergetool
> [2]: =
https://www.perforce.com/products/helix-core-apps/merge-diff-tool-p4merge

Thanks for the pointers. I currently use Ediff, which is what is
the default mergetool that is invoked from Magit (the porcelain
I use). Magit is great, Ediff not so much.

> Speaking of resolving conflicts, there's also rerere [3] which should
> save you from having to resolve the same conflict again and again.

Yes. I had that enabled after learning about it from last week's
discussion, that lead to it being the default in the next release.

[https://lore.kernel.org/git/xmqqfsxvxjj2.fsf@gitster.g/]

> [3]: https://www.git-scm.com/book/en/v2/Git-Tools-Rerere
>=20
>> So I=E2=80=99m glad there=E2=80=99s the reflog.
>=20
> Now that you've learned about and used reflog, I thought I'll let you
> know about `git fsck --lost-found` [4] in case it might come in handy
> someday ;-)
>=20
> [4]: =
https://git-scm.com/docs/git-fsck#Documentation/git-fsck.txt---lost-found

Thanks for showing me this. Looks very useful. I hope I never
need it ;-)

>> Have a great weekend, and stay safe!
>=20
> Thanks. Hope you stay safe too!
>=20
> --=20
> Sivaraam

