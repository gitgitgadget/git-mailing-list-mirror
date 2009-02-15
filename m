From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: filter-branch: Remove original/*
Date: Sun, 15 Feb 2009 22:33:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902152230330.10279@pacific.mpi-cbg.de>
References: <431341160902131845g58d99635ie0735b433802d6be@mail.gmail.com> <alpine.DEB.1.00.0902142219010.10279@pacific.mpi-cbg.de> <7vvdrblcl0.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0902152046090.10279@pacific.mpi-cbg.de>
 <7vvdrbie7k.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Eric Kidd <git@randomhacks.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 22:34:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYodF-0001Ya-QF
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 22:34:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753784AbZBOVck (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 16:32:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756015AbZBOVcj
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 16:32:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:58398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756010AbZBOVci (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 16:32:38 -0500
Received: (qmail invoked by alias); 15 Feb 2009 21:32:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 15 Feb 2009 22:32:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/TuMBOriTTkPs3qaUltSdAewQfsiLBdjgZwb4adB
	JIPYpJDTMHv0XO
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdrbie7k.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110060>

Hi,

On Sun, 15 Feb 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> Why?  Most tags will be created once and will stay there.  That is how 
> >> tags are supposed to behave, isn't it?
> >
> > Exactly my point.  In the common case, it does not change a thing.
> 
> Wrong.
> 
> In the common case, you will create tons of useless files that waste a
> disk block to store 180-byte or so perr each tag.

Hmm.  My reasoning was that the reflogs will be purged by git gc anyway, 
and that it might be interesting to be able to know how a tag entered the 
current repository (if it was not too long ago), but you're probably right 
on that.

> > However in the case that we _do_ change tags, would you not agree that 
> > the reflog is _the_ place to record the change?
> 
> That merely means whoever changes the tag and wants the record of such an
> update, which is uncommon, need to make sure reflog is created for that
> tag (and that tag only).

The thing is: we cannot.  At least not at the moment.

I agree that "git tag" should not add a reflog.  But one should be 
able to force "git update-ref" to create a reflog entry, no?

Ciao,
Dscho
