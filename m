From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 23:53:25 -0500
Message-ID: <9e4733910702112053q2c196ddcr970a062281d332b7@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
	 <9e4733910702111525x176053d3y9fd6d809ac447c0a@mail.gmail.com>
	 <Pine.LNX.4.64.0702112022430.1757@xanadu.home>
	 <7vd54gau3r.fsf@assigned-by-dhcp.cox.net>
	 <9e4733910702112029k6ef3fb7bl3bdb134a787512e8@mail.gmail.com>
	 <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 05:53:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGTBz-0005cd-Tk
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 05:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932969AbXBLEx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 23:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932970AbXBLEx2
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 23:53:28 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:6314 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932969AbXBLEx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 23:53:27 -0500
Received: by ug-out-1314.google.com with SMTP id 22so498291uga
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 20:53:26 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ENXJ9mtXPO2+C21yZI1+Y/a00qfsVwlfWbJ2+pcwXhPb0Ieg0XF64CVA316GmOJ9gszs/z4utO5MBER6dSPUhXYi2RAGGbOk80jybPeTVYe7Hsl9uIUzK6pRuIHOJ6+4FH9OQLnkHH9NFxkk4xMUVHhYxNQIXfjj4N0OuvHR+NY=
Received: by 10.114.198.1 with SMTP id v1mr5549029waf.1171256005364;
        Sun, 11 Feb 2007 20:53:25 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 20:53:25 -0800 (PST)
In-Reply-To: <7v4ppsatbr.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39363>

On 2/11/07, Junio C Hamano <junkio@cox.net> wrote:
> "Jon Smirl" <jonsmirl@gmail.com> writes:
>
> > All wireless-dev are all dead.
> > I can still get to Linus' tree without problem. wireless-2.6 tree is ok too.
> >
> > jonsmirl@jonsmirl:/extra$ git clone
> > git://git.kernel.org/pub/scm/linux/kernel/gt/linville/wireless-dev.git
> > Initialized empty Git repository in /extra/wireless-dev/.git/
> > fatal: The remote end hung up unexpectedly
>
> Are you sure the above is ".../linux/kernel/gt/linville/..."?

You're right it should be git instead of gt, somewhere in my copying
strings around I lost the 'i' and wasn't paying attention.  That's not
a very good error message: "fatal: The remote end hung up
unexpectedly" for a missing repository.

Here's a git clone with the right string. It works:

jonsmirl@jonsmirl:/extra$ git clone
git://git2.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
Initialized empty Git repository in /extra/wireless-dev/.git/
remote: Generating pack...
remote: Done counting 411874 objects.
remote: Deltifying 411874 objects.
remote:  100% (411874/411874) done
Indexing 411874 objects.
remote: Total 411874, written 411874 (delta 327049), reused 374287
(delta 289485)
 100% (411874/411874) done
Resolving 327049 deltas.
 100% (327049/327049) done
Checking files out...
 100% (21429/21429) done
jonsmirl@jonsmirl:/extra$

Same thing with cg clone, it's what is broken.
cg update is broken in the same way.
I'm using the current git version of cogitio.
I'll switch to the git commands, git clone is about 10x faster for the
clone anyway.

jonsmirl@jonsmirl:/extra$ cg clone
git://git2.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
Initialized empty Git repository in .git/
Fetching pack (head and objects)...
remote: Generating pack...
remote: Done counting 404120 objects.
remote: Deltifying 404120 objects.
remote:  100% (404120/404120) done
Indexing 404120 objects.
remote: Total 404120, written 404120 (delta 320324), reused 365290
(delta 282572)
 100% (404120/404120) done
Resolving 320324 deltas.
 100% (320324/320324) done
fatal: pack: not a valid SHA1
Fetching tags... v2.6.12 v2.6.12-rc2 v2.6.12-rc3 v2.6.12-rc4
v2.6.12-rc5 v2.6.12-rc6 v2.6.13 v2.6.13-rc1 v2.6.13-rc2 v2.6.13-rc3
v2.6.13-rc4 v2.6.13-rc5 v2.6.13-rc6 v2.6.13-rc7 v2.6.14 v2.6.14-rc1
v2.6.14-rc2 v2.6.14-rc3 v2.6.14-rc4 v2.6.14-rc5 v2.6.15 v2.6.15-rc1
v2.6.15-rc2 v2.6.15-rc3 v2.6.15-rc4 v2.6.15-rc5 v2.6.15-rc6
v2.6.15-rc7 v2.6.16 v2.6.16-rc1 v2.6.16-rc2 v2.6.16-rc3 v2.6.16-rc4
v2.6.16-rc5 v2.6.16-rc6 v2.6.17 v2.6.17-rc1 v2.6.17-rc2 v2.6.17-rc3
v2.6.17-rc4 v2.6.17-rc5 v2.6.17-rc6 v2.6.18 v2.6.18-rc1 v2.6.18-rc2
v2.6.18-rc3 v2.6.18-rc4 v2.6.18-rc5 v2.6.18-rc6 v2.6.18-rc7 v2.6.19
v2.6.19-rc1 v2.6.19-rc2 v2.6.19-rc3 v2.6.19-rc4 v2.6.19-rc5
v2.6.19-rc6 v2.6.20-rc1 v2.6.20-rc2 v2.6.20-rc3 v2.6.20-rc4
v2.6.20-rc5 v2.6.20-rc6
remote: Generating pack...
remote: Done counting 63 objects.
remote: Deltifying 63 objects.
remote:  100% (63/63) done
Indexing 63 objects.
remote: Total 63, written 63 (delta 0), reused 63 (delta 0)
 100% (63/63) done
fatal: pack: not a valid SHA1
New branch: 0953670fbcb75e26fb93340bddae934e85618f2e
Cloned to wireless-dev/ (origin
git://git2.kernel.org/pub/scm/linux/kernel/git/linville/wireless-dev.git
available as branch "origin")
jonsmirl@jonsmirl:/extra$


-- 
Jon Smirl
jonsmirl@gmail.com
