From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-remote-testgit: avoid process substitution
Date: Fri, 26 Apr 2013 15:25:05 -0700
Message-ID: <7vobd1udz2.fsf@alter.siamese.dyndns.org>
References: <7vvc7enxco.fsf@alter.siamese.dyndns.org>
	<7vwqrtgi1r.fsf@alter.siamese.dyndns.org>
	<51779052.8020507@viscovery.net>
	<CAMP44s1oX_m0d+2Z3+VkafOhT1bZK_9Z5m1ex456DMdAidEKeg@mail.gmail.com>
	<5177980A.4090305@viscovery.net> <5178C583.6000703@viscovery.net>
	<CAMP44s2nWs3XyaLQUnYd=A9u1=8tB7Qp+FN7gf+SrACxmtP8pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 00:25:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVr4t-0001Y2-8Q
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 00:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab3DZWZI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Apr 2013 18:25:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46924 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab3DZWZH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Apr 2013 18:25:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 292881A127;
	Fri, 26 Apr 2013 22:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QGv7W9djIqvE6NfPnfdVZdK6KIk=; b=sHl93V
	eSUeJbjrKFvft9HJtJGpGai8mUDMb5Y7SwGIjlEjjI3mUY+jcbG21g13nvIBF9Sz
	pZWshq8wPTgSDgBqRhm/lQ6fdlROJNm+rY12rCZA2cPuEOricgl4ZRJJheJCst31
	L9c9zVCjuszq3O28ZLr4iLVoIM4VryoStxN/U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uGKsLRdHCnLviIhpYk1P4zyTxFn8VE3G
	yfN3Qpr+yd/w68pvs01xxvR/vESqAo0v3qRvU9E41DgTWQiTgf+8zE7v5Sj2APHd
	TPrZWHKLoinkVIxWRsuW+hbLYBK5B9hszvvgokVKc42Pjs4aVGJ+Tmp0tapbPouN
	bS8WKAZ2WI4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 202481A126;
	Fri, 26 Apr 2013 22:25:07 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 834761A125;
	Fri, 26 Apr 2013 22:25:06 +0000 (UTC)
In-Reply-To: <CAMP44s2nWs3XyaLQUnYd=A9u1=8tB7Qp+FN7gf+SrACxmtP8pw@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 26 Apr 2013 16:56:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 25C9B4A4-AEC0-11E2-9046-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222599>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Apr 25, 2013 at 12:56 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> From: Johannes Sixt <j6t@kdbg.org>
>>
>> Bash on Windows does not implement process substitution.
>
> Nevermind, reporting all the refs creates a lot of irrelevant output,
> this version is fine.

When $before has this in it:

	refs/heads/refs/heads/master 664059...126eaa7

and your "read ref a" got this in the input:

	refs/heads/master 664059...126eaa7

would the pattern matching by case work corretly?

>
> Acknowledged-by: Felipe Contreras <felipe.contreras@gmail.com>
