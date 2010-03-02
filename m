From: Jez Caudle <jezcaudle@me.com>
Subject: Re: Only the config file changes ...
Date: Tue, 02 Mar 2010 13:26:15 +0000
Message-ID: <1463530E-F729-46CA-881D-A89E6CF89241@me.com>
References: <70786312428882320720829319256948501508-Webmail@me.com>
 <4B8D0FA7.8070206@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Jez Caudle <gitmailinglist@me.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Mar 02 15:26:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmT3j-0000GK-EZ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 15:26:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753337Ab0CBO0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 09:26:46 -0500
Received: from asmtpout028.mac.com ([17.148.16.103]:51330 "EHLO
	asmtpout028.mac.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752362Ab0CBO0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 09:26:45 -0500
X-Greylist: delayed 3613 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Mar 2010 09:26:45 EST
Received: from [192.168.1.3] ([89.241.40.67])
 by asmtp028.mac.com (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec
 16 2008; 32bit)) with ESMTPSA id <0KYN002NDPBRYK80@asmtp028.mac.com> for
 git@vger.kernel.org; Tue, 02 Mar 2010 05:26:21 -0800 (PST)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx engine=5.0.0-0908210000 definitions=main-1003020078
In-reply-to: <4B8D0FA7.8070206@drmicha.warpmail.net>
X-Mailer: Apple Mail (2.1077)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141396>

Sounds good.

The only problem being I find a bug in version C. I fix it in version C, now I want to merge that change back to the master and then out to A,B and then D.


I'm still reading my Git book but I'm thinking of doing it this way:

Master has it's own repository.
Each version has it's own repository that is created by cloning the Master and then removing all the files that are not specific removed from the repository.
When changes are made to the master then simply copy all the non-specific files to each of the versions.

Then I can run my unit/functional tests agains each version and if they all pass - deploy.

Jez.

On 2 Mar 2010, at 13:16, Michael J Gruber wrote:

> Jez Caudle venit, vidit, dixit 02.03.2010 13:06:
>> Hi I'm new to Git and I've read the manual and tried my best to
>> understand it.
>> 
>> I have a project that is going to have many versions, all the same
>> except for the config file, the unit/functional tests and some
>> display information.
>> 
>> I have seen that I can create branches and then merge them. I
>> wondered if I could create a branch, change the config file
>> information and then decree that the config file in the new branch is
>> not merged.
>> 
>> I read about sub modules but they didn't seam relevant.
>> 
>> Am I barking up the wrong tree here?
> 
> You're fellow dogs may need more details in order to decide that ;)
> 
> In general, I would recommend one branch (be it master) for changes
> which apply to all clients (I guess that's what you mean by "versions,
> all the same except..."), and one branch each for specific changes (to
> config etc.).
> 
> Then just make sure to merge in the right direction, i.e. merge the
> general, common branch into the specific ones.
> 
> Cheers,
> Michael
