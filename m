From: "Josh England" <jjengla@sandia.gov>
Subject: Re: tracking perms/ownership [was: empty directories]
Date: Fri, 24 Aug 2007 09:50:32 -0600
Message-ID: <1187970632.6357.108.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <Pine.LNX.4.64.0708241136301.16728@wbgn129.biozentrum.uni-wuerzburg.de>
 <20070824095217.GB16853@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Jeff King" <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 24 17:49:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IObPz-0006Mc-TA
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 17:49:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbXHXPtr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 11:49:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbXHXPtr
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 11:49:47 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:4544 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752441AbXHXPtq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 11:49:46 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 24 Aug 2007 09:49:35 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [134.253.112.134] (sacv8030ee.sandia.gov
 [134.253.112.134]) by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id
 l7OFnWJw013612; Fri, 24 Aug 2007 09:49:33 -0600
In-Reply-To: <20070824095217.GB16853@coredump.intra.peff.net>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.24.81738
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070824154936; SEV=2.2.2; DFV=B2007082412;
 IFV=2.0.4,4.0-9; AIF=B2007082412; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230372E34364345464531302E303031383A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082412_5.02.0125_4.0-9
X-WSS-ID: 6AD021852E0248406-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56579>

On Fri, 2007-08-24 at 05:52 -0400, Jeff King wrote:
> On Fri, Aug 24, 2007 at 11:38:13AM +0200, Johannes Schindelin wrote:
> 
> > > So here's the initial thought.  Create two new gitattributes, 'perms'
> > > and 'ownership', which will track perms/ownership for files matching the
> > > given pattern.
> > 
> > I wonder why you do not just use the "smudge" and "clean" attributes, and 
> > store the ownership _and_ the permissions in .gitacls.
> > 
> > Yes, _maybe_ it is something other people might want, too, but let's start 
> > quick & easy, no?
> 
> Yes, I think that is a much better idea. Perhaps they aren't that
> popular among this crowd, but it seems silly to develop in this
> direction and not at least consider people storing actual ACLs (or even
> other extended attributes). An already-standard format like that
> produced by 'getfacl' should make this pretty trivial (and handles
> regular unix permissions at the same time).

Do you mean using acls through contrib/hooks/update-paranoid?  That is
the only place I see any mention of them.  clean and smudge seem out
because they are passed blob objects and have no notion of pathname.  I
don't see how to use this for automatic storing/restoring of
perms/ownership.

-JE
