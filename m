From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document the --done option.
Date: Wed, 22 Aug 2012 10:38:38 -0700
Message-ID: <7vobm2968x.fsf@alter.siamese.dyndns.org>
References: <20120822105705.GA30472@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: esr@thyrsus.com, Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 19:38:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4EtE-00049H-22
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 19:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab2HVRin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 13:38:43 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56886 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab2HVRil (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 13:38:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9828F955E;
	Wed, 22 Aug 2012 13:38:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pudQScEeKrLY/slKhN06gEsyVac=; b=WR7u9w
	4l9a7m8IXSdoxO/tPG9SBAGq9t8VybU6PKCGcmKmyKzHUEljHlu8tMfYh8qzT8sg
	ZOsmWVIEwAyuSVKj2w/NKpVaMh4ksB422N1y2MnyQj5qMpjiAvyU6bMJCXp5jz3J
	jPZF61bTwmKZ7cfgV7nXUX7+7LRqj46yeqZZg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QgW5uL9+ayzV+0BeFjMu1FJo2jObdg+R
	rjX3oZ9fauoKEDdJWg4hhmJxKk8AFq4rpGxtaCDtwxHx17qJQCSHeotEW1LKfDdi
	rHR5489a7VK6LYtT8V6pc0HWJXQ/zFsx7K4xi+oVfkgx9XFRUB6aRk5tbf9bKe1a
	qxXO2Hbs2eE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 85DD1955D;
	Wed, 22 Aug 2012 13:38:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E00A7955C; Wed, 22 Aug 2012
 13:38:39 -0400 (EDT)
In-Reply-To: <20120822105705.GA30472@thyrsus.com> (Eric S. Raymond's message
 of "Wed, 22 Aug 2012 06:57:05 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35BB267A-EC80-11E1-A229-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204043>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> ---

A forgotten Sign-off?

Sverre, the text matches my understanding as well as what be56862
(fast-import: introduce 'done' command, 2011-07-16) says it did.
Ack?

>  Documentation/git-fast-import.txt |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index 2620d28..9291ea0 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -39,6 +39,10 @@ OPTIONS
>  	See ``Date Formats'' below for details about which formats
>  	are supported, and their syntax.
>  
> +-- done::
> +	Terminate with error if there is no 'done' command at the 
> +	end of the stream.
> +
>  --force::
>  	Force updating modified existing branches, even if doing
>  	so would cause commits to be lost (as the new commit does
> @@ -1047,7 +1051,9 @@ done::
>  	Error out if the stream ends without a 'done' command.
>  	Without this feature, errors causing the frontend to end
>  	abruptly at a convenient point in the stream can go
> -	undetected.
> +	undetected.  This may occur, for example, if an import
> +	front end dies in mid-operation without emitting SIGTERM
> +	or SIGKILL at its subordinate git fast-import instance.
>  
>  `option`
>  ~~~~~~~~
> -- 
> 1.7.9.5
