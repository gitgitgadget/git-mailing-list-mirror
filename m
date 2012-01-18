From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: found some code...
Date: Wed, 18 Jan 2012 23:45:52 +0100
Message-ID: <4F174BA0.2040109@ira.uka.de>
References: <loom.20120118T015734-175@post.gmane.org>	<CAH5451k4bMJtMLsaFi6g_uRGTL0OdQ5Z1Pss3xuMdWYs+6VcLQ@mail.gmail.com>	<2918969.0SyTOLELv0@reg-desktop>	<4F16973E.8040302@ira.uka.de> <CAHxBh_QiZzJP2jS6rMpC1c=P8uXSbFWumbcnHj3ArkQB4sXyPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Andrew Ardill <andrew.ardill@gmail.com>, git@vger.kernel.org
To: Ron Eggler <ron.eggler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 18 23:46:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RneGf-0003eE-HS
	for gcvg-git-2@lo.gmane.org; Wed, 18 Jan 2012 23:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755180Ab2ARWqE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jan 2012 17:46:04 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:43903 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752281Ab2ARWqD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 17:46:03 -0500
Received: from dslb-088-066-057-200.pools.arcor-ip.net ([88.66.57.200] helo=[192.168.2.231])
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 465 
	id 1RneGS-00071q-B3; Wed, 18 Jan 2012 23:46:02 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <CAHxBh_QiZzJP2jS6rMpC1c=P8uXSbFWumbcnHj3ArkQB4sXyPQ@mail.gmail.com>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1326926762.616720000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188773>

Mmh, your reply here didn't make it to the mailing list, maybe because 
it was multipart with html(??) or it just got lost.

Am 18.01.2012 18:57, schrieb Ron Eggler:
>     Try "git update-index --refresh", more info in this recent thread
>     "http://comments.gmane.org/__gmane.comp.version-control.__git/188291
>     <http://comments.gmane.org/gmane.comp.version-control.git/188291>"
>
>
> I got this outputand nothing really changed(generally using TortoiseGit
> on Windows but did this in the provided bash shell):
> $ git update-index --refresh
> MCU2.COF.txt: needs update
> MCU2.bak: needs update
> MCU2.c: needs update
> MCU2.esym: needs update
> MCU2.h: needs update
> MCU2.hex: needs update
> MCU2.lst: needs update
> MCU2.mcp: needs update
[...]

Ok, "needs update" seems to be the non-porcelain version of 'M' (why 'M' 
is more porcelain than "needs update" is a mystery to me ;-) respective 
"Changes not staged for commit" in git status.

Well, what does it say when you do "git diff MCU2.h" ? There are 2 
possibilities:

1) You see code differences. In that case you should be able to 
recognize where and when these changes were comitted or not.

2) You see no difference or every line is listed as different even 
though they seem to be equal. Possible reason is a mixup of line endings 
as git on windows has to convert \r\n line endings to \n line endings 
when it checks data in. This is controlled by config variables, and 
maybe your config is slightly wrong.

In that case I would create a new repo with git init in bash (not 
tortoise git!), and look at .git/config. Compare that with .git/config 
of your mixed up repo. Also compare with .git/config of the repo on your 
usb stick. As far as I know you should have core.autocrlf set to true on 
Windows.
Alternatively or for a complete picture you could do "git config -l" 
which gives you also global and system configuration variables if they 
exist.

Another possible reason would be file names with same name but different 
case. I mention this because there is a parallel thread on this mailing 
list with a problem with tortoise git and windows. See 
http://git.661346.n2.nabble.com/Bug-Git-checkout-fails-with-a-wrong-error-message-td7181244.html. 
As suggested in that thread you should have the option core.ignorecase set.


> Ok ,let's see:
> I "found" the piece of code on my thumbdrive and it ultimately is copied
> from my "old" working directory from the computer i don't have
> anymore... "get create new local folders" means that I actually created
> a new folder on my new machine and  cloned the repo from git into it so
> this would be my new working directory... now i have the code that
> should be in there seperatetely in the directory from the thumb drive....
> Does that make any more ssense?
>
