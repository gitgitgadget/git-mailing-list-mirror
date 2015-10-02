From: Spencer Graves <spencer.graves@prodsyse.com>
Subject: Re: can't install on OS X
Date: Fri, 2 Oct 2015 14:06:07 -0500
Message-ID: <560ED59F.7040604@prodsyse.com>
References: <560E2936.6020101@prodsyse.com>
 <136388305.2086780.1443793308932.JavaMail.zimbra@genarts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Stephen Bash <bash@genarts.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 21:06:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zi5ew-0001aY-4S
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 21:06:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbbJBTGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2015 15:06:12 -0400
Received: from cuda.garlic.com ([216.139.0.68]:33224 "EHLO Cuda.garlic.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818AbbJBTGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2015 15:06:11 -0400
X-ASG-Debug-ID: 1443812769-089ede16d16a3f50001-QuoKaX
Received: from nake.garlic.com (nake.garlic.com [216.139.50.102]) by Cuda.garlic.com with ESMTP id t3RDcIxduRxeiJF7; Fri, 02 Oct 2015 12:06:09 -0700 (PDT)
X-Barracuda-Envelope-From: spencer.graves@prodsyse.com
X-Barracuda-Apparent-Source-IP: 216.139.50.102
Received: from cpe-75-87-186-149.kc.res.rr.com ([75.87.186.149] helo=Spencer-Bryce-Gravess-MacBook-Pro.local)
	by nake.garlic.com with esmtpsa (UNKNOWN:AES128-SHA:128)
	(Exim 4.76)
	(envelope-from <spencer.graves@prodsyse.com>)
	id 1Zi5ej-0000XB-27; Fri, 02 Oct 2015 12:06:09 -0700
X-ASG-Orig-Subj: Re: can't install on OS X
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.3.0
In-Reply-To: <136388305.2086780.1443793308932.JavaMail.zimbra@genarts.com>
X-Barracuda-Connect: nake.garlic.com[216.139.50.102]
X-Barracuda-Start-Time: 1443812769
X-Barracuda-URL: https://cuda.garlic.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at garlic.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using per-user scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.23126
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278941>



On 10/2/2015 8:41 AM, Stephen Bash wrote:
> ----- Original Message -----
>> From: "Spencer Graves" <spencer.graves@prodsyse.com>
>> Sent: Friday, October 2, 2015 2:50:30 AM
>> Subject: can't install on OS X
>>
>> I downloaded "git-2.5.3-intel-universal-mavericks.dmg" per
>> instructions.  When I tried to install it, I first had trouble because
>> it wasn't from the Mac App Store nor an "identified developer".
> You can also right click on the installer and select "Open" for a very similar dialog, but one that gives you the opportunity to run the installer anyway.
>
>> "README.txt" says I need "sudo mv /usr/bin/git /usr/bin/git-system".  I
>> tried that and got, "mv: rename /usr/bin/git to /usr/bin/git-system:
>> Operation not permitted" (after entering my password).  [My directory
>> now includes "/usr/local/git", and "/usr/bin" includes git,
>> git-cvsserver, git-receive-pack, git-shell, git-upload-archive, and
>> git-upload-pack.]
>>
>> Suggestions?
> Sounds like you're running afoul of El Capitan's new System Integrity Protection (SIP) [1].  The git commands you're seeing there are probably Apple's thin wrappers that are mostly meant to provide instructions on installing XCode, but SIP is stopping you from modifying the /usr directory (ah, Apple's Infinite Wisdom).  There are discussions about working around SIP in the Apple forums [2] and Homebrew has some hints as well [3].
>
> [1] https://developer.apple.com/library/prerelease/mac/releasenotes/MacOSX/WhatsNewInOSX/Articles/MacOSX10_11.html
> [2] https://forums.developer.apple.com/thread/3981
> [3] https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/El_Capitan_and_Homebrew.md#if-usrlocal-does-not-exist


Thanks.  That helped.  I will summarize here what seemed to work for me 
(skipping the wailing, gnashing of teeth, Apple tech support, etc.):


[step 1] download and install "git-2.5.3-intel-universal-mavericks.dmg" 
as normal, ending with "Install successful".  Confirm that git is still 
not properly installed. Shut down or restart.


[step 2]  Boot into the Recovery partition by holding down <cmd>+R while 
power on and boot.


[step 3] Utilities > Terminal


[step 4] $ scrutil disable


[step 5] Restart normally > Terminal > sudo mv /usr/git /usr/bin/git-system


[step 6] Shut down and reboot into the Recovery partition as above.


[step 7] Utilities > Terminal


[step 8] $ scrutil enable


[step 9] Restart normally ...


*** Git now seems to be installed.  I'm still having trouble getting it 
to work properly with a private GitHub repository.  However, RStudio 
recognizes git, and I've confirmed that /usr/bin includes a subdirectory 
git-system and NOT simply git.  My problems now seem to be GitHub and 
RStudio issues.  Thanks again for your help.  I hope this summary might 
help others.  Spencer Graves

> HTH,
> Stephen
>
