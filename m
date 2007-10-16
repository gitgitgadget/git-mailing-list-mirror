From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional,
 add  callbacks.
Date: Tue, 16 Oct 2007 13:21:55 -0400 (EDT)
Message-ID: <alpine.LFD.0.9999.0710161320400.19446@xanadu.home>
References: <1192523998-19474-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-2-git-send-email-madcoder@debian.org>
 <1192523998-19474-3-git-send-email-madcoder@debian.org>
 <1192523998-19474-4-git-send-email-madcoder@debian.org>
 <1192523998-19474-5-git-send-email-madcoder@debian.org>
 <1192523998-19474-6-git-send-email-madcoder@debian.org>
 <1192523998-19474-7-git-send-email-madcoder@debian.org>
 <20071016084510.GI6919@artemis.corp> <4714E90C.80305@lsrfire.ath.cx>
 <Pine.LNX.4.64.0710161742040.25221@racer.site>
 <20071016165319.GC13946@artemis.corp>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 19:22:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihq7h-0004Ja-Gz
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 19:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761648AbXJPRV6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 13:21:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755173AbXJPRV5
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 13:21:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:28303 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbXJPRV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 13:21:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-0.15 (built Feb  9 2007))
 with ESMTP id <0JQ00093ULKJ6TD0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Oct 2007 13:21:55 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20071016165319.GC13946@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61227>

On Tue, 16 Oct 2007, Pierre Habouzit wrote:

> On Tue, Oct 16, 2007 at 04:44:44PM +0000, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Tue, 16 Oct 2007, Ren? Scharfe wrote:
> > 
> > > Pierre Habouzit schrieb:
> > > > This bit is to allow to aggregate options with arguments together when
> > > > the argument is numeric.
> > > > 
> > > >     +#if 0
> > > >     +		/* can be used to understand -A1B1 like -A1 -B1 */
> > > >     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
> > > >     +			*(int *)opt->value = strtol(opt->opt, (char **)&opt->opt, 10);
> > > >     +			return 0;
> > > >     +		}
> > > >     +#endif
> > > 
> > > I don't like it, it complicates number options with unit suffixes (e.g.
> > > --windows-memory of git-pack-objects).
> > 
> > Why?  It only means that you cannot say -W10mxabc instead of -W10m xabc.  
> > 
> > Remember: this is a special case for OPT_INTEGER.  Nothing to do with 
> > OPT_SIZE, which you'd probably implement as a callback.
> 
>   Yeah but the point is that you can't migrate an option currently being
> an integer to an OPT_SIZE because of that (see my other mail). Meaning
> that once an argument is of type OPT_INTEGER you can't change it's type
> in the future _AT ALL_ without breaking backward compatibility badly.
> I'd say it's a rather sucky design.

And what's the point of supporting so criptic arguments?
It doesn't have to go that far.


Nicolas
