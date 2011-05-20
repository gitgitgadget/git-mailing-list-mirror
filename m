From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] receive-pack: eliminate duplicate .have refs
Date: Fri, 20 May 2011 10:06:26 -0700
Message-ID: <7v39k947zh.fsf@alter.siamese.dyndns.org>
References: <20110519213231.GA29702@sigill.intra.peff.net>
 <20110519213446.GC29793@sigill.intra.peff.net>
 <7vaaei5avn.fsf@alter.siamese.dyndns.org>
 <20110520074209.GB3663@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 20 19:06:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNT9r-0006oQ-1E
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 19:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751956Ab1ETRGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 13:06:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43958 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116Ab1ETRGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 13:06:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0F8AE541E;
	Fri, 20 May 2011 13:08:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nZlouhHVayFk2mCxMAkKhLkGTxw=; b=Wre3fI
	PeAKC3/J7gvICZGA0l04D1O9KjHb5+szUI83M7WPedxPyDSzeIL0ZF7V7Jmc35Wa
	+pWAR9s8Tj1AW8gUW7ArjeyUgkT3hGz63dHFTwopOIfrjg4/fi5PoVTjUOv2CSzJ
	KMWc3awn+Jtex2lt7MkG9NkJBiZDOiPGSK74A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mW5MK+rIMmygXCqBQbaotbp45P6Oq0TL
	bO01wRpqrU2UpXvwvpCP+6kE6XpaefdlALcNnMNtCM+0nIaSKxuKSUMk6a5Spqm4
	cWvJxlWDItRZZoEOsLB5v/f1Pp2iWakmH7/G9CtjdBKFapvYH/inBiPrn7sitc0I
	OAZ34j3Ezd0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DF77C541A;
	Fri, 20 May 2011 13:08:38 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 008835416; Fri, 20 May 2011
 13:08:35 -0400 (EDT)
In-Reply-To: <20110520074209.GB3663@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 20 May 2011 03:42:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CE2C03BC-8303-11E0-B248-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174067>

Jeff King <peff@peff.net> writes:

> ...  As
> it is, this uses a little more memory than necessary since we store all
> the duplicates temporarily in memory...

... which we do not really _care_, as duplicates are minority case and
the way you implemented is optimal for normal cases.  So I still like this
patch ;-)

Thanks.
