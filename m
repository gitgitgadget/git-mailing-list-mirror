From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/16] pull: cleanup documentation
Date: Thu, 31 Oct 2013 11:11:12 -0700
Message-ID: <xmqqiowd71kv.fsf@gitster.dls.corp.google.com>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
	<1383211547-9145-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:11:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbwiH-00050W-Il
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:11:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755216Ab3JaSLQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:11:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47742 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754765Ab3JaSLO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Oct 2013 14:11:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44E514E42D;
	Thu, 31 Oct 2013 14:11:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=S4vSvJN/NquQM/GKtFmwhxRA0cc=; b=PHjODEjk7Y2TYq0BSPGT
	TySeOdZ8VzHSoZW/inEEKB5Q3u4Y/nN4kHVw6pvujX1E/38tzjIlX29/a5vhk/Jj
	rkFJV6BeEcJAJxFDbvwlHrgndSUkkZO2sTUt/DTRhQAGEXF8M0XVL4io9PxBEDcx
	9/dPm0g9FhpbgIWKHHopmRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=e4PB0rAj7/2VFoGYDJUQV2CnbZhpWHDiVAEqqxwtJNUv48
	mWmoSn08erryxoTV7yVMTnl4wtGbJKFk/9U0bV5HVih79W0/z+dDfG0U3yh5oRLE
	H/seEXKw7Dd1kayWAJlnoulDqsD+YQf08iMEqNioOpb0mCt5OWzmpcd/YsJUo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 36A0D4E42C;
	Thu, 31 Oct 2013 14:11:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 757404E42B;
	Thu, 31 Oct 2013 14:11:13 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D3D6C4A8-4257-11E3-9639-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237142>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> 'origin/master' is very clear, no need to specify the 'remotes/' prefix,
> or babysit the user.
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---
>  Documentation/git-pull.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
> index beea10b..03a39bc 100644
> --- a/Documentation/git-pull.txt
> +++ b/Documentation/git-pull.txt
> @@ -39,7 +39,7 @@ Assume the following history exists and the current branch is
>  "`master`":
>  
>  ------------
> -	  A---B---C master on origin
> +	  A---B---C origin/master
>  	 /
>      D---E---F---G master
>  ------------

This change is wrong; the illustration depicts the distributed world
(i.e. a fetch has not happened yet).  The next sentence after this
picture reads:

    Then "`git pull`" will fetch and replay the changes from the remote
    `master` branch since it diverged from the local `master` 

In other words, your (remotes/)origin/master has _not_ caught up to
the reality.

> @@ -51,7 +51,7 @@ result in a new commit along with the names of the two parent commits
>  and a log message from the user describing the changes.
>  
>  ------------
> -	  A---B---C remotes/origin/master
> +	  A---B---C origin/master
>  	 /         \
>      D---E---F---G---H master
>  ------------

This is a good change, especially in today's world.

Thanks.
