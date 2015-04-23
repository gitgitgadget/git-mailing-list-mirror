From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/5] git tag: mention versionsort.prereleaseSuffix in manpage
Date: Thu, 23 Apr 2015 11:28:55 -0700
Message-ID: <xmqqr3ra3di0.fsf@gitster.dls.corp.google.com>
References: <1429792070-22991-1-git-send-email-mhagger@alum.mit.edu>
	<1429792070-22991-3-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Apr 23 20:29:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlLs8-00031L-Bi
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 20:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030648AbbDWS3D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 14:29:03 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64522 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030515AbbDWS26 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 14:28:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E3FE4B61E;
	Thu, 23 Apr 2015 14:28:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w1jROvBdUmxqgAzi9jmMiVTCSVQ=; b=NK0R3p
	5/75VV9Ft5jb2ftTajJgRgcwyFj8w5DoMqVTqNXiUv61y2jdNqpNCOJRlQJ1walj
	+z2iWV0aDKvWVv7vFaEoz+HSHN06Epe7rSgEfTfnW6xsEHcHstcQnEBiq3laNEG5
	BJQrkwLyM0nEhSx4/1+0LwgXvUbIO4KCsh82o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hFD5AkP3PKHMEdZ6IeMATr62k3jXMa95
	neXodbHEJRVjvalgZR0MvQduIS8mXJ0Cck4U+e/rymI+4KzZ3oe7fJRWFdD81Uwr
	mnSqOoxtyQY2OEfArcs/GxaUUUdZz7LOfZNA3a41brq5X4oYnGDM38sXEBcOt4Cn
	LKoBCHLdrr4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8708F4B61D;
	Thu, 23 Apr 2015 14:28:57 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0CB134B61C;
	Thu, 23 Apr 2015 14:28:56 -0400 (EDT)
In-Reply-To: <1429792070-22991-3-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Thu, 23 Apr 2015 14:27:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9A6EDD62-E9E6-11E4-AB23-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267699>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Makes sense; will queue on nd/versioncmp-prereleases.

Thanks.

>  Documentation/git-tag.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index bfba4ef..f5b267e 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -98,10 +98,13 @@ OPTIONS
>  --sort=<type>::
>  	Sort in a specific order. Supported type is "refname"
>  	(lexicographic order), "version:refname" or "v:refname" (tag
> -	names are treated as versions). Prepend "-" to reverse sort
> -	order. When this option is not given, the sort order defaults to the
> -	value configured for the 'tag.sort' variable if it exists, or
> -	lexicographic order otherwise. See linkgit:git-config[1].
> +	names are treated as versions). The "version:refname" sort
> +	order can also be affected by the
> +	"versionsort.prereleaseSuffix" configuration variable. Prepend
> +	"-" to reverse sort order. When this option is not given, the
> +	sort order defaults to the value configured for the 'tag.sort'
> +	variable if it exists, or lexicographic order otherwise. See
> +	linkgit:git-config[1].
>  
>  --column[=<options>]::
>  --no-column::
