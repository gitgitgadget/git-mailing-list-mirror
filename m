From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] docs: add filter-branch note about The BFG
Date: Tue, 17 Dec 2013 10:13:42 -0800
Message-ID: <xmqqk3f3mjl5.fsf@gitster.dls.corp.google.com>
References: <1387277599-69719-1-git-send-email-roberto.tyley@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, peff@peff.net, tr@thomasrast.ch
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 17 19:46:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vszf7-00054W-8M
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 19:46:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756147Ab3LQSq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 13:46:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46718 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754413Ab3LQSNr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 13:13:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 483F65B456;
	Tue, 17 Dec 2013 13:13:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZnN48KIBiGplPoBEPZ5ZFQNxtNI=; b=I6kFp1
	SKg5+r8eUtX/4TEYxBJfY3u3j91R0os6rW5faXyXECSwWu5W7whnN8S/mBGj1ZvB
	PmgI8QCQ08JU+i6RC/GKDQ3MtdesEfz8wAZNeLi2kD2WHRK19c9u71gJslwveuFJ
	cZ/8XQLcsvVIjj5XYZdw8bmc+iZLi9uqMplBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fdoYxvL/gn1uejJPUz0QcAaT6siOaalJ
	vB8y/Eijb0+WJsqXrq/zOkakJ9bu/ilZrPehaB4LDNTkW5rlB9DsZH1FdVd1oE5x
	6lqyMhkiuuhOePvyLzCWeNuEHreYMj9IDZcS3tamrDjP4DqZFOkRh+M/2Nptk43H
	aJBgJ6Xos9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357635B455;
	Tue, 17 Dec 2013 13:13:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5136E5B454;
	Tue, 17 Dec 2013 13:13:45 -0500 (EST)
In-Reply-To: <1387277599-69719-1-git-send-email-roberto.tyley@gmail.com>
	(Roberto Tyley's message of "Tue, 17 Dec 2013 10:53:19 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7C389BE-6746-11E3-A5D7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239397>

Roberto Tyley <roberto.tyley@gmail.com> writes:

> The BFG is a tool specifically designed for the task of removing
> unwanted data from Git repository history - a common use-case for which
> git-filter-branch has been the traditional workhorse.
>
> It's beneficial to let users know that filter-branch has an alternative
> here:
>
> * speed : The BFG is 10-50x faster
>   http://rtyley.github.io/bfg-repo-cleaner/#speed
> * complexity of configuration : filter-branch is a very flexible tool,
>   but demands very careful usage in order to get the desired results
>   http://rtyley.github.io/bfg-repo-cleaner/#examples
>
> Obviously, filter-branch has it's advantages too - it permits very
> complex rewrites, and doesn't require a JVM - but for the common
> use-case of deleting unwanted data, it's helpful to users to be aware
> that an alternative exists.
>
> The BFG was released under the GPL in February 2013, and has since seen
> widespread production use (The Guardian, RedHat, Google, UK Government
> Digital Service), been tested against large repos (~300K commits, ~5GB
> packfiles) and received significant positive feedback from users:
>
> http://rtyley.github.io/bfg-repo-cleaner/#feedback
>
> Signed-off-by: Roberto Tyley <roberto.tyley@gmail.com>
> ---
>  Documentation/git-filter-branch.txt | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
> index e4c8e82..918e965 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -18,6 +18,12 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> +
> +NOTE: For simply removing unwanted data from repository history, you may
> +want to use link:http://rtyley.github.io/bfg-repo-cleaner/[The BFG Repo-Cleaner]
> +instead - it's generally faster and simpler for eliminating large files
> +or private data.
> +

My understanding is that the primary speed up of BFG comes from the
design decision it made to fitler each blob only once, unlike
filter-branch that allows you to (and forces you to) decide how the
same blob is filtered depending on the places it appears in space
(i.e. the path in the project's directory hierarchy) and time
(i.e. the commit it appears in).  For "removing unwanted data", I
think nobody needs the flexibility to filter differently depending
on the context, an it is a good idea to refer those with such need
to BFG.

Having said that, "You may want to use ..." without giving the
reason why we recommend the other tool leaves the reader wondering
what the pros and cons are, and why git-filter-branch exists if BFG
is the first thing its document recommends even before it describes
what git-filter-branch is and does.  "You may want to check ..."
might be slightly better, but probably by not that much improvement.

Rewriting "it's generally faster ..."  part to give a bit more info
to allow readers decide the pros and cons themselves may be needed.

>  Lets you rewrite Git revision history by rewriting the branches mentioned
>  in the <rev-list options>, applying custom filters on each revision.
>  Those filters can modify each tree (e.g. removing a file or running
> @@ -393,7 +399,7 @@ git filter-branch --index-filter \
>  Checklist for Shrinking a Repository
>  ------------------------------------
>  
> -git-filter-branch is often used to get rid of a subset of files,
> +git-filter-branch can be used to get rid of a subset of files,
>  usually with some combination of `--index-filter` and
>  `--subdirectory-filter`.  People expect the resulting repository to
>  be smaller than the original, but you need a few more steps to
> @@ -429,6 +435,12 @@ warned.
>    (or if your git-gc is not new enough to support arguments to
>    `--prune`, use `git repack -ad; git prune` instead).
>  
> +SEE ALSO
> +--------
> +link:http://rtyley.github.io/bfg-repo-cleaner/[The BFG Repo-Cleaner]
> +- a tool specifically designed for removing unwanted data from Git
> +repository history.
> +
>  GIT
>  ---
>  Part of the linkgit:git[1] suite
