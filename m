From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: 'git add --all' can remove files
Date: Sun, 06 Dec 2009 13:14:33 -0800
Message-ID: <7vmy1vg5za.fsf@alter.siamese.dyndns.org>
References: <4B1BF2D2.8000506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 22:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHORK-0000pj-UO
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 22:14:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934212AbZLFVOf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 16:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934195AbZLFVOe
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 16:14:34 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:33672 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933833AbZLFVOe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 16:14:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 45A9B858E5;
	Sun,  6 Dec 2009 16:14:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vo1+nwYqMPMT
	tY0EQ1m2hKqUGSo=; b=tCChgNvoNosbZqqTkWhAcj7bMLcBBzDkfuxiNTxik/on
	9FXzrtPTz7pk9azzowDS4AL0USbd/RnSeCmcEMYI8KKKnDQAO7hRm9Zug6M+T91r
	5fP3Ya7wG0/33gSWvXO3zWudMjBXF1xCDAUOL/ti2mhwagpLlrRO5bOIw60muT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ozNrDp
	kgoBwpsrpEF9Bo6Lu1fDX5PpfGWhgkHMmO3IaFRzzlReZp7wb3SHeywEEmvud3u+
	5loYbmz0YACFqBIqpE3wexqAGXalRlqN4VO3yKO5rdPSvPv7gnO9ff8pepz8aQpE
	sdUb5W6BzSkJFv5qNFMYY0v3Kx/LA9vNxkIp8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 26053858E4;
	Sun,  6 Dec 2009 16:14:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6218D858E3; Sun,  6 Dec
 2009 16:14:35 -0500 (EST)
In-Reply-To: <4B1BF2D2.8000506@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Sun\, 06 Dec 2009 19\:07\:14 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5C77685E-E2AC-11DE-83CD-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134689>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index e93e606..b7e8aa2 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -16,6 +16,8 @@ DESCRIPTION
>  -----------
>  This command adds the current content of new or modified files to th=
e
>  index, thus staging that content for inclusion in the next commit.
> +(Given the `--all` option, the `git add` command will also remove fi=
les
> +from the index that are no longer present in the working tree.)

The first paragraph says what "git add" does in general (does "somethin=
g"
to the index) and continues to the second paragraph that describes what=
 an
index is.

It is a good point that you noticed that the existing description of 'd=
oes
"something" to the index' covers only the "add as an entirety" and not =
the
whole range of what "git add" can be used for.  One thing that is missi=
ng
is a removal, and "-A" is one of the two options that lets you do so.

But "-u" is to match the index with the work tree contents (it does not
add untracked-so-far paths).  At least, "Given the `--all` option," par=
t
needs to be rethought.

More importantly, 'does "something" to the index' is not limited to the
"add whole" and "remove path".  Perhaps we would want to update the fir=
st
paragraph like this to cover partial add while we are at it.

	This command updates the index using the current content found in
        the work tree, to prepare the content staged for the next commi=
t.
        It typically adds the current content of existing paths as a wh=
ole
        but with some options, it can also be used to add a content wit=
h
        only part of the changes made to the work tree files applied, o=
r
        remove paths that do not exist in the work tree anymore.

That way we also cover what "add -p" lets you do.

> ++
> +This option is especially useful after running the `rsync` command w=
ith
> +the working tree as the target to sync the index with the working tr=
ee.

I do not think mentioning `rsync` like this is helpful; I actually thin=
k
this clutteres the document and nudges people in a wrong direction at t=
he
same time.  You usually don't overwrite your source tree you already ha=
ve
under control with rsync.  Use cases that do not use "git" as a SCM but=
 as
something else do have a valid reason to use rsync, but "git add -A" be=
ing
useful for that use case is a side effect, and I do not think we should
hint people who use "git" as a SCM into that direction, by casually
mentioning the use of `rsync` like the above as if it is a common and
encouraged thing to update your work tree from sideways.

> diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
> index 5afb1e7..b4dff5b 100644
> --- a/Documentation/git-rm.txt
> +++ b/Documentation/git-rm.txt
> @@ -81,6 +81,10 @@ two directories `d` and `d2`, there is a differenc=
e between
>  using `git rm \'d\*\'` and `git rm \'d/\*\'`, as the former will
>  also remove all of directory `d2`.
> =20
> +To automatically remove all files from the index that are no longer
> +present in the working tree, see the `--all` option for
> +linkgit:git-add[1].

I think this change is a lot more harmful than being helpful.  Many laz=
y
readers would _not_ read "git add --help" but would think "git add -A"
would "automatically remove all files from the index that are no longer
present".  But "add -A" does a lot more than:

    git diff --name-only --diff-filter=3DD -z | xargs -0 rm -f

So overall I am happy with the issue you identified, but not very happy
with the proposed solution.
