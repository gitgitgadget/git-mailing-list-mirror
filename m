From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 08 Feb 2013 00:16:53 -0800
Message-ID: <7v622343uy.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com> <7v38x766b2.fsf@alter.siamese.dyndns.org>
 <20130208074813.GA7337@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 09:17:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3j9A-0003cT-3e
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 09:17:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760031Ab3BHIRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 03:17:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759790Ab3BHIQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 03:16:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28FCF99CD;
	Fri,  8 Feb 2013 03:16:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qJQIGHB81niF8rpJbt4YM96BI2o=; b=h0Jlz8
	wJ28hmP6ODY0dMEdvvV4bx71Y83hKSU0ArmgTSKSH7d3X7T3hfL/+8/xmakiqDGT
	aWbNnNTBaC8uxXgv/idSgytAjDRS5uX9L5uMwd1awkX5DgZRFMUhVhsxTzO9pSMQ
	4LH0fyL53hx3TI0pufWDrtNBL6PzhWduudq1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hdDaYXcpPAEwXUYovNhGoiBSH37OnH3E
	/svh7EswkOcjOWf9IlKjfHkoVZUKmv/hRTImHNkh248aeUkxcVQNT9IvKAfxczSH
	Kkxhl6aXwpyIl8IySBqlCi9ni2CLSrpJWa+INZYIufgfBk7/NWFwrRV8da7iV3t4
	51bt67W/Gyg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C47B99CB;
	Fri,  8 Feb 2013 03:16:56 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8288A99CA; Fri,  8 Feb 2013
 03:16:55 -0500 (EST)
In-Reply-To: <20130208074813.GA7337@elie.Belkin> (Jonathan Nieder's message
 of "Thu, 7 Feb 2013 23:48:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E693FB80-71C7-11E2-BE54-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215766>

Jonathan Nieder <jrnieder@gmail.com> writes:

> "Wait, why did the remote rewind?"

Oh, I am very well aware of that glitch.

"git push" has this hack to pretend as if the pusher immediately
turned around and fetched from the remote.

It shouldn't have been made to do so unconditionally; instead it
should have been designed to give the pushee a way to optionally
tell you "I acccept this push, but you may not see it to be updated
to that exact value you pushed when you fetched from me right now".

The hack is not my design; it was not even something I accepted
without complaints, so I can badmouth about it all I want without
hesitation ;-)

More importantly, we could fix it if we wanted to.
