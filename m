From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git stash pop` UX Problem
Date: Tue, 25 Feb 2014 14:20:11 -0800
Message-ID: <xmqq4n3m6dic.fsf@gitster.dls.corp.google.com>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<vpqlhx0a3cb.fsf@anie.imag.fr> <530C893D.7000108@ira.uka.de>
	<vpqzjlf5q2z.fsf@anie.imag.fr>
	<xmqqwqgj57n9.fsf@gitster.dls.corp.google.com>
	<85r46q537a.fsf@stephe-leake.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stephen Leake <stephen_leake@stephe-leake.org>
X-From: git-owner@vger.kernel.org Tue Feb 25 23:20:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIQMX-0003pR-0J
	for gcvg-git-2@plane.gmane.org; Tue, 25 Feb 2014 23:20:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753794AbaBYWUU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Feb 2014 17:20:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753543AbaBYWUQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Feb 2014 17:20:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 946266F18B;
	Tue, 25 Feb 2014 17:20:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3S4FcjnBS5Ua0Qsdoj0fbXRNaQk=; b=OCWM1z
	+OgTPZLxopa3I7xXgMrmv117EbBvmtRlQ2KcVHaK2jHhNP7GYqYB1APEaipBKK6b
	CqZISyh9dP+WptVElUD+mzHAMKuI2ibDqF/A3s/w7zx1D1jIvTg9N6jKFCZJGLHU
	VvsT5D/16n7Yy7LrdGkc8bYXiFYpVMfqUhB+k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jAnK0twzicdYMReNzW8pSl2notbym842
	xE5STI34qtWpf5WMXkx0HNICYVgk21L5lil7HrtPK7lMHu9AIPsinIA5mP165YoE
	s95sK5DHSOgR6d/l8eG8Tq4/uJpVZaEkH9UZRGvo9P/vIB8NmSkDyixcSQO/mAes
	hytFKTqT0x0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B1256F18A;
	Tue, 25 Feb 2014 17:20:15 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6615D6F189;
	Tue, 25 Feb 2014 17:20:14 -0500 (EST)
In-Reply-To: <85r46q537a.fsf@stephe-leake.org> (Stephen Leake's message of
	"Tue, 25 Feb 2014 14:48:09 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FFA9947E-9E6A-11E3-94C1-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242688>

Stephen Leake <stephen_leake@stephe-leake.org> writes:

>> One _could_ argue that stashed changes are what could be reflected
>> to the working tree and form the source of the latter, but my gut
>> feeling is that it is a rather weak argument.  At that point you are
>> talking about what you could potentially change in the working tree,
>
> No, I saved things in the stash on purpose. For example, I had changes
> that were not ready to commit, but I wanted to do a merge from upstream.

I often save things by running "git diff >P.diff" on purpose.
Should "git status" read these patches and tell me what paths I
could change in the working tree by applying it?  Where does it end?

> There are workflows where the stash is not important; provide an option
> to 'git status' that means "ignore stash". 

How is that different to tell those who want to know what are in the
stash to type "git stash list" when they want to learn that
information?
