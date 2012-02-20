From: Nikolaus Demmel <nikolaus@nikolaus-demmel.de>
Subject: Re: git-svn won't remember pem password
Date: Mon, 20 Feb 2012 04:08:36 +0100
Message-ID: <D3380C12-D9AE-47EF-86D5-17352E4DF35C@nikolaus-demmel.de>
References: <E56535F6-2C9B-4D14-A88F-2471E34D2769@gmail.com> <m3zkcgqt0g.fsf@localhost.localdomain> <20120220005727.GA4140@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jakub Narebski <jnareb@gmail.com>, Igor <mrigor83@gmail.com>,
	git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 20 04:08:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzJcL-00061Y-Au
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 04:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599Ab2BTDIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Feb 2012 22:08:40 -0500
Received: from moutng.kundenserver.de ([212.227.17.10]:50256 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751230Ab2BTDIj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Feb 2012 22:08:39 -0500
Received: from [192.168.178.100] (c-cca272d5.015-455-73746f34.cust.bredbandsbolaget.se [213.114.162.204])
	by mrelayeu.kundenserver.de (node=mreu0) with ESMTP (Nemesis)
	id 0Lxbn5-1SWSeE2QRP-017DPk; Mon, 20 Feb 2012 04:08:38 +0100
In-Reply-To: <20120220005727.GA4140@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1084)
X-Provags-ID: V02:K0:P83Kk7A11qYeFY5KlRtbDODhBaVuhtQzZf06hta3k7A
 ztV6Py3CUiMFGe7f/X9xiNZJnTIIRJCozxOBPDjAvQvHEFR7em
 wvfg9hEKQKR/tr1kgYafCtRr6Fg8g+DLxmGkLMvcV1sw8TkYLK
 Bz+Lo/NwcI+FQbjUcfNIIbV0Qs+oilkG+J/5nsJyQYwVgBZ06+
 5ENfXBf7bcznNdSOMTGM34BhxDOE4sQGTwSH6Lf+xjdHbwTPKP
 6SO1pE99D4LKKDSWOXeYCEx6B+6uFUEbiQYZ4xY3LCRF9UYR5/
 fETmYgGNnftZKB9OYEJcUkwJqKs2GVsgB9pm052pV6VRH/Eioe
 5TYz7+dZeI3ADlNFuNTgrudp4V0or9ZBnnzlBCc4R21ZtnT580
 x4G6/hXDdkSHyUDI+yH2CtTV3Bb4+/UMpE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191042>


Am 20.02.2012 um 01:57 schrieb Jeff King:

> On Sat, Feb 18, 2012 at 03:30:00AM -0800, Jakub Narebski wrote:
> 
>> Igor <mrigor83@gmail.com> writes:
>> 
>>> I'm running into an issue where I have to enter my pem certificate
>>> password every time I git-svn fetch or git-svn dcommit. Vanilla svn
>>> uses OS X KeyChain and remembers my password just fine. Is there a
>>> known solution for this? Other users have ran into same issue as
>>> described here:
>>> 
>>>  http://stackoverflow.com/questions/605519/does-git-svn-store-svn-passwords
>> 
>>> However, that solution of removing .subversion folder did not work
>>> for me.
>> 
>> I don't know if it is svn that has to remember password, or git that
>> has to remember password.  Git 1.7.9 learned "credentials API" that
>> allows integration with platform native keychain mechanisms, and I
>> think OS X Keychain is one of examples / supported platforms (but it
>> might not made it into core git)... though I am not sure if it affects
>> git-svn, or only HTTP(S) transport.
> 
> It does not affect git-svn currently.
> 
> I have some thoughts on providing access to the credentials API for
> scripts like git-svn (right now, it is accessible only by C git
> programs). However, there is an important question: should password
> prompting in git-svn behave like git, or behave like svn?
> 
> So far, it has been the latter, and I think that is reasonable. The
> resource that requires the credentials is an svn repo, not a git repo,
> so you are more likely to want to share credentials for it with real
> svn, and not other git commands.
> 

IMHO a normal user would expect git-svn to store credentials in the same way as normal svn. I think this is the way it should be.

Best regards,
Nikolaus