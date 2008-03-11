From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 05/10] http-push: Avoid calling setup_git_directory()
 twice
Date: Tue, 11 Mar 2008 16:08:07 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803111604240.3873@racer.site>
References: <cover.1204453703.git.pclouds@gmail.com>  <20080302103419.GA8957@laptop>  <alpine.LSU.1.00.0803111427400.3873@racer.site> <fcaeb9bf0803110754v7191d8fckbde0e1313e6a69ec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1510989072-1205247929=:3873"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 16:09:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ666-00025P-37
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 16:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757728AbYCKPIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 11:08:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757700AbYCKPIE
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 11:08:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:52105 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757658AbYCKPIC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 11:08:02 -0400
Received: (qmail invoked by alias); 11 Mar 2008 15:08:00 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp013) with SMTP; 11 Mar 2008 16:08:00 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+OzqcRb0COVqwNwwRomEw3011eRt3EqSd07/DROX
	ZebZZAsVSkJnKW
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0803110754v7191d8fckbde0e1313e6a69ec@mail.gmail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
Content-ID: <alpine.LSU.1.00.0803111605460.3873@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76862>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1510989072-1205247929=:3873
Content-Type: TEXT/PLAIN; CHARSET=VISCII
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LSU.1.00.0803111605461.3873@racer.site>

Hi,

On Tue, 11 Mar 2008, Nguyen Thai Ngoc Duy wrote:

> On Tue, Mar 11, 2008 at 8:28 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> >  On Sun, 2 Mar 2008, Nguy­n Thái Ng÷c Duy wrote:
> >
> >  > Signed-off-by: Nguy­n Thái Ng÷c Duy <pclouds@gmail.com>
> >
> >  This fix is completely independent of the rest of your series.
> 
> Not really. It would have no impact (good or bad) if sent separately. 
> But it is required by the series (otherwise it would die() under certain 
> condition because prefix cannot be recomputed properly).

Well, it _is_ independent.  Either you say "we want to have this as an 
example where you can call setup_git_directory() twice" (which I would not 
find all that bad), or you say "this was calling setup_git_directory() 
twice, fix that".

In any case, it should be separate from this series.

Back to the subject of this series: as I stated already, I do not like the 
separation of work-tree and git directory, and I especially do not like 
how much you had to work outside setup.c.  I think changing the semantics 
for all callers was not necessary, and in fact, not desirable.

Ciao,
Dscho

--8323584-1510989072-1205247929=:3873--
