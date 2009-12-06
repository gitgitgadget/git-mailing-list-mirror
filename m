From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Documentation: 'git add -A' can remove files
Date: Sun, 06 Dec 2009 15:31:25 -0800
Message-ID: <7vr5r7el2q.fsf@alter.siamese.dyndns.org>
References: <4B1C384A.8000106@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Bj=C3=B6rn?= Gustavsson <bgustavsson@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 00:31:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHQZq-0008LT-2p
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 00:31:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757887AbZLFXba convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Dec 2009 18:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757847AbZLFXb3
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 18:31:29 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757815AbZLFXb3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Dec 2009 18:31:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAD50852D4;
	Sun,  6 Dec 2009 18:31:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ycEm6fEc5eku
	B5JU7uGrTr6zUAE=; b=dV15a7lj1HkXU/0czhsPN/qHL+4mbCLpVdjke5Ildqwv
	6yn+fyDvXb4TlmGHCM6xb+za64bo+5XRu13mOduWxFmPwegrH3ur31fLCZAjQuI8
	X4MDrnYwNhMyPqkQSfi2jTe+4PIC6HLHnYLMp6Myom8eiPGTdJ6EeQbJz8e183E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=H0QEFU
	WS3DrN4iZlG+0wgY99ENTzvWDhKCIs0EVChxGRSzybDC7RHett6xPdIavnYHZ0SQ
	yGbuq0fvUeyr4/DMlmKMThyJzvexfizVR11eKgKAX2J1FcTVj8/o7r8vfBPq+GeP
	0uIuxr7B2cZroF+b05QBQ2yXjjV131T+dmkHs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B68DA852D3;
	Sun,  6 Dec 2009 18:31:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 10045852D2; Sun,  6 Dec
 2009 18:31:26 -0500 (EST)
In-Reply-To: <4B1C384A.8000106@gmail.com> (=?utf-8?Q?=22Bj=C3=B6rn?=
 Gustavsson"'s message of "Mon\, 07 Dec 2009 00\:03\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7C24837C-E2BF-11DE-8A76-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134693>

Bj=C3=B6rn Gustavsson <bgustavsson@gmail.com> writes:

> Document that 'git add -A/--all' can remove files no longer
> present in the working tree from the index, and also document the
> behavior with and without path arguments on the command line.

Thanks.

> +This command updates the index using the current content found in
> +the working tree, to prepare the content staged for the next commit.
> +It typically adds the current content of existing paths as a whole,
> +but with some options it can also be used to add content with
> +only part of the changes made to the working tree files applied, or
> +remove paths that do not exist in the work tree anymore.

You probably want to change the last one also to "working tree"?

I often write this as "work tree" without thinking too much about "work=
"
vs "working", but if anybody asks me, I prefer the former because it is
shorter and because it is more consistent with the way how names of the
environment variable GIT_WORK_TREE and the configuration variable
core.worktree are spelled.  I personally am OK with either word used in
the descriptive text, as there is no room for confusion.

But it would be better to be consistent in a single paragraph.

>  -A::
>  --all::
> -	Update files that git already knows about (same as '\--update')
> -	and add all untracked files that are not ignored by '.gitignore'
> -	mechanism.
> -
> +	Update files that git already knows about (same as '\--update'),
> +	add all untracked files that are not ignored by the '.gitignore'
> +	mechanism and remove files from the index that are no longer
> +	present in the working tree.
> ++
> +If no paths are given on the command line, `git add -A` will operate
> +on the current directory and its subdirectories. If paths are given,
> +it will operate on those paths and their subdirectories.

The first line of the existing description for "--all", by saying "same=
 as
--update", refers to the first sentence of the corresponding entry for
"update", which says:

    -u::
    --update::
            Update only files that git already knows about, staging mod=
ified
            content for commit and marking deleted files for removal. T=
his
            is similar
            to what "git commit -a" does in preparation for making a co=
mmit,
            except that the update is limited to paths specified on the
            command line. If no paths are specified, all tracked files =
in the
            current directory and its subdirectories are updated.

In fact, "-A" is "do everything -u does, including removal of lost path=
s,
honoring the pathspecs exactly the same way (e.g. no pathspec is to wor=
k
in the current directory). but unlike -u, also add any new files that a=
re
not excluded by the ignore mechanism."  There is something wrong if we
have to spend more lines to describe "-A" than we describe "-u", if
description of "-A" says "it does the same for -u, and in addition...".

I wonder if we can restructure the description of "-u" to make it easie=
r
to read, to simplify the description of "-A".
