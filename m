Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 198761F454
	for <e@80x24.org>; Sun,  3 Nov 2019 04:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbfKCElr (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 00:41:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46130 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbfKCElr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 00:41:47 -0400
Received: by mail-lj1-f194.google.com with SMTP id e9so774763ljp.13
        for <git@vger.kernel.org>; Sat, 02 Nov 2019 21:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/EdOdtUg0DcsFaCguxx9Dhl8J3cdKACU/p3xGBaa/5M=;
        b=YQWuO2ILpeDBWc2TWs0NNC1v0i6N3KrC5WoHeXWq2tNoXSkPxnjd6gch73pbOgQZOy
         Jl5gLDXBCNpuIwu10pyCwi67PL9HpjKyG/xNiOKGDnh5bvjk2cwa1UOVctSFG20gPDvO
         ASmcJ/G1TAjuUN0wemxrqJTFHdCto9ELMoq6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/EdOdtUg0DcsFaCguxx9Dhl8J3cdKACU/p3xGBaa/5M=;
        b=EJTn26iLMSBhNSjj9z0kPOvzIZmPB7cPXTEDLCS3i9v3JToQUERcAXAC3I+EZCms6C
         KcfageHLRSExjBGZPJ1n4UNF2UmAb0TpmwYqxnYEgvn4D0/0k6V4vr0K9R1wGNJrdxwD
         4wHQh0lUrTstoQxx0EqX3J7mG46+MIlKp9m6Fw8aI1T/2zZX+5CTeC/p+RQz675F72u/
         8rqlJaFcVYP5JyQM6+OQJSZQ1JjnCQ02u8Hk8OyYsmDVRgo36e2IJB3g4x8qGTkq9L/v
         AtIMvWxfCGK3l249M9ZnfSOyvSjkIl3XDogToW5wsqT4Ncjhgq+Jg93iqLTekVb5NCBo
         O4yA==
X-Gm-Message-State: APjAAAVzIs9vrApq8fel82CowCP694UkGpXWHm7xblRsNC3PjrvQPHrA
        rTLUxtJ9wnxH4WZMwEr7BnZxhb+mN8LI/uKsjnTg6w==
X-Google-Smtp-Source: APXvYqwAdCB6O+CdNScmUyOEkgyB4raZXX2PoAZL8HLPOiozKsFAEkEhERzySPF3PDxNk/zF30qPY9Fb/Iz+XoLgZlI=
X-Received: by 2002:a2e:9cc4:: with SMTP id g4mr6996325ljj.99.1572756103991;
 Sat, 02 Nov 2019 21:41:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.436.git.1572418123.gitgitgadget@gmail.com>
 <CAKPyHN1p+xRAF3Mjg_XqRiEUviGjj8ifP5FM=1hVb5LZUshzLw@mail.gmail.com>
 <CAPSOpYufF8B0sBUUYqBx5YTxH+02qRom+tz4a0_2iBcNOvvMXA@mail.gmail.com> <20191103011225.b6emr2ldskktokgd@yadavpratyush.com>
In-Reply-To: <20191103011225.b6emr2ldskktokgd@yadavpratyush.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Sat, 2 Nov 2019 23:41:32 -0500
Message-ID: <CAPSOpYsBRf4tCXP-wod2h+g_=NZ-Qr0KOSZw3M=96d5FUFpFzw@mail.gmail.com>
Subject: Re: [PATCH 0/2] git-gui: revert untracked files by deleting them
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     "Bert Wesarg bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|" 
        <xlwsizdz58ciy7t@sneakemail.com>,
        Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 2, 2019, 8:12 PM Pratyush Yadav, <me@yadavpratyush.com> wrote:
> On 30/10/19 12:16PM, Jonathan Gilbert wrote:
> > It's less about overloading the 'revert' operation as overloading the
> > UI action which is currently called "Revert". I think it would be a
> > worse experience to have to activate a different option to remove
> > unwanted files as to remove unwanted changes. Maybe the UI option
> > could be renamed "Revert & Clean" or something?
>
> I disagree. There are valid workflows where you want to remove all
> changes to tracked files, but leave untracked ones alone. As an example,
> say you wrote a small script to fix some textual things, like your
> variable re-name patch. Now you run a diff before you commit those
> changes just to be sure, and notice that your script was overzealous and
> made some changes it shouldn't have. So, you clean up all tracked files,
> and give your script a fresh start. Here, you don't want to delete your
> script.
>
> And in the other direction, say you want to delete all untracked files
> but have unstaged changes in your tracked files. Combining "Revert" and
> "Clean" does not give you an option to only delete untracked files. So
> you now either have to stash your changes, or run `git clean` from the
> command line.

But, since this is in this GUI interface, you can clearly see which
are which and select only the files you want to affect. If you have so
many files that you have to select indiscriminately, then the
command-line is probably a better choice anyway. In any case, my
proposed change prompts for each part of the change, so you _can_ just
select everything, press ^J, and then say "Yes" to only one of the
prompts.

> > As a side note, `git clean untracked-file` won't do anything with a
> > default configuration, you have to explicitly `-f` it. Not sure if
> > that's relevant, but it does feel like a higher barrier to entry than
> > `git revert`.
>
> `git revert` is different from our "Revert", though I admit the naming
> is quite confusing.
[..]
> So I don't think you should, or _can_, use `git revert` for what you
> want to do. And so, I don't see why it is being factored in with this
> discussion. Am I missing something?

You are entirely correct, this was just a massive brain fart. Every
time I wrote `git revert` in my head I was actually thinking of
exactly what Git Gui does, reverting working copy changes by checking
out the file. I should have written "reverting using `git checkout`".
My apologies!

In my defence, I have over the past few days found myself digging into
code hosted in SVN repositories, and `svn revert` does exactly what
`git checkout` does to an unstaged modified file. :-)

Jonathan Gilbert

On Sat, Nov 2, 2019 at 8:12 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
>
> On 30/10/19 12:16PM, Jonathan Gilbert wrote:
> > On Wed, Oct 30, 2019 at 4:09 AM Bert Wesarg
> > bert.wesarg-at-googlemail.com |GitHub Public/Example Allow|
> > <xlwsizdz58ciy7t@sneakemail.com> wrote:
> > > in Git speak, that operation is called 'clean' (see 'git clean') why
> > > should we overload the 'revert' operation here?
> >
> > It's less about overloading the 'revert' operation as overloading the
> > UI action which is currently called "Revert". I think it would be a
> > worse experience to have to activate a different option to remove
> > unwanted files as to remove unwanted changes. Maybe the UI option
> > could be renamed "Revert & Clean" or something?
>
> I disagree. There are valid workflows where you want to remove all
> changes to tracked files, but leave untracked ones alone. As an example,
> say you wrote a small script to fix some textual things, like your
> variable re-name patch. Now you run a diff before you commit those
> changes just to be sure, and notice that your script was overzealous and
> made some changes it shouldn't have. So, you clean up all tracked files,
> and give your script a fresh start. Here, you don't want to delete your
> script.
>
> And in the other direction, say you want to delete all untracked files
> but have unstaged changes in your tracked files. Combining "Revert" and
> "Clean" does not give you an option to only delete untracked files. So
> you now either have to stash your changes, or run `git clean` from the
> command line.
>
> > As a side note, `git clean untracked-file` won't do anything with a
> > default configuration, you have to explicitly `-f` it. Not sure if
> > that's relevant, but it does feel like a higher barrier to entry than
> > `git revert`.
>
> `git revert` is different from our "Revert", though I admit the naming
> is quite confusing. `git revert` creates a new commit that "reverses"
> the changes made in an earlier commit(s). The important point to note
> here is that `git revert` is used when you publish some commits, and
> then realise later they had some bugs. Now you can't just drop those
> commits because that would re-write the history, and it would change all
> the commit hashes since that commit. So, you use `git revert` to create
> a new commit that _textually_ reverses those changes. The buggy commit
> still exists in the tree, but its changes don't.
>
> In contrast, git-gui's "Revert" works on unstaged changes. It does not
> create a new commit. In fact, our revert does something similar to `git
> checkout -- <file>` (it uses `git checkout-index` to be precise).
>
> So I don't think you should, or _can_, use `git revert` for what you
> want to do. And so, I don't see why it is being factored in with this
> discussion. Am I missing something?
>
> --
> Regards,
> Pratyush Yadav
