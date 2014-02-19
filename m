From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] test-lib: allow setting the index format version
Date: Tue, 18 Feb 2014 16:31:38 -0800
Message-ID: <xmqqlhx89c45.fsf@gitster.dls.corp.google.com>
References: <1392492197-7724-1-git-send-email-t.gummerer@gmail.com>
	<1392492197-7724-3-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 19 01:31:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFv4m-0006NA-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 19 Feb 2014 01:31:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529AbaBSAbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 19:31:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752478AbaBSAbk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 19:31:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 39E906EED0;
	Tue, 18 Feb 2014 19:31:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=D+cCO6aOZNSt3Rv1hffdJdKz/4U=; b=HfePTghu1XdmvKCqDUDD
	fPIrwLfE6Yl+1HHPuYIUhyf2JtS6DjWbVZ3WUtdV+81EpreVTuR+XDe354WNbuHF
	OxzomX5dMgl+KqJHndUedim3VFHs747IVWn6SgZkT9fPLvPwYELqjtC8Q9D/GVps
	4PZp3P3SAgt15A+owKT+vhU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=b+r+HD+/hTgsfAuPQ72JB0GoViQr43rv1HuNROnoEpfFpS
	NqlQUosnb1Y1J8FFmD20AYwYi8OsgsWrF8WbVfV2r0PtsCPKA8cN763HtOABG5vS
	EX8vrgd9zTsGobJH+vwqySkaM0aDtyu+0GAC4hUjYNHoD4D8MAOKE0b5JxsI8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2474B6EECE;
	Tue, 18 Feb 2014 19:31:40 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B36E6EECD;
	Tue, 18 Feb 2014 19:31:39 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 329BDD42-98FD-11E3-B189-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242380>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Allow adding a TEST_GIT_INDEX_VERSION variable to config.mak to set the
> index version with which the test suite should be run.
> ...
> diff --git a/Makefile b/Makefile
> index 287e6f8..c98d28f 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -342,6 +342,10 @@ all::
>  # Define DEFAULT_HELP_FORMAT to "man", "info" or "html"
>  # (defaults to "man") if you want to have a different default when
>  # "git help" is called without a parameter specifying the format.
> +#
> +# Define TEST_GIT_INDEX_FORMAT to 2, 3 or 4 to run the test suite

s/_FORMAT/_VERSION/, I would think.

Will queue on 'pu' with a fix-up on top.

Thanks.
