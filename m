From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Makefile: add missing GIT-VERSION-FILE dependency
Date: Thu, 31 May 2012 12:42:11 -0700
Message-ID: <7vy5o85e98.fsf@alter.siamese.dyndns.org>
References: <1338473444-8960-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, nickh@reactrix.com
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 31 21:42:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaBGE-000536-EX
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 21:42:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933206Ab2EaTmO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 15:42:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64628 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933202Ab2EaTmN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 15:42:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 555558CF5;
	Thu, 31 May 2012 15:42:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MPRhpIdgFuL1naeh+N4ioeaA7oE=; b=Sp1UgG
	L+jhJtkOW9L/SbrSfq5M3nle6IfSpI3VJGKy7n4r/mSGEeiUEGqLAzfIgtL+GWfJ
	mvdcOvwlAUtOip+AX2zR8oUakKh+ftPqqFoAT/GdD64Qnkr1eObzGNW9vSMNTfOp
	5bxHLM2nbbUi2mxLzUYli6HXXPd995gHywAgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XH4hVOAfQ0htnl6TsEwNuCNDlB43mv5x
	NByzi12rbggBd6sDNRpQxH3XzErNZVRnCIukLCgrs9WD7e2i+0Vh0KOh1aPSr+v3
	d9QWoxjx1iAUGdzqCwep8MBNgnkBtHPnhj7m9XoX+E6A3UGS6oWBYwhAOTEmWrER
	P+T3lmTOvQ0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CCCD8CF3;
	Thu, 31 May 2012 15:42:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C17B78CF2; Thu, 31 May 2012
 15:42:12 -0400 (EDT)
In-Reply-To: <1338473444-8960-1-git-send-email-kusmabite@gmail.com> (Erik
 Faye-Lund's message of "Thu, 31 May 2012 16:10:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7DD5B78-AB58-11E1-9772-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198943>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> In 20fc9bc (Set HTTP user agent to git/GIT_VERSION, 2006-04-04),
> http.o started recording GIT_VERSION, but http.o wasn't added
> to the list of files that depends on GIT-VERSION-FILE.
> ...
> diff --git a/Makefile b/Makefile
> index c09a679..59e2b25 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2104,7 +2104,7 @@ configure: configure.ac
>  	$(RM) $<+
>  
>  # These can record GIT_VERSION
> -git.o git.spec \
> +git.o git.spec http.o \
>  	$(patsubst %.sh,%,$(SCRIPT_SH)) \
>  	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
>  	: GIT-VERSION-FILE

Makes sense to me.  Thanks.
