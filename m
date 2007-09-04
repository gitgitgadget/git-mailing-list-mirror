From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] Add post-merge hook.
Date: Tue, 04 Sep 2007 15:23:49 -0600
Message-ID: <1188941029.6192.73.camel@beauty>
References: <11885136172952-git-send-email-jjengla@sandia.gov>
 <7v7inc7hao.fsf@gitster.siamese.dyndns.org>
 <1188923110.6192.15.camel@beauty>
 <7vmyw2ny05.fsf@gitster.siamese.dyndns.org>
 <1188934573.6192.35.camel@beauty>
 <7vodgimc53.fsf@gitster.siamese.dyndns.org>
 <1188937975.6192.59.camel@beauty> <46DDC576.3080708@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Steven Grimm" <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 23:23:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISfrR-0006Pv-Dc
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 23:23:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755322AbXIDVW5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 17:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbXIDVW4
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 17:22:56 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:2444 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755294AbXIDVW4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 17:22:56 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Tue, 04 Sep 2007 15:22:43 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l84LMdnG024199;
 Tue, 4 Sep 2007 15:22:39 -0600
In-Reply-To: <46DDC576.3080708@midwinter.com>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.4.135524
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='BODY_SIZE_700_799
 0, __CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0,
 __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0,
 __pbl.spamhaus.org_TIMEOUT '
X-TMWD-Spam-Summary: TS=20070904212244; SEV=2.2.2; DFV=B2007090416;
 IFV=2.0.4,4.0-9; AIF=B2007090416; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230312E34364444434341332E303041413A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007090416_5.02.0125_4.0-9
X-WSS-ID: 6AC313292E01273503-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57647>

On Tue, 2007-09-04 at 13:52 -0700, Steven Grimm wrote:
> Josh England wrote:
> > I'm thinking that it
> > will be sufficient to pass a flag indicating whether the working tree
> > has been modified or not.  The flag can be set for normal merge and
> > fast-forward merges, and unset for up-to-dates and squash merges.
> >   
> Squash merges modify the working tree. In fact, that's *all* they do -- 
> they don't commit anything.

OK.  Looking at it closer, the post-merge hook should only run when
there has been a real merge (not run for up-to-dates), which seems
alright with me.  With the immediate data at hand I could pass in a flag
indicating a squash merge or not, or could simply pass in the current
HEAD.  I think the first scenario is more appropriate.

-JE
