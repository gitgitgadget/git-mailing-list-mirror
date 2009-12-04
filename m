From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] crash on make test
Date: Fri, 04 Dec 2009 09:12:52 -0800
Message-ID: <7vvdgmslwr.fsf@alter.siamese.dyndns.org>
References: <D6F784B72498304C93A8A4691967698E8EE2C44FE1@REX2.intranet.epfl.ch>
 <D6F784B72498304C93A8A4691967698E8EE2C44FE2@REX2.intranet.epfl.ch>
 <20091204103557.GC27495@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marinescu Paul dan <pauldan.marinescu@epfl.ch>,
	Junio C Hamano <gitster@pobox.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 04 18:22:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGbiR-0008Fv-3I
	for gcvg-git-2@lo.gmane.org; Fri, 04 Dec 2009 18:13:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757041AbZLDRNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Dec 2009 12:13:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbZLDRM7
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Dec 2009 12:12:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60052 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756978AbZLDRM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Dec 2009 12:12:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B75FDA45FE;
	Fri,  4 Dec 2009 12:13:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5dbFYO32MG/CLpKDmKDK7ZYjF/w=; b=Zp9ayO
	6SnVFEiM5Tp4p9U5wcjP0DkKOydTnLfDlxYIF96exrqADuIRWEg/mzjHJJqUq33K
	N5BON4w4g8kx67/gib9gt+uLzr01F4wH35ptJoGuH/hdiQSiZjq/re0pWWtGIHzS
	NHhlSWM5Isrg/q46+lNeXnw7kRz3pR3Mi1bgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c6nbwqJvuHHhKRjCRwvWPwSx2hBImAl2
	M9DctAG4VBTOxiITDpC5P17mLscffhsAI8PGIhELY+rguJWnJqg8YT/TTZACps6K
	liloLl7A4MhC7XW/D2MVf74VcxPYjiet+sXXM+NhkE74CBk3hbq/Rpv/kG1wHj13
	9ebWeT2N7v0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8426DA45FD;
	Fri,  4 Dec 2009 12:12:59 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DA2DA45FB; Fri,  4 Dec 2009
 12:12:53 -0500 (EST)
In-Reply-To: <20091204103557.GC27495@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 4 Dec 2009 05\:35\:57 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 45C802C2-E0F8-11DE-80DF-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134550>

Jeff King <peff@peff.net> writes:

> I think we should apply the patch below to maint, as this is something
> that can come up due to permissions problems. But I fear it won't
> actually fix the test failure you are seeing; you will just see it die()
> instead of segfaulting. However, the value of errno should give us a
> clue about what is happening, so please try running the test again with
> this patch.

Thanks, and I agree with the whole of the above paragraph, not just the
first sentence.
