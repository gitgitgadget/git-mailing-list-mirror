From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 7/7] Factor ref updating out of fetch_with_import
Date: Thu, 29 Oct 2009 08:56:07 -0700
Message-ID: <20091029155607.GA10505@spearce.org>
References: <1256798426-21816-1-git-send-email-srabbelier@gmail.com> <1256798426-21816-8-git-send-email-srabbelier@gmail.com> <20091029142232.GS10505@spearce.org> <fabb9a1e0910290853p49070443v6d6bf2bf75faf80@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 16:56:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3XMF-0007aa-Dn
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 16:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbZJ2P4E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 11:56:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbZJ2P4E
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 11:56:04 -0400
Received: from george.spearce.org ([209.20.77.23]:57140 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZJ2P4D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 11:56:03 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id F24E438200; Thu, 29 Oct 2009 15:56:07 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <fabb9a1e0910290853p49070443v6d6bf2bf75faf80@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131605>

Sverre Rabbelier <srabbelier@gmail.com> wrote:
> On Thu, Oct 29, 2009 at 07:22, Shawn O. Pearce <spearce@spearce.org> wrote:
> > Please define a transport_update_refs wrapper function to implement
> > this method invocation on the transport instance. ?Callers should
> > not be reaching into the struct transport directly.
> 
> With pleasure, should the transport_update_refs wrapper simply 'return
> 1' without doing anything if transport->update_refs is not set?

If the function isn't defined, it should behave as though it were
defined and successfully completed.
 
> > I certainly have to wonder... if this is done in both fetch and
> > clone, why isn't it just part of fetch_refs?
> 
> Because clone does not use fetch_refs, or am I missing something?

Hmmph.  Weird.  Its been a while since I last looked at this code,
maybe I misunderstood it.
 
-- 
Shawn.
