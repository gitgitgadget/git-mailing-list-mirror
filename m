From: Dan Farina <drfarina@gmail.com>
Subject: Re: backup or mirror a repository
Date: Thu, 27 Sep 2007 19:37:43 -0700
Message-ID: <1190947063.2263.46.camel@Tenacity>
References: <1190921742.2263.17.camel@Tenacity>
	 <Pine.LNX.4.64.0709272255360.28395@racer.site>
	 <1190940704.2263.32.camel@Tenacity>
	 <Pine.LNX.4.64.0709280253150.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 04:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib5k4-0007AS-Cf
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 04:38:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754663AbXI1CiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 22:38:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754881AbXI1CiD
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 22:38:03 -0400
Received: from wa-out-1112.google.com ([209.85.146.177]:27363 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbXI1CiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 22:38:01 -0400
Received: by wa-out-1112.google.com with SMTP id v27so3384266wah
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 19:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=+0Kv9haRCQTALVEAWdTFD32qKKwDFZXlQxVdme7O70o=;
        b=Xx9xOMr+AOE7qceJySFWRuOv5IyarBn786prDa+EEUEHyZGFS722Wj2hHqJSZgV5wtwwhxsvfWKu8ViJ+JEdrPsiSe26I/fNK3wqsIHwQFxkdION8USD/pqydxsMlyeON1Jemqb+CBbtyV1mvdIHVrRSb7FbsUAXfWPzcfCZ3o8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=btmhGpKPbI5A02uHZJ1aSom6DAbZDTmzSdDRORGbRs1TSNGqu2ntcabNqI2g+wQf1AHs4wv5bjzTwf1qAHNduoWY5QIPBskrwiJJKRcIOeR3j1Q4DWWndPEzXOrdIu8SKxueBBe41E2pmJv0H8FW2Qm3vTO60VUblNGW5Rey+us=
Received: by 10.114.103.1 with SMTP id a1mr3344146wac.1190947080117;
        Thu, 27 Sep 2007 19:38:00 -0700 (PDT)
Received: from ?192.168.1.101? ( [71.134.240.3])
        by mx.google.com with ESMTPS id n38sm4682584wag.2007.09.27.19.37.57
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 27 Sep 2007 19:37:58 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709280253150.28395@racer.site>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59352>

On Fri, 2007-09-28 at 02:56 +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Thu, 27 Sep 2007, Dan Farina wrote:

> git remote rm is about removing the remote nick, not a remote branch.

Ah, I thought for some reason there'd be a "remove" (since the other
operations have long names) and, much like "ls-remote" there'd be some
"rm-remote." An insane presupposition of mine from having too little
information.


> What you should have done is "git fetch backup".
> 
> Or use "origin" instead of "backup" right from the start, and then use 
> "git fetch".
> 
> But no pull.

I did use "pull backup" (my error for being sloppy and omitting it from
my mail) and it does work provided I do the dirty thing of doing a
subsequent reset --hard (I thought perhaps things were not yet
fully-there). Fetch does it perfectly, as you say, thanks!

> You want to remove branches from the local repo which are no longer there 
> on the remote side?
> 
> Then "git remote prune" is for you.  For details, please see the man page.
> 

I did look at prune and update, but my problem is the opposite: I want
something that will remove branches from the remote repo when they no
longer exist locally. As-is over time I will proliferate little local
branches unless I occasionally sit down and delete branches by operating
directly on the bare backup repository. (and then use prune on the
remote nodes)

Thanks,
fdr
