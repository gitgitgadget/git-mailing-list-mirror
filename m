From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 13:56:38 -0800
Message-ID: <7v4pfr2kmh.fsf@gitster.siamese.dyndns.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<18232.35893.243300.179076@lisa.zopyra.com>
	<Pine.LNX.4.64.0711121727130.4362@racer.site>
	<vpq7iknqrtp.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121755460.4362@racer.site>
	<vpqy7d3pck0.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121804400.4362@racer.site>
	<vpqoddzpc88.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bill Lear <rael@zopyra.com>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:57:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrhHN-0005uQ-Rk
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753940AbXKLV4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753847AbXKLV4s
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:56:48 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:52267 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753851AbXKLV4r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:56:47 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 60FA42F2;
	Mon, 12 Nov 2007 16:57:08 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B2B0C950B8;
	Mon, 12 Nov 2007 16:57:02 -0500 (EST)
In-Reply-To: <vpqoddzpc88.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	12 Nov 2007 19:09:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64716>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>>> > On Mon, 12 Nov 2007, Matthieu Moy wrote:
>>> >
>>> >> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>> >> 
>>> >> > So you need to populate the repository before starting _anyway_.
>>> >> 
>>> >> Last time I checked, the thread was talking about bare repository.
>>
>> Look at the subject.  "Cloning empty repositories."
>
> Look at the content. "cloning a empty bare repository".

But both of Johannes's points apply equally well to an empty
bare repository and to an empty non bare repository.  IOW,
bareness does not matter to the suggestion Johannes gave.

But you are acting as if the bareness of the target repository
makes his point irrelevant.  I am a bit confused.

About his point 1, I'd just stop at saying that "it is not so
hard" does not mean "we do not have to make it even easier".

His second point is also a real issue.  If you allowed cloning
an empty repo (either bare or non-bare), then you and Bill can
both clone from it, come up with an initial commit each.  Bill
pushes his initial commit first.  Your later attempt to push
will hopefully fail with "non fast forward", if you know better
than forcing such a push, but then what?  You need to fetch, and
merge (or rebase) your change on top of Bill's initial commit,
and at that point the history you are trying to merge does not
have any common ancestor with his history.
