Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B238E1FAE2
	for <e@80x24.org>; Thu, 22 Mar 2018 20:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbeCVUqn (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 16:46:43 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37014 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeCVUqm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 16:46:42 -0400
Received: by mail-wm0-f65.google.com with SMTP id 139so18645712wmn.2
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ibd2CPCLvp+I3Woyq8jyi8sNwhzFTnAWHyc2TnGPKDg=;
        b=ZhylNDF5g2M4VYvBNDxnjAGq9LVM1za2RSEZlr/NSSViNBJLRUUx3MkTgYdrAKawVT
         6tyDULtHGliJZBzSkD0A6+A/c/rYrpJ7DRyLotKLi3FG2lN3LvqB17imLTiABr/B4zta
         N5p3EhmEsiZ35ymJJHKpLlRao6E7ZwqyBV+hArE0viyIdmTZ7GbNZoM1Pz0wUmxSZxt/
         JhQ6MtFl2s42E8wZOMDCtIqubo7SG/mTWVrhXh/L2QUFoTFAe389YC25hdgn139H8uFE
         TOsDdgdboVpHfXgXcLIdYELDVNfSIFz8cOl2xCW0SLxZNWcOzDoDw6mlv+S7Mx/NBEPV
         RRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ibd2CPCLvp+I3Woyq8jyi8sNwhzFTnAWHyc2TnGPKDg=;
        b=e7AjHdRuAS4xg6yRjUEDkn5NI7hfgfnc9ROkN+n2RvVHz/vCRmD7u6VD8RfHh9vGGa
         IubvYMbw4ZQ9ixD/RDUxXKuV8o1HTYMcjaYImJDAJCsZ4tBQSjY++Xfkfqbycd4taKCU
         MG/WJD3A2a5E7hxdvHDmclvj3tbQoLGVRO9VXuEOrwlqtY77LyVjoZdgIsNLOQvvq2hB
         pU21t5OOCpGqC05HGylUiZdxERQPGsAwgmNF/TG8xpZ6FwjXzrRiqLFiAk/H86/7J9y9
         5kIXLRaWBACs+L1gPcVTFqZHy49skE0YTp6OuRc/AEEFBPtAaVrDvr1+tczidVObU8cq
         MBaA==
X-Gm-Message-State: AElRT7G1mI7ONhcGrmGbpc4Fam7sFWFyIUs4AZOLkVRLzLy4YHESgjOn
        KHQh3dejDIQ5GanOTHK2a9Y=
X-Google-Smtp-Source: AG47ELtm01GeLsyqldBr52MFpyglugt30r/hrC+vC/uufnr06f4sEIUF83ILzDAHDvGRsUNGmt0fbQ==
X-Received: by 10.28.91.65 with SMTP id p62mr1931562wmb.140.1521751600689;
        Thu, 22 Mar 2018 13:46:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id n9sm8270071wri.48.2018.03.22.13.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Mar 2018 13:46:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH v3.1 2/9 2/2] rebase-interactive: Do not automatically run code
References: <CAKk8isoL--f1gt_p5XZ99ybN+xts=0_AKBo52Ej=n3SMPoMq3A@mail.gmail.com>
        <7ce3cfef9ff3ab97ac8292fae94a0024a1d85505.1521748846.git.wink@saville.com>
Date:   Thu, 22 Mar 2018 13:46:36 -0700
In-Reply-To: <7ce3cfef9ff3ab97ac8292fae94a0024a1d85505.1521748846.git.wink@saville.com>
        (Wink Saville's message of "Thu, 22 Mar 2018 13:03:24 -0700")
Message-ID: <xmqqefkbltxv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> At Junio's suggestion have git-rebase--am and git-rebase--merge work the
> same way as git-rebase--interactive. This makes the code more consistent.

I mumbled about making git_rebase__$type functions for all $type in
my previous response, but that was done without even looking at
git-rebase--$type.sh scriptlets.  It seems that they all shared the
same structure (i.e. define git_rebase__$type function and then at
the end clla it) and were consistent already.  It was the v3 that
changed the calling convention only for interactive, which made it
inconsistent.  If you are making git-rebase.sh call the helper shell
function for all backend $type, you are keeping the existing
consistency.

This is no longer about "interactive" alone, though, and need to be
retitled ;-)

> Signed-off-by: Wink Saville <wink@saville.com>
> ---
>  git-rebase--am.sh          | 17 ++++++-----------
>  git-rebase--interactive.sh |  8 +++++++-
>  git-rebase--merge.sh       | 17 ++++++-----------
>  git-rebase.sh              | 13 ++++---------
>  4 files changed, 23 insertions(+), 32 deletions(-)
>
> diff --git a/git-rebase--am.sh b/git-rebase--am.sh
> index be3f06892..47dc69ed9 100644
> --- a/git-rebase--am.sh
> +++ b/git-rebase--am.sh
> @@ -4,17 +4,14 @@
>  # Copyright (c) 2010 Junio C Hamano.
>  #
>  
> +# The whole contents of this file is loaded by dot-sourcing it from
> +# inside another shell function, hence no shebang on the first line
> +# and then the caller invokes git_rebase__am.

Is this comment necessary?

> +# Previously this file was sourced and it called itself to get this
> +# was to get around a bug in older (9.x) versions of FreeBSD.

ECANTPARSE.  But this probably is no longer needed here, even though
it may make sense to explain why this comment is no longer relevant
in the log message.  E.g.

	The backend scriptlets for "git rebase" are structured in a
	bit unusual way for historical reasons.  Originally, it was
	designed in such a way that dot-sourcing them from "git
	rebase" would be sufficient to invoke the specific backend.
	When it was discovered that some shell implementations
	(e.g. FreeBSD 9.x) misbehaved by exiting when "return" is
	executed at the top level of a dot-sourced script (the
	original was expecting that the control returns to the next
	command in "git rebase" after dot-sourcing the scriptlet),
	the whole body of git-rebase--$backend.sh was made into a
	shell function git_rebase__$backend and then the scriptlet
        was made to call this function at the end as a workaround.

	Move the call to "git rebase" side, instead of at the end of
	each scriptlet.  This would give us a more normal
	arrangement where a function library lives in a scriptlet
	that is dot-sourced, and then these helper functions are
	called by the script that dot-sourced the scriptlet.

	While at it, remove the large comment that explains why this
	rather unusual structure was used from these scriptlets.

or something like that in the log message, and then we can get rid
of these in-code comments, I would think.

>  git_rebase__am () {
> -
> +echo "git_rebase_am:+" 1>&5

debuggin'?  I see similar stuff left in other parts (snipped) of
this patch.
