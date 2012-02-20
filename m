From: Junio C Hamano <gitster@pobox.com>
Subject: Re: rfe: git-config: lack of color reset option
Date: Mon, 20 Feb 2012 14:05:53 -0800
Message-ID: <7vwr7hjh32.fsf@alter.siamese.dyndns.org>
References: <alpine.LNX.2.01.1202202142160.31585@frira.zrqbmnf.qr>
 <20120220212006.GB6335@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jan Engelhardt <jengelh@medozas.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 23:06:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzbMu-00082L-RH
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 23:06:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754573Ab2BTWF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 17:05:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46637 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753800Ab2BTWF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 17:05:56 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 947AD7A49;
	Mon, 20 Feb 2012 17:05:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KdFraMGbDTCsqboa9LloG3+3giQ=; b=ndEx1C
	pM+gyty3lo0w5FUP5DBrxm4b7Bqpi8iC//LLxWtXMjAMB126zeJYrqCtHxmbDilm
	NkRMN1AsQ77sas6mYy1DQNL4cSoAyTZL3OZle3xJHW4iIDgIoCh/8VTuLtnxR2xA
	k+Hjj7oJJQEqCUDyjALBTi2X2QPRPgBz9OCBY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AjoRevcCMmFHbxK5QQuMuKMa7pizzTmc
	djHpUucm8xomr4isbAyXivfsrmXtrX+GNXY5+UswJLDdRFegHZTdeLp5GpqIhKUq
	mEIwS4FiLxzMutX2x00MF5RhzqRwVfGGpbb0oabkV95c5V6eJHoZGRUXN0tEG2/d
	CSuufUg7Hhc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8B83D7A48;
	Mon, 20 Feb 2012 17:05:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F14557A47; Mon, 20 Feb 2012
 17:05:54 -0500 (EST)
In-Reply-To: <20120220212006.GB6335@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 20 Feb 2012 16:20:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F5F3C16-5C0F-11E1-A162-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191118>

Jeff King <peff@peff.net> writes:

> This is an artifact of the way the ANSI colorizing works. Git says "turn
> on bold white and a blue background", then it outputs some content, then
> it says "turn on green", and so forth. At the end we issue a "reset" to
> turn everything back to normal. We should perhaps issue a reset before
> outputting the decoration, as we are moving from one colorized bit to
> the other, and we don't know what we are inheriting.

Yeah, I agree with the diagnosis and the proposed solution. It sounds
both simple and correct thing to do.
