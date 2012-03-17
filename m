From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: rebase problem
Date: Sat, 17 Mar 2012 15:31:44 +0100
Message-ID: <OF03E8C640.7C5AF318-ONC12579C4.004F7449-C12579C4.004FCF5C@transmode.se>
References: <OF506B5658.3E449452-ONC12579C4.00460A6E-C12579C4.0047355D@transmode.se> <4F649202.4080102@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Mar 17 15:31:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ufg-0000kI-J2
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 15:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208Ab2CQObs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 10:31:48 -0400
Received: from gw1.transmode.se ([195.58.98.146]:49439 "EHLO gw1.transmode.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811Ab2CQObr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 10:31:47 -0400
Received: from mail1.transmode.se (mail1.transmode.se [192.168.201.18])
	by gw1.transmode.se (Postfix) with ESMTP id 2903F25813A;
	Sat, 17 Mar 2012 15:31:45 +0100 (CET)
In-Reply-To: <4F649202.4080102@lyx.org>
X-KeepSent: 03E8C640:7C5AF318-C12579C4:004F7449;
 type=4; name=$KeepSent
X-Mailer: Lotus Notes Release 8.5.2FP3 Aug 10, 2010
X-MIMETrack: Serialize by Router on mail1/Transmode(Release 8.5.3|September 15, 2011) at
 17/03/2012 15:31:44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193329>

Vincent van Ravesteijn <vfr@lyx.org> wrote on 2012/03/17 14:30:42:
>
> Op 17-3-2012 13:57, Joakim Tjernlund schreef:
> > A co-worker this on our local u-boot repo:
> >    git checkout master
> >    git fetch denx/master
> >    git merge denx/master
> > <resolve conflicts>
> >    git commit
> >    ...
> >    git commit
> > Now u-boot is working again
> > then update to latest u-boot so:
> >    git fetch denx/master
> >    git rebase denx/master
> > Now it is a mess, that rebase seems to start from way back as a
> > staring reference, not from the last merge shown above.
> > I guess I forgotten how git works, what did go wrong?
> >
> >    Jocke
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> The situation is like this:
>
>   master - C - o - o - D - o - o - o - A
>                       /
>   denx/master- - - - o - o - o - o - B
>
> Now, you ask to rebase master (A) onto denx/master (B). If master would
> have started from D, it would indeed apply the commits D -- A on top of
> B. In your case, however, master already had a lot of commits that were
> not in denx/master: C -- D  (including the merge resolution). So it will
> also apply C -- D on top of  B.

Thanks, this makes sense. How do I get from above to

   master - C - o - o - D - o - o - o - A
                       /
   denx/master- - o - B


Jocke
