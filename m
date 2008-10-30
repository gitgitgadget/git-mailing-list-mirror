From: Sam Vilain <sam@vilain.net>
Subject: Re: Using the --track option when creating a branch
Date: Wed, 29 Oct 2008 22:12:18 -0700
Message-ID: <1225343538.10803.9.camel@maia.lan>
References: <18696.32778.842933.486171@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 06:13:50 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvPqv-0000s3-Eg
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 06:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbYJ3FMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 01:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751732AbYJ3FMd
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 01:12:33 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:48793 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751216AbYJ3FMc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 01:12:32 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id B475C21D157; Thu, 30 Oct 2008 18:12:27 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 648D821C592;
	Thu, 30 Oct 2008 18:12:21 +1300 (NZDT)
In-Reply-To: <18696.32778.842933.486171@lisa.zopyra.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99445>

On Wed, 2008-10-29 at 09:23 -0600, Bill Lear wrote:
> We use git in a way that makes it desirable for us to only push/pull
> to the same remote branch.  So, if I'm in branch X, I want 'git push'
> to push to origin/X, and 'git pull' to fetch into origin/X and then
> merge into X from origin/X.
> 
> In other words, we want git push/pull to behave in branches other than
> master the same way it does when in master.
> 
> I have discovered the '--track' option when creating a local branch,
> and this appears to me to be the thing that gives us the desired
> behavior.

As things currently stand this is not achievable behaviour.  The
behaviour of 'git push' is to push all matching refs.  If you are lucky
this is what you intended, but it also pushes any changes to *other*
branches that you have made.

I have tabled a change proposal to make it work as you suggest in a
separate thread.

Sam
