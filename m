From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: how to skip branches on git svn clone/fetch when there are
 errors
Date: Sat, 05 Sep 2009 10:55:04 +0200
Message-ID: <1252140904.8992.6.camel@localhost>
References: <9accb4400908310126v15b08c7fr425c9daff26012f3@mail.gmail.com>
	 <20090905061657.GC22272@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Sep 05 10:55:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mjr3F-0002h4-RP
	for gcvg-git-2@lo.gmane.org; Sat, 05 Sep 2009 10:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757243AbZIEIzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2009 04:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757217AbZIEIzI
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Sep 2009 04:55:08 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:32313 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756674AbZIEIzG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2009 04:55:06 -0400
Received: by fg-out-1718.google.com with SMTP id 22so1268308fge.1
        for <git@vger.kernel.org>; Sat, 05 Sep 2009 01:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=KaxD//ArLJj2J0Lbbi6hbMRo+Z7SgUCIU0LJh2vph0g=;
        b=wW9Jc1MdhJQbYZuY8kPkUea1+U6JesUy3XLodwxZ2RDLmOCDAr/CVs15JJesqwFYzn
         JLX27j4ry6RzsW0mFIYYwJI9F/7OJTWNAd3xxCk3CdFSkxTDv53dUOjdVLz/XNfmZTPb
         vGCnhNWNHSSnp6tjNAVydY1kiOizjxPETX0yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=Ncuw9bYexfZmi1IeSQJN7CatZ/24K8GVGwOwWWsra0/KRfhSos/v67MtMlz52J2Xr1
         QUevlThuVmaXWddh99z6+404VUvMnzKzMayPmAWoIrCuiHBFUhBdwSUwEIQpDzQzruHu
         maszHkIc28DNWj8CMlo8BrFHqZ60+bu9ytBTk=
Received: by 10.86.187.27 with SMTP id k27mr5884458fgf.11.1252140907491;
        Sat, 05 Sep 2009 01:55:07 -0700 (PDT)
Received: from ?192.168.1.2? (host98-2-dynamic.52-82-r.retail.telecomitalia.it [82.52.2.98])
        by mx.google.com with ESMTPS id 3sm3567464fge.7.2009.09.05.01.55.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Sep 2009 01:55:06 -0700 (PDT)
In-Reply-To: <20090905061657.GC22272@dcvr.yhbt.net>
X-Mailer: Evolution 2.24.5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127803>

Il giorno ven, 04/09/2009 alle 23.16 -0700, Eric Wong ha scritto:
> It's unfortunate, but there's not yet an exclude/ignore directive
> when globbing.  You'll have to change your $GIT_CONFIG to only
> have a list of branches you want, something like this:
> 
> [svn-remote "svn"]
> 	url = svn://svn.mydomain.com
> 	fetch = path/to/repo/HEAD/root:refs/remotes/svn/trunk
> 
> 	; have one "fetch" line for every branch except the one you want
> 	fetch = path/to/repo/BRANCHES/a/root:refs/remotes/svn/a
> 	fetch = path/to/repo/BRANCHES/b/root:refs/remotes/svn/b
> 	fetch = path/to/repo/BRANCHES/c/root:refs/remotes/svn/c
> 
> 	; you can do the same for tags if you have the same problem
> 	tags = path/to/repo/TAGS/*/root:refs/remotes/svn/tags/*
> 
> But you shouldn't have to worry about having "fetch" entries for
> stale/old branches/tags you've already imported.

I see...
That means that then I'll have to manually add new created branches,
right?

well... I tried to avoid this kind of configuration for weeks :) but
that's probably my best way with that repo....

thank you,
Daniele
