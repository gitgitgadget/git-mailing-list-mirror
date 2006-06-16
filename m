From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Why so much time in the kernel?
Date: Fri, 16 Jun 2006 13:00:05 -0400
Message-ID: <9e4733910606161000t53328571u10a350eca894ccdc@mail.gmail.com>
References: <9e4733910606160749t4d7a541ev72a67383e96d86da@mail.gmail.com>
	 <Pine.LNX.4.64.0606160755170.5498@g5.osdl.org>
	 <9e4733910606160825hb538d6fo4c9f1d7d9768e100@mail.gmail.com>
	 <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 16 19:00:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrHg7-00053k-CE
	for gcvg-git@gmane.org; Fri, 16 Jun 2006 19:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbWFPRAJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 13:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751499AbWFPRAI
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 13:00:08 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:54356 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751494AbWFPRAH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 13:00:07 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1031953nze
        for <git@vger.kernel.org>; Fri, 16 Jun 2006 10:00:06 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Np1l+0buNzpIHRwGO/HPX5fx0neXjf/VNqg9qaNRfLBD/7khGjQ+e9Yh36A//EiyFSOxXOyV/qhHQUTmwe9ys0hebUdv3Yq6dTxbHuiIzBIUU/AvwJwXN9o77jPcm9dQKYWd7M3dMUk0JMwXifKNuO/MSU3EP0w7tNHdswVsUnE=
Received: by 10.36.10.7 with SMTP id 7mr2200108nzj;
        Fri, 16 Jun 2006 10:00:06 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Fri, 16 Jun 2006 10:00:05 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606160906250.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21947>

Is it a crazy idea to read the cvs files, compute an sha1 on each
expanded delta and then write the delta straight into a pack file? Are
the cvs and git delta formats the same? What about CVS's forward and
reverse delta use? While this is going on, track the
branches/changsets in memory and then finish up by writing these trees
into the pack file too. This should take no more ram than cvsps needs
currently.

This leaves the packfile is a non-optimal format but a repack should
fix that, right?

-- 
Jon Smirl
jonsmirl@gmail.com
