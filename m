From: Steven Grimm <koreth@midwinter.com>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 12:12:33 -0700
Message-ID: <D0968007-2A38-44DB-B26F-3D273F20D428@midwinter.com>
References: <4819CF50.2020509@tikalk.com> <4819D98E.1040004@tikalk.com> <32541b130805010827r22169651s37c707071f3448f2@mail.gmail.com> <20080501153457.GB11469@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Ittay Dror <ittayd@tikalk.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu May 01 21:13:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JreDd-0002Fi-VP
	for gcvg-git-2@gmane.org; Thu, 01 May 2008 21:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758618AbYEATMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 15:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758239AbYEATMh
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 15:12:37 -0400
Received: from tater.midwinter.com ([216.32.86.90]:39594 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758226AbYEATMh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 15:12:37 -0400
Received: (qmail 32175 invoked from network); 1 May 2008 19:12:34 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=Os04ZMNB7Uep94zAMPUX61gZRSdMsXgEqZOCqQ61rizy/uxgdbrBgnasm9jUMQiu  ;
Received: from localhost (HELO ?IPv6:::1?) (127.0.0.1)
  by localhost with SMTP; 1 May 2008 19:12:34 -0000
In-Reply-To: <20080501153457.GB11469@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.919.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80934>

On May 1, 2008, at 8:34 AM, Jeff King wrote:
> So I don't think you can always track the intent automatically.

That is absolutely true. You have to pick one case or the other as the  
default unless there's some way to tell the system your intent either  
at merge time or at move time.

However, that leaves the question of which default will be wrong the  
least often.

In my personal experience, I think a directory rename has almost  
always meant that I would want new files to appear in the new  
directory rather than to recreate the old directory. I can't think of  
a single time when I've wanted git's current behavior (though maybe  
it's happened on occasion) but the current behavior has tripped me up  
more than once and forced me to do extra work shuffling things around  
by hand post-merge. I acknowledge that there exist cases where the  
current behavior is correct -- but in my experience they're the  
minority.

Of course, the discussion is moot anyway until someone writes code to  
detect the situation; my impression is the current behavior is the way  
it is simply because it's what naturally happens in the absence of  
merge-time detection of a directory getting renamed.

-Steve
