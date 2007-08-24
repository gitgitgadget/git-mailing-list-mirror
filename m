From: "Josh England" <jjengla@sandia.gov>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 10:27:05 -0600
Message-ID: <1187972825.6357.125.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <1187971879.6357.117.camel@beauty>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 18:26:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IObzP-0005G5-7y
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 18:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753402AbXHXQ0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 12:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754109AbXHXQ0X
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 12:26:23 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:3940 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbXHXQ0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 12:26:22 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 24 Aug 2007 10:26:07 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [134.253.112.134] (sacv8030ee.sandia.gov
 [134.253.112.134]) by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id
 l7OGQ5bm020643; Fri, 24 Aug 2007 10:26:06 -0600
In-Reply-To: <1187971879.6357.117.camel@beauty>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.24.90328
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_800_899
 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070824162607; SEV=2.2.2; DFV=B2007082413;
 IFV=2.0.4,4.0-9; AIF=B2007082413; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230362E34364346303639462E303035313A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082413_5.02.0125_4.0-9
X-WSS-ID: 6AD1D9153HO246657-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56581>

On Fri, 2007-08-24 at 10:11 -0600, Josh England wrote:
> On Thu, 2007-08-23 at 15:08 -0700, Junio C Hamano wrote:
> > Of course, you would need to worry about resolving merge
> > conflicts of gitattributes file, too.
> 
> I'm still confused on things.  So, with all perms/ownership stored
> as .gitattributes, would mucking around with the index still be
> necessary?  I'm not too sure what to do about merge conflicts.

OK, let me know if this is completely off-base.  perms/ownership can be
stored in the index at update-index time and restored maybe at
checkout-index time.  Calls to write-tree and read-tree can
store/retrieve the perms/ownership data from a .gitattributes file
somewhere; and something sane needs to be done about merging.  Does this
sound reasonable enough for a first cut?

-JE
