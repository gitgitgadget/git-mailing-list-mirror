From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] fixup remaining cvsimport tests
Date: Fri, 11 Jan 2013 22:36:01 -0800
Message-ID: <7vr4lq9acu.fsf@alter.siamese.dyndns.org>
References: <1357971703-28513-1-git-send-email-chris@rorvick.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Eric S. Raymond" <esr@thyrsus.com>
To: Chris Rorvick <chris@rorvick.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 07:36:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ttuhh-0004Ch-QC
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 07:36:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717Ab3ALGgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2013 01:36:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54455 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364Ab3ALGgF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2013 01:36:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D2B08847;
	Sat, 12 Jan 2013 01:36:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VNMb1NHJVtq+aaWHSB2uU6b7iys=; b=bywngH
	gUPruK15rkTBaHj/w9QWvSGzmi/sGrKMdCH8ldvhRZkdMv5rsUrkY4BE+mnnpKh5
	VWvgO2zEFCQkxyarTHQ5kJ8eyceWTcrb/gBqkNzOMSbEalIOm8ZDrReWlqRXJu2v
	6Eq/Hzz6bBSZ/wVQhc4lAyUdRlqOAkMZ1tous=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JGmT3YfwiYE4EEjfElb9rceCQuYaQXb1
	+vSJLCPEoP+MkiCoIvebP/2VzzCb0Ybgt66CNOA0ITU9Rh1+dUyKi1lP9ooLb/I1
	So+wXMzRyyuvvaaQWVBxknyWpwD+h2X9e2b4TKLyQMeJ9evqQRje0bd33wBSTszK
	u1CE49eVsB0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 423868846;
	Sat, 12 Jan 2013 01:36:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D9928844; Sat, 12 Jan 2013
 01:36:03 -0500 (EST)
In-Reply-To: <1357971703-28513-1-git-send-email-chris@rorvick.com> (Chris
 Rorvick's message of "Sat, 12 Jan 2013 00:21:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5637B23E-5C82-11E2-A8C7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213272>

Chris Rorvick <chris@rorvick.com> writes:

> Reroll w/ sign-off.
>
> Chris Rorvick (3):
>   t/lib-cvs.sh: allow cvsps version 3.x.
>   t9600: fixup for new cvsimport
>   t9604: fixup for new cvsimport
>
>  t/lib-cvs.sh                    |  2 +-
>  t/t9600-cvsimport.sh            | 10 ++++------
>  t/t9604-cvsimport-timestamps.sh |  5 ++---
>  3 files changed, 7 insertions(+), 10 deletions(-)

Thanks.

I too noticed the droppage of "-a" support, which may not be a big
deal (people can drop it from their script, run cvsimport and they
can drop newer commits from the resulting Git history to emulate the
old behaviour without "-a" that attempted to find a quiescent point
if they really want to and suspect that the upstream CVS repository
was not quiescent during the import).

Likewise for "-x".  You said "no longer can be told" and that is
technically true, but it is more like "no longer need to be told, as
stale cache cannot get in the way", so it is probably not a big
deal, either, for people to drop it from their script.

About the changed behaviour regarding "origin", I suspect that it is
a change for the better, but we would probably need documentation
updates to cover it (and deleted options and (mis)features) before
this topic graduates.
