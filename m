From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: re-allow HEAD:Documentation on a remote
 invocation
Date: Wed, 11 Jan 2012 19:03:36 -0800
Message-ID: <7vehv54o6v.fsf@alter.siamese.dyndns.org>
References: <20120110232132.GA29245@sigill.intra.peff.net>
 <1326283958-30271-1-git-send-email-cmn@elego.de>
 <7vipkh4oyn.fsf@alter.siamese.dyndns.org>
 <20120112025445.GB25365@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Albert Astals Cid <aacid@kde.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 12 04:03:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RlAx5-0007rH-SN
	for gcvg-git-2@lo.gmane.org; Thu, 12 Jan 2012 04:03:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752449Ab2ALDDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 22:03:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752392Ab2ALDDi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 22:03:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22A876CBF;
	Wed, 11 Jan 2012 22:03:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hgnJxwbIz/lg3TPv4E3hbIgkyOg=; b=AFXrrN
	c+haYGrwFyrQG89lqd942dFgzxFhOvLsOYrR/blQLiRnggeEmtR4A35gWqaqlQMD
	Yz6PpIRQNykztMcx8IKNfU3tpCYKfWABrOq+pqUKlrKVQHoCLLm/9WfW1jaUdDmS
	rnCbuyZRrr+OtOCpnCG9TzPJz1xJ6IJwYfhLw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DcJj3cZlGI581gnv98foDrHobwQkhhuV
	wVL7HWvu9ZxTE8LkwMFXu6jDr3HCYwoffIu/mgVPdJw2HRnAVSfGn6rMWkdcsi45
	a2Qij6UsRiIYMRk4BngYZCzvLOgN80Mth45TEbt0/0i2tX7pcnqFwFOPYeRxUXLq
	B2FoS3CiRqU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A80D6CBE;
	Wed, 11 Jan 2012 22:03:38 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7AFA66CBC; Wed, 11 Jan 2012
 22:03:37 -0500 (EST)
In-Reply-To: <20120112025445.GB25365@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 11 Jan 2012 21:54:45 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05BCED7A-3CCA-11E1-ADD4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188422>

Jeff King <peff@peff.net> writes:

> I see it the opposite way. People are clearly using the "$ref:$path"
> syntax. So why would we restrict them from doing so? There are no
> security implications (i.e., they could always just grab $ref and
> extract $path themselves). In my view, ee27ca4a was over-eager in its
> restrictions because I wanted it to be simple and close the hole. Now we
> can take our time adding more code to loosen it.

Ok, so it is more like a partial revert of whatever we did. In that case,
I'd take CMN's patch to limit the extent of the changes, as it more
closely matches the spirit of the original ee27ca4 (archive: don't let
remote clients get unreachable commits, 2011-11-17) that singled out and
catered to the need of "archive" command alone. It is already part of the
v1.7.8.1 release, so I would prefer a change to be stupid and simple.
