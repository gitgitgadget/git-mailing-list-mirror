From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 03/11] Define SNPRINTF_SIZE_CORR 1 when use MSVC build
 git
Date: Tue, 18 Aug 2009 11:31:11 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908181129100.4680@intel-tinevez-2-302>
References: <1250524872-5148-1-git-send-email-lznuaa@gmail.com>  <1250524872-5148-2-git-send-email-lznuaa@gmail.com>  <1250524872-5148-3-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171829510.4991@intel-tinevez-2-302>
 <1976ea660908171819m38d3524ud174a7e76a171e75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Frank Li <lznuaa@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 11:31:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdL2H-00040v-9B
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 11:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbZHRJbN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 05:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZHRJbM
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 05:31:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:34229 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753210AbZHRJbM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 05:31:12 -0400
Received: (qmail invoked by alias); 18 Aug 2009 09:31:12 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp063) with SMTP; 18 Aug 2009 11:31:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18d0godP0odGswRHN3ZdzXXG4y7t1umMZv71OAIZf
	cf3Du2+dVZYN3X
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1976ea660908171819m38d3524ud174a7e76a171e75@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126359>

Hi,

On Tue, 18 Aug 2009, Frank Li wrote:

> > How about this instead?
> >
> > 	Define SNPRINTF_SIZE_CORR=1 for Microsoft Visual C++
> >
> > 	The Microsoft C runtime's vsnprintf function does not add NUL at
> > 	the end of the buffer.
> >
> > 	Further, Microsoft deprecated vsnprintf in favor of _vsnprintf, so
> > 	add a #define to that end.
> 
> Of course,  do you need me change commit comment and resend patch?

I think it would be best if you could rewrite your vcpatch branch using 
the new commit message.

> > The patch is good, although I suspect that the definition of vsnprintf 
> > is better handled in the precompiler options in .vcproj.
> 
> If define in .vcproj, it needs copy that to DEBUG\RELEASE and 
> 32bit\64bit (2x2) 4 places. It is easy to miss one.

No, there are the common precompiler options, too.

But maybe it is better to leave the #define's in a header file for another 
reason: better visibility (I always hated it that I had to open the 
project files in a text editor in order to find the settings with Visual 
Studio, the GUI seems to be designed by a fan of hide-and-seek).

Ciao,
Dscho
