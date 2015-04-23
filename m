From: FusionX86 <fusionx86@gmail.com>
Subject: Re: git-p4 Question
Date: Thu, 23 Apr 2015 07:42:14 -0600
Message-ID: <CAFcBi88ZohscEZXVXbaf+6=ZKJAy9LRfn2-4WT0JV+1RodBTJg@mail.gmail.com>
References: <CAFcBi89YqRGqigR1VCJJQtu1D206rP2T8Y-10KvFnvDjXYaN_g@mail.gmail.com>
	<553552FD.80703@diamand.org>
	<CAFcBi89pXTKzeVkB5EN3ZYkLwa1oPfDOqdHHhHeVogswhnpOAg@mail.gmail.com>
	<CAE5ih79L+RU934OYsBrXjP7PAoDYbeBS01hCgsOm+pnFD+dWwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Thu Apr 23 15:42:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlHOW-0004FM-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 15:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934143AbbDWNmQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 09:42:16 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:32791 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933917AbbDWNmO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 09:42:14 -0400
Received: by igbpi8 with SMTP id pi8so10366438igb.0
        for <git@vger.kernel.org>; Thu, 23 Apr 2015 06:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qzRK3eL9mosss5+13lgqeD+1+Max5NU5ajLhbx2y3is=;
        b=DXnTA/Z3Z1gt7mpIS+B0k0cv6MJCRdpyMy+86cjZQHAMUtIv+WprZB8bDJ+YJgtlM1
         EemtS8tmen4o4aiHox80x3UgQYTYzaYZ7tGlg15ZmjDZ6CsGRKbKm6x7lqx2WZ7+tXQ+
         N5VWmVvfMlu2dV7rX3ena2QP8Jf+/Vd6RBtrTaJ/+H9+Acaj6P7DsPJ1Qb3UsxYrD3fF
         dWsYqIfVkZVhi6xwxt0TRNXIPiYlFEMMBUGuctpCcVCGNYQTkJN2S3B/fgg8P3M+BUKj
         DEWSSsZZraNYTgXZuokW+qGRRRHCUQSJ4pDMlUlelipdM6q3x802YSxTJRLrzD4GSmXC
         jueA==
X-Received: by 10.50.143.106 with SMTP id sd10mr4360204igb.17.1429796534198;
 Thu, 23 Apr 2015 06:42:14 -0700 (PDT)
Received: by 10.79.93.199 with HTTP; Thu, 23 Apr 2015 06:42:14 -0700 (PDT)
In-Reply-To: <CAE5ih79L+RU934OYsBrXjP7PAoDYbeBS01hCgsOm+pnFD+dWwQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267691>

Hi Luke,

I found a silly mistake I was making in the command I've been using.
The folder under the depot should have been capitalized, but it
wasn't. Also, I expected that if there was a problem with the command,
it would fail with some message instead of creating an empty local git
repo.

Now I'll move forward with setting up an automated and periodic sync
of P4 to Git in preparation for the migration. Thanks Luke, your
suggestions prompted me to look in the right location for the problem.


On Tue, Apr 21, 2015 at 10:53 AM, Luke Diamand <luke@diamand.org> wrote:
> Can you post up the output from 'git p4 clone', and also see what the
> output from doing this is:
>
> $ p4 print //depot/some/branch/missingfile.c
>
>
>
> On 21 April 2015 at 14:33, FusionX86 <fusionx86@gmail.com> wrote:
>> Hi Luke,
>>
>> Using -v was a good suggestion. Unfortunately I still don't see what
>> the problem is. I'm starting to think that maybe I should just create
>> the client views I need and setup a cron job that p4 syncs and then
>> git commits/pushes.
>>
>> The --preserve-user option is for submitting back to Perforce correct?
>> I'm hoping to get away with a one-way sync from Perforce to Git...and
>> then eventually just cut over to Git.
>>
>> I also looked at git fusion, but unfortunately the version of Perforce
>> we're running (2012.1) doesn't meet the requirements for fusion. I
>> wish it did.
>>
>> Good point on developer mindset. I think we definitely have some
>> training and habit changing in the future.
>>
>> Thanks for the suggestions and pointers, it's much appreciated.
>>
>> On Mon, Apr 20, 2015 at 1:26 PM, Luke Diamand <luke@diamand.org> wrote:
>>> On 20/04/15 17:41, FusionX86 wrote:
>>>>
>>>> Hello,
>>>>
>>>> Hopefully this is an appropriate place to ask questions about git-p4.
>>>>
>>>> I started at a company that wants to migrate from Perforce to Git. I'm
>>>> new to Perforce and have been trying to learn just enough about it to
>>>> get through this migration. Anyway, I've been playing with git-p4 and
>>>> have one question/problem to discuss.
>>>>
>>>> After setting up the p4 cli client I can 'p4 sync' some
>>>> //depot/main/app1 which pulls down the files I would expect from the
>>>> Perforce server. If I use 'git p4 clone //depot/main/app1', I get:
>>>>
>>>> "Doing initial import of //depot/main/app1/ from revision #head into
>>>> refs/remotes/p4/master"
>>>>
>>>> But I don't get any files from that depot/folder pulled down. I can
>>>> git p4 clone other depot/folders though and get some files. I suspect
>>>> that I'm just not understanding how the git-p4 module works.
>>>
>>>
>>> You could try doing the clone with '-v' to get a bit more information.
>>>
>>>>
>>>> Basically, I'm hoping to setup a live sync of Perforce to Git of
>>>> certain depots in preparation for the migration. Also, if anyone has
>>>> pointers or guides for this type of migration, any help is
>>>> appreciated.
>>>
>>>
>>> I've done something similar in the past. You'll want to enable the
>>> --preserve-user option, for which you will need admin rights.
>>>
>>> If it's a one-way mirror (p4-to-git) then just run git-p4 periodically (if
>>> you use cron, then try to avoid having two or more instances running at the
>>> same time).
>>>
>>> If you want it to be two-way then it gets a bit more complicated.
>>>
>>> You might also want to consider using git fusion, which is Perforce's take
>>> on this problem. I've not used it myself.
>>>
>>> From past experience though I would say the biggest problem is getting
>>> developers to switch from the P4 mindset (centralized; code review hard to
>>> do or ignored) to the git mindset (decentralized; code review actively
>>> supported by the version control system).
>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe git" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
