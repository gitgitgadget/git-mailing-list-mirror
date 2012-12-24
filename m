From: Woody Wu <narkewoody@gmail.com>
Subject: Re: Find the starting point of a local branch
Date: Mon, 24 Dec 2012 15:31:04 +0800
Message-ID: <20121224073103.GA10793@zuhnb712>
References: <20121224035825.GA17203@zuhnb712>
 <201212240409.qBO49wkV020768@no.baka.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Seth Robertson <in-gitvger@baka.org>
X-From: git-owner@vger.kernel.org Mon Dec 24 08:41:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tn2fL-0007xH-9e
	for gcvg-git-2@plane.gmane.org; Mon, 24 Dec 2012 08:41:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752793Ab2LXHcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 02:32:36 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:39266 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076Ab2LXHce (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 02:32:34 -0500
Received: by mail-pa0-f43.google.com with SMTP id fb10so3960473pad.30
        for <git@vger.kernel.org>; Sun, 23 Dec 2012 23:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=VZX5nZLPxCvrTKE7s4sYc35O9PhASR/MuDpZKayMXA8=;
        b=NT+SYPmJHAaVGHmUiMep8AXwxf++iU091vcBAZtZYlN9sFi6Q3IFgAL9YdM1P9464n
         o8mCIHPnOSvae31BBM1Tfs3BN39IqZUG28jyujcOoXxU9cz2W1Y/cqfMccfvp/eWab0V
         St01KJoO7pbgI5NoY9ygL2q7KXJgeSgKN+85cbXjB/Nt+OtUgFhiMSAdaJAsxChmo+C0
         F/IbWv0FhW0ziiGph5S/nGK5v5KgGWPVL1N+6uKjLoJr7c4mm99s6NY1EG6VAsef5R65
         uSV6rpT5Pg6/RBQ+X5lwy8PWerr/VF6MohyP+EC7UFxTEThPGKWakcCGpI5GwGVRkA4U
         mQww==
X-Received: by 10.68.241.232 with SMTP id wl8mr64206255pbc.144.1356334353095;
        Sun, 23 Dec 2012 23:32:33 -0800 (PST)
Received: from localhost ([59.37.26.98])
        by mx.google.com with ESMTPS id jv1sm6570776pbc.36.2012.12.23.23.32.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 23 Dec 2012 23:32:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201212240409.qBO49wkV020768@no.baka.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212104>

On Sun, Dec 23, 2012 at 11:09:58PM -0500, Seth Robertson wrote:
> 
> In message <20121224035825.GA17203@zuhnb712>, Woody Wu writes:
> 
>     How can I find out what's the staring reference point (a commit number
>     or tag name) of a locally created branch? I can use gitk to find out it
>     but this method is slow, I think there might be a command line to do it
>     quickly.
> 
> The answer is more complex than you probably suspected.
> 
> Technically, `git log --oneline mybranch | tail -n 1` will tell you
> the starting point of any branch.  But...I'm sure that isn't what you
> want to know.
> 
> You want to know "what commit was I at when I typed `git branch
> mybranch`"?  

Yes, this is exactly I want to know.

>The problem is git doesn't record this information and
> doesn't have the slightest clue.
> 
> But, you say, I can use `gitk` and see it.  See?  Right there.  That
> isn't (necessarily) the "starting point" of the branch, it is the
> place where your branch diverged from some other branch.  Git is
> actually quite able to tell you when the last time your branch
> diverged from some other branch.  `git merge-base mybranch master`
> will tell you this, and is probably the answer you were looking for.

This is not working to me since I have more than one local branch that
diverged from the master, and in fact, the branch I have in question was
diverged from another local branch.  With the method of 'git
merge-base', I have to remember a branch tree in my brain.

But thanks anyway, I see you guys's discussions and it's a little hard
to understand to me at the moment. Currently, I still have to use gitk
with narrowed outputs.


> Note that this is the *last* divergence.  If your branch diverged and
> merged previously that will not be reported.  Even worse, if you did a
> fast-forward merge (I recommend against them in general) then it is
> impossible to discover about what the independent pre-merge history
> was really like.
> 
> 					-Seth Robertson

-- 
woody
I can't go back to yesterday - because I was a different person then.
