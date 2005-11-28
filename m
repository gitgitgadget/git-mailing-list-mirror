From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: use binmode(STDOUT) in git-status
Date: Mon, 28 Nov 2005 17:02:22 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0511281700100.11362@wbgn013.biozentrum.uni-wuerzburg.de>
References: <81b0412b0511272334w393434e7lad3e3b102e6c3e9e@mail.gmail.com>
 <438B2859.6060109@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Nov 28 17:02:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EglSW-0000ra-Sc
	for gcvg-git@gmane.org; Mon, 28 Nov 2005 17:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbVK1QC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 11:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVK1QC0
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 11:02:26 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:7317 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751174AbVK1QCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2005 11:02:25 -0500
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1A65413FED0; Mon, 28 Nov 2005 17:02:23 +0100 (CET)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id F30F99F479; Mon, 28 Nov 2005 17:02:22 +0100 (CET)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id DE7099DB02; Mon, 28 Nov 2005 17:02:22 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3EA5A13F00A; Mon, 28 Nov 2005 17:02:22 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <438B2859.6060109@zytor.com>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12889>

Hi,

On Mon, 28 Nov 2005, H. Peter Anvin wrote:

> Alex Riesen wrote:
> > Activision's Perl generates CRLF unless STDOUT is binmoded, which is
> > inconsistent with other output of git-status.
> > 
> > ---
> > I assume none _sane_ can want CRLF as line-ending...
> 
> Well, if it's a text file we probably should use platform-native line-ending,
> and at least be tolerant of \r\n.

Of course, here is the problem: git on Windows runs only using cygwin. You 
can specify the line ending behaviour of cygwin (I think it is an env 
variable). Activision Perl, being independent of cygwin, does not care 
about that setting.

So, to be accurate, you'd have to check what *cygwin* expects, and 
depending on that execute binmode(STDOUT) or not.

Ciao,
Dscho
