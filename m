From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 3/3] upload-archive: use start_command instead of fork
Date: Tue, 15 Nov 2011 10:59:47 -0800
Message-ID: <7vobwdus7w.fsf@alter.siamese.dyndns.org>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
 <201111151122.48378.trast@student.ethz.ch>
 <20111115102807.GA18649@sigill.intra.peff.net>
 <201111151311.46832.trast@student.ethz.ch>
 <20111115173715.GA4478@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Franck Bui-Huu <vagabon.xyz@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, rene.scharfe@lsrfire.ath.cx
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 19:59:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQOEd-0007zI-UZ
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 19:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756872Ab1KOS7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Nov 2011 13:59:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51190 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752286Ab1KOS7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2011 13:59:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 296046A6B;
	Tue, 15 Nov 2011 13:59:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M8zeihHI6FMPM4cJXKZ4vKfbR1w=; b=enoIdO
	NVhu6zKYrKIpV19fEwWEK7ddcilf6UNS1WJ/LN7q0NoP7ruZNnDZpRH4ZyvCmrvy
	8DPmLP2I0ycKAGLux9/OIDBjwEcLdUcgoUchjZ38jAazXGctsVN1pQ4XMcw7Jeqk
	1LqyanuTw9i9F0wdhTogxLkekng14ZLY1rOY4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OZgztRmoNbmmxKLybU1nujjbE7Sg3AKh
	SYI+5gyir7DrcKCIsqy03XjR9tQ+un2htCwmPcjnKj/MSeLptAK7GtkdvXh+bgvy
	uyiLHiBZElYj1LLUpa5ZQkEemZSQeZNAXFQOgwNt6V+LkdHUXUMPCdU65wB/maqp
	hEAlOEJahs0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E6FA6A6A;
	Tue, 15 Nov 2011 13:59:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C47416A69; Tue, 15 Nov 2011
 13:59:48 -0500 (EST)
In-Reply-To: <20111115173715.GA4478@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 15 Nov 2011 12:37:15 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FDC21FAE-0FBB-11E1-82DA-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185480>

Jeff King <peff@peff.net> writes:

> Junio, this bug is in 1.7.8-rc*. Do you want the one-liner fix for the
> release, or the nicer fix?

Let's just do "static" for now, if we know the array is large enough.
