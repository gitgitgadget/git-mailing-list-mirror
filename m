From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Thu, 13 Sep 2012 10:52:08 -0700
Message-ID: <7vr4q595fb.fsf@alter.siamese.dyndns.org>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
 <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com>
 <7vligfcdgh.fsf@alter.siamese.dyndns.org>
 <20120913132847.GD4287@sigill.intra.peff.net>
 <7v4nn1akz7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 19:52:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCDaR-0003D9-I5
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 19:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab2IMRwQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 13:52:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60003 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504Ab2IMRwO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 13:52:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B289859C;
	Thu, 13 Sep 2012 13:52:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Bk6oD+woGA5aJTY7e3mg0NMWdIU=; b=GKXYi9
	McOIlgqT4vf/tRRGLqiBAAEwG3686U3bWwxOy+qNON19tw58iQQTW7VGbjQk8i7h
	o1RBRSAr/JvkcdlBkkyS8S/owmPC/RknX172NuY5dLlanFX8we2fw49XFVCKjDlk
	vW3KtNpiD2Cadu/V2hynOzq9D6lIaH324MthM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B+QXW3G6WzBTvHizn23EaTwsF0/3/6SO
	kHw8C0r9NU0BFOqQ2KIAMUgpJ+eecMy/iDQ8+wuaUffhiw73BaEnwKeYjDu2wBmf
	vb+6r9iX369IFQhPQRxE+0wGYX2yqPuPKcYXmEI3FvtnMbS/dUKl4mKEXmdZiNEa
	Ze/jWbKYDDU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC424859A;
	Thu, 13 Sep 2012 13:52:13 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 011DA858C; Thu, 13 Sep 2012
 13:52:09 -0400 (EDT)
In-Reply-To: <7v4nn1akz7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 13 Sep 2012 10:30:52 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BDAB298E-FDCB-11E1-B47C-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205398>

Junio C Hamano <gitster@pobox.com> writes:

>>      But it should not be per-command, but per-message, and
>>      should include all output that is not diagnostic and is not
>>      machine-parseable (e.g., what I mentioned above, request-pull
>>      output, etc). If it is the project's language, then the team
>>      members will need to know it anyway, so it should not be too big a
>>      burden to have a potentially different language there than in the
>>      diagnostic messages.
>
> No matter what the project languages is, machine parseable part will
> not be localized but fixed to "C" anyway, so I do not think it comes
> into the picture.
>
> My take on this is, if there is the project language, it should
> apply to _everything_.  Please do not introduce any per-command,
> per-message, per-anything mess.  Just set LANG/LC_ALL up and be done
> with it.
>
> And I think you justified why that is the right thing to do very
> well in the second sentence in the above paragraph I quoted from
> you.

You seem to be saying that diagnostic does not have to be in project
language, but I do not think it is the right thing to do.  The first
response to "Frotz does not work" is often "What do you exactly
mean?  How did you run Frotz?  What error message are you getting
from it?", and you do not want to get back the diagnostics in
Klingon.
