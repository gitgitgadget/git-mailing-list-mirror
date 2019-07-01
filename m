Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48651F461
	for <e@80x24.org>; Mon,  1 Jul 2019 17:46:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbfGARqF (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 13:46:05 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42944 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbfGARqE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 13:46:04 -0400
Received: by mail-vk1-f194.google.com with SMTP id 130so2876581vkn.9
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTYhMI33zt6bR1pRb58pdOaCOFYl8G8oALuwsz02tL0=;
        b=ADYaP6uYUuO5bjyFzfW92oz9UTs6d5UA4gKUOPqadOnDpmduohXLArFqwzEMWpZKAo
         4HoMkknnv/I6ATUStlfnk18VuLlERxHEDLQMm5hHGN3f25a9v/7iXqYi8ZA/DIjFqd/8
         PNUD/uX1gIlGzA1noUPXkCILZ8ypYavUHqzqSIPFpNusGe3NKV/92N07JivaY/397Stg
         qy0xjscRai3MdVJTqDwrO0Hpphcqp+VVLQCID67zkKHZNUOFfI/Kc4xf3BXpf9Eom5cq
         mk52cp2IS4UYp3I8n+isyvdNIQszLvFgSWTmhmAEtTY8azg4zL+fTY5puLIF3AEYYVN8
         ojjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTYhMI33zt6bR1pRb58pdOaCOFYl8G8oALuwsz02tL0=;
        b=CUoRv1oSD3N4Cor/AxVifb2uWsjBh4yz84bXB5kV+9kiPZfE59uRAfrP5mwDxORRkA
         0aUkGH49HMBBlci1oMve/wIvfKpgeYXoh5XEPdjstZjhE2lyM+yE+p1QsFYx8aTGAOK6
         8wjWFWrAXrJqaCgi8SbSJk1B3ouURHgzr2Nt7dM5tjWfjTcfTOQC58QZLY+m3XHneYU0
         bVVdVM/g767H/yew7y8FXEDL2IuJiuk8z/e+WFCUC8r2spNDwMrWL2wl9UvJAUO4NDPL
         0u0NaXiyRFygwhXPO+zCaBMsHJdIC3cX5DpsNGUoXNb87JgIYPbEvtmOGQ4urtEZoVn2
         czSw==
X-Gm-Message-State: APjAAAXJJe57Dlw9U41iVh9wiFzzu5Ok+6Ozx7mL+IJpBaxCGT/Z9+uD
        5MQ6QOwgcNLHAcPd8Y+84E198IHk5qrFr+euYDqc082Xkoo=
X-Google-Smtp-Source: APXvYqx9C3L6CDOTJaBGPg5RNohiB/VV4P/NrZrdpVQQElibFYrkP/SKQ/apvOj73A2qxfZUFrn8XgacFyQ2EboGDTk=
X-Received: by 2002:a1f:8513:: with SMTP id h19mr8572791vkd.92.1562003163571;
 Mon, 01 Jul 2019 10:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <95EF0665-9882-4707-BB6A-94182C01BE91@gmail.com>
 <CABPp-BE8um5g98jqWawsuG2dAvO6AZcR54vrRzAkJbq+L3K6Zw@mail.gmail.com>
 <20190624185835.GA11720@sigill.intra.peff.net> <25624E1D-55F1-466D-92E0-F06C1909F920@gmail.com>
 <5b00da7c-6836-0e61-8262-a9035126b658@kdbg.org>
In-Reply-To: <5b00da7c-6836-0e61-8262-a9035126b658@kdbg.org>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 1 Jul 2019 11:45:52 -0600
Message-ID: <CABPp-BE0wbgn1OaEH-6TgBaEDrab9C-ZiQLbT9sS8PTf8E=CNQ@mail.gmail.com>
Subject: Re: [BUG] Symbolic links break "git fast-export"?
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Jeff King <peff@peff.net>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 30, 2019 at 12:28 PM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 30.06.19 um 15:05 schrieb Lars Schneider:
> >> On Jun 24, 2019, at 11:58 AM, Jeff King <peff@peff.net> wrote:
> >> You'd have to split the renames into separate delete/adds, since they
> >> can have a circular dependency. E.g. renaming "foo" to "bar" and "bar"
> >> to "foo", you must remove "foo" and "bar" both, and then add them back
> >> in.
> >
> > @peff: Can you give me a hint how one would perform this circular
> > dependency in a single commit? I try to write a test case for this.
>
> git mv Makefile foo
> git mv COPYING Makefile
> git mv foo COPYING
> git diff -B HEAD
>
> -- Hannes

Interestingly, fast-export has special code to handle cases like this;
possibly due to the understanding of how all
filemodify/filedelete/filerename commands take effect immediately (see
below for more on that).  If I make the above changes in git.git and
commit them, then:

$ git diff --name-status -B HEAD~1 HEAD
R100    Makefile        COPYING
R100    COPYING Makefile

BUT:

$ git fast-export -B -M --no-data HEAD~2..HEAD | tail -n 10
commit refs/heads/master
mark :7
author Elijah Newren <newren@gmail.com> 1562000065 -0600
committer Elijah Newren <newren@gmail.com> 1562000065 -0600
data 8
Testing
from :6
R COPYING Makefile
M 100644 8a7e2353520ddd7e0c8074d2b32d0441d97c1597 COPYING

I.e. fast-export breaks the rename and translates it into a modify
instead.  This comes from here:

        case DIFF_STATUS_COPIED:
        case DIFF_STATUS_RENAMED:
                /*
                 * If a change in the file corresponding to ospec->path
                 * has been observed, we cannot trust its contents
                 * because the diff is calculated based on the prior
                 * contents, not the current contents.  So, declare a
                 * copy or rename only if there was no change observed.
                 */
                if (!string_list_has_string(changed, ospec->path)) {
                        <snipped code for handling rename/copy>
                }
                /* fallthrough */
        case DIFF_STATUS_TYPE_CHANGED:
        case DIFF_STATUS_MODIFIED:
        case DIFF_STATUS_ADDED:

There is a question of whether fast-import should try to handle
different exporters that aren't as careful; e.g. if one gets a stream
like:

commit refs/heads/master
mark :4
author Me My <self@and.eye> 110000000 -0700
committer Me My <self@and.eye> 110000000 -0700
data 11
correction
R letters numbers
R numbers letters

Should git-fast-import attempt to divine the user's intent to swap
these two files (though it's not clear if that is the intent; see
below), or would that violate the documented behavior:

           A filerename command takes effect immediately. Once the source
           location has been renamed to the destination any future commands
           applied to the source location will create new files there and not
           impact the destination of the rename.

(I'm pretty sure Shawn would have said the latter; see e.g.
https://public-inbox.org/git/20100706193455.GA19476@spearce.org/ and
the follow-ups.)  I think the view of "immediately taking effect"
implies that this is a rename of 'letters' to 'numbers' which deletes
'numbers', and that the subsequent entry just renames the file back,
making it an expensive almost no-op; almost because it has the
side-effect of deleting the original 'numbers' file.  This is
certainly what fast-import does right now.

Elijah
