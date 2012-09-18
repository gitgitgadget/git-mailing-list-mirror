From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 1/8] Doc: Bundle file usage
Date: Tue, 18 Sep 2012 16:55:11 -0700
Message-ID: <7vzk4mj38g.fsf@alter.siamese.dyndns.org>
References: <1348010734-664-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Wed Sep 19 01:55:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TE7dV-0001An-16
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 01:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752773Ab2IRXzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 19:55:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65331 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752331Ab2IRXzO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 19:55:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 70EB38182;
	Tue, 18 Sep 2012 19:55:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tdu8Em1k7ZumdOEUTBnfqqElgSk=; b=KrPZx2
	X7RPJLej5XYYOlSdJdlQ173nAFIuBNxvUF6mC0Hc4yjrOP/3RYSLRU+g6FrIQYpJ
	RS76TIfb63nmRa8+OMA3v9+J0RKsnIfcPuOLeRgcEsZShyk0ovPCj2Thbs4g8iIT
	USq24KThUCkF648lg8aJmTesMy7UQjrj411UI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sB5/lpbnOujJRf0nzAqUAcoU7Sg+/OsE
	TakB7hcRBxvRevJkuDySq8M8M0DjiIXPC0ZijceZQ1lIdqpaWCmFd2lD7FB12U5B
	Whoz2aGS2D/X+mIp/c3ZZjyI+1QkV0Y8BuZN1QmjT9IaAGZEWCjdLaF4txdpHT8S
	0Eeg6OgATx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DD868181;
	Tue, 18 Sep 2012 19:55:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D6E3817F; Tue, 18 Sep 2012
 19:55:12 -0400 (EDT)
In-Reply-To: <1348010734-664-2-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Wed, 19 Sep 2012 00:25:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49290BE2-01EC-11E2-B809-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205897>

Philip Oakley <philipoakley@iee.org> writes:

> Git URLs can accept bundle files for fetch, pull and clone, include
> in that section. Include git clone in the bundle usage description.
> Correct the quoting of <git-rev-list-args>.
> Detail the <git-rev-list-args> '--all' option for cloning.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>
> diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
> index 16a6b0a..be6a5f1 100644
> --- a/Documentation/git-bundle.txt
> +++ b/Documentation/git-bundle.txt
> @@ -21,12 +21,12 @@ Some workflows require that one or more branches of development on one
>  machine be replicated on another machine, but the two machines cannot
>  be directly connected, and therefore the interactive git protocols (git,
>  ssh, rsync, http) cannot be used.  This command provides support for
> -'git fetch' and 'git pull' to operate by packaging objects and references
> -in an archive at the originating machine, then importing those into
> -another repository using 'git fetch' and 'git pull'
> -after moving the archive by some means (e.g., by sneakernet).  As no
> -direct connection between the repositories exists, the user must specify a
> -basis for the bundle that is held by the destination repository: the
> +'git fetch', 'git pull' and 'git clone', to operate by packaging
> +objects and references in an archive at the originating machine, then
> +importing those into another repository using 'git fetch', 'git pull',
> +or 'git clone', after moving the archive by some means (e.g., by sneakernet).
> +As no direct connection between the repositories exists, the user must
> +specify a basis for the bundle that is held by the destination repository: the
>  bundle assumes that all objects in the basis are already in the
>  destination repository.
>  
> @@ -35,7 +35,7 @@ OPTIONS
>  
>  create <file>::
>  	Used to create a bundle named 'file'.  This requires the
> -	'git-rev-list-args' arguments to define the bundle contents.
> +	<git-rev-list-args> arguments to define the bundle contents.
>  
>  verify <file>::
>  	Used to check that a bundle file is valid and will apply
> @@ -92,6 +92,8 @@ It is okay to err on the side of caution, causing the bundle file
>  to contain objects already in the destination, as these are ignored
>  when unpacking at the destination.
>  
> +To create a bundle for 'git clone', use `--all` for the <git-rev-list-args>.
> +

Hmm, what does this mean?  Specifically, it is not clear what "for
'git clone'" exactly means.  It is not "for use of 'git clone'",
because you should be able to create a bundle that has 'master'
branch without 'maint', 'next', and 'pu' and clone from it, no?

	git checkout maint
        git bundle create /var/tmp/1.bndl HEAD refs/heads/maint
        cd /var/tmp && git clone 1.bndl xprm

I also think "--all" is a bad advice for another reason.  Doesn't it
shove refs from refs/remotes/* hierarchy in the resulting bundle?
It is fine for archiving purposes, but it does not seem to be a good
advice to create a bundle to clone from.

>  EXAMPLE
>  -------
>  
> diff --git a/Documentation/urls.txt b/Documentation/urls.txt
> index 2890194..2d75cce 100644
> --- a/Documentation/urls.txt
> +++ b/Documentation/urls.txt
> @@ -42,6 +42,9 @@ These two syntaxes are mostly equivalent, except the former implies
>  --local option.
>  endif::git-clone[]
>  
> +'git clone', 'git fetch' and 'git pull', but not 'git push', will also
> +accept a suitable bundle file. See linkgit:git-bundle[1].
> +
>  When git doesn't know how to handle a certain transport protocol, it
>  attempts to use the 'remote-<transport>' remote helper, if one
>  exists. To explicitly request a remote helper, the following syntax
