From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/4] Build-in send-pack, with an API for other programs to call.
Date: Mon, 29 Oct 2007 21:18:38 -0400
Message-ID: <20071030011838.GV14735@spearce.org>
References: <Pine.LNX.4.64.0710292049350.7357@iabervon.org> <20071030011401.GU14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 30 02:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Imfkw-0005Se-4Y
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 02:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350AbXJ3BSo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2007 21:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752255AbXJ3BSo
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Oct 2007 21:18:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51994 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbXJ3BSo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2007 21:18:44 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1ImfkU-0004dJ-6H; Mon, 29 Oct 2007 21:18:30 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 961F220FBAE; Mon, 29 Oct 2007 21:18:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071030011401.GU14735@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62644>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
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
> Ick.  How about doing what I did with builtin-fetch-pack.c [...]

To be more precise please refer to the following fetch-pack changes:

  fa74052922: Always obtain fetch-pack arguments from struct fetch_pack_args
  bbaf458428: Use 'unsigned:1' when we mean boolean options

-- 
Shawn.
