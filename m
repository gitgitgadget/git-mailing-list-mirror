From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 08:22:14 +0200
Message-ID: <CAB9Jk9DH4Gx-8oJzb8H=ytohhZnMbA92pwj5P25AehmZ3PMmcg@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<506BCF19.7020800@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 08:23:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJIM1-0007ij-3U
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 08:22:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422Ab2JCGWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 02:22:35 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:49661 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752259Ab2JCGWP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 02:22:15 -0400
Received: by vcbfo13 with SMTP id fo13so7850047vcb.19
        for <git@vger.kernel.org>; Tue, 02 Oct 2012 23:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=90g+ToIulOKInRuORfCeZ7IV1CIpcnFETmFDDUAOeUc=;
        b=j2L1M9tpnQbU4Txe+wO44+elSsvTDx1857YpGLX6tNDJD41SYdULiJfRERZ8AXiPt4
         FeDyV3n2gcOcdWFuVCg8HcfV8P2PUW/raxMbPq1QJ5zr74E8SvJa28KDtNOP66SODJre
         oLAkztvixWMkcsGz0SQHaaSEhvYqqWLSGZcF5CJ2r3dprBc2XHp+gyI71zuiaBoPIMqe
         dfnAJlz/4A3t/UcxUFleQliszvvHuL7v5lFBw03+n9h/G/vKfloidnDW1knxPRP3jUrm
         rqMhgwOLo0I9Mtvo9Uvv6x3+n+tefi0JndZGUKatZ4oRTSIuBmATdD+eBIuBIG6pSvUQ
         t2Xw==
Received: by 10.221.13.202 with SMTP id pn10mr540525vcb.57.1349245334363; Tue,
 02 Oct 2012 23:22:14 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Tue, 2 Oct 2012 23:22:14 -0700 (PDT)
In-Reply-To: <506BCF19.7020800@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206858>

Hi PJ and Hannes,

try to run the last script that I posted, with and without a sleep 1
before the last commit:

git init
echo "aaa" >f1
git add f1
git commit -m A
git checkout --orphan sources
git commit -m A --allow-empty

and

git init
echo "aaa" >f1
git add f1
git commit -m A
git checkout --orphan sources
sleep 1
git commit -m A --allow-empty

In the first one, no new commit is created, and the "sources" branch
is not orphan (you can easily see it with the git gui).
In the second one, a new commit is created, and the "sources" branch
is orphan, as expected.

-Angelo
