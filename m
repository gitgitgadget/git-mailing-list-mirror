From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: fsck --full is Ok, but clones are not, "missing commits"?!
Date: Fri, 18 Apr 2008 10:55:28 +0200
Message-ID: <48086200.5020600@viscovery.net>
References: <200804161626.44174.brian.foster@innova-card.com>	 <a537dd660804170753i4dcfd189m45a9581294ce5091@mail.gmail.com>	 <48076F94.7030206@nrlssc.navy.mil>	 <200804180943.20933.brian.foster@innova-card.com> <a537dd660804180141h25b7f8e2yf7283f63d49521e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Dmitry Potapov <dpotapov@gmail.com>, git@vger.kernel.org
To: Brian Foster <brian.foster@innova-card.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 02:50:27 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmmOO-0002h5-JS
	for gcvg-git-2@gmane.org; Fri, 18 Apr 2008 10:56:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbYDRIzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2008 04:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYDRIzc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Apr 2008 04:55:32 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:50481 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbYDRIzb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2008 04:55:31 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JmmNU-0000Ab-Bm; Fri, 18 Apr 2008 10:55:28 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 229CF6B7; Fri, 18 Apr 2008 10:55:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <a537dd660804180141h25b7f8e2yf7283f63d49521e6@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 2.2 (++)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5, PLING_QUERY=0.514
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79871>

Brian Foster schrieb:
>  that seemingly bogus `check-ref-format' argument comes
>  from the pipeline (where ref=master):
> 
> 	git for-each-ref --format='%(refname)' | grep /"$ref"
>  i.e.:
> 	git for-each-ref --format='%(refname)' | grep /master
> 
>  so...
> 	$ git for-each-ref --format='%(refname)'
> 	refs/heads/master
> 	refs/remotes/origin/HEAD
> 	refs/remotes/origin/master
> 	refs/tags/linux-2.6.15
> 	refs/tags/linux-usip-v2.6.15
> 	[ ... ]
> 	$
> 
>  note two names match the RE `/master', hence the bogus
>  argument.  the reason for that seems to be (this is a
>  guess!) that `rev-parse' is *not* being run as:
> 
> 	git rev-parse --no-flags --revs-only \
> 		--symbolic-full-name --default HEAD --branches
> 
>  as I _think_ you are claiming it should be, but as:
> 
> 	git rev-parse --revs-only --symbolic --branches

One of the changes since v.1.5.3 was to get rid of this bogus grep. Can
you install a newer git?

-- Hannes
