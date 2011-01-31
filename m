From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Mon, 31 Jan 2011 12:57:02 -0800
Message-ID: <7vvd144wrl.fsf@alter.siamese.dyndns.org>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
 <7vwrll57ha.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1101311459000.8580@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Jan 31 21:57:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pk0oH-0003do-7I
	for gcvg-git-2@lo.gmane.org; Mon, 31 Jan 2011 21:57:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755994Ab1AaU5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Jan 2011 15:57:12 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753746Ab1AaU5L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Jan 2011 15:57:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 431C541B4;
	Mon, 31 Jan 2011 15:58:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ey0PB0EW+CIrt6AVdkQfa9pUWhQ=; b=TvXD5R
	mdllNMYizJ1zAYX122V3ta5NrfoZyMKOfk32+uLwNu/3CRCIaJN34cjEyFGbNr4/
	t4Kgil+cH/LOGnRLZ8OH+FhPhCueoZm4i3dgx42zyBFw8ktt5OCegJ5oq3w9jmJS
	UwT9GT8WDYAm/LQWLlUroQHoUmvtgEWnoS1Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=V90Tuu+M6dWFlHcfPuD2o7gAYwJtD+jr
	l+3Q0sAYmCUFJVPS74viAwnxtAYeIvR9Uw+Ha3NzOl39YD+mMXVs9ZfhgVXsGz8h
	j5VNo4dMoXUOJEyq7O8fc4srwDUWSaWQZipI0VfSu1h0rLeXcQVgp1BGKp+pWyw+
	B2x1DPw/nbk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1CE2041B2;
	Mon, 31 Jan 2011 15:58:01 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EA71941AE; Mon, 31 Jan 2011
 15:57:56 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1101311459000.8580@xanadu.home> (Nicolas
 Pitre's message of "Mon\, 31 Jan 2011 15\:28\:37 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CA155A80-2D7C-11E0-B985-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165751>

Nicolas Pitre <nico@fluxnic.net> writes:

> 1) Create a src/ directory and move *.c, *.h, *.sh, *.perl, *.py and 
>    the builtin directory from the root directory to it.
>
> 2) Create a build/ directory, or bin/ if prefered, to hold the result of 
>    the build.
>...
> 6) And fix up all the Makefiles to cope with the above movements.
>
> What do you think?

Knee-jerk reaction: not very motivated to make the top-level directory
just a skeleton that holds various directories with a handful of
administrative files like Makefile, README, etc.  Under your proposal, the
bulk of the current content at the top would simply move to another single
directory anyway, so I don't immediately see much point of such a move,
other than adding merge burden on me and rebase burden on others, that
is.

But that is just a knee-jerk reaction, just to fill the "Risks:" section
you didn't fill.  Your missing "Migration Plans" section might outline a
clever approach to lessen the interim hurt while merging in-flight topics.
