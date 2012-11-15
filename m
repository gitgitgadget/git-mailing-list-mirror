From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: add advice on how to push/pull to tracking
 branch
Date: Thu, 15 Nov 2012 13:49:58 -0800
Message-ID: <7vmwyi8rjt.fsf@alter.siamese.dyndns.org>
References: <1352976300-20159-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vr4nu92hm.fsf@alter.siamese.dyndns.org> <vpqmwyid59i.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:50:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ7KG-0000B3-4s
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 22:50:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751619Ab2KOVuD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2012 16:50:03 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48158 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243Ab2KOVuC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 16:50:02 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A5C2A93A5;
	Thu, 15 Nov 2012 16:50:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=emMGOijL3c8vvCu8jm3Wg7pRXZw=; b=Z1hY7X
	BwX42pSibiNpFhT6hmPb2J6YJuZHNPkplxndMvLBEmVW5KReWSuCrx65P/DybCYC
	DTFYRWLF0Yo9ixdWzRNQ89/vmt94gDFFPZrIK5ERDOtbqAV7fWI2PZNCmWTrbDNB
	OL1Lpi2dvS05S0DNSNu/CDVKBPAtE02Do6C18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kaP9xB1O/T2Rmg2/bjzNW4nysVkCXmlc
	UIt+GU1c5WKYnrZhefURpVcPZwjyUBx2mlaSnZebzSqT8U1NgPKt4lcsouZToWIn
	HcKwxglFThxtVFU/IWnBRtp32kM1LQ5Q+LAl4yk0NlXXfzh42WR0w8TeXUhwO32q
	sPL4Q0gOH8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5095193A0;
	Thu, 15 Nov 2012 16:50:00 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2CC5939E; Thu, 15 Nov 2012
 16:49:59 -0500 (EST)
In-Reply-To: <vpqmwyid59i.fsf@grenoble-inp.fr> (Matthieu Moy's message of
 "Thu, 15 Nov 2012 20:40:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 671309B4-2F6E-11E2-8149-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209848>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I don't understand what you mean by "non-current". If you mean a local
> branch not pointed to by HEAD, then I don't understand the remark, as
> the message is shown by "git status" (looking more closely, it is also
> shown by "git checkout", but after switching branch so also showing a
> message about the current branch) and precisely talks about the current
> branch.

Ah, Ok, I somehow thought that "branch -v" would also use this
information, and/or during my absense this function from remote.c
got linked into "git remote show" ;-)

So it is not an issue right now, but we will have to worry about the
messaging when we start using this to describe a branch that is not
currently checked out.
