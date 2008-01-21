From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's not in 'master', and likely not to be in, until 1.5.4
Date: Sun, 20 Jan 2008 23:27:36 -0800
Message-ID: <7vhch71vvb.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<478855B5.9070600@gmail.com>
	<7vbq7ry405.fsf@gitster.siamese.dyndns.org>
	<47885B2C.8020809@gmail.com>
	<7v7iify2wm.fsf@gitster.siamese.dyndns.org>
	<4788BFA8.2030508@gmail.com>
	<7vwsqeubj8.fsf@gitster.siamese.dyndns.org>
	<47891658.3090604@gmail.com>
	<7vbq7qssd7.fsf@gitster.siamese.dyndns.org>
	<47893E1A.5020702@gmail.com>
	<7v4pdislrf.fsf@gitster.siamese.dyndns.org>
	<alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de>
	<7vir1xmazm.fsf@gitster.siamese.dyndns.org>
	<7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org>
	<7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org>
	<7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org>
	<7vd4rv3ds5.fsf@gitster.siamese.dyndns.org>
	<7vtzl71x1c.fsf@gitster.siamese.dyndns.org>
	<7vprvv1wnu.fsf@gitster.siamese.dyndns.org>
	<7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 08:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGr4m-0004RT-OK
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 08:28:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686AbYAUH1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 02:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753742AbYAUH1n
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 02:27:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:60716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbYAUH1m (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 02:27:42 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 58B433D2E;
	Mon, 21 Jan 2008 02:27:41 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B682F3D2C;
	Mon, 21 Jan 2008 02:27:38 -0500 (EST)
In-Reply-To: <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 20 Jan 2008 23:13:04 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71237>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Bad news is that this does not seem to have much to do with the
>> incore-index series.  v1.5.4-rc4 shows the same breakage.
>
> Please disregard that bad news -- that was my stupidity while
> bisecting.  v1.5.4-rc4 seems to be Ok.

And the bisection points at the first one in the series "Updated
in-memory index cleanup".  Which is kind of odd and sad, as it
is not supposed to change the semantics at all, and I did not
see anything obviously wrong with it.

$ cd t
$ while :
  do
    sh -x ./t7501-commit.sh -i -v >,,log 2>&1 || break
  done
