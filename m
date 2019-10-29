Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1009D1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 20:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfJ2UeL (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 16:34:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37043 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726635AbfJ2UeK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 16:34:10 -0400
Received: by mail-lj1-f195.google.com with SMTP id v2so126578lji.4
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 13:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jynPFs+Zvmk1Wfdqyozcec4xI4c5DWdPQtpIku1Bp/Y=;
        b=G7WMcXIm55wJiQqU9IWxcT7m7/xpitD1ug/AcCRcBuYo7Rd3+/67SgsMtjQ00BacyW
         evS5ksB5GbOVlL6A9e+Wd24yCRCEaYrSnEG0iCKZrIEneDhu44P8lLv8grjRt/jKO/fB
         +vIi6bmkKgus2xiQBfR6Tq7wvS2+rxNYB/4EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jynPFs+Zvmk1Wfdqyozcec4xI4c5DWdPQtpIku1Bp/Y=;
        b=tlVDODZufW+s76rRzceo4JGwlKN4Wu85f0tvSaM8KlDVJ9AlON2av1QZs/wxfD34Ih
         eyDEDUZvhtlgX63Eu04XSWboibJ7Md5jWPfb4ZrUnWKjphidpkseHvtg1cVIaF8r37AV
         43Gu67+nbf8O+QEH0FNeZx6Ncm8oU8yTJ2l2ZiPUFIOZsDZll+aI2iRtKAmgglDr9ng7
         VOA72cQHIywbhq62ilzeSEtarYJYjj0/mGEOzr4IIj/CVI437rvnFBhj5DFpdw5vDh6U
         FsVzyGAsTED/82jN7PVUPIPi3CIfZZVf8nHtC03a8befM4f2ElQsgVQhkcP2YEyTUpIv
         XsAA==
X-Gm-Message-State: APjAAAUJ710fBycXZaaIGSzfQptp0+ihqfJJ5oPJCDEgu3orsUX+DF2T
        hr5K/IA377fJHExoeXxjOvp5hNds90zYNci7aHHXRA==
X-Google-Smtp-Source: APXvYqzoPl+DmOMz6E9r5hO+t9PoXAvDjYnguNHcxK2TeiHYuaNKU94VzdvjcX3BMoPMtOl4YB+89+Ca2gL8UH0Nf8w=
X-Received: by 2002:a2e:858d:: with SMTP id b13mr3593289lji.71.1572381248415;
 Tue, 29 Oct 2019 13:34:08 -0700 (PDT)
MIME-Version: 1.0
References: <pull.423.git.1572289087.gitgitgadget@gmail.com>
 <CAKPyHN3WEpVLnxYN5FsovW3G_borc+YrF05Npr0Wyvv6YhbcaQ@mail.gmail.com> <CAPSOpYsA9n6Y1vH1_+vRTCV7Mrvox4L2LpQmpXBnpH8ke0yDhQ@mail.gmail.com>
In-Reply-To: <CAPSOpYsA9n6Y1vH1_+vRTCV7Mrvox4L2LpQmpXBnpH8ke0yDhQ@mail.gmail.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Tue, 29 Oct 2019 15:33:46 -0500
Message-ID: <CAPSOpYs1zqbbbsAD=cNvQ6M_4EvziBaf6B=-BfS7XoZhU5cD_Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] Allow the 'revert' option in Git Gui to operate on
 untracked files, deleting them
To:     "Bert Wesarg bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|" 
        <xlwsizdz58ciy7t@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(should have had:)
> > I have an entry in the "Tools" menu for this called 'Delete':

> That's kind of neat, I wasn't aware of that facet of Git Gui :-) But,
> it isn't quite the same feature:

Oops, double gaffe. I accidentally forgot to "Reply All", so this was
a re-send of the message. And when I re-sent it, I didn't notice that
the e-mail client hid the quoted line from me and accidentally sent it
without quoting Bert's line. I wasn't sure whether to write this
follow-up but the longer I stared at it, the more sure I was that
somebody would call me out on it so I decided to be pre-emptive. My
apologies if it would have been better to just let it slide.

Jonathan Gilbert

On Tue, Oct 29, 2019 at 3:25 PM Jonathan Gilbert <logic@deltaq.org> wrote:
>
> That's kind of neat, I wasn't aware of that facet of Git Gui :-) But,
> it isn't quite the same feature:
>
> * It has to be manually set up on each installation.
> * It invokes an external process, I don't know if it's safe to assume
> that "rm" will work on all platforms (though I just tested it on my
> Windows installation and it worked).
> * It doesn't remove directories that it makes empty.
> * I don't see a way to bind it to a keyboard shortcut. That could just
> be me not knowing enough about custom tools, though. :-)
> * It only processes the first file selected.
> * If I select a tracked file, it will still delete it, and the feature
> I'm looking for is more of a "return repository to clean state" type
> function, like "revert" already is but extended to handle files that
> you can't actually "git revert".
>
> Thanks,
>
> Jonathan Gilbert
>
> On Tue, Oct 29, 2019 at 9:32 AM Bert Wesarg
> bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|
> <xlwsizdz58ciy7t@sneakemail.com> wrote:
> >
> > On Mon, Oct 28, 2019 at 7:58 PM Jonathan Gilbert via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:
> > >
> > > My development environment sometimes makes automatic changes that I don't
> > > want to keep. In some cases, this involves new files being added that I
> > > don't want to commit or keep. I have typically had to explicitly delete
> > > those files externally to Git Gui, and I want to be able to just select
> > > those newly-created untracked files and "revert" them into oblivion.
> > >
> >
> > I have an entry in the 'Tools" menu for this called 'Delete':
> >
> > [guitool "Delete"]
> >     cmd = rm -f \"$FILENAME\"
> >     noconsole = yes
> >     needsfile = yes
> >     confirm = yes
> >
> > Best,
> > Bert
> >
> > > This change updates the revert_helper function to check for untracked files
> > > as well as changes, and then any changes to be reverted and untracked files
> > > are handled by independent blocks of code. The user is prompted
> > > independently for untracked files, since the underlying action is
> > > fundamentally different (rm -f). If after deleting untracked files, the
> > > directory containing them becomes empty, then the directory is removed as
> > > well.
> > >
> > > This introduces new strings in index.tcl. I have been told that there is a
> > > separate process whereby the translations get updated.
> > >
> > > Jonathan Gilbert (1):
> > >   git-gui: Revert untracked files by deleting them
> > >
> > >  git-gui/lib/index.tcl | 139 +++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 104 insertions(+), 35 deletions(-)
> > >
> > >
