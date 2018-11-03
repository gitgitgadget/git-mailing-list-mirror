Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 038691F453
	for <e@80x24.org>; Sat,  3 Nov 2018 15:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbeKDAql (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 20:46:41 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:53861 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbeKDAql (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 20:46:41 -0400
Received: by mail-wm1-f44.google.com with SMTP id v24-v6so4381984wmh.3
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 08:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1XmjaqFFj23aVEuHo6p85RsTRDFb7khkr6CkkLo1YGw=;
        b=pubBugIrlRflQ30CMhCoA0vcRdbx2anNsPTydBHhD3ATeBgPD4C6JHnWkd+gbF2pRv
         mZZstEMNg/AmrNmAYkconBWjHmW7DE5Y5zufn1K0bUZLyq225A951EtI2MHAebi59Rt5
         uV2GJY2UL6+26pWBnBibteYpbKmqydeu7OFYIYmJOkzwV22opeMmoyN0WuNsBHcB8p7E
         KpoZ0GgAtTXVJsmg0vFgohvsVBfodiSKPif6SpXMirhKcuLaFm7DQluvfdNwmbFFuBnH
         ZIDUjDqxmAroySjKqwecH2Nt7tHhT0evtWRciwFgm19ebROJPflm43v7rQZo5EsaifcW
         BvyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1XmjaqFFj23aVEuHo6p85RsTRDFb7khkr6CkkLo1YGw=;
        b=SZHfxamToa0SV6OwmammLk1TFMairPcCiKrMIJL3FUD+JY5oBSHjNvso/ylb7/noLx
         2l1Lhyrj7jxeTskdq05E0PrsAbXll2QbLHMcywsllifrOvr6cgR27x7lgimCzwwuD7IQ
         ELg05b0MDynp+4aHz1nLnRlj2ujds92lIH1FV0HMsW0+yA/3clvc+1TXE26BiziNNHNv
         yO+W9cmrKsh6CwaKJRScFpKlUkLMIpfV4z2Y1KulhPq40oVxHcNRx3zb2MvzAiIW76Lq
         dVrZJO/YhtlZP+H81gqMJujTcF0yVzeWtATwjItfY4F+is6aQLbmyIR/xGECeybHgap0
         qmCQ==
X-Gm-Message-State: AGRZ1gKOS82E2LKR2ORXSwhqbKgBQv+AsrJpZM4KK8GytFgNmOcxGFLR
        ql9nqzP1SVpXnEqyYxUlrjBRccOK
X-Google-Smtp-Source: AJdET5fFeSH8f5306WwzM3medHaToUrlf260qv3YDv0cc2+EA1oIiJyC0PN2nzdi9sqT81MHC6+IWA==
X-Received: by 2002:a1c:5689:: with SMTP id k131-v6mr1175826wmb.119.1541259300851;
        Sat, 03 Nov 2018 08:35:00 -0700 (PDT)
Received: from localhost ([2.25.81.124])
        by smtp.gmail.com with ESMTPSA id x197-v6sm37691977wme.15.2018.11.03.08.34.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 08:34:59 -0700 (PDT)
Date:   Sat, 3 Nov 2018 15:34:58 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     "Quinn, David" <David.Quinn@cmegroup.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Failed stash caused untracked changes to be lost
Message-ID: <20181103153458.GG4883@hank.intra.tgummerer.com>
References: <1540292560837.94684@cmegroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540292560837.94684@cmegroup.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23, Quinn, David wrote:
> 
> Issue: While running a git stash command including the '-u' flag to include untracked files, the command failed due to arguments in the incorrect order. After this untracked files the were present had been removed and permanently lost.

Thanks for your report (and sorry for the late reply)!

I believe this (somewhat) fixed in 833622a945 ("stash push: avoid
printing errors", 2018-03-19), which was first included in Git 2.18.
Your message doesn't state which version of Git you encountered the
bug, but I'm going to assume with something below 2.18 (For future
reference, please include the version of Git in bug reports, or even
better test with the latest version of Git, as the bug may have been
fixed in the meantime).

Now I'm saying somewhat fixed above, because we still create an stash
if a pathspec that doesn't match any files is passed to the command,
but then don't remove anything from the working tree, which is a bit
confusing.

I think the right solution here would be to error out early if we were
given a pathspec that doesn't match anything.  I'll look into that,
unless you're interested in giving it a try? :)

> Environment: Windows 10, Powershell w/ PoshGit
> 
> 
> State before running command: 9 Modified files, 2 (new) untracked files
> 
> Note: I only wanted to commit some of the modified files (essentially all the files/changes I wanted to commit were in one directory)
> 
> Actual command run:  git stash push -u -- Directory/To/Files/* -m "My Message"
> 
> Returned:
> 
>     Saved working directory and index state WIP on [BranchName]: [Commit hash] [Commit Message]
>     fatal: pathspec '-m' did not match any files
>     error: unrecognized input
> 
> State after Command ran: 9 Modifed files, 0 untracked files
> 
> 
> The command I should have ran should have been
> 
>     git stash push -u -m "My Message"? -- Directory/To/Files/*
> 
> 
> I have found the stash that was created by running this command:
> 
>     gitk --all $(git fsck --no-reflog | Select-String "(dangling commit )(.*)" | %{ $_.Line.Split(' ')[2] })
> ?
> and searching for the commit number that was returned from the original (paritally failed??) stash command. However there is nothing in that stash. It is empty.
> 
> 
> 
> I think that the fact my untracked files were lost is not correct behaviour and hence why I'm filing this bug report
> 
> 
> 
> 
> ________________________________
> NOTICE: This message, and any attachments, are for the intended recipient(s) only, may contain information that is privileged, confidential and/or proprietary and subject to important terms and conditions available at E-Communication Disclaimer<http://www.cmegroup.com/tools-information/communications/e-communication-disclaimer.html>. If you are not the intended recipient, please delete this message. CME Group and its subsidiaries reserve the right to monitor all email communications that occur on CME Group information systems.
