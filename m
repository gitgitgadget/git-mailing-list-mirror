From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] transport-helper: update remote helper namespace
Date: Thu, 18 Apr 2013 10:30:57 -0700
Message-ID: <7vobdb690u.fsf@alter.siamese.dyndns.org>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
	<1366258473-12841-7-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:31:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USsfn-0003K3-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967236Ab3DRRbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:31:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52959 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967001Ab3DRRa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:30:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 101B9175AC;
	Thu, 18 Apr 2013 17:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=oDH2hmFtVZ60/qilt7O+zEm6H8s=; b=SAaIw5PiA0/KELOQ2rZX
	qOnDAvgZBMaFz/VuY5QKoZZoQkS0QZ8mT8ogo1lrcuP6nCjcZxEtyt8cy+Tg4M7u
	dATIpjnHZNhJeh5iIsBXWFCIpH80j9RRdfNC34yiXDyd8Lti8jzk1iWsJ66Rli4h
	kjVoP34Ef1OnqmiO7U6tUPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=YsDpMmU3BQ8B5SXFV1MfDZWJ/hUS2heEfURDNdAWfmKGxw
	McDTwzkBFetOhmniYvPNfe3FiVXUCqiGtXFMSJx58m/LuyZG8cAjAbhP4za+F2a6
	m5EcS3ruJbblx0YKNt2hhSyNTyTonlqPrbUPQ8HzQ2M4r+aaJxth9EGBcYGZw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05F28175AB;
	Thu, 18 Apr 2013 17:30:59 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63C0B175A7;
	Thu, 18 Apr 2013 17:30:58 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BB6E772A-A84D-11E2-AF60-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221676>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> When pushing, the remote namespace is updated correctly
> (e.g. refs/origin/master), but not the remote helper's
> (e.g. refs/testgit/origin/master), which currently is only updated while
> fetching.
>
> Since the remote namespace is used to tell fast-export which commits to
> avoid (because they were already imported/exported), it makes sense to
> have them in sync so they don't get generated twice. If the remote
> helper was implemented properly, they would be ignored, if not, they
> probably would end up repeated (probably).
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

This one looks suspiciously familiar ;-).

I'll drop the last one I queued and pushed out a few days ago and
replace it with these 6 patches.
