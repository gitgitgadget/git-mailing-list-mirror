From: "Guilhem Bonnefille" <guilhem.bonnefille@gmail.com>
Subject: Re: Howto use StGit and git-svn at same time
Date: Mon, 15 Jan 2007 14:26:36 +0100
Message-ID: <8b65902a0701150526j5a954529xf45b2d0348a77573@mail.gmail.com>
References: <8b65902a0701091335u160c6dfl81a523e4cd5adbee@mail.gmail.com>
	 <8b65902a0701091341v5983c113tc5cd32c6c4c57719@mail.gmail.com>
	 <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 20:07:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VVl-0000O6-07
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:20:45 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6VAA-0003eK-RB
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:58:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbXAON0i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 08:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbXAON0i
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 08:26:38 -0500
Received: from wx-out-0506.google.com ([66.249.82.226]:53250 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932323AbXAON0h (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 08:26:37 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1757547wxd
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 05:26:37 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ty29u/lrRmovBjxKXULR/DhCKw6MAxzni+R3pgDzMEhY2OMfA9lqhDLYMrg0+LM3SX2oxE6iodwCSLFn1g+2kdXC6ItmVfgayCjn3a4Fx7b3mXHIpibj99Nd8ELz3Kf3+SsXOKoF24PJBcTCecYpWuL87Mk3YVLO04qfvEvMZPw=
Received: by 10.90.86.10 with SMTP id j10mr2783389agb.1168867596495;
        Mon, 15 Jan 2007 05:26:36 -0800 (PST)
Received: by 10.90.51.4 with HTTP; Mon, 15 Jan 2007 05:26:36 -0800 (PST)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20070109224125.GF17093@nan92-1-81-57-214-146.fbx.proxad.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36861>

Ok, thanks for the reminder: I forgot "stg pop/push".

I redo whole job as this:
- git-svn -i trunk fetch
- stg pop -a
- git-rebase remotes/trunk # as recommended by git-svn manual
- stg push -a
- playing another merging game as my patches submissions were modified
since archived

Thanks.

On 1/9/07, Yann Dirson <ydirson@altern.org> wrote:
> On Tue, Jan 09, 2007 at 10:41:20PM +0100, Guilhem Bonnefille wrote:
> > Humh...
> > I finished the conflicts solving game. I think the way I choosed is
> > incorrect. Following gitk, it is now a big big bazaar in my commits
> > history.
>
> Right, you should not use git-rebase on a StGIT branch :)
>
> What you should have done is moving your stack base from your old
> origin branch to remotes/trunk - something that StGIT does not support
> yet from command-line, but I've done this manually in the past
> (migrating an StGIT stack after re-running a full git-cvsimport after
> the original cvs branch got corrupted).
>
> Something along the line of (untested, off the top of my head):
>
> $ stg pop -a
> $ echo <TARGET-SHA1>  >  .git/refs/heads/<BRANCH>
> $ echo <TARGET-SHA1>  >  .git/refs/bases/<BRANCH>
>
> And then use "stg push" and "stg resolved -i" to resolve the conflicts.
>
> But always be sure of backing up your .git before doing such by-hand
> experiments.
>
> Best regards,
> --
> Yann.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Guilhem BONNEFILLE
-=- #UIN: 15146515 JID: guyou@im.apinc.org MSN: guilhem_bonnefille@hotmail.com
-=- mailto:guilhem.bonnefille@gmail.com
-=- http://nathguil.free.fr/
