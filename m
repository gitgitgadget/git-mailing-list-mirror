From: Sam Vilain <sam@vilain.net>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Tue, 09 Dec 2008 22:08:54 +1300
Message-ID: <1228813734.28186.77.camel@maia.lan>
References: <493A6CEC.4060601@tuffmail.com>
	 <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>
	 <493C1F36.7050504@tuffmail.com>
	 <eaa105840812071230l5e8d54bcg21b36019711bc3cd@mail.gmail.com>
	 <493C47FD.4080302@tuffmail.com>	 <493D1CC2.8050407@drmicha.warpmail.net>
	 <493D66BB.3060907@tuffmail.com>
	 <eaa105840812081040s1036b79an9914c1f74d6d7f6a@mail.gmail.com>
	 <493D6AE9.6020504@tuffmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Peter Harris <peter@peter.is-a-geek.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Grzegorz Kossakowski <grek@tuffmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA8Yw-000736-Ai
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 20:48:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754603AbYLITqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 14:46:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754599AbYLITqk
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 14:46:40 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:43943 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603AbYLITqi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 14:46:38 -0500
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id F3EC121C3D4; Wed, 10 Dec 2008 08:46:36 +1300 (NZDT)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	DATE_IN_PAST_06_12 autolearn=no version=3.2.5
Received: from [127.0.0.1] (longdrop.musashi.utsl.gen.nz [192.168.253.12])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTPSA id 3DEDA21C3B9;
	Wed, 10 Dec 2008 08:46:32 +1300 (NZDT)
In-Reply-To: <493D6AE9.6020504@tuffmail.com>
X-Mailer: Evolution 2.22.3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102652>

On Mon, 2008-12-08 at 19:43 +0100, Grzegorz Kossakowski wrote:
> > Yes. The rfoo = sha1hash part is git-svn rebuilding its index.
> > "Current branch master is up to date" is git-svn calling "git rebase
> > <svn-branch>", and git saying that there is nothing to do, since there
> > have been no svn commits to that branch since the last time you ran
> > git svn rebase (or since you cloned the git mirror, or since the last
> > time the git mirror pulled from svn).
> 
> Thanks for confirmation and explanation.
> 
> The remaining question is who should address this issue with non-existing trunk ref? Should I ask
> Jukka, who maintains svn mirrors, to put instruction into his scripts that will add trunk reference?

It's up to the git-svn user to make sure that they prepare the refs to
be what git-svn expects.  This is something probably requiring more
documentation and/or git-svn features to be easier.

> Would it be the best practice?

Well, obscure stuff should never really be best practice.  The best practice
is to have a single git repository that is where the svn -> git migration
happens.  And git-svn could perhaps auto-init based on information in the
commit log or something.  Best practice is to enhance the tool to work the
way it Should(tm) :)

Sam
