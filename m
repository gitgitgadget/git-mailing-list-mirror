From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 06 May 2009 19:22:08 -0500
Message-ID: <vmGwFm-7sqyeL1D7WrJ-qBXW02LwMMHQ7rLy7XbfdUutAtORXrswbw@cipher.nrlssc.navy.mil>
References: <20090506055913.GA9701@dektop> <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> <fcaeb9bf0905061615v2c1b1b4fmc6ade674aabf9586@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 07 02:22:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1rNj-0003Dn-7n
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 02:22:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbZEGAWM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 20:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752248AbZEGAWL
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 20:22:11 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:40159 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbZEGAWK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 20:22:10 -0400
Received: by mail.nrlssc.navy.mil id n470M9AS003017; Wed, 6 May 2009 19:22:09 -0500
In-Reply-To: <fcaeb9bf0905061615v2c1b1b4fmc6ade674aabf9586@mail.gmail.com>
X-OriginalArrivalTime: 07 May 2009 00:22:09.0298 (UTC) FILETIME=[DC068720:01C9CEA9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118415>

Nguyen Thai Ngoc Duy wrote:
> On Thu, May 7, 2009 at 4:14 AM, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>> Nguyen Thai Ngoc Duy wrote:
>>> Hi,
>>>
>>> I did "make test" on a SunOS 5.10 and it failed.
>>> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
>>> index b68ab11..61ccdee 100755
>>> --- a/t/t4200-rerere.sh
>>> +++ b/t/t4200-rerere.sh
>>> @@ -57,7 +57,7 @@ test_expect_success 'conflicting merge' '
>>>       test_must_fail git merge first
>>>  '
>>>
>>> -sha1=$(sed -e 's/    .*//' .git/MERGE_RR)
>>> +sha1=$(cut -f 1 .git/MERGE_RR)
>> Are you using /bin/sed?  I think it has a problem with tabs.
> 
> Yes I use /bin/sed. if /usr/xpg4/bin/sed is recommended, test-lib.sh
> should set up PATH automatically, I think.

/usr/xpg*/bin is where Sun puts the POSIX compliant versions of standard
system utilities.

The binaries in /bin/ retain their historical Solaris behavior.

Check out the XPG4 man page on a sun.

Not sure about the best route to take here.  /usr/xpg4/bin should probably
be in the user's PATH when git is executed too.

-brandon
