Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 549F01F609
	for <e@80x24.org>; Wed, 28 Nov 2018 23:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbeK2K0A (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 05:26:00 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34965 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbeK2K0A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 05:26:00 -0500
Received: by mail-lf1-f65.google.com with SMTP id e26so26725lfc.2
        for <git@vger.kernel.org>; Wed, 28 Nov 2018 15:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BxLpr8mW+f+hJryAx6+wDyEoiUgouXgUJXaXTEdIsus=;
        b=PvjfPpZI7feZinp+dU5NR3d5ZFHE1RA/v0vMPXrkHW+MgDx57KZqolTZLEF3UPZDIs
         QQQ76KPOt04y/Mq1U1qJeRgfxJh2oob9ech8RKcJvYnJ1KWDaMARqbGUOMRtV3eisZLW
         5OXMecZa6tTZd/TR90hsGXBY/SK+2Ygz51ydU9ZLBrsTTwsrnhoqaKgvDMaUJfE/EEz5
         BGBsLzUMmjRrptl4mb0Y2nmK5ESfOpdsE5bxJXdEhRtz/kY4LwmAIkG9DtjTVZIlCMkx
         YT8UUkc6dGxYFdkPs7z0k/LlPzy05gSf/CCmITWpLjaqh7TULlSxNNI8olVgjTxQaDMP
         VyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BxLpr8mW+f+hJryAx6+wDyEoiUgouXgUJXaXTEdIsus=;
        b=FUGA8OxeQnNNxVrUxUQtASfk9hkzJXBAIYmIDX39qyxGy5PphaciXQ/jFFz12WVhKy
         anYGh9fqsoyuvMswVYdxAYbZNRTxBajix1W9eUAfYOkgG6PNWr7VFmUlsmp3yxsXsBMQ
         e9k8p8SfmfyHcMDVltxp0HgimUrhWSJ2nUdOezyiPa3mnW/QdLOEzUvLFXGpK12mxRDI
         6MDq4WY7dAQRBFyx3YbIHQO6wF1mLqVQ4mUqgAAa+il3zEVOHF+16CptY+JTkz3MoJR0
         S7rhAMtQPm+DBlJdwjUUR6Bd+NCE9Rtbnv/Tbgwb+2q7lacQgS1t/8vXFTGxzkwNXWoc
         Z1DA==
X-Gm-Message-State: AGRZ1gKzj886BLVcjGjl9X3rsFasNT7s511RiZhg+Z8aPIABYgUSYvJt
        lqEBSbt6oM/T9WutzKPY8hii5uoeUNIGZ4iy6uDzFQ==
X-Google-Smtp-Source: AJdET5fKckoA2LaVabtSfdxcQD0WDZqyAJqZXPtVcUQt9iIrOkUvXBGRUSwTiuz2L+opRDIrNwM+mzlfCldLko1S1oo=
X-Received: by 2002:a19:5154:: with SMTP id f81mr24280698lfb.96.1543447360391;
 Wed, 28 Nov 2018 15:22:40 -0800 (PST)
MIME-Version: 1.0
References: <20181120174554.GA29910@duynguyen.home> <20181127165211.24763-1-pclouds@gmail.com>
 <20181127165211.24763-7-pclouds@gmail.com> <xmqqftvlspqn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
In-Reply-To: <CACsJy8Bzs=FYKrR6h1cqVH32eEt2t8rUMtE2yFNvt+W55u=sDA@mail.gmail.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Wed, 28 Nov 2018 15:22:29 -0800
Message-ID: <CAPL8ZiuaEW5tp8ZMOZtZcb5oi3L-pDF6ajcA7b5wnH3=7Ls7Tg@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] checkout: split into switch-branch and checkout-files
To:     pclouds@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        t.gummerer@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Since the other one is already "checkout-files", maybe this one could jus=
t be "checkout-branch".

I rather like switch-branch and dislike the word "checkout" since it
has been overloaded in git for so long (does it mean moving HEAD or
copying files to my working tree?)

> nobody will become "sick of" the single "checkout" command that can

I have to admit I'm already sick of the checkout command. :-p I can
see myself using these two new commands 100% of the time and never
missing the old one.

Some behaviors I'd expect to see from these commands (I haven't yet
checked to see if you've already done this):

git checkout-files <tree-ish>
should reset all the files in the repository regardless of the current
directory - it should produce the same effect as "git reset --hard
<tree-ish> && git reset HEAD@{1}". It should also delete
locally-created files that aren't present in <tree-ish>, such that the
final working tree is exactly identical to what was committed in that
tree-ish.

git checkout-files foo -- myfile.txt
should delete myfile.txt if it is present locally but not present in foo.

git checkout-files foo -- .
should recursively checkout all files in the current folder and all
subfolders, and delete any locally-created files if they're not
present in foo.

git checkout-files should never move HEAD in any circumstance.

Suggestion:
If git checkout-files overwrites or deletes any locally-modified files
from the workspace or index, those files could be auto-stashed. That
would make it easy to restore them in the event of a mistyped command.
Auto-stashing could be suppressed with a command-line argument (with
alternate behaviors being fail-if-modified or always-overwrite).

Idea:
If git checkout-files modifies the submodules file, it could also
auto-update the submodules. (For example, with something like "git
submodule update --init --recursive --progress").

  - Stefan
On Wed, Nov 28, 2018 at 7:31 AM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Wed, Nov 28, 2018 at 7:03 AM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:
> >
> > > The good old "git checkout" command is still here and will be until
> > > all (or most of users) are sick of it.
> >
> > Two comments on the goal (the implementation looked reasonable
> > assuming the reader agrees with the gaol).
> >
> > At least to me, the verb "switch" needs two things to switch
> > between, i.e. "switch A and B", unless it is "switch to X".
> > Either "switch-to-branch" or simply "switch-to", perhaps?
> >
> > As I already hinted in my response to Stefan (?) about
> > checkout-from-tree vs checkout-from-index, a command with multiple
> > modes of operation is not confusing to people with the right mental
> > model, and I suspect that having two separate commands for "checking
> > out a branch" and "checking out paths" that is done by this step
> > would help users to form the right mental model.
>
> Since the other one is already "checkout-files", maybe this one could
> just be "checkout-branch".
>
> > So I tend to think
> > these two are "training wheels", and suspect that once they got it,
> > nobody will become "sick of" the single "checkout" command that can
> > be used to do either.  It's just the matter of being aware what can
> > be done (which requires the right mental model) and how to tell Git
> > what the user wants it do (two separate commands, operating mode
> > option, or just the implied command line syntax---once the user
> > knows what s/he is doing, these do not make that much a difference).
>
> I would hope this becomes better defaults and being used 90% of time.
> Even though I know "git checkout" quite well, it still bites me from
> time to time. Having the right mental model is one thing. Having to
> think a bit every time to write "git checkout" with the right syntax,
> and whether you need "--" (that ambiguation problem can still bite you
> from time to time), is frankly something I'd rather avoid.
> --
> Duy
