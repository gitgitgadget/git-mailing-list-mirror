From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add additional build options for Interix, and remove
 obsolete ones.
Date: Wed, 25 May 2011 10:51:37 -0700
Message-ID: <7vhb8i4qja.fsf@alter.siamese.dyndns.org>
References: <1306332924-28587-1-git-send-email-mduft@gentoo.org>
 <1306332924-28587-2-git-send-email-mduft@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mduft@gentoo.org
X-From: git-owner@vger.kernel.org Wed May 25 19:51:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPIFM-0005wU-7u
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 19:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751601Ab1EYRvr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 13:51:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54948 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750757Ab1EYRvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 13:51:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D2EC95C4B;
	Wed, 25 May 2011 13:53:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Rlqq5lvhkRgO4LS+QWuR9xQm4Z4=; b=IadG3t
	gputD+ipT3F6OlpuzjE1dnb8DcR5TQi+1JFz7UJ59QyVyNCZlzLDHyTNP4sgv3h7
	ojqL7NFhkWhxykHWkM519zuQDxLZwV3f/evjfLnFjTvcm3hFaH/w/Fq2NTxmMtDB
	IqsmqRFv9DUrvf1684ymJvLQZQNglQ2nK98Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CRW9rXsoKRo9DuElTxiimWgQiEdjQ6q0
	VJW/rbjJXG6sSRx9cvOSCvZg7DPnNADYZlwpW7l8qBd+Vg5xXPysX57RJIGF6DpL
	WApS0RJA3xh5uzXD3PIihzGkb+MCCUWk5YPxH1W8vlEMbACkiF+2rnFB7rnPAjFr
	wrowBflN5W0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF2BB5C4A;
	Wed, 25 May 2011 13:53:49 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 957025C48; Wed, 25 May 2011
 13:53:46 -0400 (EDT)
In-Reply-To: <1306332924-28587-2-git-send-email-mduft@gentoo.org>
 (mduft@gentoo.org's message of "Wed, 25 May 2011 16:15:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1FF95FE-86F7-11E0-9387-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174438>

mduft@gentoo.org writes:

> Interix versions older than 6.0 (so 3.5 and 5.2) both lack
> struct sockaddr_storage and the FNM_CASEFOLD GNU extension,
> so disable them both.
>
> The removed options are obsolete, because interix support now
> depends on libsuacomp.

and linkage with -lsuacomp happens automatically without any change in the
Makefile for anybody?  Just asking, as I do not have an access to (nor any
particular desire to get an access to) an Interix to figure it out myself,
and the only think I care about in this patch is if it helps only your
installation or it will help everybody who has Interix but not necessarily
with the same set of additional configuration as you have.

> Signed-off-by: Markus Duft <mduft@gentoo.org>
> ---
>  Makefile |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index db72c45..c47cd4e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1113,8 +1113,6 @@ endif
>  	X = .exe
>  endif
>  ifeq ($(uname_S),Interix)
> -	NO_SYS_POLL_H = YesPlease
> -	NO_INTTYPES_H = YesPlease
>  	NO_INITGROUPS = YesPlease
>  	NO_IPV6 = YesPlease
>  	NO_MEMMEM = YesPlease
> @@ -1125,10 +1123,14 @@ ifeq ($(uname_S),Interix)
>  	ifeq ($(uname_R),3.5)
>  		NO_INET_NTOP = YesPlease
>  		NO_INET_PTON = YesPlease
> +		NO_SOCKADDR_STORAGE = YesPlease
> +		NO_FNMATCH_CASEFOLD = YesPlease
>  	endif
>  	ifeq ($(uname_R),5.2)
>  		NO_INET_NTOP = YesPlease
>  		NO_INET_PTON = YesPlease
> +		NO_SOCKADDR_STORAGE = YesPlease
> +		NO_FNMATCH_CASEFOLD = YesPlease
>  	endif
>  endif
>  ifneq (,$(findstring MINGW,$(uname_S)))
