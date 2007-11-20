From: "Medve Emilian" <Emilian.Medve@freescale.com>
Subject: RE: git-daemon
Date: Tue, 20 Nov 2007 15:04:52 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E27017BCE24@az33exm24.fsl.freescale.net>
References: <598D5675D34BE349929AF5EDE9B03E27017BCC42@az33exm24.fsl.freescale.net> <7vbq9pnac2.fsf@gitster.siamese.dyndns.org> <598D5675D34BE349929AF5EDE9B03E27017BCC8D@az33exm24.fsl.freescale.net> <20071120050756.GA29502@sigill.intra.peff.net> <598D5675D34BE349929AF5EDE9B03E27017BCD50@az33exm24.fsl.freescale.net> <20071120182606.GA9646@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 23:49:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IubuY-0001lh-SL
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 23:49:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764775AbXKTWst (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2007 17:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755493AbXKTWst
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 17:48:49 -0500
Received: from de01egw01.freescale.net ([192.88.165.102]:62349 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755724AbXKTWsr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 17:48:47 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id lAKMlpK1027425
	for <git@vger.kernel.org>; Tue, 20 Nov 2007 15:48:43 -0700 (MST)
Received: from az33exm24.fsl.freescale.net (az33exm24.am.freescale.net [10.64.32.14])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id lAKM4rDP013034
	for <git@vger.kernel.org>; Tue, 20 Nov 2007 16:04:53 -0600 (CST)
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
In-Reply-To: <20071120182606.GA9646@sigill.intra.peff.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git-daemon
thread-index: AcgrotXr4aEWxV+dQ/mxEk5hBGyGggABUS3w
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65579>

Hi Jeff,


I think I found the explanation why v1.5.3.6 works for me (and others
apparently) but master and next don't. The fairly recent changes to the
PATH handling in exec_cmd.c done by Scott R Parish <srp@srparish.net>, I
believe, didn't make it into maint. Adjusting the PATH git-daemon sees
is fixing my problem even in master and next.

Thanks for your help and time.


Cheers,
Emil.


> -----Original Message-----
> From: Jeff King [mailto:peff@peff.net] 
> Sent: Tuesday, November 20, 2007 12:26 PM
> To: Medve Emilian
> Cc: git@vger.kernel.org
> Subject: Re: git-daemon
> 
> On Tue, Nov 20, 2007 at 09:54:13AM -0700, Medve Emilian wrote:
> 
> > I just built and installed the latest master (and next) and 
> then I tried
> > to clone (as I usualy do) one of my repositories. I run 
> git-daemon only
> > with the upload-pack service enabled.
> > [...]
> > 
> > Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Connection from
> > 10.82.124.104:2978
> > Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Extended 
> attributes (18
> > bytes) exist <host=server>
> > Nov 20 10:17:04 emmedve1-12 git-daemon: [3921] Request 
> upload-pack for
> > '/srv/scm/linux-2.6.git'
> 
> I don't see anything useful there.  Have you tried running git-daemon
> with --verbose? If that doesn't turn up anything, can you try running
> with GIT_TRACE=1 to see the upload pack command that is being executed
> (and try running it yourself)?
> 
> > Did you try this and is working for you?
> 
> Yes, it works fine (though I ran it under tcpserver, not xinetd).
> 
> -Peff
