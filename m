From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3/RFC 4/5] gitweb: Create links leading to
 'blame_incremental' using JavaScript
Date: Thu, 12 Nov 2009 00:05:42 -0800
Message-ID: <7vtyx0f9rd.fsf@alter.siamese.dyndns.org>
References: <1251805160-5303-1-git-send-email-jnareb@gmail.com>
 <1251805160-5303-5-git-send-email-jnareb@gmail.com>
 <20091105203316.GD17748@machine.or.cz> <200911061905.52285.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org,
	Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 09:06:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8Ugx-0000Z3-6F
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 09:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752060AbZKLIFz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Nov 2009 03:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673AbZKLIFz
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 03:05:55 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56648 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbZKLIFz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 03:05:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6DF7C9B92A;
	Thu, 12 Nov 2009 03:06:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=xk+Nvv2MTtX7Heosdu4WHxzspYs=; b=rKU3anMFsTnl6bPjk7y1jzH
	4f1D0uQT/Vp1NS92vl4jogL+g5WtmfWbvgVPFI56J9B4RrX6gVZ6NNl+iI4+3TJU
	KRv47i1fqjbHGtMnw7RNf6tliwLkpQd/2sX3hYHBSNn/9R2iN0meQiApbDETUT7u
	CGSQLAsm1l+SmzkZNVTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=MLWtrYX+pR+3Jessk10xD5G7IrqwrYV4NEEyvRGQ3rBtnU342
	1C7t4bsKEpRk0ijHEvoeKH3Zgc7GPJSEEz69yUUOtguzmk9E8/IPosrC1z/IKmdY
	1c2/bE/psaix9TD/sF20cBaVPGwoZ5bI2bDEKK7feTEjxQTTGiZQEyo1SY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F2FAE9B929;
	Thu, 12 Nov 2009 03:05:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A79759B927; Thu, 12 Nov 2009
 03:05:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 328CE4A4-CF62-11DE-9BFD-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132744>

Jakub Narebski <jnareb@gmail.com> writes:

> But even if incremental blame turns out to be slower than incremental
> blame it still has the advantage of being _incremental_.  You have at 
> least some result soon.

It wasn't it was slow that bothered me, but early implementations of
incremental blame I tried didn't _appear_ as incremental.  That was the
dissapointing part.

At the protocol and implementation level it certainly was feeding data
incrementally to the browser, but the end user experience on the screen
was "click....wait...wait...wait...voila the whole blame appears", not
"click...trickle...trickle...trickle...ah everything is filled".  The
latter obviously is what an incremental one should be aiming for.

No I haven't tried your latest code.  Probably I should.
