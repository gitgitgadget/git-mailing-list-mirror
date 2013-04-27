From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] complete: zsh: use zsh completion for the main cmd
Date: Sat, 27 Apr 2013 14:39:41 -0700
Message-ID: <7vtxmrsleq.fsf@alter.siamese.dyndns.org>
References: <1367094846-9830-1-git-send-email-felipe.contreras@gmail.com>
	<1367094846-9830-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 23:39:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWCqU-00072u-6B
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 23:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754773Ab3D0Vjo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 17:39:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56854 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071Ab3D0Vjo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 17:39:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AF0541AB17;
	Sat, 27 Apr 2013 21:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dT5moDlVwNkbPNYzNs/Jfep8rvI=; b=fbFbGa
	yemYVOzV1tNWBr0pbHruTdGQsqiExpMh+mIs1mTNWsZcy8iWRYAkQtW6fkcq6h9E
	Q3OktI9u8jjyHoDvJXOq8C9STpuiHCD01p86HBmKNCU+xqrrX/6yVEwj5lq3Pmg1
	b3fRzgEBPoqH3bburMTL+bYquJqcLKtN/a0DY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IYY4dlnEKQnlJZkC+GloXVtJgek0HT6j
	E6jK1oeQ6PdJXkIQjTgBWcwGJCp0hFrnnggnLQj8MyVgv0f7QPPTI9Bb4QxCKEJf
	f7SGhS3XXWVnyR9K+VD0o0P1ky11aJdKJ3y6eZojBzV3L7C5Fad18h+KY8anGuyl
	EfexDo+tSu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A45521AB16;
	Sat, 27 Apr 2013 21:39:43 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 21E131AB15;
	Sat, 27 Apr 2013 21:39:43 +0000 (UTC)
In-Reply-To: <1367094846-9830-3-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Sat, 27 Apr 2013 15:34:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F8EDD0D2-AF82-11E2-872B-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222705>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +__git_zsh_cmd_common ()
> +{
> +	local -a list
> +	list=(
> +	add:'add file contents to the index'
> +	bisect:'find by binary search the change that introduced a bug'
> +	branch:'list, create, or delete branches'
> +	checkout:'checkout a branch or paths to the working tree'
> +	clone:'clone a repository into a new directory'
> +	commit:'record changes to the repository'
> +	diff:'show changes between commits, commit and working tree, etc'
> +	fetch:'download objects and refs from another repository'
> +	grep:'print lines matching a pattern'
> +	init:'create an empty Git repository or reinitialize an existing one'
> +	log:'show commit logs'
> +	merge:'join two or more development histories together'
> +	mv:'move or rename a file, a directory, or a symlink'
> +	pull:'fetch from and merge with another repository or a local branch'
> +	push:'update remote refs along with associated objects'
> +	rebase:'forward-port local commits to the updated upstream head'
> +	reset:'reset current HEAD to the specified state'
> +	rm:'remove files from the working tree and from the index'
> +	show:'show various types of objects'
> +	status:'show the working tree status'
> +	tag:'create, list, delete or verify a tag object signed with GPG')

Maintaining this list feels somewhat painful.  Isn't this something
we can help by tweaking "git help"?
