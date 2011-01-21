From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: suggest "reset --keep" to undo a commit
Date: Fri, 21 Jan 2011 12:28:33 -0800
Message-ID: <7vbp3aovbi.fsf@alter.siamese.dyndns.org>
References: <vpq62ziv788.fsf@bauges.imag.fr>
 <20110120195726.GA11702@burratino> <20110120200827.GB14184@vidovic>
 <201101202134.41911.trast@student.ethz.ch>
 <7vfwsnqn8c.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.1101210801210.15247@pacific.mpi-cbg.de>
 <20110121073730.GA26276@burratino> <7voc7ap3dp.fsf@alter.siamese.dyndns.org>
 <20110121191459.GC16325@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Eric Raible <raible@nextest.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 21 21:29:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PgNbW-0005nf-Sy
	for gcvg-git-2@lo.gmane.org; Fri, 21 Jan 2011 21:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753020Ab1AUU3A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jan 2011 15:29:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53116 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701Ab1AUU27 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jan 2011 15:28:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 341102144;
	Fri, 21 Jan 2011 15:29:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YmwCFxcWFeMn3fGwixCG3/bgQrY=; b=QaYemV
	x5jGF7IKzcNJ2E2swQjRGtrrXeTSDdq8y1Y5sxP3CnSf1C1Khb6txU7hcUG82bxx
	Dl1YcCL6L1Yl9x9WsF5g06cmHLACEtgPAUlc23W0YfdRFgthUcoEGAzVI7/OE/pi
	boAiLSQXTyPCVV6VGAf5z1/x7zo9y4QBsDn9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=haeN740PkFvM4y7JPInplnSy5yUcj2gZ
	li+WxmkkTpW6fYQwq4bgZD66uAAhbtRqhMliObzmYc2q9mivlZcwCc1Z0WrvUNjd
	Anc7PaYZfOHfrAwts+A6i92V6dCR9Zv7kG/NKZYBiH5BK3dHVRljUDuH7PtDMu1o
	B2IjCaYsniE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D1FF213E;
	Fri, 21 Jan 2011 15:29:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B49EE213C; Fri, 21 Jan 2011
 15:29:21 -0500 (EST)
In-Reply-To: <20110121191459.GC16325@burratino> (Jonathan Nieder's message of
 "Fri\, 21 Jan 2011 13\:14\:59 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 28BDFFAC-259D-11E0-8034-BC4EF3E828EC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165391>

Jonathan Nieder <jrnieder@gmail.com> writes:

>> Please tell a story where keep makes more sense than hard by enhancing the
>> explanatory text <1> associated with this section.  The current text says
>> that the three topmost commit representing what you have recently worked
>> so far are all unwanted, strongly hinting that hard is more appropriate
>> thing to do than keep, which is not what we want if we are changing the
>> example to use keep.
>
> Maybe the best story would be "you have just explored a blind alley
> and decided the last three commits are not a good idea at all", with

That unfortunately does not seem to describe the nature of the local
changes at all, which I think is the whole point of this topic to
encourage use of --keep over --hard.

>> It would be sufficient to just hint that the uncommitted changes that you
>> have in your working tree are unrelated to what these three commits wanted
>> to do (e.g. you always keep small changes around, such as debugging
>> printf's
>
> That use case is less interesting to me --- it is relatively harmless
> to clobber such content.

Actually I think that is the primary use case of the feature, as --keep
was done as a parallel to the behaviour of checkout that checks out a
different branch while keeping local changes.
