From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] commit: show interesting ident information in 
 summary
Date: Thu, 14 Jan 2010 11:15:12 -0800
Message-ID: <7vy6k0cxbz.fsf@alter.siamese.dyndns.org>
References: <20100113173408.GA16652@coredump.intra.peff.net>
 <20100113184510.GA22849@coredump.intra.peff.net>
 <5722BD3D-E7C9-47F7-B547-09B14D87DA39@wincent.com>
 <201001141602.22244.trast@student.ethz.ch>
 <94a0d4531001141104w74dbaf35jb5fded9e266bc04b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Megacz <adam@megacz.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 20:15:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVVAN-0006tA-8T
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jan 2010 20:15:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304Ab0ANTPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 14:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757366Ab0ANTPa
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 14:15:30 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:50248 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362Ab0ANTP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 14:15:29 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4905B902FC;
	Thu, 14 Jan 2010 14:15:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ufdeYV9PB7+LNeG9M18po7LJhtg=; b=npBbUq
	LyOw1ZnqJckW+TiX7M9Xnqf6cMQsWDIT3wza4uEme1QR/P0+IWPcbZsIDzz1ExCq
	eqPxFXKzCFxQIxwwyXnPWAwfVzbyBUrPefO4mJsGXAS3uaQ70fprerK1EV7WmGsG
	YwmoxInBTsGJcYCPxK5ng7zZIfN7afRxFn2os=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r9K58DlvbN9M4QrwL2Nq71CbbJl5+cWt
	6hD7d2cU1PQReKmLtv2S6YrDUAA8RtpusQrio/XiH+d17Z4lhDaDBVF+8VwFjfJd
	ANNyV+UQOtqP2XCLj8NX/VqVCTxKqN85eEI83em8w9ZSCC6qcEdLXCmFbR/lVzku
	is0QliQ5wvM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E2518902F5;
	Thu, 14 Jan 2010 14:15:20 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C27E1902EB; Thu, 14 Jan
 2010 14:15:13 -0500 (EST)
In-Reply-To: <94a0d4531001141104w74dbaf35jb5fded9e266bc04b@mail.gmail.com>
 (Felipe Contreras's message of "Thu\, 14 Jan 2010 21\:04\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 2888DB1E-0141-11DF-B1B7-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137012>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Thu, Jan 14, 2010 at 5:02 PM, Thomas Rast <trast@student.ethz.ch> wrote:
>> Wincent Colaiuta wrote:
>>>
>>> Fair enough, but I'm sighing here at the thought of people jumping in
>>> and using git commands without even having looked at _any_ of the
>>> zillions of "your first 10 minutes with Git" tutorials out there,
>>> which pretty much _all_ start with how to set up your user.name and
>>> user.email...
>>
>> If you really are shocked by that thought, try hanging out on #git for
>> six hours on any given day...
>
> Which is precisely why I was pushing for this:
> http://thread.gmane.org/gmane.comp.version-control.git/131150

I think the point of the message you are responding to is that it has
already been proven that there are users that never reads any of the
zillions of "your first 10 minutes with Git".  How that _could_ ever
possibly be the reason/justification why you would want to push that
change to our documentation?
