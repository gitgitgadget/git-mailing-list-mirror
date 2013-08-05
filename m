From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log doc: the argument to --encoding is not optional
Date: Mon, 05 Aug 2013 08:20:00 -0700
Message-ID: <7vob9cnp0f.fsf@alter.siamese.dyndns.org>
References: <20130802221640.GA7478@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 05 17:20:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6MZw-0005w3-7P
	for gcvg-git-2@plane.gmane.org; Mon, 05 Aug 2013 17:20:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776Ab3HEPUF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Aug 2013 11:20:05 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51398 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752178Ab3HEPUD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Aug 2013 11:20:03 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CDFC36884;
	Mon,  5 Aug 2013 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j/hwQLJv9N71lynu76tL/cB+uzQ=; b=Kr7pdo
	7VEg1eRJzaM6eCVh+Grzr/T71Y7iNYHKaHm695JKQ/ZqF3vPd6KjtH0UYvsR9zIh
	xj8N3HdobDEl5G4S9VXVPr5e7LL22GSgRZ1sMdVgDcPJp9oOKAl5UcOQ4Fwidj5K
	TVCcxzyP2cJ/z2c0njhxBUWMMR8j0D8H6yi5I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mx4V4YJBjTZBR710qK8ATlw/aIk9QjSV
	uGAM36z76cGdTg6xgcsDqCxrBI+tFJmvEcIC0okCTm6pFXDm7UFbTJ5OM1mYGp3a
	u8s+UXExR8Ci3MJrNOfqkxU/gI56Z0IYoREijYBEX0XeeI4szc+qlvFzftdxby1d
	yHI1ikriUp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3003E36883;
	Mon,  5 Aug 2013 15:20:03 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 06F0D3687F;
	Mon,  5 Aug 2013 15:20:01 +0000 (UTC)
In-Reply-To: <20130802221640.GA7478@elie.Belkin> (Jonathan Nieder's message of
	"Fri, 2 Aug 2013 15:16:40 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7FA34122-FDE2-11E2-9ECC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231653>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  $ git log --encoding
>  fatal: Option '--encoding' requires a value
>  $ git rev-list --encoding
>  fatal: Option '--encoding' requires a value
>
> The argument to --encoding has always been mandatory.  Unfortunately
> manpages like git-rev-list(1), git-log(1), and git-show(1) have
> described the option's syntax as "--encoding[=<encoding>]" since it
> was first documented.  Clarify by removing the extra brackets.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

Thanks.

>  Documentation/git-rev-list.txt   | 2 +-
>  Documentation/pretty-options.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
> index 65ac27e0..045b37b8 100644
> --- a/Documentation/git-rev-list.txt
> +++ b/Documentation/git-rev-list.txt
> @@ -40,7 +40,7 @@ SYNOPSIS
>  	     [ \--right-only ]
>  	     [ \--cherry-mark ]
>  	     [ \--cherry-pick ]
> -	     [ \--encoding[=<encoding>] ]
> +	     [ \--encoding=<encoding> ]
>  	     [ \--(author|committer|grep)=<pattern> ]
>  	     [ \--regexp-ignore-case | -i ]
>  	     [ \--extended-regexp | -E ]
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> index 5e499421..eea0e306 100644
> --- a/Documentation/pretty-options.txt
> +++ b/Documentation/pretty-options.txt
> @@ -28,7 +28,7 @@ people using 80-column terminals.
>  	This is a shorthand for "--pretty=oneline --abbrev-commit"
>  	used together.
>  
> ---encoding[=<encoding>]::
> +--encoding=<encoding>::
>  	The commit objects record the encoding used for the log message
>  	in their encoding header; this option can be used to tell the
>  	command to re-code the commit log message in the encoding
