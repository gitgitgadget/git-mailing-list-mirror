From: Johan Herland <johan@herland.net>
Subject: Re: How to ignore changes on remote
Date: Tue, 23 Mar 2010 18:20:51 +0100
Message-ID: <201003231820.51618.johan@herland.net>
References: <26ae428a1003230654m50c35caci4a02e2df321f289c@mail.gmail.com> <d411cc4a1003230905y12839743x400333a0aa2e7018@mail.gmail.com> <4BA8EA6A.4030607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Scott Chacon <schacon@gmail.com>, sylvain@abstraction.fr,
	howard@e-learndesign.co.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 23 18:21:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu7nT-0007SB-KG
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 18:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752946Ab0CWRVh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 13:21:37 -0400
Received: from smtp.opera.com ([213.236.208.81]:54874 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752027Ab0CWRVg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 13:21:36 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id o2NHKpTp009221
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 23 Mar 2010 17:21:08 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4BA8EA6A.4030607@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143031>

On Tuesday 23 March 2010, Johannes Sixt wrote:
> Am 3/23/2010 17:05, schrieb Scott Chacon:
> > Why would we teach someone to do that instead of just recommending
> > the far less obscure 'git push -f'?  A leading '+' on the refspec
> > is ridiculously confusing compared to "just tell it to force the
> > push with -f".  Am I forgetting something?
>
> -f is dangerous. I was once bitten badly by a hastily typed
>
>    git push -f repo
>
> that pushed two branches instead of only one: One needed an urgent
> update (that was the good one), but it also pushed the other one,
> which was not yet prepared for publication.

IMHO the main problem in this case is NOT with the -f option, but rather 
that 'git push' defaults to pushing all "matching" branches. I'd much 
rather have push.default default to the much safer "tracking", which 
pushes at most one branch. But changing default behaviour is hard to do 
without annoying old-timers.

I'm rolling out Git at my $DAYJOB to a few hundred developers, and I 
instruct them to

	git config --global push.default tracking

immediately after installing Git. Which sucks, but is the only sane 
thing I can do to prevent this problem from haunting us.

> By teaching the +refspec form, you force the user to be careful which
> branch is rewound. Yes, you can still say +refs/heads/*, but if you
> do that, you are much more explicit than with "push -f repo", where
> the affected branches are hidden in the config file.

IME refspecs are not easily grasped by Git newbies, and the longer they 
can get by without having to learn them, the happier they'll be with 
Git. IMHO, refspecs are really cool and powerful, but you shouldn't 
have to learn them in order to do day-to-day development.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
