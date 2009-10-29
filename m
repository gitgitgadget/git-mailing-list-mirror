From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 14:43:41 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0910291435180.14365@iabervon.org>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com>  <1256798426-21816-8-git-send-email-srabbelier@gmail.com> <20091029142232.GS10505@spearce.org>  <fabb9a1e0910290853p49070443v6d6bf2bf75faf80@mail.gmail.com>  <20091029155607.GA10505@spearce.org>
 <fabb9a1e0910290932u45c9c416m4d0ba0a8b2f5b01d@mail.gmail.com>  <alpine.LNX.2.00.0910291311570.14365@iabervon.org> <fabb9a1e0910291039u3c9d7eb6qe36e25ea76cdddc9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 19:43:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ZyO-0006tx-GN
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 19:43:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbZJ2Sni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 14:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755358AbZJ2Sni
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 14:43:38 -0400
Received: from iabervon.org ([66.92.72.58]:54205 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755330AbZJ2Sni (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 14:43:38 -0400
Received: (qmail 19934 invoked by uid 1000); 29 Oct 2009 18:43:41 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Oct 2009 18:43:41 -0000
In-Reply-To: <fabb9a1e0910291039u3c9d7eb6qe36e25ea76cdddc9@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131644>

On Thu, 29 Oct 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Thu, Oct 29, 2009 at 10:22, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > (a) if HEAD is determined to be a symref, and we care about HEAD, we care
> > about whatever HEAD is a symref to; wanted_peer_refs() shouldn't be
> > filtering such things out.
> 
> It seems that wanted_peer_refs filters out HEAD no matter what though?

It probably shouldn't. Actually, I bet Nico's clone will get extremely 
confused if the remote's HEAD isn't the same as any of its branches. I'll 
try to take a look tonight.

> > (b) we don't want to make a whole bunch of copies of the ref list to avoid
> > updating the mutable ref list that we will look for updated values in; the
> > merge of my series with Nico's should replace my copy_ref_list with his
> > wanted_peer_refs, not include the copy afterwards. Correcting this should
> > lead to the value that matters in the list that will be used having been
> > updated directly by transport_fetch_refs().
> 
> This I can and will fix. Patch-bomb incoming.

I'll look over it later, thanks.

	-Daniel
*This .sig left intentionally blank*
