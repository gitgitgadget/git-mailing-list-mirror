Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 090701F453
	for <e@80x24.org>; Mon, 29 Oct 2018 01:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbeJ2KOt (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Oct 2018 06:14:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42396 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJ2KOt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Oct 2018 06:14:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id y15-v6so6871005wru.9
        for <git@vger.kernel.org>; Sun, 28 Oct 2018 18:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=cAQXLYWn7TuXulM3GvPmIdz5G3dlKoNPX6DJ7DqlON0=;
        b=Tp0S16VdzVlbZbRYK2n528pG6w2e4kSCNxBhU4IZnWOw2H4UczsTiGG1Ls8BddomWe
         h9jKCOJSOX7F9gNXq8NGg5Na7xOYriol9zGFGNDFcMzkBYLC9p/pJGrF6lZlol1YCeJh
         JIfb2/rKlwMf9DiLXFkTpuJQPaIgCk7ENCEnuVNCfsx3IyKBPhUuts6FUyPtQgZFakQ+
         kyVAUa+fhS4nGlwgCBgCnN0d3dXV9Y7r/BH4gnYvwpRktxqiMGkc5duxA3mdN+F4jXSQ
         j3PuWThvcnZtvtyhNwaw8ZQkcn6vwgECPxrKKyb+uBbpsp4JiLoqReqPYSEY1+IHT7A8
         alJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=cAQXLYWn7TuXulM3GvPmIdz5G3dlKoNPX6DJ7DqlON0=;
        b=FgRHv+U2KcWZaZfhwY88qRzqMpEe6gPvVV9L40eTxcnU9q3/cwhfxUZ7FZJYA+DWHF
         iL/B8sUbr7xl48CILdTPDhNjj8nU3LFlBCbs/nffNrT+pXd5aw72H4XvQXS0u0S2zZwb
         AFUvlMv9lzQoWQ4cKgu6MmCVFeU4+1NYIN43vlbCkDhi1hl7hGoJozuMsYgmLDiI767b
         gJqpdcG6+MiMduMoCpE5mI6+b7oOt9cLtI7x9L+J6rrdhY2nkv5wj5A4SQ0OypFj48sT
         dHHkDtQM+le1UA0LJQquXl/nXzgD6GwrqF8VvEwl6VS9B9QzA1xmVSNJStwqmeiCBcxw
         Wslw==
X-Gm-Message-State: AGRZ1gJYoqKfd8O5zHoJAmgr7W7uZE+YKSBXujvkgv+0IScsu9WlmsK3
        YW7gH34jxyXjozk506Q7d0o=
X-Google-Smtp-Source: AJdET5d4MmUMuruzhC6XcZig5kaA2yjj778r3tidqyXS50YT73RCegCOvGNW+GnagLzeDH5Jvo8Xig==
X-Received: by 2002:adf:e206:: with SMTP id j6-v6mr12729913wri.205.1540776503264;
        Sun, 28 Oct 2018 18:28:23 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l4-v6sm29550715wrb.92.2018.10.28.18.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Oct 2018 18:28:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 00/78] nd/config-split reroll
References: <20181027062351.30446-1-pclouds@gmail.com>
Date:   Mon, 29 Oct 2018 10:28:21 +0900
In-Reply-To: <20181027062351.30446-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 27 Oct 2018 08:22:33 +0200")
Message-ID: <xmqqwoq18rt6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Compared to the version on 'pu', this one moves all the config files
> to Documentation/config/ directory. imap.* is also added back in
> config.txt (curently only documented in git-imap-send.txt)

The other biggie seems to be http.* that are now in a separate
file, which is good.

> This one is built on top of bp/reset-quiet and js/mingw-http-ssl to
> avoid non-trivial conflicts.

I've applied these on top of the suggested base, and compared the
result with a merge of the previous round with the suggested base.
I didn't find any questionable differences.

> I notice that there are duplicated config documentation in git-*.txt.
> But given the size of this series, I think people will agree that can
> be done separately later.

Yup.

Thanks.

> Nguyễn Thái Ngọc Duy (78):
>   Update makefile in preparation for Documentation/config/*.txt
>   config.txt: move advice.* to a separate file
>   config.txt: move core.* to a separate file
>   config.txt: move add.* to a separate file
>   config.txt: move alias.* to a separate file
>   config.txt: move am.* to a separate file
>   config.txt: move apply.* to a separate file
>   config.txt: move blame.* to a separate file
>   config.txt: move branch.* to a separate file
>   config.txt: move browser.* to a separate file
>   config.txt: move checkout.* to a separate file
>   config.txt: move clean.* to a separate file
>   config.txt: move color.* to a separate file
>   config.txt: move column.* to a separate file
>   config.txt: move commit.* to a separate file
>   config.txt: move credential.* to a separate file
>   config.txt: move completion.* to a separate file
>   config.txt: move diff-config.txt to config/
>   config.txt: move difftool.* to a separate file
>   config.txt: move fastimport.* to a separate file
>   config.txt: move fetch-config.txt to config/
>   config.txt: move filter.* to a separate file
>   config.txt: move format-config.txt to config/
>   config.txt: move fmt-merge-msg-config.txt to config/
>   config.txt: move fsck.* to a separate file
>   config.txt: move gc.* to a separate file
>   config.txt: move gitcvs-config.txt to config/
>   config.txt: move gitweb.* to a separate file
>   config.txt: move grep.* to a separate file
>   config.txt: move gpg.* to a separate file
>   config.txt: move gui-config.txt to config/
>   config.txt: move guitool.* to a separate file
>   config.txt: move help.* to a separate file
>   config.txt: move ssh.* to a separate file
>   config.txt: move http.* to a separate file
>   config.txt: move i18n.* to a separate file
>   git-imap-send.txt: move imap.* to a separate file
>   config.txt: move index.* to a separate file
>   config.txt: move init.* to a separate file
>   config.txt: move instaweb.* to a separate file
>   config.txt: move interactive.* to a separate file
>   config.txt: move log.* to a separate file
>   config.txt: move mailinfo.* to a separate file
>   config.txt: move mailmap.* to a separate file
>   config.txt: move man.* to a separate file
>   config.txt: move merge-config.txt to config/
>   config.txt: move mergetool.* to a separate file
>   config.txt: move notes.* to a separate file
>   config.txt: move pack.* to a separate file
>   config.txt: move pager.* to a separate file
>   config.txt: move pretty.* to a separate file
>   config.txt: move protocol.* to a separate file
>   config.txt: move pull-config.txt to config/
>   config.txt: move push-config.txt to config/
>   config.txt: move rebase-config.txt to config/
>   config.txt: move receive-config.txt to config/
>   config.txt: move remote.* to a separate file
>   config.txt: move remotes.* to a separate file
>   config.txt: move repack.* to a separate file
>   config.txt: move rerere.* to a separate file
>   config.txt: move reset.* to a separate file
>   config.txt: move sendemail-config.txt to config/
>   config.txt: move sequencer.* to a separate file
>   config.txt: move showBranch.* to a separate file
>   config.txt: move splitIndex.* to a separate file
>   config.txt: move status.* to a separate file
>   config.txt: move stash.* to a separate file
>   config.txt: move submodule.* to a separate file
>   config.txt: move tag.* to a separate file
>   config.txt: move transfer.* to a separate file
>   config.txt: move uploadarchive.* to a separate file
>   config.txt: move uploadpack.* to a separate file
>   config.txt: move url.* to a separate file
>   config.txt: move user.* to a separate file
>   config.txt: move versionsort.* to a separate file
>   config.txt: move web.* to a separate file
>   config.txt: move worktree.* to a separate file
>   config.txt: remove config/dummy.txt
>
>  Documentation/Makefile                        |    2 +-
>  Documentation/config.txt                      | 2957 +----------------
>  Documentation/config/add.txt                  |    7 +
>  Documentation/config/advice.txt               |   86 +
>  Documentation/config/alias.txt                |   18 +
>  Documentation/config/am.txt                   |   14 +
>  Documentation/config/apply.txt                |   11 +
>  Documentation/config/blame.txt                |   21 +
>  Documentation/config/branch.txt               |  102 +
>  Documentation/config/browser.txt              |    9 +
>  Documentation/config/checkout.txt             |   23 +
>  Documentation/config/clean.txt                |    3 +
>  Documentation/config/color.txt                |  201 ++
>  Documentation/config/column.txt               |   55 +
>  Documentation/config/commit.txt               |   29 +
>  Documentation/config/completion.txt           |    7 +
>  Documentation/config/core.txt                 |  594 ++++
>  Documentation/config/credential.txt           |   26 +
>  .../{diff-config.txt => config/diff.txt}      |    2 +-
>  Documentation/config/difftool.txt             |   14 +
>  Documentation/config/fastimport.txt           |    8 +
>  .../{fetch-config.txt => config/fetch.txt}    |    0
>  Documentation/config/filter.txt               |    9 +
>  .../fmt-merge-msg.txt}                        |    0
>  .../{format-config.txt => config/format.txt}  |    0
>  Documentation/config/fsck.txt                 |   67 +
>  Documentation/config/gc.txt                   |  108 +
>  .../{gitcvs-config.txt => config/gitcvs.txt}  |    0
>  Documentation/config/gitweb.txt               |   16 +
>  Documentation/config/gpg.txt                  |   20 +
>  Documentation/config/grep.txt                 |   24 +
>  .../{gui-config.txt => config/gui.txt}        |    0
>  Documentation/config/guitool.txt              |   50 +
>  Documentation/config/help.txt                 |   23 +
>  Documentation/config/http.txt                 |  271 ++
>  Documentation/config/i18n.txt                 |   10 +
>  Documentation/config/imap.txt                 |   44 +
>  Documentation/config/index.txt                |   10 +
>  Documentation/config/init.txt                 |    3 +
>  Documentation/config/instaweb.txt             |   20 +
>  Documentation/config/interactive.txt          |   16 +
>  Documentation/config/log.txt                  |   43 +
>  Documentation/config/mailinfo.txt             |    6 +
>  Documentation/config/mailmap.txt              |   15 +
>  Documentation/config/man.txt                  |   12 +
>  .../{merge-config.txt => config/merge.txt}    |    4 +-
>  Documentation/config/mergetool.txt            |   53 +
>  Documentation/config/notes.txt                |   59 +
>  Documentation/config/pack.txt                 |  120 +
>  Documentation/config/pager.txt                |    8 +
>  Documentation/config/pretty.txt               |    9 +
>  Documentation/config/protocol.txt             |   64 +
>  .../{pull-config.txt => config/pull.txt}      |    0
>  .../{push-config.txt => config/push.txt}      |    0
>  .../{rebase-config.txt => config/rebase.txt}  |    0
>  .../receive.txt}                              |    0
>  Documentation/config/remote.txt               |   78 +
>  Documentation/config/remotes.txt              |    3 +
>  Documentation/config/repack.txt               |   27 +
>  Documentation/config/rerere.txt               |   12 +
>  Documentation/config/reset.txt                |    2 +
>  .../sendemail.txt}                            |    0
>  Documentation/config/sequencer.txt            |    5 +
>  Documentation/config/showbranch.txt           |    3 +
>  Documentation/config/splitindex.txt           |   24 +
>  Documentation/config/ssh.txt                  |   35 +
>  Documentation/config/stash.txt                |    9 +
>  Documentation/config/status.txt               |   72 +
>  .../submodule.txt}                            |    0
>  Documentation/config/tag.txt                  |   16 +
>  Documentation/config/transfer.txt             |   71 +
>  Documentation/config/uploadarchive.txt        |    6 +
>  Documentation/config/uploadpack.txt           |   65 +
>  Documentation/config/url.txt                  |   30 +
>  Documentation/config/user.txt                 |   26 +
>  Documentation/config/versionsort.txt          |   33 +
>  Documentation/config/web.txt                  |    4 +
>  Documentation/config/worktree.txt             |    9 +
>  Documentation/git-fmt-merge-msg.txt           |    2 +-
>  Documentation/git-imap-send.txt               |   45 +-
>  Documentation/git-merge.txt                   |    2 +-
>  Documentation/git-rebase.txt                  |    2 +-
>  Makefile                                      |    2 +-
>  generate-cmdlist.sh                           |    2 +-
>  84 files changed, 2959 insertions(+), 2899 deletions(-)
>  create mode 100644 Documentation/config/add.txt
>  create mode 100644 Documentation/config/advice.txt
>  create mode 100644 Documentation/config/alias.txt
>  create mode 100644 Documentation/config/am.txt
>  create mode 100644 Documentation/config/apply.txt
>  create mode 100644 Documentation/config/blame.txt
>  create mode 100644 Documentation/config/branch.txt
>  create mode 100644 Documentation/config/browser.txt
>  create mode 100644 Documentation/config/checkout.txt
>  create mode 100644 Documentation/config/clean.txt
>  create mode 100644 Documentation/config/color.txt
>  create mode 100644 Documentation/config/column.txt
>  create mode 100644 Documentation/config/commit.txt
>  create mode 100644 Documentation/config/completion.txt
>  create mode 100644 Documentation/config/core.txt
>  create mode 100644 Documentation/config/credential.txt
>  rename Documentation/{diff-config.txt => config/diff.txt} (99%)
>  create mode 100644 Documentation/config/difftool.txt
>  create mode 100644 Documentation/config/fastimport.txt
>  rename Documentation/{fetch-config.txt => config/fetch.txt} (100%)
>  create mode 100644 Documentation/config/filter.txt
>  rename Documentation/{fmt-merge-msg-config.txt => config/fmt-merge-msg.txt} (100%)
>  rename Documentation/{format-config.txt => config/format.txt} (100%)
>  create mode 100644 Documentation/config/fsck.txt
>  create mode 100644 Documentation/config/gc.txt
>  rename Documentation/{gitcvs-config.txt => config/gitcvs.txt} (100%)
>  create mode 100644 Documentation/config/gitweb.txt
>  create mode 100644 Documentation/config/gpg.txt
>  create mode 100644 Documentation/config/grep.txt
>  rename Documentation/{gui-config.txt => config/gui.txt} (100%)
>  create mode 100644 Documentation/config/guitool.txt
>  create mode 100644 Documentation/config/help.txt
>  create mode 100644 Documentation/config/http.txt
>  create mode 100644 Documentation/config/i18n.txt
>  create mode 100644 Documentation/config/imap.txt
>  create mode 100644 Documentation/config/index.txt
>  create mode 100644 Documentation/config/init.txt
>  create mode 100644 Documentation/config/instaweb.txt
>  create mode 100644 Documentation/config/interactive.txt
>  create mode 100644 Documentation/config/log.txt
>  create mode 100644 Documentation/config/mailinfo.txt
>  create mode 100644 Documentation/config/mailmap.txt
>  create mode 100644 Documentation/config/man.txt
>  rename Documentation/{merge-config.txt => config/merge.txt} (98%)
>  create mode 100644 Documentation/config/mergetool.txt
>  create mode 100644 Documentation/config/notes.txt
>  create mode 100644 Documentation/config/pack.txt
>  create mode 100644 Documentation/config/pager.txt
>  create mode 100644 Documentation/config/pretty.txt
>  create mode 100644 Documentation/config/protocol.txt
>  rename Documentation/{pull-config.txt => config/pull.txt} (100%)
>  rename Documentation/{push-config.txt => config/push.txt} (100%)
>  rename Documentation/{rebase-config.txt => config/rebase.txt} (100%)
>  rename Documentation/{receive-config.txt => config/receive.txt} (100%)
>  create mode 100644 Documentation/config/remote.txt
>  create mode 100644 Documentation/config/remotes.txt
>  create mode 100644 Documentation/config/repack.txt
>  create mode 100644 Documentation/config/rerere.txt
>  create mode 100644 Documentation/config/reset.txt
>  rename Documentation/{sendemail-config.txt => config/sendemail.txt} (100%)
>  create mode 100644 Documentation/config/sequencer.txt
>  create mode 100644 Documentation/config/showbranch.txt
>  create mode 100644 Documentation/config/splitindex.txt
>  create mode 100644 Documentation/config/ssh.txt
>  create mode 100644 Documentation/config/stash.txt
>  create mode 100644 Documentation/config/status.txt
>  rename Documentation/{submodule-config.txt => config/submodule.txt} (100%)
>  create mode 100644 Documentation/config/tag.txt
>  create mode 100644 Documentation/config/transfer.txt
>  create mode 100644 Documentation/config/uploadarchive.txt
>  create mode 100644 Documentation/config/uploadpack.txt
>  create mode 100644 Documentation/config/url.txt
>  create mode 100644 Documentation/config/user.txt
>  create mode 100644 Documentation/config/versionsort.txt
>  create mode 100644 Documentation/config/web.txt
>  create mode 100644 Documentation/config/worktree.txt
