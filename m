From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hook, and related docs and tests
Date: Tue, 25 Sep 2007 15:47:20 -0600
Message-ID: <1190756840.6078.109.camel@beauty>
References: <1190406421-15620-1-git-send-email-jjengla@sandia.gov>
 <7vzlzfh7xd.fsf@gitster.siamese.dyndns.org>
 <1190654052.6078.14.camel@beauty>
 <7vsl53ap5x.fsf@gitster.siamese.dyndns.org>
 <1190662396.6078.63.camel@beauty>
 <7vejgnai1z.fsf@gitster.siamese.dyndns.org>
 <1190671558.6078.87.camel@beauty>
 <7vfy138vql.fsf@gitster.siamese.dyndns.org>
 <1190738473.6078.102.camel@beauty>
 <7v4phi5t98.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 23:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaIDl-0007ge-IG
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 23:45:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbXIYVpX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 17:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbXIYVpX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 17:45:23 -0400
Received: from mm03snlnto.sandia.gov ([132.175.109.20]:4480 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751375AbXIYVpV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 17:45:21 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 25 Sep 2007 15:45:12 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8PLjB4k030561;
 Tue, 25 Sep 2007 15:45:11 -0600
In-Reply-To: <7v4phi5t98.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.25.141627
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_900_999
 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070925214513; SEV=2.2.2; DFV=B2007092517;
 IFV=2.0.4,4.0-9; AIF=B2007092517; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230322E34364639383136382E303131343A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092517_5.02.0125_4.0-9
X-WSS-ID: 6AE75EE22E03440606-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59178>

On Tue, 2007-09-25 at 14:29 -0700, Junio C Hamano wrote:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> > So this leads to my next question:  Should the post-merge patch be
> > brought in under this same umbrella to form a single post-checkout hook,
> > or should it stay a separate hook?
> 
> I think it is called would be inconvenient for the callee if you
> call the same hook without telling the hook script why it is
> called, so if you go in the unification route the caller of the
> unified hook needs to supply an extra parameter and existing
> hooks if any need to be updated --- neither sounds like a very
> idea.  The writer of the hooks however can choose to call one
> from the other if he wants the same action for both hooks, so it
> looks to me that separate hooks for separate purposes is the way
> to go.

Yeah, I agree.  I'll rework post-checkout and send in both again.

-JE
