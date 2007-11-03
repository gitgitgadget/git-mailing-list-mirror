From: Junio C Hamano <gitster@pobox.com>
Subject: Re: *[PATCH 2/2] Let git-add--interactive read colors from .gitconfig
Date: Sat, 03 Nov 2007 11:11:13 -0700
Message-ID: <7vpryrxkqm.fsf@gitster.siamese.dyndns.org>
References: <471045DA.5050902@gmail.com>
	<19271E58-5C4F-41AF-8F9D-F114F36A34AC@wincent.com>
	<20071013172745.GA2624@coredump.intra.peff.net>
	<20071013175127.GA3183@coredump.intra.peff.net>
	<47112491.8070309@gmail.com>
	<20071015034338.GA4844@coredump.intra.peff.net>
	<20071016194709.3c1cb3a8@danzwell.com>
	<20071017015152.GN13801@spearce.org>
	<20071022164048.71a3dceb@danzwell.com>
	<20071023042702.GB28312@coredump.intra.peff.net>
	<20071023035221.66ea537f@danzwell.com>
	<20071102224111.7f7e165c@paradox.zwell.net>
	<7vy7dfyl33.fsf_-_@gitster.siamese.dyndns.org>
	<20071103022626.253dcd93@paradox.zwell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	Wincent Colaiuta <win@wincent.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan del Strother <maillist@steelskies.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Dan Zwell <dzwell@zwell.net>
X-From: git-owner@vger.kernel.org Sat Nov 03 19:11:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoNTB-0007NA-Um
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 19:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755070AbXKCSL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 14:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755257AbXKCSL1
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 14:11:27 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:60299 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755070AbXKCSL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 14:11:26 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id DD0AD2F0;
	Sat,  3 Nov 2007 14:11:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0954490E1D;
	Sat,  3 Nov 2007 14:11:38 -0400 (EDT)
In-Reply-To: <20071103022626.253dcd93@paradox.zwell.net> (Dan Zwell's message
	of "Sat, 3 Nov 2007 02:26:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63295>

Dan Zwell <dzwell@zwell.net> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> In addition to a small matter of testing, a more practical issue
>> would be to add PAGER support there, I think.
>
> You mean in general, so that users can view a hunk in the PAGER, then
> be prompted for what to do with it? (Because it doesn't solve the color
> problems, because calling "diff --color" here creates other problems.)

Yes.  I see it a much bigger problem that we let a long hunk
scroll off the top of the screen then ask the user what to do
with it, than any coloring of diff.

> ... but it does not highlight
> whitespace at the end of lines or space/tab errors.

No, but you can make it so if you want.

Personally, I think it is not so useful for "add -i" to do so,
as it is too late in the workflow, unless you add it ways to let
you edit and fix the whitespace errors.
