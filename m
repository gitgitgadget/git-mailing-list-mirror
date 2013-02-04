From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "git archve --format=tar" output changed from 1.8.1 to 1.8.2.1
Date: Sun, 03 Feb 2013 21:05:55 -0800
Message-ID: <7vvca8653g.fsf@alter.siamese.dyndns.org>
References: <20130131172805.GC16593@kroah.com>
 <7vzjzpgswz.fsf@alter.siamese.dyndns.org> <20130131174103.GA20111@kroah.com>
 <7vr4l1gqv8.fsf@alter.siamese.dyndns.org> <20130204004512.GB6243@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>, git@vger.kernel.org,
	Konstantin Ryabitsev <mricon@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 04 06:06:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2EG5-0004TS-Oz
	for gcvg-git-2@plane.gmane.org; Mon, 04 Feb 2013 06:06:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901Ab3BDFF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 00:05:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54968 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750735Ab3BDFF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 00:05:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C11A84C7;
	Mon,  4 Feb 2013 00:05:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nX2L/ASI4oaYDbl+oGfTcn2piqA=; b=avsotu
	RB4XN6havdy9ayuDKgHQQsI4FYmMudN+l+zK2PPWBZIzhjd+LJFsXHKe+bThfYqB
	CKa3IEzvjccjDOF8y6nYRF+/d76e20HkFoAPYWBcLmgGTTQHMnu82Gabp0y6wqy3
	cfSYzhmGhNZp8aFs1u88xr/ZAhQ4q9leYW270=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rk6S0MgL6muXubzdUImgvXWScidP4y1W
	wDTgzygz7Ih7OGTJqD3LnAPZkUpCEtXDoflBBYP381ocmmTEoVDX06i6l6UyiOuD
	k/LROK4XJG5YeN4EM2w+5RjTioGJpKV0BP2J2jQmtfkAZSWCx14+9Z7yL3QZWah5
	iObpVmK4UbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 19DC384C2;
	Mon,  4 Feb 2013 00:05:57 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 844D584AC; Mon,  4 Feb 2013
 00:05:56 -0500 (EST)
In-Reply-To: <20130204004512.GB6243@kroah.com> (Greg KH's message of "Sun, 3
 Feb 2013 18:45:12 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8ED5C366-6E88-11E2-A0BE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215355>

Greg KH <gregkh@linuxfoundation.org> writes:

>> Then how about fixing kup to try both versions of Git?  There will
>> be people who run different versions of Git anyway, and kup should
>> not be preventing Git from helping people on other platforms, or
>> improving its output in general.
>
> I think the combinations of different versions of git that would have to
> be installed on kernel.org to handle stuff like this as things change
> over time, wouldn't be worth it.

You make it sound as if you have to pick the right one among 47
different versions, but I think over the lifetime of Git there was
only one time that output from "diff" would have affected the kup's
trick to avoid the transmission of patch text, and another that
output from "tar-tree" (aka "archive --format=tar") would have
afffected the transmission of tarballs.  I do think it is feasible
if "kup" wanted to.

> The number of people this affects right now is only one (me), given that
> the offending file is not in Linus's tree right now, so he doesn't have
> issues with uploading new releases.

As a tree grows larger over time, it may be just a matter of time
for somebody else to be hit by another deep path, though.
