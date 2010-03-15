From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase--interactive: don't enforce valid branch
Date: Mon, 15 Mar 2010 10:14:28 -0700
Message-ID: <7vbpepse17.fsf@alter.siamese.dyndns.org>
References: <1268628502-29696-1-git-send-email-cxreg@pobox.com>
 <7vsk82i2kd.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1003142227100.796@narbuckle.genericorp.net>
 <7vvdcygmz8.fsf@alter.siamese.dyndns.org>
 <7vd3z6f6wt.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.1003150132060.4362@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 18:15:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrDsa-00049n-IS
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 18:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965518Ab0COROf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 13:14:35 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52378 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965508Ab0COROe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 13:14:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 891D4A2628;
	Mon, 15 Mar 2010 13:14:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=N41ITYD3wfikf0ne4dTZRf7Qi2s=; b=X2jU3CfimD3QSsTH8f1hO90
	E3cJ9waZqBSJzopKpIvIvp/kBeX6tYePeA7M2iWpEQCgztlDTAaIe2W6LsgckJM8
	tA8Fg9pDnp+NmgeXxAPuUj7l1TlYks9g2WrpSySJNO9Ftl5XJaUlED6OhMiyA5jT
	bg3g0glMJIZVavTkFIgE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=CyWgMJu3y7n0jeQtqE7NCtNCl1oMoXfmEP3dbOQj/TcRaSc+5
	pzKEIrZt5TtZajbPSV4bDE1AhiCD48hieX/OaXv+njnf7k5Dy8F2DOsgdopwdgkp
	iyjnAF8cZxXNiO6QTeR/nV5AOSoummSUdao4XXbzfgoXM4LqYnIkJ2CrSc=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5AB5BA2626;
	Mon, 15 Mar 2010 13:14:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF3D8A2624; Mon, 15 Mar
 2010 13:14:29 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 38D6D54A-3056-11DF-BD0A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142227>

Dave Olszewski <cxreg@pobox.com> writes:

>> Also I did't follow the code, but does it behave sanely when you say
>> "rebase --abort"?
>
> Good question.  It turns out that both rebase and rebase -i will end
> up on the commit specified by <branch>, whether it's a branch or not.
> That might be the expected and desired behavior, though:
>
>   [Starting on branch A]
>   git rebase origin/B B
>   git rebase --abort
>   [HEAD is now a symref to B]
>
>   [Starting on branch A]
>   git rebase origin/B B^0
>   git rebase --abort
>   [HEAD is now detached at B^0]

Yup, that is what I would call "behave sanely".  Thanks for clarification.
