From: Kevin Menard <nirvdrum@gmail.com>
Subject: Re: git svn dcommit difficulties/feature request
Date: Fri, 20 Feb 2009 07:59:44 -0500
Message-ID: <7e3605160902200459x50e56c92x462d9a072eaa84d0@mail.gmail.com>
References: <200902191930.10139.kumbayo84@arcor.de>
	 <200902191947.22622.kumbayo84@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Oberndorfer <kumbayo84@arcor.de>
X-From: git-owner@vger.kernel.org Fri Feb 20 14:01:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LaV0O-00013z-11
	for gcvg-git-2@gmane.org; Fri, 20 Feb 2009 14:01:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755064AbZBTM7t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2009 07:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754736AbZBTM7s
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Feb 2009 07:59:48 -0500
Received: from mail-qy0-f11.google.com ([209.85.221.11]:45951 "EHLO
	mail-qy0-f11.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754353AbZBTM7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2009 07:59:46 -0500
Received: by qyk4 with SMTP id 4so1401819qyk.13
        for <git@vger.kernel.org>; Fri, 20 Feb 2009 04:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Swjnn7pqA0IMlJTEDoq7VlpZbZJeOhAzEbDvSBGBldQ=;
        b=B71Afnv3atNaZsAssvCG4tz+jYKNg9Qm6czeRKdFCXdQS9lvzojXj+RVVuwHEUdnUh
         +mJ8UcX//kXJEnIglZb1fGt6DLWp7DHqHfT49SSXgfv0Ev9Fq88xRo26sB7pyUemEWua
         zM3snqi42rW4wLWE9stuzxiSTlLpHo13N3XAE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WJWh+8PrQQf+c4ymmlTn0lwiYOff/Q2gb7W7YArimU/8PDfMmbBdp8GVlXCyZ28xFJ
         ODQPfu8qg2f18UP5omFsEOpxUsBrKzPO3+vg7SGyjlpsDzdevwbHKS6aVcGC55IszVG7
         cS6DYFvQWzGKb0JGUewksQXqcl+xPxn9+fhTA=
Received: by 10.229.96.9 with SMTP id f9mr111187qcn.78.1235134784842; Fri, 20 
	Feb 2009 04:59:44 -0800 (PST)
In-Reply-To: <200902191947.22622.kumbayo84@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110841>

We've run into the same issue with the experimental git support at the
ASF.  We dcommit to an EU mirror which lags behind the primary one for
a couple minutes.  While annoying, I don't think there's much that can
be done other than to commit and read from the master SVN server.
Otherwise, plan on getting good at "git svn dcommit; git svn rebase".
I tolerate this step because I think using git on top of SVN, even
with this lag, makes me more productive than SVN alone.

-- 
Kevin



On Thu, Feb 19, 2009 at 1:47 PM, Peter Oberndorfer <kumbayo84@arcor.de> wrote:
> Hi,
>
> With the patch i am replying to git-svn got a bit more comfortable for me but
> there is still a problem left.
>
> I fetch via svn://anonsvn.kde.org/home/kde/trunk/KDE/kdelibs
> and push to svn+ssh://YOUR_LOGIN@svn.kde.org/home/kde/trunk/KDE/kdelibs
>
> Pushing multiple changes at once to KDE servers with different fetch/commit
> url is not possible for me.
>
> Here is what it think what happens during a push:
> git svn dcommit pushes the first commit to svn.kde.org,
> then tries to fetch what it just pushed from anonsvn.kde.org
> (which lags behind authenticated svn by a few minutes).
>
> git svn does not see the just committed changes, gets confused
> and stops pushing the rest of the commits.
>
> My idea would be to temporarily fetch from the authenticated server, but not
> update the current head and revdb., so nothing is affected beside the push.
> But this seems quite complicated.
> Or do not care about difference between fetch/dcommit url, and just fetch from
> the dcommit url during dcommit.
>
> Anybody have a good idea if this is possible or a better way to solve this
> problem?
>
> Greetings Peter
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
