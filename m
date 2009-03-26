From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCH 2/2] Add feature release instructions to gitworkflows
 man page
Date: Thu, 26 Mar 2009 10:35:30 -0400
Message-ID: <49CB92B2.6070909@fastmail.fm>
References: <1238032575-10987-1-git-send-email-rocketraman@fastmail.fm> <1238032575-10987-2-git-send-email-rocketraman@fastmail.fm> <7veiwksrsr.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 15:44:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmqoK-0001PU-Mt
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 15:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758189AbZCZOmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 10:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757769AbZCZOmU
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 10:42:20 -0400
Received: from smtp107.rog.mail.re2.yahoo.com ([68.142.225.205]:34318 "HELO
	smtp107.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757151AbZCZOmT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 10:42:19 -0400
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2009 10:42:18 EDT
Received: (qmail 17391 invoked from network); 26 Mar 2009 14:35:37 -0000
Received: from unknown (HELO apollo.rocketraman.com) (rocketraman@99.224.155.40 with login)
  by smtp107.rog.mail.re2.yahoo.com with SMTP; 26 Mar 2009 14:35:37 -0000
X-YMail-OSG: 0TkRcYQVM1leVE6feixXjJfBMXPbGk98O6Jh_WRdsHnptEtE7jSzz6bzn_IHbPXTmw--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id 2851221C051B;
	Thu, 26 Mar 2009 10:35:37 -0400 (EDT)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e7D+xuucFENW; Thu, 26 Mar 2009 10:35:30 -0400 (EDT)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 5F52D21C051A;
	Thu, 26 Mar 2009 10:35:30 -0400 (EDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <7veiwksrsr.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114786>

Junio C Hamano wrote:
> rocketraman@fastmail.fm writes:
> 
>> +Release Tagging
>> +~~~~~~~~~~~~~~~
>> +
>> +The new feature release is tagged on 'master' with a tag matching
>> +vX.Y.Z, where X.Y.Z is the new feature release version.
>> +
>> +.Release tagging
>> +[caption="Recipe: "]
>> +==========================================
>> +`git tag -s -m GIT "vX.Y.Z" vX.Y.Z`
>> +==========================================
> 
> I actually always do:
> 
> 	git tag -s -m "GIT X.Y.Z" vX.Y.Z master
> 
> The argument to -m in your descriptoin is incorrectly quoted, and has an
> extra v.  I also spell out 'master' to avoid mistakes, and I would be
> happy to encourage others to follow it.

Fixed.

>> +Maintenance branch update
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +The current maintenance branch is optionally tracked with the older
>> +release version number to allow for further maintenance releases on
>> +the older codebase.
>> +
>> +.Track maint
>> +[caption="Recipe: "]
>> +=====================================
>> +`git branch maint-X.Y.(Z-1) maint`
>> +=====================================
> 
> This creates maint-X.Y.(Z-1) from maint, but calling this step "track
> maint" entirely misses the point.
> 
> When people use the word "track", the intention is that they intend to
> merge subsequent changes to the original branch (in this case, 'maint') to
> the new branch ('maint-X.Y.(Z-1)') from time to time.
> 
> That is exactly opposite to what I create maint-X.Y.(Z-1) branch for.
> This new "branch to maintain an older codebase" will *never* merge from
> 'maint' after it forks.

Yeah, I originally had written "Copy maint" but copy seemed to be more
subversion-speak rather than git-speak so I changed it. However it
does seem to accurately describe the operation. Would "Copy maint" be
acceptable terminology?

>> +Update next branch
>> +~~~~~~~~~~~~~~~~~~
>> +
>> +The 'next' branch may be rebuilt from the tip of 'master' using the
>> +surviving topics on 'next'.
>> +
>> +This step is optional. If it is done by the maintainer, then a public
>> +announcement will be made indicating that 'next' was rebased.
> 
> The wording I use is more like 'rewound and rebuilt'.

Fixed.

Cheers,
Raman
