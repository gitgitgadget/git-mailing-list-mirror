From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-tag(1): we tag HEAD by default
Date: Wed, 03 Apr 2013 08:04:08 -0700
Message-ID: <7vzjxf64gn.fsf@alter.siamese.dyndns.org>
References: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Apr 03 17:04:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNPEu-0005Wd-Uf
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 17:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760852Ab3DCPEM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Apr 2013 11:04:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59887 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561Ab3DCPEL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Apr 2013 11:04:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF45B123C5;
	Wed,  3 Apr 2013 15:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6g6TzLS+uNwCAjNf56LuoVDj+x0=; b=vPvt8w
	baKwHjwWy/U4wduJYcuwpGYPYgqYvrXyLK5qNOpCya7LyTrRSZH5bm2Y7hUXG4GB
	msltb8TkWorBBEBy2fjxKUhMowdPrhDEm8/W13in0TKXmSy0XLaQtTpMtnhx7t5O
	mqD6vYxzYAFPgGpPyW1eEzWfwozXqp5JUZmRY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wHIEux9QLepmgr0xzDcv2Bylhz8dslRf
	PfHo26NYHkNdWzlZhfmD5Tv8FH7gfLXkAdH4MtVJ/y1XX72L37U3Ivcg9q0oassF
	uSYXZsvSydHodPuLT4zgsQJ9TEPb0Zu3w4MrYlcki0fyj5H+gMW1C/0/B28+bi3S
	sKltwH3PyiY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E778A123C4;
	Wed,  3 Apr 2013 15:04:10 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A28C123C3; Wed,  3 Apr
 2013 15:04:10 +0000 (UTC)
In-Reply-To: <137ebfa428b16497287c55e552372df1087f1588.1364999181.git.trast@inf.ethz.ch>
 (Thomas Rast's message of "Wed, 3 Apr 2013 16:27:14 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BD24A736-9C6F-11E2-A7C5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219943>

Thomas Rast <trast@inf.ethz.ch> writes:

> The <commit>|<object> argument is actually not explained anywhere
> (except implicitly in the description of an unannotated tag).  Write a
> little explanation, in particular to cover the default.
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>
> Prompted by a question on IRC about the default value.  Do we actually
> read our own docs? ;-)

Perhaps among us some of them are real men ;-)

>  Documentation/git-tag.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index e3032c4..697df50 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -126,6 +126,11 @@ This option is only applicable when listing tags without annotation lines.
>  	linkgit:git-check-ref-format[1].  Some of these checks
>  	may restrict the characters allowed in a tag name.
>  
> +<commit>, <object>::
> +	The object that the new tag will refer to, usually a commit.
> +	Defaults to HEAD.

Shouldn't this be more like this:

    <commit>::
    <object>::
	Your explanation here...

Other than that, I think this is a reasonable change.
Thanks.

> +
> +
>  CONFIGURATION
>  -------------
>  By default, 'git tag' in sign-with-default mode (-s) will use your
