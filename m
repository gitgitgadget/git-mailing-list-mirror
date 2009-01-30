From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Finding the name of the parent branch?
Date: Fri, 30 Jan 2009 14:57:05 +0100
Message-ID: <adf1fd3d0901300557t19ca4bccn7fe24013a05d2d57@mail.gmail.com>
References: <a2633edd0901300256k2ad7530elcaca5cdc30c17534@mail.gmail.com>
	 <adf1fd3d0901300318s5a0e4c94gab5f31342643ea52@mail.gmail.com>
	 <a2633edd0901300456y48e8d78fn199675f2ae105c8@mail.gmail.com>
	 <adf1fd3d0901300516y3d1bf58dmda9c5172586d828@mail.gmail.com>
	 <a2633edd0901300535mf2d9ceemd9e9009e0aa18b40@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Fri Jan 30 14:58:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSttM-0003GG-Bu
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 14:58:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753180AbZA3N5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 08:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753055AbZA3N5L
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 08:57:11 -0500
Received: from fk-out-0910.google.com ([209.85.128.186]:6173 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753083AbZA3N5J (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 08:57:09 -0500
Received: by fk-out-0910.google.com with SMTP id f33so471025fkf.5
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 05:57:06 -0800 (PST)
Received: by 10.103.239.10 with SMTP id q10mr588096mur.67.1233323825803; Fri, 
	30 Jan 2009 05:57:05 -0800 (PST)
In-Reply-To: <a2633edd0901300535mf2d9ceemd9e9009e0aa18b40@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107820>

2009/1/30 Pascal Obry <pascal@obry.net>:
> Santi,
>
>> Maybe if you explain why you want it (a use case) instead of just this
>> specific problem...
>
> To know the proper merge base to display all commits done on a specific
> topic branch.
>

gitk topicbranch ^trackingbranch

But I agree that a way to refer to the tracking branch would be great, as:

branch^{origin}

so you can say, for example:

gitk topicbranch ^topicbranch^{origin}

>>>> Just a counterexample, just rearranging you graph:
>>>>
>>>>                        o---B
>>>>                        /
>>>>                   o---2---o---o---o---C
>>>>                  /
>>>>          ---o---1---o---o---o---A
>>>>
>>>> From you description: For B I would get C and for C I would get A.
>>
>> Please, if you quote text do not edit it (the 1 and the 2 in this case).
>
> Well I've just added 1 and 2, nothing changed in the semantic!
>
>> Yes. Compare your sentence and mine:
>>
>> For B I want to get A and for C I want to get B.
>> For B I would get C and for C I would get A.
>>
>> So for B you get A while I get C, and the equivalent for C.
>
> Ok, that's expected since you have renamed B to C and C to B.

I did not rename B to C and C to B, I just draw them differently.

Let's put name to the commits:

Your tree:


                        i---j---k---C
                        /
                   f---g---h---B
                  /
          ---a---b---c---d---e---A

My tree:

                       h---B
                       /
                  f---g---i---j---k---C
                 /
         ---a---b---c---d---e---A

So the commits in all the branches are equal, the only change is that
I painted B above C.

> So when I said:
>
>    For B I want to get A and for C I want to get B.
>
> It is equivalent to your (just rename B and C).:
>
>   For B I would get C and for C I would get A.
>
> Frankly I do not see your point... That's maybe the cause of the
> problem I'm having....

At least part of. You have to understand the branch model:

git model:
  * a branch is just a pointer to a commit
  * you cannot say "this commit was done in that branch"
  * what you can say is "this commit is contained in that branch"

in contrast to other models:
  * where a commit really belongs to a branch (it is specified at
commit time somehow)
  * you can say "this commit was done in that branch"

HTH,
Santi
