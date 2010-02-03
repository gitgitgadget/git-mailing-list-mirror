From: "Christian Eisendle" <git@eisendle.net>
Subject: Re: Linux Kernel based project in git
Date: Wed, 3 Feb 2010 09:32:18 +0100
Message-ID: <be6731d603701c3c5befc79613fd451b.squirrel@webmail.eisendle.net>
References: <9da7f2802f639777acfeb38eb1e3db90.squirrel@webmail.eisendle.net>
    <32541b131002021153t53d19e32j56be356c219c5780@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 09:32:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ncaew-0006Bb-St
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 09:32:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753613Ab0BCIcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 03:32:21 -0500
Received: from vs.eisendle.net ([62.75.248.112]:51202 "EHLO eisendle.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752283Ab0BCIcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 03:32:20 -0500
Received: (qmail 18317 invoked from network); 3 Feb 2010 08:32:18 -0000
Received: from unknown (HELO webmail.eisendle.net) ([127.0.0.1])
          (envelope-sender <git@eisendle.net>)
          by localhost (qmail-ldap-1.03) with SMTP
          for <apenwarr@gmail.com>; 3 Feb 2010 08:32:18 -0000
Received: from 212.166.112.250 (proxying for unknown)
        (SquirrelMail authenticated user git@eisendle.net)
        by webmail.eisendle.net with HTTP;
        Wed, 3 Feb 2010 09:32:18 +0100
In-Reply-To: <32541b131002021153t53d19e32j56be356c219c5780@mail.gmail.com>
User-Agent: SquirrelMail/1.4.19
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138814>


>> For release we always generate 3 patches:
>> - BSP patch
>> - USB patch (since USB part is an external patch comming from a 3rd
>> party)
>> - WiFi patch (same as for USB)
>>
>> So my question is:
>> What's the best way for handling this inside the git repository?
>>
>> IMHO it would make sense to have 3 branches (BSP, USB, WiFi) each based
>> on
>> unmodified 2.6.22 Kernel. USB and WiFi branch is used for generating the
>> patch and for applying possible fixes. BSP branch for actual BSP related
>> feature development and fixes.
>> The changes in these branches are merged into the master branch which is
>> used for compiling/testing the whole BSP.
>
> Are you planning to submit these patches upstream at any point?  If
> not, it might be easiest to just jam them all together in one branch
> and not look back.  Since it seems like they probably affect quite
> different parts of the code, you could always extract a clean set of
> patches *later* and submit those patches upstream.

For BSP I plan to upstream eventually.

The basic idea was to divide the project in three different patches since
USB and WiFi comes from a third party and is not released under GPL (well,
different story...)
Keeping them in three different branches would make patch creation easier
especially if fixes are checked in into the USB/WiFi branch.

>
> But that's just my lazy advice :)  The disadvantage to maintaining
> them in separate branches is that probably none of the three branches
> will work on its own anyway, since you don't have a physical device
> that only has the new USB device, or only the new WiFi device, or only
> needs the BSP but doesn't have updated USB or WiFi.  Putting them in
> separate branches is therefore a bit artificial and won't buy you
> much.

At least the BSP could work on its own but for WiFi and USB you are right -
it's hard to test them seperately.
I just thought that there is a convenient way for handling such kind of
project.

Thanks,
Christian.
