From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 08 Feb 2013 09:11:28 -0800
Message-ID: <7vsj563f3z.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <5113E849.8000602@elegosoft.com>
 <CALkWK0=53riU3xKbKkyAVS8--9VoAU5P6h88MQ9-geW=H5+a-w@mail.gmail.com>
 <20130207233017.GD19397@google.com> <7v38x766b2.fsf@alter.siamese.dyndns.org>
 <20130208074813.GA7337@elie.Belkin> <7v622343uy.fsf@alter.siamese.dyndns.org>
 <5114D5B0.5080906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael Schubert <mschub@elegosoft.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 18:11:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3rUR-0002R3-B5
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 18:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946746Ab3BHRLb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 12:11:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51160 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946671Ab3BHRLa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 12:11:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 271DDB1DC;
	Fri,  8 Feb 2013 12:11:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/+jG4xj6155UK+iYqbJp3PTCU5U=; b=ZzSYaU
	IXdU4vRZWg1hn5St9vbRZrmn+6BpdGg6Z7bKpGgCij+1/gibJ7NGcRlTIsZ1Y9op
	hfgpEwcHFMSGMtWJZVt6n3ori30607yMU+clfe5PBTkP+d66h3El51rudyE5pjOt
	ctYhHyWNEbpb3UKpvNqF6Va3LDhXXmD9RohT0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EUigYVbM8glIMUAEsgiSGkkviQM1wplu
	5NjNDDjkz4r6mK+Iar4fg9AoHe3MMO00zDbiP0RKlymPohu8tNkN6xOCPpvousBu
	8CjfpwlULfht6jDN4lsvmIsHK6kXg4tWUHJ6HAoMPfHkDOjn7SKZhYpA9qoy/JH0
	qYWaqzNuxrA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A9BFB1D9;
	Fri,  8 Feb 2013 12:11:30 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 88A0DB1D8; Fri,  8 Feb 2013
 12:11:29 -0500 (EST)
In-Reply-To: <5114D5B0.5080906@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 08 Feb 2013 11:38:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 942FECB4-7212-11E2-8C45-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215783>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> As for the triangle remote, I really think we should clean up the
> situation regarding push, pushurlinsteadof and the various different and
> inconclusive output formats of "git remote" (with or without "-v", with
> or without a remote name) first, before introducing yet another way to
> twist things around. "git push downstream" does not hurt any kittens
> (while git remote ouput does, somehwat).

As people tend to fetch more often than they push if they are
working on a real project where the others as a whole will be far
more productive than any single individual, I agree that keeping
"git fetch" (or "git pull") lazy by having "origin" point at where
they fetch from and be a bit more explicit in "git push" would
actually make sense.
