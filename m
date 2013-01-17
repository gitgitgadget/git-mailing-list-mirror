From: David Lang <david@lang.hm>
Subject: RE: Question re. git remote repository
Date: Thu, 17 Jan 2013 15:19:26 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1301171514530.21503@nftneq.ynat.uz>
References: <201301161749.r0GHnGV6007806@smtpb02.one-mail.on.ca> <20130116220615.48c159546bccfa5b9cd9028e@domain007.com> <20130116182156.GB4426@sigill.intra.peff.net> <20130116233744.7d0775eaec98ce154a9de180@domain007.com> <0630A778-9AC8-4023-889C-4FC58ABAB683@gmail.com>
 <alpine.DEB.2.02.1301161459060.21503@nftneq.ynat.uz> <201301172153.r0HLrUIr001039@smtpb01.one-mail.on.ca>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Konstantin Khomoutov <kostix+git@007spb.ru>,
	Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Stephen Smith <ishchis2@gmail.com>
To: "Lang, David" <David.Lang@uhn.ca>
X-From: git-owner@vger.kernel.org Fri Jan 18 00:21:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvymJ-0005Iz-Ne
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 00:21:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754950Ab3AQXV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jan 2013 18:21:27 -0500
Received: from mail.lang.hm ([64.81.33.126]:47372 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754150Ab3AQXVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jan 2013 18:21:25 -0500
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id r0HNKplF005423;
	Thu, 17 Jan 2013 15:20:55 -0800
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201301172153.r0HLrUIr001039@smtpb01.one-mail.on.ca>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213890>

distributed version control systems let each developer have a full repository 
locally on their machine, they then can send updates to other people who have a 
repository (or a pull request which asks the other person to pull from the 
developers repository to the other persons repository)

Most projects have one repository that they designate as being the 'main' 
repository for the project, and developers push updates to it (or send pull 
requests to the people who own that repository)

The communication between developers is typically via e-mail and the repository 
updates are sent via the git-daemon and the git network protocol.



This sort of thing is very different from the model where there is one 
repository on a shared disk somewhere and everyone accesses that shared disk to 
do their work or apply updates via NFS/CIFS protocols.

Does this clarify the difference?

David Lang

On Thu, 17 Jan 2013, Lang, David wrote:

> Hi David,
>
> Ok, now I'm really lost! This is definitely due to my newbie git status but 
> I'll ask anyway. I'm confused by your statement "... if you try to have one 
> filesystem, with multiple people running git on their machines against that 
> shared filesystem, I would expect you to have all sorts of problems."
>
> Isn't that the whole point of git, or any versioning system? I thought the 
> idea was that each developer installed git locally on their machines and (as 
> needed) committed their changes to the master repository which resides 
> externally to any of the local machines, such as on a network server (and 
> which I'm assuming has git installed locally as well).
>
> What am I missing?
>
> The 'other' David Lang   ;-)
>
> -----Original Message-----
> From: David Lang [mailto:david@lang.hm]
> Sent: Wednesday, January 16, 2013 6:01 PM
> To: Stephen Smith
> Cc: Konstantin Khomoutov; Jeff King; git@vger.kernel.org; Lang, David
> Subject: Re: Question re. git remote repository
>
> On Wed, 16 Jan 2013, Stephen Smith wrote:
>
>>>>>> Ideally we'd prefer to simply create our remote repository on a
>>>>>> drive of one of our local network servers. Is this possible?
>>>>>
>>>>> Yes, this is possible, but it's not advised to keep such a
>>>>> "reference" repository on an exported networked drive for a number
>>>>> of reasons (both performance and bug-free operation).
>>>>
>>>> I agree that performance is not ideal (although if you are on a fast
>>>> LAN, it probably would not matter much), but I do not recall any
>>>> specific bugs in that area. Can you elaborate?
>>>
>>> This one [1] for instance.  I also recall seing people having other
>>> "mystical" problems with setups like this so I somehow developed an
>>> idea than having a repository on a networked drive is asking for troubles.
>>> Of course, if there are happy users of such setups, I would be glad
>>> to hear as my precautions might well be unfounded for the recent
>>> versions of Git.
>>>
>>> 1. http://code.google.com/p/msysgit/issues/detail?id=130
>>
>> A group I was with used a master repository on a windows share for quite some time without a database corruption being seen.   --
>
> I think the risk is that if you have multiple people doing actions on the shared filesystem you can run into trouble.
>
> As long as only one copy of git is ever running against the repository, I don't see any reason for there to be a problem.
>
> But if you try to have one filesystem, with multiple people running git on their machines against that shared filesystem, I would expect you to have all sorts of problems.
>
> David Lang
>
> This e-mail may contain confidential and/or privileged information for the sole use of the intended recipient.
> Any review or distribution by anyone other than the person for whom it was originally intended is strictly prohibited.
> If you have received this e-mail in error, please contact the sender and delete all copies.
> Opinions, conclusions or other information contained in this e-mail may not be that of the organization.
>
>
