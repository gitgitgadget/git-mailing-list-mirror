From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add
 callbacks.
Date: Tue, 16 Oct 2007 17:44:44 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710161742040.25221@racer.site>
References: <1192522616-16274-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-1-git-send-email-madcoder@debian.org>
 <1192523998-19474-2-git-send-email-madcoder@debian.org>
 <1192523998-19474-3-git-send-email-madcoder@debian.org>
 <1192523998-19474-4-git-send-email-madcoder@debian.org>
 <1192523998-19474-5-git-send-email-madcoder@debian.org>
 <1192523998-19474-6-git-send-email-madcoder@debian.org>
 <1192523998-19474-7-git-send-email-madcoder@debian.org> <20071016084510.GI6919@artemis.corp>
 <4714E90C.80305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:45:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhpXT-00042z-4t
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:45:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbXJPQox (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:44:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754276AbXJPQox
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:44:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:42949 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753438AbXJPQow (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:44:52 -0400
Received: (qmail invoked by alias); 16 Oct 2007 16:44:50 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 16 Oct 2007 18:44:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19/GnteyW1/xpRssd2ghzxOVQ3yP3E3V7B0X0b0ue
	VEjQEC678AirCs
X-X-Sender: gene099@racer.site
In-Reply-To: <4714E90C.80305@lsrfire.ath.cx>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61206>

Hi,

On Tue, 16 Oct 2007, Ren? Scharfe wrote:

> Pierre Habouzit schrieb:
> > This bit is to allow to aggregate options with arguments together when
> > the argument is numeric.
> > 
> >     +#if 0
> >     +		/* can be used to understand -A1B1 like -A1 -B1 */
> >     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
> >     +			*(int *)opt->value = strtol(opt->opt, (char **)&opt->opt, 10);
> >     +			return 0;
> >     +		}
> >     +#endif
> 
> I don't like it, it complicates number options with unit suffixes (e.g.
> --windows-memory of git-pack-objects).

Why?  It only means that you cannot say -W10mxabc instead of -W10m xabc.  

Remember: this is a special case for OPT_INTEGER.  Nothing to do with 
OPT_SIZE, which you'd probably implement as a callback.

Ciao,
Dscho
