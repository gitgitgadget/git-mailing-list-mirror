From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH 07/17] Fix __stdcall/WINAPI placement and
 function prototype
Date: Tue, 15 Sep 2009 02:24:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0909150224010.8306@pacific.mpi-cbg.de>
References: <cover.1252925290.git.mstormo@gmail.com> <160ceafba5f58cfcadb13380e3d8ef724009b700.1252925290.git.mstormo@gmail.com> <1d699897d4163224ce22db9400569fab20547e9d.1252925290.git.mstormo@gmail.com> <200909142200.52174.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <mstormo@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Sep 15 02:23:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnLpI-0002WS-5W
	for gcvg-git-2@lo.gmane.org; Tue, 15 Sep 2009 02:23:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757346AbZIOAXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2009 20:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757340AbZIOAXJ
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 20:23:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:34337 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757334AbZIOAXI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 20:23:08 -0400
Received: (qmail invoked by alias); 15 Sep 2009 00:23:10 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp003) with SMTP; 15 Sep 2009 02:23:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+2/+M0pTO2ezul711fq/FCACCquG/ZwbGL95ex/P
	L0qLjMDrrqweA1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200909142200.52174.j6t@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128502>

Hi,

On Mon, 14 Sep 2009, Johannes Sixt wrote:

> On Montag, 14. September 2009, Marius Storm-Olsen wrote:
> > WINAPI is a macro which translates into the proper calling convention, so
> > replace __stdcall with that.
> 
> I've already pointed out elsewhere that the documentation of 
> _beginthreadex explicitly says that the calling convention of the 
> function pointer must be __stdcall. It does not mention WINAPI. 
> Therefore, I think that these two changes are not correct:
> 
> > -static __stdcall unsigned ticktack(void *dummy)
> > +static unsigned WINAPI ticktack(void *dummy)
> 
> > -static __stdcall unsigned run_thread(void *data)
> > +static unsigned WINAPI run_thread(void *data)
> 
> You should s/WINAPI/__stdcall/.

I don't think that comments by our most proficient MSys guy should be 
disregarded as thee comments were.

Ciao,
Dscho
