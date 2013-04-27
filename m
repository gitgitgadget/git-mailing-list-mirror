From: Patrik Gornicz <patrik-git@mail.pgornicz.com>
Subject: Re: Making a (quick) commit to another branch
Date: Sat, 27 Apr 2013 10:56:39 -0400
Message-ID: <517BE727.1050000@mail.pgornicz.com>
References: <517BDB6D.8040809@cedarsoft.com> <CALZVap=9Z=0DPM1fNwotn3sN-W7mXMPRSJ2aY5jzkQTBD6v=Kw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schneider <mailings@cedarsoft.com>
To: Javier Domingo <javierdo1@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 27 17:05:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW6h3-0001E3-0I
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 17:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753859Ab3D0PFg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 11:05:36 -0400
Received: from li287-246.members.linode.com ([66.228.37.246]:54629 "EHLO
	mail.pgornicz.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753549Ab3D0PFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 11:05:35 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Apr 2013 11:05:35 EDT
Received: from [192.168.1.110] (CPEc0c1c09f18e2-CM0026f321196d.cpe.net.cable.rogers.com [99.236.108.68])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.pgornicz.com (Postfix) with ESMTPSA id 845D249C18;
	Sat, 27 Apr 2013 10:56:51 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130406 Thunderbird/17.0.5
In-Reply-To: <CALZVap=9Z=0DPM1fNwotn3sN-W7mXMPRSJ2aY5jzkQTBD6v=Kw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222655>

I've also encountered this desire to quickly fix something in another 
branch.

My need is more driven by the fact that it's a large project and 
stashing changes / switching branches frequently results in 2-6 minute 
build times afterward. Thus the commit to another branch suggestion 
would be quite neat as I wouldn't have to stash/switch.

Another possible approach would be to allow cherry-picking a change 
into another branch (without the stash/switch need).

Either way though, things might be a little weird if there's a 
conflict. Most of the time with the types of changes I'd like to do 
this simply won't be the case so perhaps just failing and requiring the 
user to work around it with either of the suggested work arounds would 
be effective enough . . .

Patrik

On Sat Apr 27 10:21:31 2013, Javier Domingo wrote:
> 2013/4/27 Johannes Schneider <mailings@cedarsoft.com>:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> Hi guys,
>>
>> I love git. And I use it every day. But there is one minor thing, that
>> bugs me a little bit:
>> I am implementing something on a feature branch. Now I detect a minor
>> typo/bug/whatever that just needs a one line commit.
>>
>> But of course I don't want to add that commit to my feature branch.
>> Instead I'd like to commit that fix directly to another branch (e.g.
>> master).
>>
>> Unfortunately that take a lot of steps to make this happen:
>> - - comitting
>> - - stashing other changes
>> - - changing branch
>> - - cherry-picking commit
>> - - switching branches back
>> - - reverting latest commit
>> - - unstashing changes
>>
>> I'd love to solve this by having an option for git commit that gives
>> me the possibility to commit to another branch:
>>
>>
>> git commit thefixedfile.txt -m "fixed a typo" -b master
>>
>>
>>
>> Any ideas/hints?
>>
>
> I would first recommend you, instead of cherry-picking the commit, you did this:
> -- stash
> -- go to the master branch
> -- fix the line
> -- commit the fix
> -- got to the feature branch
> -- unstash
>
> As when you merge with master, git will carry on with the changes. I
> don't see the need to cherry pick that commit.
>
> Javier Domingo
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
