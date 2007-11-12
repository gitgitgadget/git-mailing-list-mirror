From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cloning empty repositories, was Re: What is the idea for bare repositories?
Date: Mon, 12 Nov 2007 13:59:25 -0800
Message-ID: <7vzlxj15xe.fsf@gitster.siamese.dyndns.org>
References: <86k5on8v6p.fsf@lola.quinscape.zz>
	<20071112131927.GA1701@c3sl.ufpr.br>
	<Pine.LNX.4.64.0711121355380.4362@racer.site>
	<200711121719.54146.wielemak@science.uva.nl>
	<Pine.LNX.4.64.0711121624330.4362@racer.site>
	<vpq3avbv2ju.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0711121715090.4362@racer.site>
	<alpine.LFD.0.9999.0711121231150.21255@xanadu.home>
	<Pine.LNX.4.64.0711121751100.4362@racer.site> <4738A6BD.50704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Nicolas Pitre <nico@cam.org>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Jan Wielemaker <wielemak@science.uva.nl>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Mon Nov 12 22:59:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrhK2-0006lt-Ma
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 22:59:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754149AbXKLV7m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 16:59:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754160AbXKLV7m
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 16:59:42 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:48858 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753986AbXKLV7l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 16:59:41 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 0673D2FA;
	Mon, 12 Nov 2007 17:00:01 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 6986F9501B;
	Mon, 12 Nov 2007 16:59:54 -0500 (EST)
In-Reply-To: <4738A6BD.50704@op5.se> (Andreas Ericsson's message of "Mon, 12
	Nov 2007 20:17:17 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64717>

Andreas Ericsson <ae@op5.se> writes:

> Johannes Schindelin wrote:
>
>> But since you're one of the people knowing git _internals_ pretty
>> well, here's another reason just for you why this cannot be done:
>> There is no way to find out where the HEAD points to.
>
> $ mkdir foo; cd foo; git init; git symbolic-ref -q HEAD
> refs/heads/master

Johannes is talking about the lack of native protocol support to
transfer symref information.  That's the reason git-clone dances
around finding where HEAD really points at.  It simply does not
know -- all it gets about a symref is what SHA-1 the ref points
at.
