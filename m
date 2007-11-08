From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rebase --skip
Date: Thu, 08 Nov 2007 15:52:08 -0800
Message-ID: <7vir4cz45z.fsf@gitster.siamese.dyndns.org>
References: <20071107222105.GA31666@glandium.org>
	<20071108032308.GA5638@sigill.intra.peff.net>
	<20071108102412.GA31187@atjola.homenet> <4732E5A8.3020101@op5.se>
	<20071108104403.GB31187@atjola.homenet>
	<20071108231632.GC29840@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>,
	Andreas Ericsson <ae@op5.se>, Mike Hommey <mh@glandium.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 09 03:39:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqJlx-0000Kp-I4
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 03:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758820AbXKICis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 21:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759309AbXKICir
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 21:38:47 -0500
Received: from lollipop.listbox.com ([208.210.124.78]:50579 "EHLO
	lollipop.listbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751747AbXKICir (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 21:38:47 -0500
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id 5029D428062
	for <git@vger.kernel.org>; Thu,  8 Nov 2007 18:55:08 -0500 (EST)
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 134272F2;
	Thu,  8 Nov 2007 18:52:47 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 7240D93A7D;
	Thu,  8 Nov 2007 18:52:41 -0500 (EST)
In-Reply-To: <20071108231632.GC29840@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 8 Nov 2007 18:16:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64120>

Jeff King <peff@peff.net> writes:

> Personally, I don't see the point of a --force option; it turns your work
> flow from:
>
>   1. git-rebase --skip
>   2. Oops, I guess I have to reset.
>   3. git-reset --hard; git-rebase --skip
>
> to:
>
>   1. same as above
>   2. same as above
>   3. git-rebase --force --skip

I do not see it as improvement, either, for the same reason you
state.

> AIUI, Andreas's proposal is not so much DWIM as "do the obvious thing,
> but include a safety valve to prevent throwing away work." Is there
> actually a case where it would not have the desired effect?

The user is explicitly saying --skip, so I do not think it is
dangerous even if we unconditionally did "reset --hard" at that
point.

Or we could introduce a new option "--drop" (that's "drop the
current commit and continue") to do so, if people find that the
word "skip" does not sound like a scary destructive operation.

But I do not think that is needed.
