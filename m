From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Tue, 02 Sep 2014 11:41:11 -0700
Message-ID: <xmqqiol527co.fsf@gitster.dls.corp.google.com>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
	<alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
	<xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
	<20140829234327.GF24834@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 02 20:41:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOt1E-0000Bw-BU
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 20:41:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651AbaIBSlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 14:41:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62690 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752455AbaIBSlX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 14:41:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D457936FEA;
	Tue,  2 Sep 2014 14:41:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4jTmeG8wzc4X78YweHxkzQcv0Lc=; b=prmTku
	vJ5QpoiSVJfbYTp9taGkGARuzIGDExKmnKQ4jhvmlcOAUEk89k3dQ1QIQ2E3pTgq
	gQozlHzQ/9GUM9zJ21eXDSepHwOn6YkSslo4oWOwx8AivI+P/ypsKBA4jWi4C3oB
	v6lm4IuO1lw5TTKsgKQ3Nvi0GTt8qS4FATULs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lKEZIL+lmaTAfE9Y6Z0ACs8WxjJ1j2lL
	fMe2UXWDcpEdnmphTO3aD7szIIZZ3vKdK88REIRPFRFYkNFBvt/5bBZ0Mh9DSiK7
	s3dWNlTCADV30tXhF3GfFnccvHMihbsINptu69RzmOGI4qrHp/z+ICwQM7ZlLxNY
	9GFvWMOCtrc=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CB31836FE9;
	Tue,  2 Sep 2014 14:41:22 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 2584736FDB;
	Tue,  2 Sep 2014 14:41:13 -0400 (EDT)
In-Reply-To: <20140829234327.GF24834@peff.net> (Jeff King's message of "Fri,
	29 Aug 2014 19:43:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B6EE6D72-32D0-11E4-8090-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256334>

Jeff King <peff@peff.net> writes:

> On Thu, Aug 28, 2014 at 02:25:16PM -0700, Junio C Hamano wrote:
>
>> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
>> 
>> > We inspect commit objects pretty much in detail in git-fsck, but we just
>> > glanced over the tag objects. Let's be stricter.
>> >
>> > This work was sponsored by GitHub Inc.
>> 
>> Is it only this commit, or all of these patches in the series?
>> Does GitHub want their name sprinkled over all changes they sponsor?
>
> GitHub does not really care either way. I think it is well-known that we
> sponsor some git development (i.e., pretty much everything I and Michael
> work on), and we do not need that fact sprinkled in the commit history.
>
> But we are also happy for that fact to be transparent if it changes
> people's opinions on whether the patch is a good idea (i.e., to know
> that Johannes has some motive beyond just "I think this is the right
> thing to do"; I hope he _also_ thinks it is the right thing to do or
> would not post the series, of course).
>
> Personally, I think the cover letter is a good place for such things.

Yeah, and I saw it explained in the cover.  It looked somewhat out
of place to see it duplicated only for this patch in the 6 patch
series and I was wondering if there was something special about this
specific patch, hence my question.
