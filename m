From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-bisect: weird usage of read(1)
Date: Mon, 11 Aug 2008 16:15:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808111615260.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 16:13:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSY86-0000RO-19
	for gcvg-git-2@gmane.org; Mon, 11 Aug 2008 16:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751959AbYHKOLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 10:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbYHKOLJ
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 10:11:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:41834 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751193AbYHKOLJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 10:11:09 -0400
Received: (qmail invoked by alias); 11 Aug 2008 14:11:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp044) with SMTP; 11 Aug 2008 16:11:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18inQkrIf4iGViyIdiox6t6I5IHFyDcGt7cPMX9UY
	DlNm49WSO7fI0B
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <38b2ab8a0808110657y24ac9526wca4acea3bddaec00@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91937>

Hi,

On Mon, 11 Aug 2008, Francis Moreau wrote:

> I found this in git bisect:
> 
>               printf >&2 'Are you sure [Y/n]? '
>               case "$(read yesno)" in [Nn]*) exit 1 ;; esac
> 
> which looks very weird since read(1) returns a status and not the
> string reads from std input.
> 
> Am I missing something ?

Yes.  "$()" does not return the status, but the output.

Ciao,
Dscho
