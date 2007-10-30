From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 3/4] Build-in send-pack, with an API for other programs
 to call.
Date: Mon, 29 Oct 2007 21:19:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710292119080.7357@iabervon.org>
References: <Pine.LNX.4.64.0710292049350.7357@iabervon.org>
 <20071030011401.GU14735@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 02:20:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImfmI-0005kb-0C
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 02:20:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbXJ3BUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 21:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752582AbXJ3BUD
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 21:20:03 -0400
Received: from iabervon.org ([66.92.72.58]:32985 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752423AbXJ3BUB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 21:20:01 -0400
Received: (qmail 454 invoked by uid 1000); 30 Oct 2007 01:19:52 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 30 Oct 2007 01:19:52 -0000
In-Reply-To: <20071030011401.GU14735@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62645>

On Mon, 29 Oct 2007, Shawn O. Pearce wrote:

> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > -int main(int argc, char **argv)
> > +void setup_send_pack(struct send_pack_args *args)
> > +{
> > +	receivepack = args->receivepack;
> > +	verbose = args->verbose;
> > +	send_all = args->send_all;
> > +	force_update = args->force_update;
> > +	use_thin_pack = args->use_thin_pack;
> > +	dry_run = args->dry_run;
> > +}
> ...
> > +struct send_pack_args {
> > +	const char *receivepack;
> > +	int verbose;
> > +	int send_all;
> > +	int force_update;
> > +	int use_thin_pack;
> > +	int dry_run;
> > +};
> > +
> 
> Ick.  How about doing what I did with builtin-fetch-pack.c which
> was to copy the args into a global "static struct fetch_pack_args"
> and make the struct a bitfield with these boolean items as ":1"
> rather than a full int?

Yeah, that's better. I'll respin parts 3 and 4 that way.

	-Daniel
*This .sig left intentionally blank*
