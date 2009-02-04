From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] apply: fix access to an uninitialized mode variable,
 found by valgrind
Date: Wed, 4 Feb 2009 17:44:35 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902041743530.22763@intel-tinevez-2-302>
References: <cover.1233712140u.git.johannes.schindelin@gmx.de> <alpine.DEB.1.00.0902040249030.9822@pacific.mpi-cbg.de> <20090204153150.GC6896@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Don Zickus <dzickus@redhat.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 04 17:46:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUkt8-0000GR-0n
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 17:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752478AbZBDQom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 11:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbZBDQom
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 11:44:42 -0500
Received: from mail.gmx.net ([213.165.64.20]:40855 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751863AbZBDQom (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 11:44:42 -0500
Received: (qmail invoked by alias); 04 Feb 2009 16:44:39 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 04 Feb 2009 17:44:39 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pCEtggoNp/GTFx2uLlOa2vy9/S5LjHTclvmjOlU
	I4wH5ope5tJB2b
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090204153150.GC6896@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108393>

Hi,

On Wed, 4 Feb 2009, Jeff King wrote:

> On Wed, Feb 04, 2009 at 02:50:15AM +0100, Johannes Schindelin wrote:
> 
> > When 'tpatch' was initialized successfully, st_mode was already taken
> > from the previous diff.  We should not try to override it with data
> > from an lstat() that was never called.
> 
> Yay. Valgrind For The Win, as the kids are saying these days.

Yes, indeed.

> Was this being triggered by t4121 and t4127? If so, then I think it 
> solves the mystery valgrind errors I reported in the last paragraph 
> here:
> 
>   http://article.gmane.org/gmane.comp.version-control.git/98898

Yep, t4121 and t4127.  But I did not have time to follow the link.

Ciao,
Dscho
