From: "Josh England" <jjengla@sandia.gov>
Subject: Re: tracking perms/ownership
Date: Fri, 24 Aug 2007 02:19:58 -0600
Message-ID: <1187943598.6357.99.camel@beauty>
References: <1187716461.5986.71.camel@beauty>
 <20070821134030.b763e9d3.seanlkml@sympatico.ca>
 <1187817948.5986.159.camel@beauty>
 <alpine.LFD.0.999.0708221618510.30176@woody.linux-foundation.org>
 <1187905879.5986.199.camel@beauty>
 <7vtzqpsy3q.fsf@gitster.siamese.dyndns.org>
 <1187940171.6357.59.camel@beauty>
 <7vd4xds7oj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 10:19:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOUOB-0006SN-W3
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 10:19:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752683AbXHXITS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 04:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753118AbXHXITS
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 04:19:18 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:4506 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753965AbXHXITQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 04:19:16 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Fri, 24 Aug 2007 02:19:01 -0600
X-Server-Uuid: AA8306FD-23D1-4E5B-B133-B2D9F10C3631
Received: from [134.253.112.50] (sacv8030ay.sandia.gov [134.253.112.50])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l7O8J09n007978;
 Fri, 24 Aug 2007 02:19:00 -0600
In-Reply-To: <7vd4xds7oj.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.311128,
 Antispam-Data: 2007.8.24.5123
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_900_999
 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070824081902; SEV=2.2.2; DFV=B2007082407;
 IFV=2.0.4,4.0-9; AIF=B2007082407; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230352E34364345393437352E303046313A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007082407_5.02.0125_4.0-9
X-WSS-ID: 6AD04BFF3HO208088-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56563>

On Fri, 2007-08-24 at 00:39 -0700, Junio C Hamano wrote:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> > That's ok.  Any place to store the data is fine by me.  I'm just
> > concerned about some comments I saw in attrs.c <line13>:
> > /*
> > The basic design decision here is that we are not going to have insanely
> > large number of attributes.
> > This is a randomly chosen prime.
> > */
> > #define HASHSIZE 257
> 
> That talks about the size of the vocabulary of attribute names,
> such as "diff", "crlf", "merge".  IIRC, you need two more
> (owner, perm) or maybe three (group), not 150k.

OK that's comforting.  The 150k above though is not # of attribute
*types* (perms/uid/gid or whatever), it is number of attribute *entries*
in a .gitattributes file (eg:  /etc/sudoers  mode=0440 uid=0 gid=0).
Hopefully it shouldn't actually be as high as 150k, i don't know.

-JE
