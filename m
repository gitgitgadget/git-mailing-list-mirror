From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for git format-patch --to and format.to config
 option
Date: Sun, 07 Mar 2010 10:38:20 -0800
Message-ID: <7vk4torn8j.fsf@alter.siamese.dyndns.org>
References: <7v7hptt0mr.fsf@alter.siamese.dyndns.org>
 <20100306003946.GD27414@genesis.frugalware.org>
 <7vr5nykx55.fsf@alter.siamese.dyndns.org> <4B92EDFA.1000602@gmail.com>
 <7vaaukdch2.fsf@alter.siamese.dyndns.org> <4B937559.6000302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Steven Drake <sdrake@xnet.co.nz>, git@vger.kernel.org
To: Stephen Boyd <bebarino@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 19:38:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoLNQ-0000NS-Ny
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 19:38:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754690Ab0CGSif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 13:38:35 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56587 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754683Ab0CGSid (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 13:38:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B36AEA0E9D;
	Sun,  7 Mar 2010 13:38:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=6yIKrErvR+5so97awcL9n6kr+mk=; b=ltOAn1pJ3vBVF9q2p7DiOQv
	8Z14tslsV7YaXRdveFHHYhilsILRXJtE2LowuUG3GsUGYjb7lqEOHPIYtkBKbxAh
	JkEd7zb+GYDp48HX0TDiHRTe3ZD153E0P1EbQTsr+f8zwCaEvIPWx4sX6ora5RNu
	iNiTw0XmoIIAAYn0rJqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=wC1K4LpRZH4/suKKFnkhQIPaKc0wiwPpF/od+owWzd0YkvCBf
	ljhYJE2Az3I9ZFlmjtzvPaQvjCvUrRkvNNBlAnZyxR1IpGNz8ajbCX0I5YhyudVq
	xKkZM83hOzm8p/zj+T9MzrK5NGrSBssTS640Vd5lwVqyMPBWTOFl1LWoJw=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6DD2EA0E9B;
	Sun,  7 Mar 2010 13:38:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A8F5DA0E9A; Sun,  7 Mar
 2010 13:38:22 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9EAD6BAC-2A18-11DF-AAC8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141723>

Stephen Boyd <bebarino@gmail.com> writes:

> ... We have the
> option of making them consistent with the rest of git with a little bit
> of work. If you say --no-cc or --no-add-headers or --no-to the
> respective config should be overriden. If you say --to or --cc or
> --add-headers it should be appended. I doubt anyone would find that
> surprising since --no-* doesn't do anything right now.

That sounds like a sensible and practical way out, as it won't break
existing setup that expects the additive behaviour these two command
somehow ended up with, while allowing --no-* to override the config when
necessary.
