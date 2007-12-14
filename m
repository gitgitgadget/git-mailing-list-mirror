From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Don't use the pager when running "git diff --check"
Date: Fri, 14 Dec 2007 12:54:30 -0800
Message-ID: <7v1w9pq9o9.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-2-git-send-email-win@wincent.com>
	<1197575138-58070-1-git-send-email-win@wincent.com>
	<20071214045127.GC10169@sigill.intra.peff.net>
	<7vmysdx3la.fsf@gitster.siamese.dyndns.org>
	<26AEA0A9-9F15-4245-9D27-61050DA57E6F@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 21:55:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3HYo-0001wo-1d
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 21:55:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbXLNUyo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 15:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753524AbXLNUyn
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 15:54:43 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57977 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752718AbXLNUyn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Dec 2007 15:54:43 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 559DF9D8C;
	Fri, 14 Dec 2007 15:54:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ADACF9D8B;
	Fri, 14 Dec 2007 15:54:32 -0500 (EST)
In-Reply-To: <26AEA0A9-9F15-4245-9D27-61050DA57E6F@wincent.com> (Wincent
	Colaiuta's message of "Fri, 14 Dec 2007 08:47:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68345>

Wincent Colaiuta <win@wincent.com> writes:

> El 14/12/2007, a las 6:11, Junio C Hamano escribi=C3=B3:
>
>> You are right.  While I do not personally miss paging output, it is =
a
>> regression not to page --check output by default.
>
> I thought this was ok because "git diff --exit-code" also produces
> useful output and also turns off the pager.

It is different.  --exit-code was that way from day one.  The primary
use of --check has been (and I suspect it will continue to be) for
people to _view_ the diff, spot problems so that they can fix them up,
and for that use case, exit code does not matter but pageability does.
You are introducing a new behaviour and a new use case --- that does no=
t
give you a license to break other existing use cases.
