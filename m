From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] t5700: document a failure of alternates to affect
 fetch
Date: Sun, 12 Feb 2012 19:35:19 -0800
Message-ID: <7vsjifids5.fsf@alter.siamese.dyndns.org>
References: <1328941261-29746-1-git-send-email-mhagger@alum.mit.edu>
 <1328941261-29746-2-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Mon Feb 13 05:00:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rwn58-0007vZ-LS
	for gcvg-git-2@plane.gmane.org; Mon, 13 Feb 2012 05:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab2BMD76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 22:59:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49794 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754097Ab2BMD75 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 22:59:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 996FF6E2F;
	Sun, 12 Feb 2012 22:59:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=lzzSz2gYEAVYyqdABzvxLHwLlww=; b=u8yHl1rOk4JIBvykEY43
	dyeVxO3UDtD3KmLlVXqMCUcQspmu0PfzGrL0QYtOg1+W/V/nxI25jPwLZmZFkFHW
	vaZUsVEfmkWhX4R7nFTVTzrXAAfQRScYu2aN+dKKD5f08M+7YFkT04ZbLW5EUuMP
	ktHGqDCpfyFE4uRWtyPGaBk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=lc0LA9/A/OzgTmrPzhEH/oxx37hwfCwbEUrQw1MTtWo5As
	y7eOL+GVwlAa7dfy4k1HAZRKM5fyDurJKLA6xXId/AZ2KcpPm9uwzL0Y8/1W8spk
	tF6d5sHJeOqkHDDTCCRuOgLjoyAzN+/s8D14+sJoqpUr1ohiDem/RvDCrUeCI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 903606E2E;
	Sun, 12 Feb 2012 22:59:56 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 275EC6E2D; Sun, 12 Feb 2012
 22:59:56 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30CB4EBC-55F7-11E1-B854-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190601>

mhagger@alum.mit.edu writes:

> +test_expect_success 'prepare branched repository' '
> +	git clone A J &&
> +	(
> +		cd J &&
> +		git checkout -b other master^ &&
> +		echo other > otherfile &&

s/ > / >/; but that is nothing I cannot fix locally.

> +test_expect_failure 'fetch with incomplete alternates' '

I am assuming that this "incomplete" means "this alternate helps reducing
the number of objects we need to fetch from the remote, but it does not
have everything objects we need, and we still need to fetch some from the
remote".  Am I correct?

I do not think you meant the alternate repository is in some way corrupt,
but I am just making sure, because I found the phrasing a bit odd.
