From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Notes on diffcore API
Date: Wed, 28 Jun 2006 09:36:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606280934550.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060626233838.GA3121@steel.home> <7v4py7h2b9.fsf@assigned-by-dhcp.cox.net>
 <7virmn9hx8.fsf_-_@assigned-by-dhcp.cox.net>
 <81b0412b0606270141x7e38af5i8a97b27e37da17bf@mail.gmail.com>
 <7vbqse6unx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 09:36:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvUal-0003Np-NS
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 09:36:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423207AbWF1HgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 28 Jun 2006 03:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423211AbWF1HgD
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jun 2006 03:36:03 -0400
Received: from mail.gmx.de ([213.165.64.21]:730 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1423207AbWF1HgB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Jun 2006 03:36:01 -0400
Received: (qmail invoked by alias); 28 Jun 2006 07:36:00 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 28 Jun 2006 09:36:00 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbqse6unx.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22777>

Hi,

On Tue, 27 Jun 2006, Junio C Hamano wrote:

> "Alex Riesen" <raa.lkml@gmail.com> writes:
> 
> > On 6/27/06, Junio C Hamano <junkio@cox.net> wrote:
> >> -- >8 --
> >> Notes on diffcore API
> >> =====================
> >
> > Thanks!
> >
> >> Diffcore Transformation
> >> -----------------------
> >>
> >> The input file pairs recorded in the previous phase are
> >> collected in diff_queued_diff (a global variable -- which means
> >> that you cannot have two diffs running in parallel with the
> >> current setup).  This is an expandable array of pointers to
> >> `struct diff_filepair` structure.
> >>
> >
> > merge-recursive shouldn't have any problems with that, as the
> > renames are just read in the current implementation.
> > Still, it is somehow uncomfortable to see the amount of APIs
> > with the above restriction. Never know when it'll bite.
> 
> I think it is simply the matter of moving diff_queued_diff a
> field in diff_optionss structure and adding an extra parameter
> to point at the current diff_options to handful functions if we
> ever need to support it.  I haven't bothered doing that because
> we haven't had the need to run more than one diff at once.

And we shouldn't bother until we need it. It has a small performance 
impact, and the code gets more ugly.

Ciao,
Dscho
