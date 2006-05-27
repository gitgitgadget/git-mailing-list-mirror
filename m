From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: remaining git-cvsimport problems: robustness when cvsps feeds strange history
Date: Sun, 28 May 2006 03:23:01 +1200
Message-ID: <46a038f90605270823qdea766fxcf2327ae0bf7373a@mail.gmail.com>
References: <20060527120105.GL6535@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Cc: "GIT list" <git@vger.kernel.org>, cvsps@dm.cobite.com
X-From: git-owner@vger.kernel.org Sat May 27 17:23:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fk0dF-0007mx-H8
	for gcvg-git@gmane.org; Sat, 27 May 2006 17:23:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550AbWE0PXH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 11:23:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbWE0PXH
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 11:23:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:27824 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751550AbWE0PXF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 May 2006 11:23:05 -0400
Received: by wr-out-0506.google.com with SMTP id i7so598338wra
        for <git@vger.kernel.org>; Sat, 27 May 2006 08:23:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E+ojs2shv+x13MgQ1Cd4Laig/qdA1qhD1PbwzpapJY0JdbLs0vl1qtMmynUKadjj9cwtOEDdDxMLai/TJzld71BLZecHh6Oiohh4JHThXluS0CBf548B8neteMqA11uCxW22kJboMJ5+PYqv7kSS1La6ihVmigLNVvpN2gjaJrU=
Received: by 10.54.103.1 with SMTP id a1mr102524wrc;
        Sat, 27 May 2006 08:22:18 -0700 (PDT)
Received: by 10.54.127.12 with HTTP; Sat, 27 May 2006 08:23:01 -0700 (PDT)
To: "Yann Dirson" <ydirson@altern.org>
In-Reply-To: <20060527120105.GL6535@nowhere.earth>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Yann,

I want to see if we can close these gaps. Have you got a public repo
that shows this problem so can look more into it?

On 5/28/06, Yann Dirson <ydirson@altern.org> wrote:
> As a sidenote, I'm wondering why there is no precise information on
> the branchpoint in "cvsps -A".  I guess the semantics are "fork a new
> branch from the ancestor one" at whatever point it currently is - that
> would look quite risky to me, and could be part of the reason why
> cvsps did not notice the inconsistency: it just did not try to find
> out where the new branch was to be grafted exactly.

It is perfectly possible for cvs to branch at a "point" that is not
really a patchset/patchlevel. Just like it is to tag something that
has never been a patchset.

It is something we currently fudge a bit (or a lot, depending on your
point of view). If the branch was made on a checkout with an
inconsistent tree, we cannot really represent that in git matching
what happened in CVS.

OTOH, the cvsps output you are showing us seems to be in the right
order...  patchset 20 should go on top of patchset 3... is cvsimport
truly mishandling this?



martin
