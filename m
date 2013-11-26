From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git issues with submodules
Date: Tue, 26 Nov 2013 11:33:58 -0800
Message-ID: <xmqq1u23vty1.fsf@gitster.dls.corp.google.com>
References: <20131122151120.GA32361@sigill.intra.peff.net>
	<CAErtv25zrsde7wYg+VUZebow2pmhDnDQG53Dmz_gbjavC-D2cA@mail.gmail.com>
	<CALkWK0m9MK=RBBor-ZeGrGU9KA6tZa89UUi0J7j9fxr1g6uJtQ@mail.gmail.com>
	<CAErtv24Lv1JegCBQ=TXvOsgBNHp=Rphk5YVAq2qqRbNmqfNSkw@mail.gmail.com>
	<CAErtv24P+wyZKvvuuPJJ0oxzMif7XtOwJDtKcTKQdKHZaAUbig@mail.gmail.com>
	<CALkWK0muxsRUtO6KYk5G3=RVN0nqd=8gOZn=jsNbTc4B9KCATQ@mail.gmail.com>
	<528FC638.5060403@web.de> <20131122215454.GA4952@sandbox-ub>
	<20131122220953.GI4212@google.com> <52910BC4.1030800@web.de>
	<20131124005256.GA3500@sandbox-ub> <52922962.3090407@web.de>
	<xmqq1u24xkjq.fsf@gitster.dls.corp.google.com>
	<5294EC11.2010405@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Sergey Sharybin <sergey.vfx@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Nov 26 20:34:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlOOm-0000c0-R7
	for gcvg-git-2@plane.gmane.org; Tue, 26 Nov 2013 20:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756723Ab3KZTeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Nov 2013 14:34:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40436 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752690Ab3KZTeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Nov 2013 14:34:11 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FD01549BF;
	Tue, 26 Nov 2013 14:34:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JZlUAqwEiuXmLr3QUT9l5apRCxc=; b=l9BQap
	HztWRdlt1AtMV+6STZ6bX6Tm6D6bW9Np/Q/N51UaB2LWGYioRKMqoKy/c89TWyhx
	9ev5xUTCuGqwBkrd3t+qwt5Bynggs0MS4plzGoStsN6T7SYhjVuYDJj8+fIFAprG
	wHq/Cp5nQ6oUs5qfLFRPMQU/md4V5zjw84gj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LnI2w1g2paTPuBqwBpN/wD3+PHtbij4R
	yoMGj3Kow3qJprYxJS8z8keOcdjUkZOyrcXhfuHfflrFxERGOrfexLygUZV8V1fo
	mOW1XCz+PFqiGBdjK3ROFVPFdxoc7Pt4mmQ2HienL+mUZxN0aP3le2XVhUXVkteO
	SSH5U/nyoyY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A75B549BE;
	Tue, 26 Nov 2013 14:34:08 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 705E7549B4;
	Tue, 26 Nov 2013 14:34:07 -0500 (EST)
In-Reply-To: <5294EC11.2010405@web.de> (Jens Lehmann's message of "Tue, 26 Nov
	2013 19:44:33 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B75806AA-56D1-11E3-89F0-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238390>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 25.11.2013 22:01, schrieb Junio C Hamano:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>>> Looking good to me. Please add tests for "diff.ignoreSubmodules"
>>> and "submodule.<name>.ignore", the latter both in .gitmodules and
>>> .git/config. While doing some testing for this thread I found an
>>> inconsistency in git show which currently honors the submodule
>>> specific option only from .git/config and ignores it in the
>>> .gitmodules file ...
>> 
>> Sorry, but isn't that what should happen?  .git/config is the
>> ultimate source of the truth, and .gitmodules is a hint to prime
>> that when the user does "git submodule init", no?
>
> "git submodule init" only copies the "update" and "url" settings
> to .git/config, all others default to the value they have in the
> .gitmodules file if they aren't found in .git/config. This allows
> upstream to change these settings unless the user copies them to
> .git/config himself.

I know what the code does. I was questioning if "only copies X and
Y" is a sensible thing.

Copying at init time will fix the values when copied and give the
user a stable and dependable behaviour.  I have a feeling that the
current "not copy to fix it to a stable value, but look into
.gitmodules as a fallback" was not a designed behaviour for the
other properties, but was done by accident and/or laziness.
