From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix argument handling for fetch-pack call when stdout
 is connected and -q/--quiet is supplied.
Date: Fri, 3 Oct 2008 16:39:55 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810031636010.19665@iabervon.org>
References: <4ac8254d0810031234x26ebc96cy7cf5dcae2ef516e0@mail.gmail.com>  <alpine.LNX.1.00.0810031548260.19665@iabervon.org>  <4ac8254d0810031318j3e0f326ewc4bf250c51681670@mail.gmail.com> <85647ef50810031333m254036bav81d6dd4a58fb56da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org,
	davej@codemonkey.org.uk
To: Constantine Plotnikov <constantine.plotnikov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 22:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlrSX-0007d5-9M
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 22:41:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbYJCUj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 16:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753076AbYJCUj6
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 16:39:58 -0400
Received: from iabervon.org ([66.92.72.58]:51784 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752796AbYJCUj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 16:39:57 -0400
Received: (qmail 11448 invoked by uid 1000); 3 Oct 2008 20:39:56 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 3 Oct 2008 20:39:56 -0000
In-Reply-To: <85647ef50810031333m254036bav81d6dd4a58fb56da@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97453>

On Sat, 4 Oct 2008, Constantine Plotnikov wrote:

> I think such patch would be too harsh for IDE plugin developers. When
> git is run from IDE, the isatty(1) will be true. But progress
> information will be still useful, to display an operation progress to
> user. Please provide a way to force output of progress (for example
> using environment).

Probably progress.h ought to have something for whether progress bars make 
sense, that uses isatty(1) with an environment variable override. 
Conceptually, transport.c should be figuring out whether the verbosity of 
the operation suggests progress bars, and should pass off to something 
else the determination of whether we can actually output progress bars in 
particular.

	-Daniel
*This .sig left intentionally blank*
