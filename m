From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Fri, 19 Jul 2013 09:40:33 -0700
Message-ID: <7vtxjqwlj2.fsf@alter.siamese.dyndns.org>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
	<1374245631-15955-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 18:40:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0DjV-0005LB-AJ
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 18:40:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760340Ab3GSQkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 12:40:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62267 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751857Ab3GSQkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 12:40:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91FC92F5A0;
	Fri, 19 Jul 2013 16:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4084Df7NTzw/QHqG+R2Cepyncrw=; b=qNEL05
	OWtQD56C+YpC1BzF7Z/R5aADQDAG8DhHamo6YeD0kFsvjonkdfixt3SSByofF2PF
	NYKoD8unmvuP2HhpQ60kbvtEHyQZAYPBw8JlZZjl1GkWO905vI6EZCrqzgGS9eqK
	/v1uDD2vYGj5zj4VmPdJZPmpJAQ26X4EQ4cWM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xy+ONlcgo54OL5Z5VK9fHV5hUg9O4yDH
	TAXbHLmQ7Dd2JoBg6/hJZRembJ7N6kpR3S7CCRewLPtM++8N0oWiPncvNt9tv+cX
	LgMhzs/f/iaPawx0wCPFa0zz3qhSA2vBylqUTGDUFICWfMpiqFhFmIqUmGtalViB
	Pe0HcOzvYxw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 851C92F59F;
	Fri, 19 Jul 2013 16:40:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C81872F599;
	Fri, 19 Jul 2013 16:40:34 +0000 (UTC)
In-Reply-To: <1374245631-15955-1-git-send-email-mlevedahl@gmail.com> (Mark
	Levedahl's message of "Fri, 19 Jul 2013 10:53:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF2EFF62-F091-11E2-B088-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230826>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Junio - The above notes are more accurate than in my previous commit message,
> so if this commit survives into next/master, I would prefer this version as
> opposed to the one now on pu (da875762)

Thanks, will replace.

What do we want to do with the compat/regex build-time switch?

IIRC, this was only needed for 1.7 and not 1.5, and I also would
expect (without anything to back-up, so this is more a faith than
expectation) over time the "new library" would have a working regex
library.

>
> Mark
>
>  config.mak.uname | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 174703b..bf5db47 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -164,7 +164,6 @@ ifeq ($(uname_O),Cygwin)
>  	NO_THREAD_SAFE_PREAD = YesPlease
>  	NEEDS_LIBICONV = YesPlease
>  	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
> -	NO_TRUSTABLE_FILEMODE = UnfortunatelyYes
>  	NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease
>  	# There are conflicting reports about this.
>  	# On some boxes NO_MMAP is needed, and not so elsewhere.
