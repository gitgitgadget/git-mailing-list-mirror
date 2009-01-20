From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] expand --pretty=format color options
Date: Tue, 20 Jan 2009 11:36:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901201133280.3586@pacific.mpi-cbg.de>
References: <20090117153846.GB27071@coredump.intra.peff.net> <49736331.8010003@lsrfire.ath.cx> <20090118173753.GB17434@coredump.intra.peff.net> <20090118194328.GA31180@coredump.intra.peff.net> <20090118195342.GA612@coredump.intra.peff.net>
 <7vljt6q4cf.fsf@gitster.siamese.dyndns.org> <20090120040617.GB30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201126500.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 20 11:37:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPDzA-0001i3-Lc
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 11:37:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755809AbZATKgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 05:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755208AbZATKgH
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 05:36:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:53119 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753934AbZATKgF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 05:36:05 -0500
Received: (qmail invoked by alias); 20 Jan 2009 10:36:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 20 Jan 2009 11:36:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18n3YhomeknjUe5KC9dKEPGDaAEj5IcuyttAspsQW
	OvIveHJ/TOTaxc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901201126500.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106468>

Hi,

On Tue, 20 Jan 2009, Johannes Schindelin wrote:

> On Mon, 19 Jan 2009, Jeff King wrote:
> 
> > On Mon, Jan 19, 2009 at 03:10:56PM -0800, Junio C Hamano wrote:
> > 
> > > > Hrm. OK, it doesn't actually work always. It does for git-log, but 
> > > > not for rev-list, which leaves diff_use_color_default as -1. I 
> > > > don't know if there are any other ways you can get to this code 
> > > > path without having set diff_use_color_default.
> > > 
> > > Yuck, no matter what you do please don't contaminate plumbing with 
> > > the UI color options.
> > 
> > Of course. But the problem is that rev-list is _already_ contaminated 
> > by --pretty=format:%Cred. Or do you mean, you really want rev-list to 
> > unconditionally output color in such a case?
> 
> No, rev-list is not contaminated with UI color options.  %Cred _always_ 
> outputs the color, even when the user turned off color explicitely, 
> using --no-color.

BTW I would find it very logical for rev-list not to output any color at 
all when %C(yellow) is specified, as your code respects the diff UI 
options, which are implicitly turned off for rev-list (as rev-list is no 
UI), just like the coloring of "commit <name>" is implicitly turned off 
for rev-list.

Ciao,
Dscho
