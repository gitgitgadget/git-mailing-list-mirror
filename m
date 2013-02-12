From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] completion: support 'git config --local'
Date: Tue, 12 Feb 2013 14:13:05 -0800
Message-ID: <7v1uclfafi.fsf@alter.siamese.dyndns.org>
References: <85E0E68E8961D64E9200C534AC5E1B240A443EDC@RED-INF-EXMB-P1.esri.com>
 <1360671642-10272-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vzjz9h1w0.fsf@alter.siamese.dyndns.org>
 <20130212211140.GA29358@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Dasa Paddock <dpaddock@esri.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 12 23:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5O6Z-0006Hf-BV
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 23:13:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab3BLWNK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2013 17:13:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36295 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752263Ab3BLWNI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2013 17:13:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3817CC18A;
	Tue, 12 Feb 2013 17:13:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SnAP0EtckUxfbaljZhi4oUyxBB0=; b=a0QD1b
	9EOuemWql/4A4cRMM4X/AFHZRjBkJ4GYb2dSEvu64N9Y4QOhal0gE9ctePxHD817
	eVX/A2zKKXJlUUdBMVgnajHv4sYoDD0vm69sh2xew+5CnKbUvCHvVXPL4ezYTYGa
	1Ig7IejhFdab3Xnd7Pjm7NYWphWiNElmfVDR4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xEEwkKK/UR22B9z2SUsdRNL1lndf9HVR
	DIS5fz31avnIcoHIrACjLQSGEG36jrDKZpNCM/L8nWKapxCFqXhoMEJ0bgaP3oOr
	P1e9GE4WjoRDPs/pE3cir1ds1pcsxQT7jGEhE5lg2DkOqCSnAZunsZUjJuvox+4M
	5nXdoOdX0iA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27AC7C189;
	Tue, 12 Feb 2013 17:13:07 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 997F2C185; Tue, 12 Feb 2013
 17:13:06 -0500 (EST)
In-Reply-To: <20130212211140.GA29358@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 12 Feb 2013 16:11:40 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6088D252-7561-11E2-90F4-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216206>

Jeff King <peff@peff.net> writes:

> I'm not sure I understand the original poster's point about "git config
> -l --local". "-l" does not take a limiter, does it?

"git config -l core.\*" will just die without limiting the output to
everything under core. hierarchy, so you are right---the combination
does not make any sense.  You have to say

    git config -l | grep ^core\\.

or something like that.

Completing "git config -l --lo<TAB>" still may help, though.
