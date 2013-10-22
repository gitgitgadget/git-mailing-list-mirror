From: Mandeep Sandhu <mandeepsandhu.chd@gmail.com>
Subject: Re: Moving commits from one branch to another (improving my git fu!)
Date: Tue, 22 Oct 2013 11:41:38 +0530
Message-ID: <CAC+QLdQADFPvuZ6VcDqSUYSd_sn54LK=YLqaW3U2DC1MbnsM+g@mail.gmail.com>
References: <CAC+QLdSjTjftgUBy-1cHbATZnX-UO3PavUaLwErhCaxBa-hPmQ@mail.gmail.com>
	<alpine.DEB.2.00.1310220647400.13299@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Oct 22 08:11:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYVBv-0008SB-Ny
	for gcvg-git-2@plane.gmane.org; Tue, 22 Oct 2013 08:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab3JVGLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Oct 2013 02:11:39 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:47978 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3JVGLj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Oct 2013 02:11:39 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so8152950pbb.27
        for <git@vger.kernel.org>; Mon, 21 Oct 2013 23:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=MtVNBiWsh401CnQ3j6xdAbjFwWQos99uO+xVL3Im5bY=;
        b=dAA+mlHEKyg4jB2xXFePzO8IZqNnTFMDsbWOux/J9fHZ1vh4s/tVbHaPvFXxRzUcYp
         DJmv8aNij8qzZ1gEezHqMv35ziJ1qjcwbIVikjqtkq4CgyWOrXED2gTXe8MJ3d4pxgel
         JsqV2313aPVyPLppdDyrRy3crrX2Qb8U8vzC5P+TBZQQKFMZ9rQj2yX7HGufXFXt7eGw
         3CZ5zgw0riKhRxT3vV1rDFxSoLoNQX4iw4dm/XqSAjtqovG5whZ9Qbgaq34eXgIC0sVO
         Ql4zCBoxQkQBYFHwtwKHt0LhPJL+OgW9tGmBOU7dLn1OnLKu+zKk09JiScFl9dp7pRLS
         Nyzw==
X-Received: by 10.68.240.33 with SMTP id vx1mr21425824pbc.12.1382422298668;
 Mon, 21 Oct 2013 23:11:38 -0700 (PDT)
Received: by 10.66.165.233 with HTTP; Mon, 21 Oct 2013 23:11:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1310220647400.13299@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236458>

>> $ git rebase dev stable topicA
>> (this was suggested in the manpage as well).
>
>
> I guess you also had an "--onto" in there, as the above would throw a syntax
> error. As long as the branches are in order, I cannot see how that wouldn't
> do what you wanted.

Yes, you're right. There was "--onto" there.

The only problem is that there were a LOT of conflicts when I ran this
cmd in places which have nothing to do with my commit. And as I said,
dev is vastly different from stable.

>
> However, the easiest way to do it would probably just to run:
>
>  git checkout topicA
>  git rebase dev
>
> As long as "dev" already contains all the commits in "stable", that should
> work fine. If not, then you would need something more complicated.

I don't think thats the case currently. People commit bug-fixes to
'stable' (from which a release will be made later) and all new and
experimental stuff is tried on 'dev'. So there's a lot in 'dev' that's
not there in 'stable'.

>
> Another way to do it would be to use cherry-pick on a new branch:
>
>  git checkout -b new_topicA dev
>  git cherry-pick stable..topicA

Hmmm...this looks safe to do. If I do "git log stable..topicA" it
should only show my commits made on top of stable, right? Or I can
even mention the commit SHA here?

Thanks,
-mandeep

>
> --
> \\// Peter - http://www.softwolves.pp.se/
