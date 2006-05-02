From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Tue, 2 May 2006 19:08:49 +1200
Message-ID: <46a038f90605020008y7f4193d5vb35ec00e3aeb4b90@mail.gmail.com>
References: <20060429165151.2570.qmail@science.horizon.com>
	 <e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>
	 <e30k0n$ij5$1@sea.gmane.org> <e32kkf$amc$1@sea.gmane.org>
	 <7vfyjuwt0v.fsf@assigned-by-dhcp.cox.net>
	 <7v8xpmva9x.fsf@assigned-by-dhcp.cox.net>
	 <4455638A.3070802@vilain.net>
	 <7vlktms02x.fsf@assigned-by-dhcp.cox.net>
	 <4456A616.6070402@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 02 09:09:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fap0G-0004us-Hh
	for gcvg-git@gmane.org; Tue, 02 May 2006 09:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWEBHI5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 2 May 2006 03:08:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbWEBHI5
	(ORCPT <rfc822;git-outgoing>); Tue, 2 May 2006 03:08:57 -0400
Received: from wproxy.gmail.com ([64.233.184.230]:2193 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932411AbWEBHI5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 2 May 2006 03:08:57 -0400
Received: by wproxy.gmail.com with SMTP id i21so2229597wra
        for <git@vger.kernel.org>; Tue, 02 May 2006 00:08:56 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fcW4w/QjIkNw2GKMKjbyDYjI6SLa7d5kPMrXYcgel3yXzqY5xsIjEuzipsNWkNHE5JR86ua1FTztzm7LCpZ2i9seYZi029vrwG3XPhi14IGzfyLLqYAUji/1WK5BPHx8JUh72uiaxE7LE8xYIeMvXYsLFpvfonesZ86QfQa0dKQ=
Received: by 10.54.102.5 with SMTP id z5mr406786wrb;
        Tue, 02 May 2006 00:08:46 -0700 (PDT)
Received: by 10.54.127.4 with HTTP; Tue, 2 May 2006 00:08:49 -0700 (PDT)
To: "Sam Vilain" <sam@vilain.net>
In-Reply-To: <4456A616.6070402@vilain.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19401>

On 5/2/06, Sam Vilain <sam@vilain.net> wrote:
> Here I'm a little bit confused still. Surely criss-crossing branches
> already don't converge unless the commits are in the same order.

They do under GIT. No matter how much you criss-cross, every time you
identify a merge base for the next merge, you are identifying the last
commit in common on both branches.

While maybe you didn't have that commit being the tip of a head in
your repo, it _is_ the last common point. If your criss-crossing is
messy and a few commits are out of order or cherry picked, git-merge
has a good chance of spotting it. The whole mechanism tends pulls
quite consistently towards convergence.

If the notes in the commit msg aren't consistent and we lose the
natural tendency towards convergence that's a major drawback. On the
other hand, if two branches have exchanged patches "out of band",
git-merge still gets it right most of the time, so perhaps slightly
different headers in the commit messages are tolerable?

Junio had written:
> >On the other hand, a "note" field that records on which branch
> >of which repository each commit was made (you need to give each
> >repository-branch an UUID) when you do create a new commit would
> >be a sensible thing to have if somebody cares deeply enough.

I really don't like that -- goes against the grain of really simple,
portable repos. I cp -pr repo{,_tmp} all the time to do risky merges
or save a heavy download from a remote server. Let me run away from
this idea... quick before Linus kills us all ;-)

I did feel a couple of times the need of remembering where I had
checked this in -- but it went away quite quickly, must have been a
leftover of my Arch days ;-). And it actually got solved by agreeing
within my team to a commit message format pretty much like what's used
in the kernel. Because the truth is that most of my heads and branches
have very "local" names.

cheers,



martin
