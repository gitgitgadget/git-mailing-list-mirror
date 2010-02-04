From: Junio C Hamano <gitster@pobox.com>
Subject: Re: extra headers in commit objects
Date: Wed, 03 Feb 2010 16:38:49 -0800
Message-ID: <7v8wb96die.fsf@alter.siamese.dyndns.org>
References: <20100203174041.GC14799@spearce.org>
 <alpine.LFD.2.00.1002031311010.1681@xanadu.home>
 <9b18b3111002031101p3385ecdfo638433bc269791aa@mail.gmail.com>
 <20100203192612.GD14799@spearce.org>
 <7vwryugifz.fsf@alter.siamese.dyndns.org>
 <20100203210407.GG14799@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: demerphq <demerphq@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
	git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 04 01:39:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcpkU-0003T1-HU
	for gcvg-git-2@lo.gmane.org; Thu, 04 Feb 2010 01:39:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888Ab0BDAjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 19:39:05 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53990 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756225Ab0BDAjB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 19:39:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E796797637;
	Wed,  3 Feb 2010 19:38:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=lLb/9dYcK/DNQwMk2Ewy4eItYcs=; b=DS6gR5djA31/LN+h7psp92f
	3L2IB2UDdpGYd3NbTufbXZCdJEx4xc/F6JASSnC59kavvnczV7FcXj45zgDbTQQn
	JrIIMo5lEHtNg199mhLovZPeEACC5F5Yh60AswnM0oQrjcNGTO9QhZrH6Ve0XF7z
	lS60L3BimesTCffTRAaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=B3CKFnD5VQuW5MmtrkNucKcu9ANe3OXq5ajl2FEACjlOHkjn5
	2MG3hYGKOc8qOEqOqbhVCHM002bsyL0zeWpVlr23JgiOt9vfc2LTMCc98imaraEp
	RhysrTHoRf81RNS7sB/F4JtYXW2VZrwN57QpGThrdgwljt+C+DdWUPcDB0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A40EB97630;
	Wed,  3 Feb 2010 19:38:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9AF539762B; Wed,  3 Feb
 2010 19:38:50 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ACE33424-1125-11DF-9191-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138920>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> We all know that some other systems, e.g. SVN, permit adding
> additional properties to commits, and that often these are used
> to make statements like "Fixed bug NNNN", and bug tracking systems
> integrate into SVN by reading or updating those properties.
>
> So you, Nico, myself, might all agree that "bug" does not belong
> in the header, but many others see it like SVN sees additional
> properties on a revision, and thus it goes there.
>
> Hence the artifical example.  It seems that it is not that artifical
> outside of our mailing list.

Aren't the meta-properties like "Fixed bug NNNN" something you can add
after the fact, even in SVN?

We have that in "notes".  I never said people are wrong for wanting to
record additional information _about_ commits somewhere (and I didn't say
"artificial" at all---it was you who said it was a "made-up" example).

My point was that they do not belong to the commit _header_, and "but many
others see" doesn't contradict with that.  Many others may feel the need
to be able to express random things _about_ the commit; it does not mean
these random things have to go _in_ the commit.
