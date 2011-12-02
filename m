From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git auto-repack is broken...
Date: Fri, 02 Dec 2011 10:08:15 -0800
Message-ID: <7vd3c6onhs.fsf@alter.siamese.dyndns.org>
References: <CA+55aFznj49hx6Ce6NhJ1rRd2nvNyOERseyyrC6SNcW-z9dyfg@mail.gmail.com>
 <CACBZZX7Q5qb1r_Oh0QfMiWh9UAM1c6QWBn4abv-xHpFBaKuyKg@mail.gmail.com>
 <CA+55aFyq28vmo9dk-5mVm+nNn86qSjNT6VJGc09iaJo=+OP1Sg@mail.gmail.com>
 <20111202171017.GB23447@sigill.intra.peff.net>
 <7vobvqoozr.fsf@alter.siamese.dyndns.org>
 <20111202174546.GA24093@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	=?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
	<avarab@gmail.com>, Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Dec 02 19:08:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWXX6-00015Y-2Z
	for gcvg-git-2@lo.gmane.org; Fri, 02 Dec 2011 19:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757268Ab1LBSIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Dec 2011 13:08:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39530 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab1LBSIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Dec 2011 13:08:18 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E11BD679C;
	Fri,  2 Dec 2011 13:08:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nsmyd5e4WfsUAK5aVPwY8iMRnHg=; b=te9jY3
	W2YLKbuKbDK+9CtRUsBdulrguRh/owaaqCY9WJrkYSI8eED5etRIl2N9+gsNrl4o
	/R/wCkV5m5N+AutQm16dvNEcEulKYcaV4UVhpi+ughrhdMIMAHodFKgW8+d8cUbj
	b0pvzDD9qCRwm/1kqAa2PW9f4RMnDpGg762gA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Aet27f9R+WL6qdEkjhwKwKHy8avz7mEB
	v1fwKIj0HDMEbc8pmnWUimVM8WRZfLjf46/qc2rrsbrDfaZ8DrHcBrtMGAjGLIGU
	tTY6pS92kyy2K1wvocvqMZJ5QzsrcvOEPIv7WlkoG/3kGEJaJXAKr3ECU9+wOv5M
	pbSz+6ppTzw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CD2EC679B;
	Fri,  2 Dec 2011 13:08:17 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4304D679A; Fri,  2 Dec 2011
 13:08:17 -0500 (EST)
In-Reply-To: <20111202174546.GA24093@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 Dec 2011 12:45:46 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9C11039E-1D10-11E1-8104-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186235>

Jeff King <peff@peff.net> writes:

> But we shouldn't be packing totally unreferenced objects.

Everything you said is correct in today's Git and I obviously know it, but
I was taking the "Or have an extra option to..." at the end of the OP's
message in the thread into account, so...
