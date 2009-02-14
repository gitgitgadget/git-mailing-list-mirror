From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: human readable diffs, was Re: [PATCH v2] config: Use parseopt.
Date: Sat, 14 Feb 2009 22:08:38 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902142157000.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902141230250.10279@pacific.mpi-cbg.de> <1234612989-32297-1-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0902142041370.10279@pacific.mpi-cbg.de> <7viqncsreo.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 14 22:09:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYRlC-0001ZD-6R
	for gcvg-git-2@gmane.org; Sat, 14 Feb 2009 22:09:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316AbZBNVHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Feb 2009 16:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753298AbZBNVHq
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Feb 2009 16:07:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:44258 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753277AbZBNVHp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Feb 2009 16:07:45 -0500
Received: (qmail invoked by alias); 14 Feb 2009 21:07:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 14 Feb 2009 22:07:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+6x3dMSra672i/bQbTmTDuCaLWvp2fHLVC10jwe0
	9Ww79c8uWzxoSH
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7viqncsreo.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109927>

Hi,

On Sat, 14 Feb 2009, Junio C Hamano wrote:

>     I also noticed that the diff was impossible to read because it 
>     matched the lines with only an indented close brace or whitespace 
>     between the preimage and the postimage too aggressively.  Your 
>     --patience did seem to help a little bit, at least it produced a 
>     different result, but not much (not that patience was meant to make 
>     this kind of change easier to read).  It may have helped if we had 
>     that "do not match trivial lines too aggressively just to reduce the 
>     patch size" option.

Yeah, I think that your objections to my '--collapse-non-alnums' patch 
show to be relevant especially with this patch: an '} else {' matches, but 
actually disturbs readability.

So an option would be nice, indeed, which can merge a single matching line 
(or a given maximal number of matching lines) between runs of a certain 
minimal number of _non-matching_ lines.

But how to call it?

And how determine the ideal ratio between matching/non-matching lines 
until which to consider the matching lines to be non-matches?  Maybe a 
simple fraction would be enough...

Or maybe an absolute number of matching lines?  But it is obvious how to 
construct a case where this breaks down.

Ciao,
Dscho
