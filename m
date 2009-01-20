From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] diff: Support diff.color-words config option
Date: Tue, 20 Jan 2009 22:02:16 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901202202060.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901162208180.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901200031350.3586@pacific.mpi-cbg.de> <200901192017.54163.bss@iguanasuicide.net> <200901192145.21115.bss@iguanasuicide.net> <alpine.DEB.1.00.0901201058520.3586@pacific.mpi-cbg.de>
 <7vskndkip9.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901201819490.5159@intel-tinevez-2-302> <7vk58pk9k5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	=?ISO-8859-15?Q?Santi_B=E9jar?= <santi@agolina.net>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Teemu Likonen <tlikonen@iki.fi>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 22:03:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPNlB-0008In-Ke
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 22:03:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758066AbZATVCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 16:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbZATVCV
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 16:02:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:44398 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757981AbZATVCU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 16:02:20 -0500
Received: (qmail invoked by alias); 20 Jan 2009 21:02:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp002) with SMTP; 20 Jan 2009 22:02:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Jn9VN4lqJI9uwE2Y5pTnCW1XDt5JXQZsYhHzm4R
	oTnhyWim/vUtSq
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vk58pk9k5.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106523>

Hi,

On Tue, 20 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> By the way, wouldn't it make sense to optimize the precontext of that 
> >> hunk by doing _something_ like:
> >> 
> >> 	if (!o->word_regex && strcmp(one->path, two->path))
> >>         	o->word_regex = userdiff_word_regex(two);
> >> 
> >> "Something like" comes from special cases like /dev/null for new/deleted
> >> files, etc.
> >
> > You mean to avoid the cost of initializing the regex in case one and the 
> > same file is diffed against itself?
> 
> No.
> 
> What I meant is much simpler than that.
> 
> If one and two are the same filename, and earlier gitattributes lookup for
> the path already failed to produce any when you checked one, isn't it very
> likely that the gitattributes lookup for two would fail the same way to
> produce any result?

Oh, I see!

Thanks,
Dscho
