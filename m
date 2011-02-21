From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: default -u<mode> is 'normal'
Date: Mon, 21 Feb 2011 10:46:47 -0800
Message-ID: <7vei71jkdk.fsf@alter.siamese.dyndns.org>
References: <20110219163008.GA16117@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Mon Feb 21 19:47:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pramj-0005Kq-IO
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 19:47:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730Ab1BUSq5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 13:46:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37024 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab1BUSq4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 13:46:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 41FF33DDE;
	Mon, 21 Feb 2011 13:48:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xPYFGkSAvBetJuTLpSrXDh6Xitw=; b=wARFyV
	pJGSOU1kVyFH5sVPzZ7WML/pL/bGlYGxdaKvEtYgE2Ucogq2X9QI0PPMctDe4JD3
	anGjzXzIm7MIk4lqtdCbCDJEM1UbGZpet5wc7zbm1Bvth3O89QuSb9oQfS2zws7j
	lz6F6evrbHp2z75l2VxxxlnOQH0k4KvGI5dz4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lsa7NToIJ/iCHVacQ7vUrtlYt4kfkA/Z
	+9CviBXjWNYtsYsxISEXAN98nL4srjerqaugKOotVamgf3UCDrqPeKOlvXu/lKHa
	eBrd/s7aDOxvXeSkOZAcQv+MwnKQiGV/RABMWK9asfvP+5MkVP8NVxfRPuyUKzhc
	3rR6g+2Syks=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0E9AB3DDA;
	Mon, 21 Feb 2011 13:48:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F5333DD9; Mon, 21 Feb 2011
 13:48:00 -0500 (EST)
In-Reply-To: <20110219163008.GA16117@localhost> (Clemens Buchacher's message
 of "Sat\, 19 Feb 2011 17\:30\:08 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1D5AA85C-3DEB-11E0-84C6-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167500>

Clemens Buchacher <drizzd@aon.at> writes:

> git-commit's and git-status' default untracked status mode is
> 'normal', not 'all'.
>
> Signed-off-by: Clemens Buchacher <drizzd@aon.at>

I wouldn't say there is no problem in this part of the documentation, but
I think the "default" you are touching is not entirely incorrect.  It is
talking about what happens when you give only -u without saying <mode>,
and I think <mode> _does_ default to 'all'.

When the command is _not_ given any "-u" option, the behaviour of it does
default to "handle untracked files in the 'normal'" mode.

> ...
>  -u[<mode>]::
>  --untracked-files[=<mode>]::
> -	Show untracked files (Default: 'all').
> +	Show untracked files (Default: 'normal').
>  +
>  The mode parameter is optional, and is used to specify
>  the handling of untracked files.

So either

	Show untracked files (<mode> defaults to 'all')

        The mode parameter is optional, and is used to specify the
        handling of untracked files; when -u is not used, the default is
        'normal', i.e. _show x and y and z_

(I'm too lazy to look x/y/z up, so please fill in the blanks).

or

	Show untracked files.

        The mode parameter is optional (defaults to 'all'), and is used to
        specify the handling of untracked files; when -u is not used, the
        default is 'normal', i.e. _show x and y and z_

I don't have a strong preference either way, but if I had to choose I
probably would go with the latter.
