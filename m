From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Fri, 20 Nov 2009 05:56:18 +0300
Message-ID: <20091120025617.GD22556@dpotapov.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com> <m37htnd3kb.fsf@localhost.localdomain> <31e9dd080911181152h665d5d9dr5c0736c0ca3234c1@mail.gmail.com> <009401ca68bc$7e4b12b0$7ae13810$@com> <20091120014843.GB22556@dpotapov.dyndns.org> <alpine.DEB.2.00.0911191754540.10307@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: George Dennie <gdennie@pospeople.com>,
	'Jason Sewall' <jasonsewall@gmail.com>,
	'Jakub Narebski' <jnareb@gmail.com>,
	'Jan =?iso-8859-1?Q?Kr=FCger'?= <jk@jk.gs>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Fri Nov 20 03:56:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBJfo-0001X8-8e
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 03:56:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758245AbZKTC4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 21:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758243AbZKTC4Y
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 21:56:24 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39062 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218AbZKTC4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 21:56:24 -0500
Received: by bwz27 with SMTP id 27so3026176bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 18:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=8UxwODjpJTNX8jXUGSQI1wA6Xk64LpB3eTTLjUD+Bqw=;
        b=YLzyM2teU+h8CU6Qt1AT/dcZYOyJLJ7tRxfP2/kpI+He3Mk6xjPTD7yo716RZIviPm
         dvIeEwFb/XPLLGGEdnnAFmEl4eqgRcn+wMFrZ4JpUkvZvrqEdR/Q6b2SNgGRGZj8IFXi
         Og57/hc1DyRwO8TaU9aiPeMKv0SNWi1YXjCQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=kNzCZwjJtenztKpcETh7rtEB119iIepRzQ1tWX6YJpNPRPRwoj90Bj6uD2PA3amPWQ
         hafwrV0ti6AbZ6aDFZ8Eot/omwD7Bbu1K3mCZqXbS1WVSaQlj/sVrOalWcT5Sf5B5+6w
         0n/QCbb4lQzqAKKWsn2aXCztip5ZlNOYaxqvM=
Received: by 10.204.160.154 with SMTP id n26mr783861bkx.90.1258685789317;
        Thu, 19 Nov 2009 18:56:29 -0800 (PST)
Received: from localhost (ppp91-76-17-113.pppoe.mtu-net.ru [91.76.17.113])
        by mx.google.com with ESMTPS id 15sm404559fxm.2.2009.11.19.18.56.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 18:56:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.0911191754540.10307@asgard.lang.hm>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133299>

On Thu, Nov 19, 2009 at 05:55:21PM -0800, david@lang.hm wrote:
> On Fri, 20 Nov 2009, Dmitry Potapov wrote:
>
>> So, the correct way to use Git is to find the right balance between
>> the need to clean up after mistakes (using git-rebase) and not doing
>> too much, so you will not lose important history or create problems
>> for other peoples.
>
> the typical advice is to clean up before you make changes public, but not 
> afterwords.

True, except patches may get additional clean up or improvements based
on review feedback, or even get some small fix-ups while they live on
'pu'. But re-writing something that other people may base their work on
is clearly wrong. On the other hand, rebasing a large series of patches
even if it has never been published may be a wrong way to go, because
you replace well tested states with some others, which were not tested.
So if it is a long and complex series of patches, chances are high that
you can break something in it. So, it requires some judgement when to
use git-rebase and when git-merge.


Dmitry
