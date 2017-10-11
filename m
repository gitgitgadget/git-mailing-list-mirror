Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E0B120437
	for <e@80x24.org>; Wed, 11 Oct 2017 03:22:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754285AbdJKDWp (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 23:22:45 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34725 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbdJKDWo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 23:22:44 -0400
Received: by mail-pg0-f68.google.com with SMTP id u27so584694pgn.1
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/+LuQ0Keb2CJdwystDFfJyuqT3Ub1q9l3b48HKEG3KA=;
        b=nmVBwGGTzvc1vUxNMrMLugLXdNVuKi6+q3TMiuVwNipdZGsZ/KEieYDYTtxXeKkbT7
         fXPLI0+am7iULPg748ekVzejJoQA68ChMwuoc+BtpTGwHuy0OP7TfY+VkDll0kRAekWi
         OP3G2oZZmqo2IeTezDIWrhlXcGjepu+kf4chje2w0TgPrlOOG1IJZTXgeHHQqbemp/vV
         MODjN23yj/48um+wmPAYvIpNNkhMry9pSLISd/n5kBIQXCRrsn1ISKjGUhhe7cCLp7Yd
         aMDrXZr2cWxDjxgtUG00TZTQrWfjAXVXrJlzavEB3XFDLr6bHDTxSbeFk+R+vUAge+Z+
         OF0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/+LuQ0Keb2CJdwystDFfJyuqT3Ub1q9l3b48HKEG3KA=;
        b=AGZB72/mVeaB4DB1DLPcL/D080b9tat766IHYQjFywpKPbc0Xhmf79n5NOWbQDelqB
         vn4l03207oBSeV6XUoiDdcLOdenYiXwZdbiYyfxp0kc9frkQDn4bflSvP3TglLl5E7Op
         qq8Q/c/aqTTwRf+y1ozdDiyxpL6dLFVcpDZVWvDdMm3kXSbtpTC9faNrP3OdfVE+hl4B
         yNIqMp5zgxnwIyvCeSGBUBQYJ8eEy2ynbNbtGBO3hLWoRVDJOEox/ZkQdpQvxr7PLHq/
         TgcdeH6gi4JOsZBh2WYI3gwR+NstHaHp85vwYsaj6Sm4HiYnZHQ7tApkr77b3nAuFljz
         B3Ng==
X-Gm-Message-State: AMCzsaX7TXHV5IjaRdCzAlnR90oeB4w8HY1dO7XZUJyjiR4APBVbKAy4
        AQSrlIhb+oDWuwvxPMYDgQI=
X-Google-Smtp-Source: AOwi7QAwJX2zPnjVTeleo3Gjc0Du9NrVqA/3acurXyTPqnmMiZ/S3y24MhHbzjxkNA9db4TYPYUUOA==
X-Received: by 10.98.252.71 with SMTP id e68mr14900341pfh.319.1507692163667;
        Tue, 10 Oct 2017 20:22:43 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:8577:c864:99f:8edc])
        by smtp.gmail.com with ESMTPSA id j6sm21087187pgn.68.2017.10.10.20.22.42
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 10 Oct 2017 20:22:42 -0700 (PDT)
Date:   Tue, 10 Oct 2017 20:22:40 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing list <git@vger.kernel.org>, Kevin Daudt <me@ikke.info>,
        "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: [PATCH] checkout doc: clarify command line args for "checkout
 paths" mode
Message-ID: <20171011032240.GZ19555@aiede.mtv.corp.google.com>
References: <alpine.LFD.2.21.1709300523190.27819@localhost.localdomain>
 <20170930143258.GA20886@alpha.vpn.ikke.info>
 <alpine.LFD.2.21.1709301800060.7869@localhost.localdomain>
 <xmqqo9prv86l.fsf@gitster.mtv.corp.google.com>
 <alpine.LFD.2.21.1710010603340.17338@localhost.localdomain>
 <xmqqtvzis87i.fsf@gitster.mtv.corp.google.com>
 <xmqqefqao1av.fsf_-_@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqefqao1av.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:

[...]
> The source of the confusion is that -p(atch) is described as if it
> is just another "optional" part and its description is lumped
> together with the non patch mode, even though the actual end user
> experience is vastly different.

Makes sense.  This should have been done as part of b831deda
(2010-06-01), but better late than never.

Let's see how the patch goes...

[...]
>  Documentation/git-checkout.txt | 32 +++++++++++++++++---------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
> index d6399c0af8..8e77a9de49 100644
> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -13,7 +13,8 @@ SYNOPSIS
>  'git checkout' [-q] [-f] [-m] [--detach] <commit>
>  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
> +'git checkout' [<tree-ish>] [--] <pathspec>...
> -'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
> +'git checkout' (-p|--patch) [<tree-ish>] [--] [<paths>...]

This file is inconsistent about <commit> versus <commit-ish>, <paths>
versus <pathspec>, etc.

On the subject of <commit> versus <commit-ish>, nowadays <commit> is
almost always preferable.  Git commands consistently accept a tag
pointing to a commit where a commit is expected, so emphasizing that
feature by calling it a commit-ish only adds distraction.  That's not
what this patch is about, though.

Even for this particular form, the current file is inconsistent about
whether to call the arguments '<paths>...' or '<pathspec>...'.
"<paths>..." is even more strange when I think about it for a moment,
since it is the plural of the plural of path --- i.e., it implies that
each argument names multiple paths.  Why does this patch use
<pathspec> for the --no-patch case and <paths> for the --patch case?


>  DESCRIPTION
>  -----------
> @@ -78,20 +79,13 @@ be used to detach HEAD at the tip of the branch (`git checkout
>  +
>  Omitting <branch> detaches HEAD at the tip of the current branch.
>  
> +'git checkout' [<tree-ish>] [--] <pathspec>...::
> +	Restore modified or deleted paths in the working tree by
> +	replacing with their original contents from the index, or
> +	the contents from a named <tree-ish> (most often a

This sentence is hard to read:

- "Restore ... in" reads oddly, as though this is an art conservation
  project that takes place in the working tree.  Is the intent that
  the command will bring the content of those paths back to the
  working tree, or something else?

- "replacing with" reads a little briskly and informally.  In this
  context, "replacing them with" will work better.

- "their original contents from" also reads oddly.  "Their original
  content from" would be fine, meaning their original content as
  obtained from.  I was tempted to read this as "The original contents
  of", but that was a misreading.

- Similarly, "the contents from" perhaps should be "the content of".

Stepping back, what problem is this solving in the original text?
It said

	When <paths> or --patch are given, git checkout does *not*
	switch branches. It updates the named paths in the working
	tree from the index file or from a named <tree-ish> (most
	often a commit). In this case, the -b and --track options are
	meaningless and giving either of them results in an error. The
	<tree-ish> argument can be used to specify a specific tree-ish
	(i.e. commit, tag or tree) to update the index for the given
	paths before updating the working tree.

The "or --patch" would have to go, of course.  Is the problem that
the description focuses too much on what this form does not do?
To fix that, it could say

	Replace matching paths in the working tree with content
	from the index or the named tree (most often a commit).  The
	<tree-ish> argument can be used to specify a specific tree,
	commit, or tag that will be used to update the entries for
	matching paths in the index before updating the working tree.

One thing that doesn't tell is what happens to files that are present
in the worktree but deleted in the index or the named tree.  Does "git
checkout" delete them?  I remember wishing that it would but don't
remember whether it does, so it's probably worth mentioning the
manpage giving an answer.

... aha, now I see the next paragraph where this text came from.  I
still think I like my example text based on the first paragraph
better. :)

[...]
> @@ -101,6 +95,14 @@ specific side of the merge can be checked out of the index by
>  using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
>  file can be discarded to re-create the original conflicted merge result.
>  
> +'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
> +	This is similar to the "check out paths to the working tree
> +	from either the index or from a tree-ish" mode described
> +	above, but lets you use the interactive interface to show
> +	the "diff" output and choose which hunks to use in the
> +	result.

s/use/apply/, perhaps.

The options section explains --patch again.  Maybe that should point
back to here to avoid some duplication.

Thanks,
Jonathan
