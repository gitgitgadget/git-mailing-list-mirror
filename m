From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] Documentation/git-checkout: Move `--detach` flag in
 synopsis to correct command
Date: Wed, 11 Sep 2013 12:06:41 -0700
Message-ID: <20130911190641.GF4326@google.com>
References: <CA+DWcQah8Uy41oZXGhP-i+H7JAU_bOWPVt3i79fDnW==FeTJGw@mail.gmail.com>
 <xmqq1u4vuw4y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Benjamin Bergman <ben@benbergman.ca>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 11 21:06:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJpkZ-0003RM-VF
	for gcvg-git-2@plane.gmane.org; Wed, 11 Sep 2013 21:06:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab3IKTGr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Sep 2013 15:06:47 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:53105 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab3IKTGp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Sep 2013 15:06:45 -0400
Received: by mail-pd0-f177.google.com with SMTP id y10so9536578pdj.36
        for <git@vger.kernel.org>; Wed, 11 Sep 2013 12:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wYByLgNyhQJRpfGOq7Hx4tVULBlB41qbWfbjoLPjD/c=;
        b=RW6/+p0A4hQZmDU3KrbB/Y45xwYry/XCA29oHcxD9lZNrG2jd4qZhr5sj3j1cuaFRm
         Jqv8r/2/Rg6rc7VRgf+Z4ohJebTuyXnCPdzoDDhzAoNbaS3zs2gtkCVKslwdgMowKulL
         SIf4Db0lUX6qdPyURGzH/rHvWbIEKQq4XH52woY68cUqa4dnVk+elTCf3ITTVLT/9O8+
         c7ahYuSizwySO44rukfUMAk/soBOEytinNwTdYrqr44Lq9XjutM6TMqNM6g5wmWykmZT
         7EprW3bgMUm8E3lBioGstJV9TmcLGSchXnzVAUPQit2+81VrecY3WTBUDEUTK+3Z9p4S
         /PCQ==
X-Received: by 10.66.171.77 with SMTP id as13mr5381947pac.170.1378926405117;
        Wed, 11 Sep 2013 12:06:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id sz3sm31471058pbc.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 11 Sep 2013 12:06:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqq1u4vuw4y.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234599>

Hi,

Junio C Hamano wrote:

> --- a/Documentation/git-checkout.txt
> +++ b/Documentation/git-checkout.txt
> @@ -9,7 +9,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git checkout' [-q] [-f] [-m] [<branch>]
> -'git checkout' [-q] [-f] [-m] [--detach] [<commit>]
> +'git checkout' [-q] [-f] [-m] --detach [<branch>]
> +'git checkout' [-q] [-f] [-m] [--detach] <commit>
>  'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
>  'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <paths>...
>  'git checkout' [-p|--patch] [<tree-ish>] [--] [<paths>...]
> @@ -62,7 +63,7 @@ that is to say, the branch is not reset/created unless "git checkout" is
>  successful.
>  
>  'git checkout' --detach [<branch>]::
> -'git checkout' <commit>::
> +'git checkout' [--detach] <commit>::

Looks sensible.

[...]
> @@ -71,10 +72,13 @@ successful.
>  	tree will be the state recorded in the commit plus the local
>  	modifications.
>  +
> -Passing `--detach` forces this behavior in the case of a <branch> (without
> -the option, giving a branch name to the command would check out the branch,
> -instead of detaching HEAD at it), or the current commit,
> -if no <branch> is specified.
> +Even though a branch name can be used to name a commit, you have to
> +explicitly say `git checkout --detach <branch>` when you want to
> +detach HEAD at the tip of the branch (`git checkout <branch>` will
> +check out that branch without detaching HEAD).  Omitting <branch>,
> +i.e. `git checkout --detach` detaches HEAD at the tip of the current
> +branch.  When naming the commit in a form other than just a branch
> +name, e.g. `master^0`, `HEAD~4`, `c2f3bf071e`, you can omit --detach.

Hm.  I agree that the old explanation is overly convoluted, but I don't
think the replacement is clear enough yet.  The "Even though a branch
name can be used to name a commit," part forced me to pause for too
long --- why is this telling me that a branch can be used to name a
commit, and in what context?

I think the main problem with the old text is that it tried to say too
much in one sentence.

The explanation lower down of the --detach option does this rather
well:

	--detach
		Rather than checking out a branch to work on it, check
		out a commit for inspection and discardable
		experiments.  This is the default behavior of
		"git checkout <commit>" when <commit> is not a branch
		name.  See the "DETACHED HEAD" section below for
		details.

How about splitting this into multiple paragraphs, like so?  In the
suggestion below I also cleaned up the language a little.

	git checkout --detach [<branch>], git checkout [--detach] <commit>
		Prepare to work on top of <commit>, by detaching [...]

		When the <commit> argument is a branch name, the --detach
		option can be used to detach HEAD at the tip of the
		branch ('git checkout <branch>' would check out that
		branch without detaching HEAD).

		Omitting <branch> detaches HEAD at the tip of the
		current branch.

I'd leave out the last sentence about commits other than branch names,
since it is already implied by the [--detach] in the syntax.

Thanks and hope that helps,
Jonathan
