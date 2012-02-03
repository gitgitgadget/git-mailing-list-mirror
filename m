From: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: Alternates corruption issue
Date: Fri, 03 Feb 2012 14:40:19 +0000
Message-ID: <1328280019.3895.112.camel@ted>
References: <1328018729.13744.26.camel@ted>
	 <20120131193922.GA31551@sigill.intra.peff.net>
	 <7v1uqf8vqu.fsf@alter.siamese.dyndns.org>
	 <20120131204417.GA30969@sigill.intra.peff.net>
	 <20120131214047.GA13547@burratino>
	 <20120131214740.GA2465@sigill.intra.peff.net>
	 <20120131215501.GF13252@burratino>
	 <20120131220510.GA3253@sigill.intra.peff.net>
	 <20120131222258.GG13252@burratino>
	 <20120202215913.GA26727@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	"Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 03 15:40:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtKJm-0002Jk-GC
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 15:40:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756730Ab2BCOkp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 09:40:45 -0500
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:49388 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756638Ab2BCOkp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 09:40:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q13EeQ3p021354;
	Fri, 3 Feb 2012 14:40:26 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 20022-07; Fri,  3 Feb 2012 14:40:22 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q13EeERt021348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 3 Feb 2012 14:40:14 GMT
In-Reply-To: <20120202215913.GA26727@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.2- 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189778>

On Thu, 2012-02-02 at 16:59 -0500, Jeff King wrote:
> On Tue, Jan 31, 2012 at 04:22:58PM -0600, Jonathan Nieder wrote:
> 
> > Anyway, thanks for explaining.  Hopefully I can get to this soon and
> > factor out a common function for get_repo_path and enter_repo to call
> > so playing with the ordering becomes a little less scary. ;-)
> 
> So here's what I think we should apply to fix the particular issue that
> Richard mentioned at the start of this thread.
> 
> Besides tweaking the ordering, the main contribution is a set of tests
> that actually check some of these ambiguous cases (especially checking
> the fact that both code paths behave identically!). I didn't factor the
> logic into a common function, but doing so should be a little safer on
> top of these tests, if you're still interested.

I didn't have much to add to the discussion yesterday but this solution
looks good to me and should resolve the problems I was seeing.

Thanks!

Richard
