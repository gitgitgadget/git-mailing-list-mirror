From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: add -e, was Re: What's cooking in git.git (Apr 2009, #02; Sun,
 12)
Date: Tue, 14 Apr 2009 22:25:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904142224030.10279@pacific.mpi-cbg.de>
References: <7vvdp9w9l1.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904141943060.10279@pacific.mpi-cbg.de> <7vhc0r3wpq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 22:25:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtpBp-0002Ce-BX
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 22:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754492AbZDNUXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 16:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755545AbZDNUXL
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 16:23:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:49532 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755272AbZDNUXK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 16:23:10 -0400
Received: (qmail invoked by alias); 14 Apr 2009 20:23:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 14 Apr 2009 22:23:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+cinENe6Gcio9Q/Gzt5XHbnwREN5EberSkQfrx1T
	9jjVlJrgCJDTh6
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vhc0r3wpq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116565>

Hi,

On Tue, 14 Apr 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sun, 12 Apr 2009, Junio C Hamano wrote:
> >
> >> * js/add-edit (Wed Apr 8 23:30:24 2009 +0200) 1 commit
> >>  - git-add: introduce --edit (to edit the diff vs. the index)
> >> 
> >> I am Ok with the general idea, but the error detection needs to be 
> >> more robust than merely relying on --recount.
> >
> > You mean something like saving an extra copy of the patch, and 
> > checking if common or removed lines were either removed or kept 
> > intact?
> 
> No, editing a removed line and changing it to an unchanged line is 
> perfectly fine.
> 
> I was thinking more about people touching the lines near the hunk 
> boundary (e.g. insert a new line at the beginning of the hunk) which 
> would not be compatible without --unidiff-zero hack while applying, and 
> --unidiff-zero hack should not be used if we care about the correctness.

Actually, I am beginning to hate the idea of having this in add -e, but 
would prefer it to be in apply ("git apply $PATCH" could -- and should -- 
complain when not being called with --unidiff-zero and encountering a 
patch that should (but does not) have common context lines).

Do you agree?

Ciao,
Dscho
