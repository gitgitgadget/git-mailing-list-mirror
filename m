From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix "is_refname_available(): query only
 possibly-conflicting references"
Date: Mon, 14 Nov 2011 23:24:14 -0800
Message-ID: <7vty65x2zl.fsf@alter.siamese.dyndns.org>
References: <1319804921-17545-27-git-send-email-mhagger@alum.mit.edu>
 <1321336525-19374-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 15 08:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQDNV-0007L6-Vw
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 08:24:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1KOHYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 02:24:17 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57016 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab1KOHYR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 02:24:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 600F526FD;
	Tue, 15 Nov 2011 02:24:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ez2e+oGnYBlz5fxH5ExJCxyqFo0=; b=Dg+nPT
	7xaNNcq/0Z1dYjhtOnIHePkEciDKSuaYzFlHI9Ju7r8XRXay5r5HySrNjgJ/spum
	gkjn07IJBvncOe2cIxccDrELfSOQFuMibH/48VnIaQHgY9y8H6eazL25vb6rhEF0
	YI2u14nOqcSxJGCYEjVn+6E9mBJb7OFqsgfSw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cia4FSLXkSA62h2f455TGZK9/t7tks7K
	5Hvla1vlef+g2jq2CtyOAmsweCvjnkgn/JzWIdWBmXP2UHHhuMnU2F7revfHrq3F
	mWlEcg2X2YFBPSpSFAnOF12HMAUaIcMaVOWLveBBGwpJhZpKPZY4RvcuyaSOfO53
	2ytadg+8yYQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 56ABD26FC;
	Tue, 15 Nov 2011 02:24:16 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C729026FB; Tue, 15 Nov 2011
 02:24:15 -0500 (EST)
In-Reply-To: <1321336525-19374-1-git-send-email-mhagger@alum.mit.edu>
 (mhagger@alum.mit.edu's message of "Tue, 15 Nov 2011 06:55:25 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2F454BA-0F5A-11E1-B59C-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185438>

mhagger@alum.mit.edu writes:

> This patch can be squashed on top of "is_refname_available(): query
> only possibly-conflicting references", or applied at the end of
> mh/ref-api-take-2; it does not conflict with the two commits later in
> the series.

Thanks. At the microscopic level (i.e. in the context of the said series),
the patch makes sense to me.

However, I'd rather see us spend effort to make absolutely sure that other
topics already in next that touch the related codepaths (I think you have
two such series yourself and I suspect there are other minor fixes that
may textually conflict) are in good shape and have them graduate early
after 1.7.8 ships, before queuing a re-roll of the ref-api series, which
is rather extensive.
