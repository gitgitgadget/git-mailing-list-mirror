From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git config: error when editing a repo config and not 
 being in one
Date: Thu, 30 Apr 2009 11:21:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904301117040.6621@intel-tinevez-2-302>
References: <alpine.DEB.1.00.0904300043030.10279@pacific.mpi-cbg.de>  <1241045387-30181-1-git-send-email-felipe.contreras@gmail.com>  <alpine.DEB.1.00.0904301036380.6621@intel-tinevez-2-302> <94a0d4530904300211j57903a3ei782b4e3e2f967c8a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Teemu Likonen <tlikonen@iki.fi>,
	Junio C Hamano <gitster@pobox.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 11:22:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzSSt-0002yc-5a
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 11:21:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755661AbZD3JVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2009 05:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752631AbZD3JVu
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Apr 2009 05:21:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:33256 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751115AbZD3JVt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2009 05:21:49 -0400
Received: (qmail invoked by alias); 30 Apr 2009 09:21:48 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 30 Apr 2009 11:21:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/l7WdaewLlrRd04foZ/YBhlRuoz2cvVWzcw4UE1F
	C9O1ltHndu6Tk8
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <94a0d4530904300211j57903a3ei782b4e3e2f967c8a@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118007>

Hi,

On Thu, 30 Apr 2009, Felipe Contreras wrote:

> On Thu, Apr 30, 2009 at 11:37 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 30 Apr 2009, Felipe Contreras wrote:
> >
> >> Let's throw an error on this specific case. If the user specifies the 
> >> config file, he must know what he is doing.
> >>
> >> Teemu Likonen pointed this out.
> >>
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >
> > I would have Acked it, but Junio already applied it ;-)
> 
> :)
> 
> Just for the record, where is people supposed to learn about 'nongit'? 
> Apparently it's not mentioned in the documentation.

It's not about 'nongit'.  It is about setting up the git directory 
"gently", i.e you can ask for a setup _if possible_ using 
setup_git_directory_gently(), which will not fail if we're not in any 
repository.

To require a repository, call setup_git_directory().  This will die() if 
there is no repository.

As we already ask via _gently() in cmd_config(), it appeared natural to me 
to reuse that information rather than redoing the discovery.

Ciao,
Dscho
