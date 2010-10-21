From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 00/21] git notes merge
Date: Thu, 21 Oct 2010 16:20:22 -0700
Message-ID: <7vaam7rv49.fsf@alter.siamese.dyndns.org>
References: <1287626936-32232-1-git-send-email-johan@herland.net>
 <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	jrnieder@gmail.com, bebarino@gmail.com, avarab@gmail.com,
	gitster@pobox.com
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 01:20:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P94RC-0001cQ-0A
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 01:20:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752901Ab0JUXUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 19:20:39 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37221 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751098Ab0JUXUi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 19:20:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2390DE0362;
	Thu, 21 Oct 2010 19:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wM2WMl/LARowXchdJevAAsdwA1Q=; b=qsGNKe
	TnS9Zu2giUKK/3y0tkEZg/tzwEqi8sP2u2HXfMJOZCJ27pdkqrcb7rpdFOH8giyd
	IM26ygArjgElCMbHr+gYSGYUo+ZCzSNYfvh2Nvlb8Js5uk+9QCg3SVtBay67czfO
	iGt6VVXII65vYxmQ9iGsOc46QXhSe9gfruPZ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LCHD2briiKIcmdC6NEJRKQwq6kxBWFxT
	v8405pijGT8U3GNc5NaKYzvNnjCngvWiGS+HVkSd4EIvUlGA+T3uIHOkSDCUV+vH
	bI6fXMKOoiWdfcu4Ijk7mGaJiEArldw+pUslj4sgtZtHhiTV5m8dTl2gu5bv1euc
	iMsFaqSOIwY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFD78E0360;
	Thu, 21 Oct 2010 19:20:31 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 942B2E035A; Thu, 21 Oct
 2010 19:20:23 -0400 (EDT)
In-Reply-To: <AANLkTi=YJd023C3rX_G+NEM_0N-nZqd0uP7yyTSt1tHj@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 21 Oct 2010 16\:00\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CC843AC4-DD69-11DF-BB32-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159588>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Can someone comment on whether "git reset --merge" is a good
> implementation of "git merge --abort"? If we can get an Ack from
> someone I'd love to see this implemented.

I think it depends on in what state you started from and how the merge
operation stopped.  If your index was clean, probably yes, but "git reset
--merge" may not be something you may want to do if the merge stopped
because you had previously added something.
