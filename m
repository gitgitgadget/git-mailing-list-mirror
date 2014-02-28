From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Add docstrings for lookup_replace_object() and do_lookup_replace_object()
Date: Fri, 28 Feb 2014 13:17:25 -0800
Message-ID: <xmqqk3cfszru.fsf@gitster.dls.corp.google.com>
References: <1393604957-7571-1-git-send-email-mhagger@alum.mit.edu>
	<1393604957-7571-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 22:17:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJUoO-000438-RK
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 22:17:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbaB1VRh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 16:17:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56368 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752547AbaB1VRa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 16:17:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA120709C7;
	Fri, 28 Feb 2014 16:17:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GAftt5pLnSiTlIt3I4/r6M+QJug=; b=pAfjp7
	YVEFUM47ns7srquZUZasggimjxUvQOvmq6WYhEyzgFrUkqK8J3jOwMmAg0f9TMMm
	R7yyY/MAOgRKeniB8jHaLxrZ226zUEL6pvqYa8iTKeF9pQvbeMuM/IGNVASMkC9i
	WbwIcI/gc173wvaV4jmbapI6E9Qal4QX0ulKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nw19N66DpeaANnv03R9MK06evQqMOQqT
	4HLOvXt0YTwsuK8xJ3aBrLnkQpfeTBpS8S3mRpV/thiD2CoLUWbuFX7iwaLoWRBt
	P16d9/9110V4xLWGzBYyiASSvJmYg7aMOSy6AyQtY+/ZKGSayNjefNBCUAyMKHYo
	XFWXH3+rvH4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 967AA709C6;
	Fri, 28 Feb 2014 16:17:29 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CA8EF709C2;
	Fri, 28 Feb 2014 16:17:28 -0500 (EST)
In-Reply-To: <1393604957-7571-2-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 28 Feb 2014 17:29:16 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BA6FD7B0-A0BD-11E3-829E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243017>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---

Reviewed-by: Junio C Hamano <gitster@pobox.com>

Thanks.

>  cache.h          | 13 +++++++++++++
>  replace_object.c |  7 +++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index b039abc..9407560 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -798,13 +798,26 @@ static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *
>  {
>  	return read_sha1_file_extended(sha1, type, size, LOOKUP_REPLACE_OBJECT);
>  }
> +
> +/*
> + * This internal function is only declared here for the benefit of
> + * lookup_replace_object().  Please do not call it directly.
> + */
>  extern const unsigned char *do_lookup_replace_object(const unsigned char *sha1);
> +
> +/*
> + * If object sha1 should be replaced, return the replacement object's
> + * name (replaced recursively, if necessary).  The return value is
> + * either sha1 or a pointer to a permanently-allocated value.  When
> + * object replacement is suppressed, always return sha1.
> + */
>  static inline const unsigned char *lookup_replace_object(const unsigned char *sha1)
>  {
>  	if (!check_replace_refs)
>  		return sha1;
>  	return do_lookup_replace_object(sha1);
>  }
> +
>  static inline const unsigned char *lookup_replace_object_extended(const unsigned char *sha1, unsigned flag)
>  {
>  	if (!(flag & LOOKUP_REPLACE_OBJECT))
> diff --git a/replace_object.c b/replace_object.c
> index c5cf9f4..31fabde 100644
> --- a/replace_object.c
> +++ b/replace_object.c
> @@ -92,6 +92,13 @@ static void prepare_replace_object(void)
>  /* We allow "recursive" replacement. Only within reason, though */
>  #define MAXREPLACEDEPTH 5
>  
> +/*
> + * If a replacement for object sha1 has been set up, return the
> + * replacement object's name (replaced recursively, if necessary).
> + * The return value is either sha1 or a pointer to a
> + * permanently-allocated value.  This function always respects replace
> + * references, regardless of the value of check_replace_refs.
> + */
>  const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
>  {
>  	int pos, depth = MAXREPLACEDEPTH;
