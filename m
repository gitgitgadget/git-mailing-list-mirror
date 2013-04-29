From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix grammar in the 1.8.3 release notes.
Date: Mon, 29 Apr 2013 14:15:28 -0700
Message-ID: <7vli81ghsf.fsf@alter.siamese.dyndns.org>
References: <7vvc78u8jl.fsf@alter.siamese.dyndns.org>
	<1367262904-9885-1-git-send-email-marcnarc@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Apr 29 23:15:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWvQ8-0004ig-RX
	for gcvg-git-2@plane.gmane.org; Mon, 29 Apr 2013 23:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759832Ab3D2VPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 17:15:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51609 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758869Ab3D2VPb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 17:15:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3ECD51A36A;
	Mon, 29 Apr 2013 21:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JRF42D3gdIbJFYpVKEjN22iKoRE=; b=Owqhs9
	8JIM9p/RPGEbFAPmCySkIMGoY/71n1daDdGZ7sau71A1yWS8KH0h70tRIaCUoWQZ
	mroCWj35cg82ZKLG8G5flEY5xrHjWcHH21bDT9X3WzNgHyyvD4ehYOYhMEiMKznS
	FAISbLjTN68N7w59Cjd+wZAzntLOL9X1Z8ko4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iTijjOpjncTDcIHqFC9O23koYAD31sHS
	vR87T++BDUcekD76F4ntC1hU7YSqJ8Ok+k6xLHHL4GIqHAuSGp/gFf17MzAeCtZq
	rP22kxGWSol1iTX8hGfkRto9Ra4qNLkJ8SMfs3GVUu1Oslqcbvsx8uVQwoikBsLL
	QJ9JE/4V4r8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 357DB1A369;
	Mon, 29 Apr 2013 21:15:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 601621A364;
	Mon, 29 Apr 2013 21:15:30 +0000 (UTC)
In-Reply-To: <1367262904-9885-1-git-send-email-marcnarc@xiplink.com> (Marc
	Branchaud's message of "Mon, 29 Apr 2013 15:15:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBD9A11A-B111-11E2-AF46-8D009ADAE8A5-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222865>

Marc Branchaud <marcnarc@xiplink.com> writes:

> This started out as an attempt to make the backward compatibility notes
> more parsable, but then I just kept going...

Thanks.

>   * "git bundle" did not like a bundle created using a commit without
> -   any message as its one of the prerequistes.
> +   any message, as it is one of the prerequistes.

This is actually saying a different thing.  

When you create a bundle, you can say "you can only unbundle this in
a repository that has commit X", with "git bundle create $name ^X Y
Z".  Such a commit X is called the bundle's prerequisite.  You can
have more than one prerequisite, e.g. "... ^X ^W Y Z".

But if you create a bundle by using a commit that does not have any
message as X (i.e. the bundle's prerequisite), the "git bundle" did
not like to read the resulting bundle output.

So <a commit <without any message> as its (bundle's) one of the
prerequisites> is what the original wanted to say.  The rewrite
makes it read like "For a commit, having a message is a requirement
to be used in a bundle", at least to me.

>   * "index-pack --fix-thin" used an uninitialized value to compute
> -   delta depths of objects it appends to the resulting pack.
> +   the delta depths of objects it appends to the resulting pack.
>  
> - * "index-pack --verify-stat" used a few counters outside protection
> -   of mutex, possibly showing incorrect numbers.
> + * "index-pack --verify-stat" used a few counters outside the protection
> +   of a mutex, possibly showing incorrect numbers.
>  
>   * The code to keep track of what directory names are known to Git on
> -   platforms with case insensitive filesystems can get confused upon a
> -   hash collision between these pathnames and looped forever.
> +   platforms with case insensitive filesystems could get confused upon a
> +   hash collision between these pathnames and would loop forever.
>  
> - * Annotated tags outside refs/tags/ hierarchy were not advertised
> -   correctly to the ls-remote and fetch with recent version of Git.
> + * Annotated tags outside the refs/tags/ hierarchy were not advertised
> +   correctly to ls-remote and fetch with recent versions of Git.
>  
> - * Recent optimization broke shallow clones.
> + * Recent optimizations broke shallow clones.
>  
>   * "git cmd -- ':(top'" was not diagnosed as an invalid syntax, and
>     instead the parser kept reading beyond the end of the string.
>  
>   * "git tag -f <tag>" always said "Updated tag '<tag>'" even when
> -   creating a new tag (i.e. not overwriting nor updating).
> +   creating a new tag (i.e. neither overwriting nor updating).
>  
>   * "git p4" did not behave well when the path to the root of the P4
>     client was not its real path.
>     (merge bbd8486 pw/p4-symlinked-root later to maint).
>  
> - * "git archive" reports a failure when asked to create an archive out
> -   of an empty tree.  It would be more intuitive to give an empty
> + * "git archive" reported a failure when asked to create an archive out
> +   of an empty tree.  It is more intuitive to give an empty
>     archive back in such a case.
>  
> - * When "format-patch" quoted a non-ascii strings on the header files,
> + * When "format-patch" quoted a non-ascii string in header files,
>     it incorrectly applied rfc2047 and chopped a single character in
> -   the middle of it.
> +   the middle of the string.
>  
>   * An aliased command spawned from a bare repository that does not say
> -   it is bare with "core.bare = yes" is treated as non-bare by mistake.
> +   it is bare with "core.bare = yes" was treated as non-bare by mistake.
>  
> - * In "git reflog expire", REACHABLE bit was not cleared from the
> + * In "git reflog expire", the REACHABLE bit was not cleared from the
>     correct objects.
>  
>   * The logic used by "git diff -M --stat" to shorten the names of
> @@ -347,9 +346,9 @@ details).
>     common prefix and suffix between the two filenames overlapped.
>  
>   * The "--match=<pattern>" option of "git describe", when used with
> -   "--all" to allow refs that are not annotated tags to be used as a
> +   "--all" to allow refs that are not annotated tags to be a
>     base of description, did not restrict the output from the command
> -   to those that match the given pattern.
> +   to those refs that match the given pattern.
>  
>   * Clarify in the documentation "what" gets pushed to "where" when the
>     command line to "git push" does not say these explicitly.
> @@ -357,7 +356,7 @@ details).
>   * The "--color=<when>" argument to the commands in the diff family
>     was described poorly.
>  
> - * The arguments given to pre-rebase hook were not documented.
> + * The arguments given to the pre-rebase hook were not documented.
>  
>   * The v4 index format was not documented.
>  
> @@ -375,7 +374,7 @@ details).
>  
>   * In the v1.8.0 era, we changed symbols that do not have to be global
>     to file scope static, but a few functions in graph.c were used by
> -   CGit from sideways bypassing the entry points of the API the
> +   CGit sideways, bypassing the entry points of the API the
>     in-tree users use.
>  
>   * "git update-index -h" did not do the usual "-h(elp)" thing.
> @@ -388,30 +387,30 @@ details).
>     $msg already ended with one.
>  
>   * The SSL peer verification done by "git imap-send" did not ask for
> -   Server Name Indication (RFC 4366), failing to connect SSL/TLS
> +   Server Name Indication (RFC 4366), failing to connect to SSL/TLS
>     sites that serve multiple hostnames on a single IP.
>  
>   * perl/Git.pm::cat_blob slurped everything in core only to write it
>     out to a file descriptor, which was not a very smart thing to do.
>  
>   * "git branch" did not bother to check nonsense command line
> -   parameters and issue errors in many cases.
> +   parameters.  It now issues errors in many cases.
>  
> - * Verification of signed tags were not done correctly when not in C
> + * Verification of signed tags was not done correctly when not in C
>     or en/US locale.
>  
>   * Some platforms and users spell UTF-8 differently; retry with the
>     most official "UTF-8" when the system does not understand the
> -   user-supplied encoding name that are the common alternative
> -   spellings of UTF-8.
> +   user-supplied encoding name that is a common alternative
> +   spelling of UTF-8.
>  
> - * When export-subst is used, "zip" output recorded incorrect
> + * When export-subst is used, "zip" output recorded an incorrect
>     size of the file.
>  
>   * "git am $maildir/" applied messages in an unexpected order; sort
>     filenames read from the maildir/ in a way that is more likely to
> -   sort messages in the order the writing MUA meant to, by sorting
> -   numeric segment in numeric order and non-numeric segment in
> +   sort the messages in the order the writing MUA meant to, by sorting
> +   numeric segments in numeric order and non-numeric segments in
>     alphabetical order.
>  
>   * "git submodule update", when recursed into sub-submodules, did not
