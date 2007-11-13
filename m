From: Andreas Ericsson <ae@op5.se>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare
 repositories?
Date: Tue, 13 Nov 2007 01:13:25 +0100
Message-ID: <4738EC25.20108@op5.se>
References: <86k5on8v6p.fsf@lola.quinscape.zz>	<20071112131927.GA1701@c3sl.ufpr.br>	<Pine.LNX.4.64.0711121355380.4362@racer.site>	<200711121719.54146.wielemak@science.uva.nl>	<Pine.LNX.4.64.0711121624330.4362@racer.site>	<vpq3avbv2ju.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121715090.4362@racer.site>	<18232.35893.243300.179076@lisa.zopyra.com>	<Pine.LNX.4.64.0711121727130.4362@racer.site>	<vpq7iknqrtp.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121755460.4362@racer.site>	<vpqy7d3pck0.fsf@bauges.imag.fr>	<Pine.LNX.4.64.0711121804400.4362@racer.site>	<vpqoddzpc88.fsf@bauges.imag.fr> <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 01:14:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrjPj-0008Ug-NJ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 01:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754186AbXKMANa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 19:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbXKMANa
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 19:13:30 -0500
Received: from mail.op5.se ([193.201.96.20]:60763 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753954AbXKMAN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 19:13:29 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 04C861F08758;
	Tue, 13 Nov 2007 01:13:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jEDfDrN3GuYo; Tue, 13 Nov 2007 01:13:27 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id 846771F08702;
	Tue, 13 Nov 2007 01:13:26 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64738>

Junio C Hamano wrote:
> 
> His second point is also a real issue.  If you allowed cloning
> an empty repo (either bare or non-bare), then you and Bill can
> both clone from it, come up with an initial commit each.  Bill
> pushes his initial commit first.  Your later attempt to push
> will hopefully fail with "non fast forward", if you know better
> than forcing such a push, but then what?  You need to fetch, and
> merge (or rebase) your change on top of Bill's initial commit,
> and at that point the history you are trying to merge does not
> have any common ancestor with his history.


If we assume zero communication between these two, the alternative
is this:
Bill starts hacking in his own repo and then uploads his .git dir
to the server.
David starts hacking in his own repo and then uploads his .git
dir to the server.

The only difference between the two scenarios is (assuming they
have write access to those shared directories) that the last-in
wins in the second case, while first-in wins in the first one.

Oh, and the fact that the first to upload his .git dir to the
server will lose all his refs if he isn't careful to save his
original copy until they both have established which "first"
commit to use, which could take a while in this imaginary world
where they don't seem to be speaking to each other but are still
working together.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
