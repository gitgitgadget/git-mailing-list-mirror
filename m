From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] git-reset.txt: make modes description more
 consistent
Date: Mon, 13 Sep 2010 17:35:10 -0700
Message-ID: <7vd3sh9n7l.fsf@alter.siamese.dyndns.org>
References: <cover.1284365021.git.git@drmicha.warpmail.net>
 <d4a048c1cfd39a2d7ab8a86554bb48937629620c.1284365021.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Sep 14 02:35:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvJUk-0006Tv-Jz
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 02:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013Ab0INAfV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Sep 2010 20:35:21 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37070 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751908Ab0INAfU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Sep 2010 20:35:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4FC4D6C82;
	Mon, 13 Sep 2010 20:35:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jiM65gJLKSLR9IXkKnZzdIfK6Lc=; b=BLhYS0
	FQhPrLT+nCH7PlH9TdoV4VZdeQf3AeSXlMGgfVV7rIgF3NQ7bCSdjeKHxSOqu8ZY
	2tt4KWms6aNREJpLwD4ke8/BMAXlv2+t6nDEt+e3aAfbmNsAGRLqIyUcxYglY3oQ
	fQVPR+Zvu3GGTNy1eWuOptDTkrLHITXrKTrkY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=J/azbp6Zh9PkB6K25sev3CFXqeP2OIVG
	MefWnhFIZ/Qc1nOE8kZfb1wddrwZ+s9X5vcSXeFs33RP1Eui6XEoXroaqeh3Jn12
	M1DgDTh/4AcbQF3wwAgeA3Zd/tb3wb8pn/ZONeaVmNhL+SH2X3PWuIgig+YKBXt6
	C4p7szyLR0M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 65A3AD6C81;
	Mon, 13 Sep 2010 20:35:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 29024D6C7F; Mon, 13 Sep
 2010 20:35:11 -0400 (EDT)
In-Reply-To: <d4a048c1cfd39a2d7ab8a86554bb48937629620c.1284365021.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Mon\, 13 Sep 2010 10\:06\:36 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F1E781DA-BF97-11DF-A306-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156155>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
> index 40e2fd8..6b60b59 100644
> --- a/Documentation/git-reset.txt
> +++ b/Documentation/git-reset.txt
> @@ -15,13 +15,13 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  In the first and second form, copy entries from <commit> to the index.
> -In the third form, set the current branch head to <commit>, optionally
> +In the third form, set the current branch head (HEAD) to <commit>, optionally
>  modifying index and working tree to match.  The <commit> defaults to HEAD
>  in all forms.

In the documentation (not limited to "git reset"), we say "update HEAD"
and expect the reader to understand that (1) when HEAD is not detached,
that updates what commit the current branch points at, (2) when HEAD is
detached, no branch is affected.

But that is asking too much to newcomers who weren't around before we
introduced detached HEAD around 1.5.0 timeframe.  This documentation
glitch is there primarily because the detached HEAD came much later than
all the "updates the branch" concepts were codified and documented for
many commands that advance/modify history, e.g. reset, commit, merge, etc.

We should rectify this, and I think this series is going in the right
direction.

> @@ -39,9 +39,10 @@ This means that `git reset -p` is the opposite of `git add -p` (see
>  linkgit:git-add[1]).
>  
>  'git reset' [--<mode>] [<commit>]::
> -	This form sets the current branch head to <commit> and then
> -	updates index and working tree according to <mode>, which must
> -	be one of the following:
> +	This form sets the current branch head to <commit> and
> +	possibly updates the index (resetting it to the tree of <commit>) and
> +	the working tree depending on <mode>, which
> +	must be one of the following:

Nice.

> @@ -57,22 +58,30 @@ linkgit:git-add[1]).
>  	been updated. This is the default action.
>  
>  --hard::
> -	Matches the working tree and index to that of the tree being
> -	switched to. Any changes to tracked files in the working tree
> -	since <commit> are lost.
> +	Resets the index and working tree. Any changes to tracked files in the
> +	working tree since <commit> are lost.

Explaining what "reset" does using the undefined word "reset" smells
somewhat wrong.  Not that "matches" is any better, but at least the
original says "to that of the tree", which you seem to have lost, so there
is no indication what they are reset _to_.  I don't think the above is a
good change for this reason.

I also would prefer "are discarded" over "are lost".  It is a conscious
decision to use "git reset --hard" by the user in order to _do_ something,
and "discard" is probably more accurate, in the sense that you use the
command because you want to throw it away, than "lose" which implies you
might have wanted to keep but did something wrong.

>  --merge::
> -	Resets the index to match the tree recorded by the named commit,
> -	and updates the files that are different between the named commit
> -	and the current commit in the working tree.
> +	Resets the index and updates the files in the working tree that are
> +	different between <commit> and HEAD, but keeps those which are
> +	different between the index and working tree (i.e. which have unstaged
> +	changes).
> +	If a file that is different between <commit> and the index has unstaged
> +	changes, reset is aborted.

It may be just me, but "unstaged" sounds as if you once have staged and
then changed your mind and took it back.  "... which have changes that
haven't been added" might be clearer.

Again, it is made unclear what these entities are _reset to_ with the
above change.  Same comments apply for your change to --keep.
