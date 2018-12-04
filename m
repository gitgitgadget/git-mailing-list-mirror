Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025B2211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 01:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbeLDB3H (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 20:29:07 -0500
Received: from mail-vk1-f180.google.com ([209.85.221.180]:38184 "EHLO
        mail-vk1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbeLDB3H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 20:29:07 -0500
Received: by mail-vk1-f180.google.com with SMTP id w72so3409888vkd.5
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 17:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B8A7njPR7ZSa7Tf6H9gwprFaI3xW8WJJoN3sQdhGdAI=;
        b=DnZFx6zouGq9yyH+rVmXlEcR2SDt+RLEbEEfQZBiMqH7WA7EGRo6+lm1Ay9ISkazcV
         z5k396W7hCDc3aTUU0GtQUZvcHIN5XtKuE6U2nIz31TcMZKynfxP3bnIQBl40o+ajWIr
         N4ENZEDJeKbdp1HAjT/feQ4EMMjiU2aGcPF6lLYE0w6ao59ShHG6fyTSm0k9yarbGyl9
         bKTS/kiL+otQiOZvucvcnWvB4gdYphlJXurnUXGTHVPXJCoLo7ffLJYbVfmQeG404s03
         9S9qxs627uZMS5arVa+8qvbV34ie/+CrfFUQNI4AlPLuk2XIG0g04kPbQBGauvcQsR4p
         Vtdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B8A7njPR7ZSa7Tf6H9gwprFaI3xW8WJJoN3sQdhGdAI=;
        b=cPMZIULR0PSxmHmUCYsa/1Q3uSlzAhYk+k3EE2x0vOI4mXWBYKEUj6TePuhaQUEqp3
         ydEE/AKK4medobGj9sCONAYO9XovBWejp3qPvjbcxDOgOasuZYxzdUdCByMNAVIxcWQX
         q+OFgyulr6VPk63UlvOSb00/9Wz4e6QOoSde0oQQUEeKvBD0asWOwG1PjnhF2dRFvMgw
         unJsc3EePMGGPYFF+YWMNRggeRezf8TMZTVbVJgMuBXFuQsrZzyRCtUQVXzCKCq2Jghl
         gKq5g1EQXOHpKfToB8sa6lw2LZLDi+0GniXc2GUdiCP4+W22Obw0b/GgTgT3oZ99cDzh
         QygA==
X-Gm-Message-State: AA+aEWbKSbhRJinAvOsLe7+xSxAsiEYjWGyFUgV2uqUc2e7H0EP/NvMt
        GrX53dV6L94hNxrw5r1N3zvMZtoLVrZxSY4lUIM=
X-Google-Smtp-Source: AFSGD/Um9ucN9ryoa4+bU1AxnQS9ziIhrWLam52bvNkiw1rU4AwhqEQZ5C22JxDJzjcKR4+inzVp8T6YAXuou6s+BfY=
X-Received: by 2002:a1f:a28a:: with SMTP id l132mr7921855vke.37.1543886946091;
 Mon, 03 Dec 2018 17:29:06 -0800 (PST)
MIME-Version: 1.0
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com>
In-Reply-To: <20181129215850.7278-1-pclouds@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 3 Dec 2018 17:28:53 -0800
Message-ID: <CABPp-BGsw3cxU4Y+-UMcwk=skyuvgU_Rfkyh0o1rRPwOv_LDDA@mail.gmail.com>
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, sxenos@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 29, 2018 at 2:01 PM Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <=
pclouds@gmail.com> wrote:
>
> v3 sees switch-branch go back to switch-branch (in v2 it was
> checkout-branch). checkout-files is also renamed restore-files (v1 was
> restore-paths). Hopefully we won't see another rename.

I started reading through the patches.  I also tried to apply them
locally, but they had conflicts or missing base file version on both
master and next.  What version did you base it on?

I stopped at 07/14, and dropped my comments all there.  I didn't read
any further yet, and may wait for your post-2.20 reroll.

> I'll try to summarize the differences between the new commands and
> 'git checkout' down here, but you're welcome to just head to 07/14 and
> read the new man pages.
>
> 'git switch-branch'
>
> - does not "do nothing", you have to either switch branch, create a
>   new branch, or detach. "git switch-branch" with no arguments is
>   rejected.
>
> - implicit detaching is rejected. If you need to detach, you need to
>   give --detach. Or stick to 'git checkout'.
>
> - -b/-B is renamed to -c/-C with long option names
>
> - of course does not accept pathspec
>
> 'git restore-files'
>
> - takes a ref from --from argument, not as a free ref. As a result,
>   '--' is no longer needed. All non-option arguments are pathspec
>
> - pathspec is mandatory, you can't do "git restore-files" without any
>   pathspec.
>
> - I just remember -p which is allowed to take no pathspec :( I'll fix
>   it later.

This all looks good.  I commented elsewhere but please remember that
pathspec implies directories as a possibility and we really need to
fix the broken behavior of checkout when given a directory.

> - Two more fancy features (the "git checkout --index" being the
>   default mode and the backup log for accidental overwrites) are of
>   course still missing. But they are coming.
>
> I did not go replace "detached HEAD" with "unnamed branch" (or "no
> branch") everywhere because I think a unique term is still good to
> refer to this concept. Or maybe "no branch" is good enough. I dunno.

I personally like "unnamed branch", but "no branch" would still be
better than "detached HEAD".
