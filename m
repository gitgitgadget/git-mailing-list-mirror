From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Thu, 31 Jan 2013 10:16:27 -0800
Message-ID: <7vr4l1gqv8.fsf@alter.siamese.dyndns.org>
References: <20130131172805.GC16593@kroah.com>
 <7vzjzpgswz.fsf@alter.siamese.dyndns.org> <20130131174103.GA20111@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 19:16:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0ygu-0000zd-UL
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 19:16:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977Ab3AaSQb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2013 13:16:31 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47550 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751523Ab3AaSQa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2013 13:16:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74B7BCF8B;
	Thu, 31 Jan 2013 13:16:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/+AAQptiZBlEBmecnL8VXRx8FhU=; b=O3rcTZ
	cf4WRjbSe10CqigbEYutUMP2AmQPASmHteB2UoS9RBvUWJPgKjmmb5ag0IwHsBgs
	K89Vqq5NVwIB24OfjvKk/rsm5s3HcYROUq/LpO+RwycHxLnpTX9+ut2XXqLNqVxZ
	W6cfvStZMYnpUMBGS4zg1o4ofx3d5XygPFyNw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I7YPnNWRmBmjk1UZAv8ykSgbWWPp46D4
	KjnZdwojnFJD1lfE+B1itWUqiSWdx5HQyQxt39uOSoq1cOS4OMQ9Z7LU9GzFDMs/
	2IB7GERI7dSLs5Jw421kvuctCSeQvjR6a0B+m+oaiAH/L4zUBkqy8gf7bFWSoNLZ
	uyvj+3+OQ2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68BE9CF80;
	Thu, 31 Jan 2013 13:16:29 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC892CF7E; Thu, 31 Jan 2013
 13:16:28 -0500 (EST)
In-Reply-To: <20130131174103.GA20111@kroah.com> (Greg KH's message of "Thu,
 31 Jan 2013 18:41:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 55089DC4-6BD2-11E2-869D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215138>

Greg KH <gregkh@linuxfoundation.org> writes:

> On Thu, Jan 31, 2013 at 09:32:12AM -0800, Junio C Hamano wrote:
>
>> How about fixing kup to teach the "let's cheat and let the other end
>> run 'git archive', if the resulting archive and GPG signature
>> locally created does match, we do not have to transfer the tarball
>> itself" trick a fall-back mode that says "but if the signature does
>> not match, then transfer the bulk used to create the signature to
>> the remote anyway".  This fallback can and should of course be
>> useful for the compressed patch transfer.
>
> Ugh, uploading a 431Mb file, over a flaky wireless connection (I end up
> doing lots of kernel releases while traveling), would be a horrible
> change.  I'd rather just keep using the same older version of git that
> kernel.org is running instead.

Then how about fixing kup to try both versions of Git?  There will
be people who run different versions of Git anyway, and kup should
not be preventing Git from helping people on other platforms, or
improving its output in general.
