From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH v2 08/16] remote-helpers: Support custom transport
 options
Date: Tue, 13 Oct 2009 17:41:48 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910131732260.32515@iabervon.org>
References: <1255400715-10508-1-git-send-email-spearce@spearce.org> <1255400715-10508-9-git-send-email-spearce@spearce.org> <alpine.LNX.2.00.0910122357230.32515@iabervon.org> <20091013184531.GB9261@spearce.org> <alpine.LNX.2.00.0910131550170.32515@iabervon.org>
 <20091013205258.GD9261@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 13 23:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mxp9L-0004He-Fq
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 23:43:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbZJMVm0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Oct 2009 17:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759540AbZJMVm0
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Oct 2009 17:42:26 -0400
Received: from iabervon.org ([66.92.72.58]:36396 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753120AbZJMVmZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Oct 2009 17:42:25 -0400
Received: (qmail 8248 invoked by uid 1000); 13 Oct 2009 21:41:48 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 13 Oct 2009 21:41:48 -0000
In-Reply-To: <20091013205258.GD9261@spearce.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130220>

On Tue, 13 Oct 2009, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Tue, 13 Oct 2009, Shawn O. Pearce wrote:
> > > > > +'option thin'::
> > > > > +	Transfer the data as a thin pack if possible.
> > > > 
> > > > Does anyone still use non-default thinness? 
> > > 
> > > Its a command line option on the porcelain.
> > 
> > Actually, the command line supports turning it on, and it defaults to on. 
> > So I think your helper can safely assume that it's on. :)
> 
> For fetch it defaults to "on", but for push I think it defaults
> to "off".  Turning it on when pushing on a low bandwidth network
> connection might actually be useful to an end-user.

Nope, on ~line 849 of transport.c, it gets set for all native-transport 
handlers, and never gets turned off. Looks like a misconversion 2 years 
ago defaulting "data->thin" to 1 instead of 0, but it seems not to have 
caused problems.

	-Daniel
*This .sig left intentionally blank*
