Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5240C1F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 01:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbfJ2Bpb (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 21:45:31 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37625 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbfJ2Bpb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 21:45:31 -0400
Received: by mail-lf1-f65.google.com with SMTP id b20so9264082lfp.4
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 18:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a+ehhmeqh6rwWvBNOHd46hoDG0fFu4e/X0YGuZA7mJQ=;
        b=GU5tnF7LU8eBSO1LG/qrNynxtBuhyCi0+kwnQRelMyVLGDD3U+uK9S1n8bMfROyopw
         M15+CACaaKDlIcOqP10grQZ15o+1iFDVamKbA9W9DkjmpctqVijoQGhYmnfD/H6k9zBN
         nuif6gSCHsP4yzj5wHmvyHB9sWnwfhpAcDbiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a+ehhmeqh6rwWvBNOHd46hoDG0fFu4e/X0YGuZA7mJQ=;
        b=MeM4IzvOVkm7iITseuDTrW6kwnytLJ2ug1GswTeXDCmmvrQNmYrvVraDNNPuiPBr9L
         pykpaF+cIc6MQs39e3O12h0AW5gtaxqCOGsVj67N4K2a4/zp+NSBhdPEW38Z6T1POq+x
         RuUQixl+l26/1KEz8byrd17KYAm64J7fcvl4FwvF9TbRUCmnJMfRVY/eax7PwjsVetH+
         7LwLkB0jFAp2RioVbCsFb6/XSbZvbEk7aURorgHQtnrtLU6YKV7zBRcXoL9ybZXyIn+0
         isX5sKw6aAzh1tzoLayqVm5BpTPQo877HRkhTnKYBwT8Hzm7nsvy3ZKhZeT/D020goq/
         ppPQ==
X-Gm-Message-State: APjAAAXNajMKwhR2ol+v7p8JvcVQwvHbE6o0azuBu5Jcl6YC1TllSiw0
        GiohiL+wGYsrIl5m16Zc+gcp6fDNGrPGZO/Ufn05cjSlYQATNBYu
X-Google-Smtp-Source: APXvYqzI/7bLjCXpNjZlB7cM8+/DKjqKYoWTJxXBZ8Vy6Z/vhlAmcyArw/cmzV+rp7Xu02PB7NMmj5raird+D+TOCv4=
X-Received: by 2002:ac2:4822:: with SMTP id 2mr422776lft.115.1572313528875;
 Mon, 28 Oct 2019 18:45:28 -0700 (PDT)
MIME-Version: 1.0
References: <pull.423.git.1572289087.gitgitgadget@gmail.com> <20191029001253.2lxsntgcivs2jhax@camp.crustytoothpaste.net>
In-Reply-To: <20191029001253.2lxsntgcivs2jhax@camp.crustytoothpaste.net>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Mon, 28 Oct 2019 20:45:08 -0500
Message-ID: <CAPSOpYu4pHymWpSrph41JsbR00dvpFUVrSPAx3S+RqRUi8t+ig@mail.gmail.com>
Subject: Re: [PATCH 0/1] Allow the 'revert' option in Git Gui to operate on
 untracked files, deleting them
To:     "brian m. carlson sandals-at-crustytoothpaste.net |GitHub Public/Example
        Allow|" <92ue75mvem3o2ht@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Is there a reason these new files can't be ignored, with one of the.gitignore file, .git/info/exclude, or core.excludesFile?

I guess it's implied in the way I worded the message, but I have
fallen into the habit of using Git-Gui to manage the state of the
working copy (at least in detail). I am primarily doing .NET
development, for which projects can have a file App.config that stores
various settings that apply to the project at runtime. The NuGet
package manager sometimes edits App.config on your behalf as part of
installing a package, and if a project doesn't already have an
App.config file, it adds one. It has also updated a packages.config
file and the main project file. If I decide that I actually don't want
the change after all, Git-Gui permits me to revert the packages.config
change and revert the project file change. If an existing App.config
file was edited, I can revert that too, but if it was newly-generated,
then I want to delete that file, but I don't want to ignore App.config
files going forward, because there's a good chance a future change may
introduce a different need for an App.config file.

With the current Git-Gui version, I need to exit the Git-Gui UI/flow,
navigate to the project in a console window (which probably isn't
already in the correct folder) and manually delete the unwanted file.
This deletion requires me to identify the file explicitly as well.
With the proposed change, the untracked file, which Git-Gui already
lists, can be selected, and then activating the "revert" function
performs a UI flow for deleting the file. Without these changes,
Git-Gui simply does nothing at all when you tell it to revert an
untracked file.

Another example is when I go to review changes and discover a VIM
crash dump or a spurious temporary file from a code analyzer, files
that aren't _expected_ to normally come into existence at all. While
we could try to anticipate every type of spurious file and .gitignore
them all, I prefer to simply delete the files, and for similar reasons
as before, navigating a separate tool to the correct folder to perform
the deletion is a manual, time-consuming and context-switching
process. This is what led me to want this feature directly from the
Git-Gui tool, which is what identifies the rogue file to me in the
first place.

If you can think of a concise way to say that, I'll be happy to add it
to the commit message. My intuition is that that's too wordy
as-written, but if that intuition is wrong, I can copy/paste this text
too. :-)

Thanks,

Jonathan Gilbert


On Mon, Oct 28, 2019 at 7:12 PM brian m. carlson
sandals-at-crustytoothpaste.net |GitHub Public/Example Allow|
<92ue75mvem3o2ht@sneakemail.com> wrote:
>
> On 2019-10-28 at 18:58:06, Jonathan Gilbert via GitGitGadget wrote:
> > My development environment sometimes makes automatic changes that I don't
> > want to keep. In some cases, this involves new files being added that I
> > don't want to commit or keep. I have typically had to explicitly delete
> > those files externally to Git Gui, and I want to be able to just select
> > those newly-created untracked files and "revert" them into oblivion.
>
> Is there a reason these new files can't be ignored, with one of the
> .gitignore file, .git/info/exclude, or core.excludesFile?
>
> If so, it would be helpful to explain that in the commit message so we
> can more fully understand the rationale here.
> --
> brian m. carlson: Houston, Texas, US
> OpenPGP: https://keybase.io/bk2204
