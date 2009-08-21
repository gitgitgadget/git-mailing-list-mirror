From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/14] Avoid including windows.h in winansi.c for MSVC
 build
Date: Fri, 21 Aug 2009 14:02:11 -0700
Message-ID: <7vmy5sdgoc.fsf@alter.siamese.dyndns.org>
References: <cover.1250860247.git.mstormo@gmail.com>
 <6283b3e1775f43c6fc07e5047f9c99acdc27bc8f.1250860247.git.mstormo@gmail.com>
 <af66de324093bbe8f500b1ef20689dd5d355abf4.1250860247.git.mstormo@gmail.com>
 <c899c41fdccfdc94ae294f1a50895ba0290a1ec3.1250860247.git.mstormo@gmail.com>
 <e06c143a91dc2b5b95bcaca42a419d56e25690ac.1250860247.git.mstormo@gmail.com>
 <07846e22f50dfd5e1b483a02cf550e5373125f1d.1250860247.git.mstormo@gmail.com>
 <1c403f4a41f4a210ff15933814bba56495d812d3.1250860247.git.mstormo@gmail.com>
 <9e8fc158b4d4331d698d1fe4ed33a61fbb011412.1250860247.git.mstormo@gmail.com>
 <1e623b19b2df001919c83418fef89ef04d7b8dfe.1250860247.git.mstormo@gmail.com>
 <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes.Schindelin@gmx.de, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 23:02:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MebFp-0001Om-3W
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 23:02:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932616AbZHUVCZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 17:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932597AbZHUVCY
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 17:02:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34721 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932528AbZHUVCX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 17:02:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0DE7F138B5;
	Fri, 21 Aug 2009 17:02:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VSfI5iF0syrs6JTYH90PAy979kQ=; b=noyacz
	P8boHGzqMgvshI9Crfg9ma3ytGiuK20pDg+87q4N0jqeUuzbQrBu0q+Ww24XTzPo
	TeJf8Pcu3RydBxdfzuF6EIkme9GRJO/vGyQ4G2Sg5GY1wCHYSrXJ+t5OQPy9tE2K
	3dk8muvUw0IuOeGNmFLHKiuIAmJGkupCYpB2k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RwyIGQEKJVFZCIBoxdhf2s8CG6EGkgeR
	kA8mSvyb4g3miFN4cLn1WcAHbjaSdVsDdZnDjS68JOt8URO4PVYVUS11BG542fpw
	QaV0B1yBfjCe9vcK3GLha/4EQ4yw/EJhbjiNsD3gO9ITzm3loAITx9DM7r0aowNJ
	GkmW+suUFSE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B0487138B4;
	Fri, 21 Aug 2009 17:02:19 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D35E138B1; Fri, 21 Aug
 2009 17:02:12 -0400 (EDT)
In-Reply-To: <74ca14c3a691cc9844a0dd806f5db47977317bdb.1250860247.git.mstormo@gmail.com>
 (Marius Storm-Olsen's message of "Fri\, 21 Aug 2009 15\:30\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA1F8846-8E95-11DE-9356-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126753>

Marius Storm-Olsen <mstormo@gmail.com> writes:

> From: Frank Li <lznuaa@gmail.com>
>
> compat/msvc.h includes winsock2.h which conflicts with windows.h.
> msvc.h also defines the oldest Windows API version required.

The first sentence sort-of makes sense; compat/msvc.h will be included by
git-compat-util.h and including <windows.h> here will bring conflicting
definitions, so we avoid doing so when on MSC.

The second sentence does not make any sense to me.  It may be correctly
stating a fact (i.e. "defines required WAPI version"), but it is unclear 
what relevance it has to this change to stop including <windows.h>.

Having said that, the first sentence hints me that perhaps you guys should
include (conditionally only on windows but not with MSC) <windows.h> not
from this file, but from git-compat-util.h?

> Signed-off-by: Frank Li <lznuaa@gmail.com>
> Signed-off-by: Marius Storm-Olsen <mstormo@gmail.com>
> ---
>  compat/winansi.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/compat/winansi.c b/compat/winansi.c
> index 9217c24..0d79845 100644
> --- a/compat/winansi.c
> +++ b/compat/winansi.c
> @@ -2,7 +2,9 @@
>   * Copyright 2008 Peter Harris <git@peter.is-a-geek.org>
>   */
>  
> +#ifndef _MSC_VER
>  #include <windows.h>
> +#endif
>  #include "../git-compat-util.h"
>  
>  /*
> -- 
> 1.6.3.msysgit.0.18.gef407
