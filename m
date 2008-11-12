From: Arafangion <thestar@fussycoder.id.au>
Subject: Re: [PATCH 2/2] Cached the git configuration, which is now
	noticibly faster on windows.
Date: Wed, 12 Nov 2008 22:54:50 +1100
Message-ID: <1226490890.10685.3.camel@therock.nsw.bigpond.net.au>
References: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
	 <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
	 <7vr65kagvm.fsf@gitster.siamese.dyndns.org>
	 <200811101046.01543.simon@lst.de>
	 <7vzlk5u5rq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Simon Hausmann <simon@lst.de>,
	Han-Wen Nienhuys <hanwen@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 13:59:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0FJu-0007KV-9H
	for gcvg-git-2@gmane.org; Wed, 12 Nov 2008 13:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbYKLM61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2008 07:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbYKLM60
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Nov 2008 07:58:26 -0500
Received: from nschwqsrv02p.mx.bigpond.com ([61.9.189.234]:43087 "EHLO
	nschwqsrv02p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587AbYKLM6Z (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Nov 2008 07:58:25 -0500
Received: from nschwotgx01p.mx.bigpond.com ([58.173.132.215])
          by nschwmtas04p.mx.bigpond.com with ESMTP
          id <20081112114448.LCMS1796.nschwmtas04p.mx.bigpond.com@nschwotgx01p.mx.bigpond.com>;
          Wed, 12 Nov 2008 11:44:48 +0000
Received: from therock.local ([58.173.132.215])
          by nschwotgx01p.mx.bigpond.com with ESMTP
          id <20081112114446.IFMZ15831.nschwotgx01p.mx.bigpond.com@therock.local>;
          Wed, 12 Nov 2008 11:44:46 +0000
In-Reply-To: <7vzlk5u5rq.fsf@gitster.siamese.dyndns.org>
X-Mailer: Evolution 2.6.3 
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150203.491AC1AE.0049,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100746>

Thanks for making those patches more visible, however I do feel the need
to mention one thing I expected to have been raised during patch review:
1) The memory optimisation may cause significant slowdown, which wasn't
a big issue on my machine, perhaps because I'm _still_ trying to get it
to work on my particular repo. (It's still using too much memory), and I
have a very fast machine.  It switches git-p4 from a RAM-intensive app
to a somewhat-less-RAM-intensive app at the cost of also becomming much
more CPU-intensive.



On Tue, 2008-11-11 at 16:50 -0800, Junio C Hamano wrote:
> Simon Hausmann <simon@lst.de> writes:
> 
> > On Sunday 09 November 2008 Junio C Hamano, wrote:
> >> These are patches to fast-import/git-p4, which you two seem to in charge
> >> of.
> >>
> >>     From:	John Chapman <thestar@fussycoder.id.au>
> >>     Subject: [PATCH 1/2] Added support for purged files and also optimised
> >> memory usage. Date:	Sat,  8 Nov 2008 14:22:48 +1100
> >>     Message-Id: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
> >>
> >>     From:	John Chapman <thestar@fussycoder.id.au>
> >>     Subject: [PATCH 2/2] Cached the git configuration, which is now
> >> noticibly faster on windows. Date:	Sat,  8 Nov 2008 14:22:49 +1100
> >>     Message-Id: <1226114569-8506-2-git-send-email-thestar@fussycoder.id.au>
> >>
> >> It was unfortunately not immediately obvious from the Subject: line what
> >> these patches are about, and I am guessing you missed them because of that.
> >
> > Ack on both patches. The second one could be done better, as suggested
> > in the follow-ups, but both are clearly an improvement :)
> 
> Thanks, both of you.  Will apply.
> 
