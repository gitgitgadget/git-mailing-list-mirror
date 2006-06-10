From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 13:23:35 +1200
Message-ID: <46a038f90606091823u45dd3dffsc584c0d4e0128b4c@mail.gmail.com>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	 <46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	 <9e4733910606091113vdc6ab06l2d3582cb82b8fd09@mail.gmail.com>
	 <Pine.LNX.4.64.0606091158460.5498@g5.osdl.org>
	 <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@osdl.org>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 10 03:23:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FosCR-0006Q9-9Q
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 03:23:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030219AbWFJBXg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 21:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932616AbWFJBXg
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 21:23:36 -0400
Received: from wr-out-0506.google.com ([64.233.184.231]:12077 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932615AbWFJBXg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 21:23:36 -0400
Received: by wr-out-0506.google.com with SMTP id i22so764343wra
        for <git@vger.kernel.org>; Fri, 09 Jun 2006 18:23:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bA/aR/Upg0iKBX+eWnBqFYShEsuvcQHGbfIRiJY1/yGd72iRG5smXQmbvHcRlYLBX47ZXM26nvEA+BFlhrhq/K6Ofe75tf3HrQNjjiD+jFYsdoEWQ0B5WoVf461Q0jZnhS9fX4EuKqHSuXj853g+XC6M6Alyyy5U8J2Maq0JXGc=
Received: by 10.54.140.8 with SMTP id n8mr636926wrd;
        Fri, 09 Jun 2006 18:23:12 -0700 (PDT)
Received: by 10.54.71.4 with HTTP; Fri, 9 Jun 2006 18:23:35 -0700 (PDT)
To: "Jon Smirl" <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606091317p26d66579mdf93db293f93fb50@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21578>

On 6/10/06, Jon Smirl <jonsmirl@gmail.com> wrote:
> The git tree that Martin got from cvsps is much smaller that the git
> tree I got from going to svn then to git.  I don't why the trees are
> 700KB different, it may be different amounts of packing, or one of the
> conversion tools is losing something.

Don't read too much into that. Packing/repacking points make a _huge_
difference, and even if one of our trees is a bit corrupt, the
packsizes should be about the same.

(With the patches I sent you we _are_ choosing to ignore a few
branches that don't seem to make sense in cvsps output. These will
show up in the error output -- what I saw were very old, possibly
corrupt branches there, stuff I wouldn't shed a tear over, but it is
worth reviewing).

> I haven't come up with anything that is likely to result in Mozilla
> switching over to git. Right now it takes three days to convert the
> tree. The tree will have to be run in parallel for a while to convince
> everyone to switch. I don't have a solution to keeping it in sync in
> near real time (commits would still go to CVS). Most Mozilla
> developers are interested but the infrastructure needs some help.

Don't worry about the initial import time. Once you've done it, you
can run the incremental import (which will take a few minutes) even
hourly to keep 'in sync'.

> Martin has also brought up the problem with needing a partial clone so
> that everyone doesn't have to bring down the entire repository. A
> trunk checkout is 340MB and Martin's git tree is 2GB (mine 2.7GB).  A
> kernel tree is only 680M.

Now that I have managed to repack the repo, it is indeed back in the
600M range. Actually, I just re-repacked, it took under a minute, and
it shrank down to 607MB.

Yay.

I'm sure that if you git-repack -a -d on a machine with plenty of
memory once or twice, we'll have matching packs.

cheers,



martin
