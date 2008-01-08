From: Junio C Hamano <gitster@pobox.com>
Subject: Re: CRLF problems with Git on Win32
Date: Tue, 08 Jan 2008 11:47:06 -0800
Message-ID: <7vir24rtfp.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0801071010340.1864@ds9.cixit.se>
	<200801071947.28586.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801071915470.10101@racer.site>
	<200801072203.23938.robin.rosenberg.lists@dewire.com>
	<alpine.LSU.1.00.0801072115120.10101@racer.site>
	<3B08AC4C-A807-4155-8AD7-DC6A6D0FE134@zib.de>
	<20080108172957.GG22155@fieldses.org>
	<CE10C08D-AAF1-44B5-89B5-9A16A4AB70EA@zib.de>
	<7vmyrgry20.fsf@gitster.siamese.dyndns.org>
	<02DC77F5-7465-418D-972E-0F76E56C3F75@zib.de>
	<20080108190952.GK22155@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Jeff King <peff@peff.net>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Git Mailing List <git@vger.kernel.org>,
	msysGit <msysgit@googlegroups.com>
To: "J. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 20:47:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKQT-000266-Jo
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 20:47:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbYAHTrZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 14:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752820AbYAHTrZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 14:47:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34169 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750962AbYAHTrY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 14:47:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D4E8C60F;
	Tue,  8 Jan 2008 14:47:22 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 755A0C57F;
	Tue,  8 Jan 2008 14:47:08 -0500 (EST)
In-Reply-To: <20080108190952.GK22155@fieldses.org> (J. Bruce Fields's message
	of "Tue, 8 Jan 2008 14:09:52 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69906>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> On Tue, Jan 08, 2008 at 07:58:57PM +0100, Steffen Prohaska wrote:
>> ...
>> I don't think a solution will be found by declaring one platform
>> native (UNIX) and all other platform non-native.  The question to
>> answer is how to support cross-platform projects.  A valid
>> solution should never corrupt data unless the user explicitly
>> told git to do so.
>
> My only suggestion is that we consider allowing the user that
> "explicitly told git to do so" be the project maintainer.  So if you
>
> 	echo * autodetectcrlf >.gitattributes
> 	git add .gitattributes
> 	git commit
>
> then users that clone your repo will get that default without having to
> be told to do something magic on clone.
>
> (And ideally I'd've hoped you could do that using the existing crlf
> attribute rather than having to invent something new, but maybe that
> doesn't work.)

I think the project can mark text files as text with attributes
and if the port to the platform initialized core.autocrlf
appropriately for the platform everything should work as you
described. 

At least that is how I read the description of `crlf` in
gitattributes(5).
