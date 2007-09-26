From: "Josh England" <jjengla@sandia.gov>
Subject: Re: [PATCH] post-checkout hooks and related tests
Date: Wed, 26 Sep 2007 11:16:50 -0600
Message-ID: <1190827010.6078.123.camel@beauty>
References: <1190760563-32453-1-git-send-email-jjengla@sandia.gov>
 <7vve9y2v39.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 19:15:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaaTW-0000O5-4S
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 19:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755175AbXIZROw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 13:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbXIZROw
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 13:14:52 -0400
Received: from mm04snlnto.sandia.gov ([132.175.109.21]:1927 "EHLO
	sentry.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754367AbXIZROv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 13:14:51 -0400
Received: from [132.175.109.1] by sentry.sandia.gov with ESMTP (SMTP
 Relay 01 (Email Firewall v6.3.1)); Wed, 26 Sep 2007 11:14:38 -0600
X-Server-Uuid: 6CEB1540-FE13-491B-9872-FD67060ED864
Received: from [132.175.2.191] (beauty.son.sandia.gov [132.175.2.191])
 by mailgate.sandia.gov (8.14.0/8.14.0) with ESMTP id l8QHEbuO023181;
 Wed, 26 Sep 2007 11:14:37 -0600
In-Reply-To: <7vve9y2v39.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.10.1
X-PMX-Version: 5.3.3.310218, Antispam-Engine: 2.5.2.313940,
 Antispam-Data: 2007.9.26.93837
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0,
 __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0,
 __MIME_VERSION 0, __SANE_MSGID 0'
X-TMWD-Spam-Summary: TS=20070926171438; SEV=2.2.2; DFV=B2007092615;
 IFV=2.0.4,4.0-9; AIF=B2007092615; RPD=5.02.0125; ENG=IBF;
 RPDID=7374723D303030312E30413031303230372E34364641393337442E303045433A53434A535441543838363133332C73733D312C6667733D30;
 CAT=NONE; CON=NONE
X-MMS-Spam-Filter-ID: B2007092615_5.02.0125_4.0-9
X-WSS-ID: 6AE44CF42E03534886-01-01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59236>

On Tue, 2007-09-25 at 16:17 -0700, Junio C Hamano wrote:
> "Josh England" <jjengla@sandia.gov> writes:
> 
> > diff --git a/git-checkout.sh b/git-checkout.sh
> > index 17f4392..78355eb 100755
> > --- a/git-checkout.sh
> > +++ b/git-checkout.sh
> > @@ -137,6 +137,13 @@ Did you intend to checkout '$@' which can not be resolved as commit?"
> >  	git ls-files --error-unmatch -- "$@" >/dev/null || exit
> >  	git ls-files -- "$@" |
> >  	git checkout-index -f -u --stdin
> > +
> > +        # Run a post-checkout hook -- the HEAD does not change so the
> > +	# current HEAD is passed in for both args
> > +	if test -x "$GIT_DIR"/hooks/post-checkout; then
> 
> It is usually a good idea to view your patch in your MUA before
> sending them out.
>
> You will spot HT vs SP indentation inconsistencies right away.

Dang.  It looked ok in emacs.  :(

> HEAD did not change but don't you want to differenciate if the
> checkout was from the index or from the HEAD?  If not why not?

Hmmmm.  It wouldn't hurt to add another arg though I guess in case
someone might use it.  I'm just trying to figure out how to word this
nicely in the Documentation.

-JE
