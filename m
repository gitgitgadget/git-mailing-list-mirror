From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: add missing configuration variables
Date: Fri, 17 Dec 2010 12:44:36 -0800
Message-ID: <7vei9gi0y3.fsf@alter.siamese.dyndns.org>
References: <1292395613-12859-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <20101215130046.GB25647@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 17 21:44:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PThAd-0003BK-SH
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 21:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab0LQUou (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Dec 2010 15:44:50 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:35426 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab0LQUot (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Dec 2010 15:44:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 22413362E;
	Fri, 17 Dec 2010 15:45:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ol38+NqFSDiRNiH5ya4rz8gqQNA=; b=THtfEW
	vHT02I0qPISo813tgyC6yN5Wf9rieSFtJs4iAYRD/iFDmbKklYI4oEgmBPZcr+Kg
	R5dmbegy1V3+X+NMiimy1kWSMqu7SZKwiLgOughlZ0IodMH2NF1tnI4BJ0+yBPJj
	8zjJdBFrWpOmjwVR0P6aNWS89vlZZhjHk74Zo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=x0fpC6Xh4zFaPEEK2Rig3AXFazsNBY8K
	QXMmCr7OFwqjJs+XuCbVxYd/Dca+u7wpQDyacnfdQL5zm57hm1Vttn4zcgndmyeu
	u+bGGocKAh+wJE8FG/42yjBxEWMAUDO39Jc7yt/Yo/25285bshAgv1YZImZdHRSW
	FRgAvE2bDw0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E3D84362D;
	Fri, 17 Dec 2010 15:45:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 97A9A362C; Fri, 17 Dec 2010
 15:45:06 -0500 (EST)
In-Reply-To: <20101215130046.GB25647@sigill.intra.peff.net> (Jeff King's
 message of "Wed\, 15 Dec 2010 08\:00\:47 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8B078FCE-0A1E-11E0-B2C2-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163889>

Jeff King <peff@peff.net> writes:

> All variables are case-insensitive. The config parser down-cases them,
> so all code should treat tham as all-lowercase. However, we tend to
> document them as camelCase for readability.

Careful.  The second level of three-level names is supposed to be usable
for user defined names (e.g. names of branches and remotes) and I think
the completion code should not downcase it.
 
