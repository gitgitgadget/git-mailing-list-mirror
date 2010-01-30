From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Implement pthread_cond_broadcast on Windows
Date: Sat, 30 Jan 2010 03:28:43 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1001300328070.3749@intel-tinevez-2-302>
References: <4B62CEAB.5050608@viscovery.net> <201001292102.49105.j6t@kdbg.org> <201001292316.03858.j6t@kdbg.org> <201001300054.05610.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Zolt=E1n_F=FCzesi?= <zfuzesi@eaglet.hu>,
	git@vger.kernel.org,
	msysGit Mailinglist <msysgit@googlegroups.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	"Andrzej K. Haczewski" <ahaczewski@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 03:28:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb34u-0001Sg-8k
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 03:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756182Ab0A3C2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 21:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099Ab0A3C2q
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 21:28:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:59310 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752639Ab0A3C2q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 21:28:46 -0500
Received: (qmail invoked by alias); 30 Jan 2010 02:28:44 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp031) with SMTP; 30 Jan 2010 03:28:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7vqg06yX7+sVU7l4evFnPL1iZHb97JC/O0/MQDI
	Z7Fu6e3+SMmS3x
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <201001300054.05610.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.60999999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138426>

Hi,

On Sat, 30 Jan 2010, Johannes Sixt wrote:

> See http://www.cse.wustl.edu/~schmidt/win32-cv-1.html, section "The
> SignalObjectAndWait solution". But note that this implementation does not
> use SignalObjectAndWait (which is needed to achieve fairness, but we do
> not need fairness).
> 
> Note that our implementations of pthread_cond_broadcast and
> pthread_cond_signal require that they are invoked with the mutex held that
> is used in the pthread_cond_wait calls.
> 
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Junio,
> 
>  please queue this patch for 1.7.0-rc1 even though it has not undergone
>  a lot of review - the result is better than a git that does not even
>  build on Windows.

As you Cc:ed the msysGit list, do you want this in 4msysgit.git, too?

Ciao,
Dscho
