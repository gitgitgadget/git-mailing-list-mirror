From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug: rebase when an author uses accents in name on MacOSx
Date: Wed, 30 May 2012 23:33:50 -0700
Message-ID: <7v62bc97w1.fsf@alter.siamese.dyndns.org>
References: <06DD2F56-F956-46DF-84A4-3443D4702CDE@spotinfluence.com>
 <7vehq18c82.fsf@alter.siamese.dyndns.org>
 <20120531011911.GC5488@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Lanny Ripple <lanny@spotinfluence.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 31 08:33:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZyxJ-0003ON-Dj
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 08:33:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752007Ab2EaGdx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 02:33:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750955Ab2EaGdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 02:33:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 650405EBC;
	Thu, 31 May 2012 02:33:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xMR3J/CiEp24GiJek0JuUlsf0rQ=; b=sG9y9g
	bA+qVJojCh531nBcRI1H8mJvXp61WpTT4Kq4L1iyNPtnAhyDcHML0kMaKVcdh2uU
	fGJ8HmltrWk/gmOc2Mu3x4FZsqtGy8hE+GxbLvn4Fz4h3mBpF85RqcvbobEqTvod
	sX/RFbq5owxVDCF0uwj+6dA36F5P6sfS3PYZw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RyDqbGy2Ng9+YJEf0rIRjK1EEwjvUMDK
	DSVJY0qCFPBxIof7muXwojFC9IJykJgCNsbAwBKKOFVWNgaI0yVdMHZAchRGd8Qz
	StcSDCPyNg/rvAC47rWVaIV/3974EvTfiRmvWsbid53H7SdrvSZRMefpcdJHaV3R
	Z9nPs2wPx0E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DA995EBB;
	Thu, 31 May 2012 02:33:52 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3ED15EBA; Thu, 31 May 2012
 02:33:51 -0400 (EDT)
In-Reply-To: <20120531011911.GC5488@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 May 2012 21:19:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 965B232C-AAEA-11E1-BAA8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198862>

Jeff King <peff@peff.net> writes:

> On Wed, May 30, 2012 at 04:45:33PM -0700, Junio C Hamano wrote:
> ...
>> So in C locale where each byte is supposed to be a single character,
>> that implementation of "sed" refuses to match a byte with high-bit
>> set when given a pattern '.'?
>> 
>> That is a surprising breakage, I would have to say.
>
> It should not be too surprising, since we discussed it a few months ago:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/192218

Heh, no wonder I do not recall that one, as everything happened and
conclusions reached while I was sleeping ;-)

If it is not a bug in platform-sanctioned sed, but a buggy
third-party build, then I wouldn't worry about it for this cycle,
but pre-release freeze might be a good time to start sketching
Thomas's --format="%'%an <%ae>%'" approach, perhaps?
