From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: Re: Please discuss: what "git push" should do when you do not say
 what to push?
Date: Tue, 20 Mar 2012 23:41:28 +0000
Message-ID: <4F6915A8.9040009@pileofstuff.org>
References: <7v7gyjersg.fsf@alter.siamese.dyndns.org> <7vty1ndcoi.fsf@alter.siamese.dyndns.org> <4F6461D7.40303@pileofstuff.org> <7vipi1d9r7.fsf@alter.siamese.dyndns.org> <4F6792DE.80208@pileofstuff.org> <7v62e09sig.fsf@alter.siamese.dyndns.org> <4F67B78B.6080208@pileofstuff.org> <7vsjh48af1.fsf@alter.siamese.dyndns.org> <4F68F4A3.60506@pileofstuff.org> <7vhaxi50q8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 21 00:41:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SA8gM-0003SR-Dv
	for gcvg-git-2@plane.gmane.org; Wed, 21 Mar 2012 00:41:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932135Ab2CTXld (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Mar 2012 19:41:33 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:65325 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755627Ab2CTXlc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Mar 2012 19:41:32 -0400
Received: from aamtaout01-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120320234130.BAVZ21084.mtaout03-winn.ispmail.ntl.com@aamtaout01-winn.ispmail.ntl.com>;
          Tue, 20 Mar 2012 23:41:30 +0000
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout01-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120320234130.PFNW10211.aamtaout01-winn.ispmail.ntl.com@[192.168.0.2]>;
          Tue, 20 Mar 2012 23:41:30 +0000
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <7vhaxi50q8.fsf@alter.siamese.dyndns.org>
X-Cloudmark-Analysis: v=1.1 cv=R50lirqlHffDPPkwUlkuVa99MrvKdVWo//yz83qex8g= c=1 sm=0 a=pFZ1vDXyzkQA:10 a=thCgSaaV3M8A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=Y2EbQZCEdSMRtZGpx94A:9 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193552>

On 20/03/12 23:09, Junio C Hamano wrote:
> Andrew Sayers <andrew-git@pileofstuff.org> writes:
> 
>> I assume the reason for removing the warning altogether is that some day
>> the signal:noise ratio will just get too bad.
> 
> The reasoning is a lot simpler than that.
> 
> If the end game is not remove the warning, then we would be switching to a
> new default that is "give loud warning until the user configures her own
> default, but push upstream/current anyway" mode.  We do not want such a
> stupid mode as the default---we want the default to be either upstream or
> current at the end, when nobody remembers what the ancient default was.
> 
> The "warn loud but do it anyway" is a very good interim step during the
> migration, but is never a good default.  If we are going to stop there,
> "give loud warning until the user chooses and configures the default, and
> push nothing" mode would be a LOT safer and saner default, as it would
> really force people to configure the default.  Obviously we do not want to
> go there, so...
> 

It sounds like we're disagreeing, but I can't tell what about.  I agree
that "warn loud but do it anyway" is a bad default in the long term.  I
propose implementing the behaviour you want by adding a push.default
setting to the .git/config file for all new repositories, so that users
with a longer-than-expected short term still get the warning.  That
should warn 99% of the people who need it without bothering anyone that
doesn't.  What am I missing?

	- Andrew
