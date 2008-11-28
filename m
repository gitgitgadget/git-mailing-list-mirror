From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: remote branch checkout issue, why its *(no branch)
Date: Fri, 28 Nov 2008 14:32:56 -0800 (PST)
Message-ID: <m3k5anjxcd.fsf@localhost.localdomain>
References: <9e6474ae0811281415n7b4596afq7b3ce25816d9a639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sudipta GHOSH" <sudipta.in@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 23:34:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Buk-00069a-Mp
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 23:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752893AbYK1WdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 17:33:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752837AbYK1WdB
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 17:33:01 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:24139 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752710AbYK1Wc7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 17:32:59 -0500
Received: by nf-out-0910.google.com with SMTP id d3so867322nfc.21
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 14:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=GPzsVUNII4eaUs4kSfJrBQ7k068NN2If7g9O1mAZbUY=;
        b=B+lYDpF+2IJC8HMTK+25rj2YwqPrtwCeh8yKRp+f5APnMBicDa4wFufiHXTlNZNwqC
         FIS30bUawQejeNos4XjgzBV8IIZ/mbQh7zA70K1QmUhWCIBLpsMSZOOHrhrr+ZtF8NvE
         X9fJ0i4GykS3QMw2ErByVDrD5Ypco1k/upOn8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=h2gaY3a2qq/gu6S0u4tDLYTCDEJNAcKWhyTwtFHQ8VutCuodJ7Mai0BjzSSgjVhYGX
         gS7URnp6UNhJSzaqW/IXxY2r8SO4TJ2AyrzBee+oBCq1kC4CseWkO0QwVlS80mspXPSo
         BFh/q9PwFfIUW2k0yPfoiKzWhzOekaoSyIJa0=
Received: by 10.210.56.7 with SMTP id e7mr9413759eba.25.1227911577436;
        Fri, 28 Nov 2008 14:32:57 -0800 (PST)
Received: from localhost.localdomain (abvh10.neoplus.adsl.tpnet.pl [83.8.205.10])
        by mx.google.com with ESMTPS id 20sm4809102eyc.58.2008.11.28.14.32.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Nov 2008 14:32:56 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mASMWOW1021372;
	Fri, 28 Nov 2008 23:32:35 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mASMWIA6021368;
	Fri, 28 Nov 2008 23:32:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <9e6474ae0811281415n7b4596afq7b3ce25816d9a639@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101889>

"Sudipta GHOSH" <sudipta.in@gmail.com> writes:

> In our git repository there are few branches like
> 
> master
> origin/B1
> origin/B2
> 
> After doing  #git checkout origin/B1 I found that my current branch is
> *(no branch)
> 
> #git branch
> *(no branch)
> master
> 
> Why its showing *(no branch) why not origin/B1
> 
> How I can checkout origin/B1 and after that my current branch will be
> origin/B1 not the *(no branch)

First, 'origin/B1' is so called remote-tracking branch, and its full
name is refs/remotes/origin/B1.  Those branches are updated
_automatically_ by git on fetch, to follow branch 'B1' in 'origin'
repository.  Therefore, to not lose _your_ changes git doesn't allow
checking out remote-tracking branches.  You can checkout _state_ of
such branch into anonymous noname branch, so called in git jargon
"detached HEAD".


What you can do is to create _local_ branch, closely tied to
remote-tracking branch 'origin/B1', by using:

  $ git branch -b B1 --track origin/B1

Git would set up configuration for this branch in such way that "git
pull" command given on 'B1' branch would "do the right thing"(TM)


I really recommend reading "Git User's Manual" or "The Git Community
Book" first...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
