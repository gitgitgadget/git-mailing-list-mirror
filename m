From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH lt/block-sha1 0/2 v3] block-sha1: avoid pointer
 conversion that violates alignment constraints
Date: Sun, 22 Jul 2012 21:28:42 -0700
Message-ID: <7v8vebp0cl.fsf@alter.siamese.dyndns.org>
References: <20120722233547.GA1978@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 06:28:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StAGJ-0006g6-9F
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jul 2012 06:28:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab2GWE2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jul 2012 00:28:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34959 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751741Ab2GWE2p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2012 00:28:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A676E5485;
	Mon, 23 Jul 2012 00:28:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cc7Cr8QSdX4RQHh1UToZSHQOXcc=; b=NxAm5g
	3zjCsWDITQMXRjCvcWGNfyJ/0ZuihPm+/NV+SokDGSorda1pDiqbThkLhfTf+MMn
	zg7/mrdgssIifpSnFlkahI5RsMckx4B1UnsojtZMA9Q6PCoeY7e6zthjwPuePmzq
	LYVr9w0ot7OkTah6WLQBc4dUkhktwfBz10YuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qIZMbWhIKtNW+TlIwiUDv8PHEdVoG6ex
	71VknqAHy3MnhmawuAUAW4rJbZTovRfYkbS3i7lbLj8R/Ebg9+7wJqhvz9QfAy7h
	hdo/VNmuL1S1o0AkjrGJB1UtjlH78gYWsLonHrEEyAk1bpFGrG6Wo/ZN0Dv6zq75
	hv0URl2+QIg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 940335484;
	Mon, 23 Jul 2012 00:28:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 100FC5481; Mon, 23 Jul 2012
 00:28:43 -0400 (EDT)
In-Reply-To: <20120722233547.GA1978@burratino> (Jonathan Nieder's message of
 "Sun, 22 Jul 2012 18:35:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E335E20A-D47E-11E1-9DDD-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201894>

Jonathan Nieder <jrnieder@gmail.com> writes:

> This is a series of two patches: the first avoids alignment faults
> that were making git either slow on Alpha machines or crashy,
> depending on the machine's configuration, and the second patch is a
> cosmetic nit noticed while reviewing the first.
> ...
> Thoughts?
> Jonathan

Thanks.

Did somebody actually compiled Git for Alpha, and even more
surprisingly on a big-endian variant of one?
