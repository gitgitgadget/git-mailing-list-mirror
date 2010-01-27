From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-format-patch should include a checksum
Date: Tue, 26 Jan 2010 17:25:44 -0800
Message-ID: <7v4om8xrs7.fsf@alter.siamese.dyndns.org>
References: <871vhcmr5b.fsf@trurl.pps.jussieu.fr>
 <7vljfkxxj9.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1001261526tc86c04em4c6ede23e109e66@mail.gmail.com>
 <alpine.LFD.2.00.1001261639550.17519@localhost.localdomain>
 <fabb9a1e1001261650r18e04e3cw2efade6072a426b@mail.gmail.com>
 <alpine.LFD.2.00.1001262006150.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Juliusz Chroboczek <jch@pps.jussieu.fr>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 02:28:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZwhv-00061b-4S
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 02:28:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752342Ab0A0B0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 20:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178Ab0A0B0G
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 20:26:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:42191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752164Ab0A0B0B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 20:26:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9DFA94EF9;
	Tue, 26 Jan 2010 20:25:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PbJoofNKuLsKRAz9adx27N+THrc=; b=IB0es5
	rZFTPejwuydAB2xJ9KTYOJkdG0vK6Hv/kJNHcw6nrzMOd8Ydpp6HD7N4CuAEdxGn
	mES1ewQEz89X6fnOsoIoLy0lXamDwI9oHCGExSk9aYDLMwRLDQxazGJiUQeVz24h
	JwLKRJeXYDD9EUxeAr5BHWb0f+qVX3ll7dKU4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=j3fdAX79O354OGAHVVHnKOCihzOSX1qo
	vIJ0BocUO5BjLmjKVrftYvKP+MCP1IsMAF6Xida7IRu+Rw2Wv9zYrYqFLe8yBMD4
	R2EbJ1jrT9D46E+M/kzLUQXzXC7V2Z7FwowcWTGiRyOlYNvYUGWjzE91ttSLCrGf
	vMuB1b+hklM=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 6CE0A94EF7;
	Tue, 26 Jan 2010 20:25:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DA3094EF5; Tue, 26 Jan
 2010 20:25:46 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001262006150.1681@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 26 Jan 2010 20\:13\:56 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E91B5CBC-0AE2-11DF-A4AD-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138098>

Nicolas Pitre <nico@fluxnic.net> writes:

> FWIW, I do manually edit both incoming and outgoing patches from time to 
> time as well.

Me three.

> I think what would be even more useful at first is to find out why 
> corrupted patches still apply.

Exactly.  That is why I asked that question at the very beginning.

> ... Just 
> applying the patch to that blob and confirming it matches the postimage 
> SHA1 should cover many cases already.

That would work when you are/have the sole authority (so contributors
won't send patches based on some other trees), you push out often (to keep
the length of the patch queue contributors keep short).

That would make it more likely that others base their work on what you
published, and send patches from their base version all the way (not
skipping "this is what I sent earlier but haven't been accepted nor pushed
out").  Otherwise it will be unlikely that you have the object recorded as
the preimage.  Often when I receive follow-up patches from people, some
are based on what was committed by me (possibly with tweaks), and some
others are based on what was seen on the list (lacking the tweaks), yet
some others are based on random other versions.  I'll have preimages only
in the first case.

Usually while editing incoming patch text (not log message), you mostly
touch postimage, but when fixing up a diff that was based on a bit stale
version, you need to touch preimage as well.  In these cases, the blob
object names recorded in the patch wouldn't be very useful.
