From: Ulrich =?utf-8?B?U3DDtnJsZWlu?= <uqs@spoerlein.net>
Subject: Re: use case, advices (SVN/GIT)
Date: Fri, 23 Apr 2010 17:25:17 +0200
Message-ID: <20100423152517.GA92627@acme.spoerlein.net>
References: <20100422151401.2c47aa76@pbmiha.malagasy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Mihamina Rakotomandimby <mihamina@gulfsat.mg>
X-From: git-owner@vger.kernel.org Fri Apr 23 17:25:28 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O5Kkx-0001Cg-Qx
	for gcvg-git-2@lo.gmane.org; Fri, 23 Apr 2010 17:25:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755686Ab0DWPZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Apr 2010 11:25:24 -0400
Received: from acme.spoerlein.net ([188.72.220.29]:40226 "EHLO
	acme.spoerlein.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754747Ab0DWPZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Apr 2010 11:25:21 -0400
Received: from acme.spoerlein.net (localhost.spoerlein.net [IPv6:::1])
	by acme.spoerlein.net (Postfix) with ESMTPS id 634825C92;
	Fri, 23 Apr 2010 17:25:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=spoerlein.net;
	s=dkim200908; t=1272036319;
	bh=qF/qZ/nMnNaxnAXNCEuKn/SF/aUmmZJCSF/7HV0siMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=iNqKsi0NriIKkGXox/kdqJNnhz5UWiOq86fgdYHcdZHnagcbsXCqogGnXH32PKdGS
	 QiWS9JVCl8jhgwgAIlmnLHHqndSdlj/qe7UzGWy4ME1PyzrBYYVexCkFqL8e4t3xyn
	 PcAFGM1HnBlxjnSMy6qn1RDhOY4D+F2biHdzObcI=
Received: (from uqs@localhost)
	by acme.spoerlein.net (8.14.4/8.14.4/Submit) id o3NFPH7o067873;
	Fri, 23 Apr 2010 17:25:17 +0200 (CEST)
	(envelope-from uqs@spoerlein.net)
Content-Disposition: inline
In-Reply-To: <20100422151401.2c47aa76@pbmiha.malagasy.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145624>

On Thu, 22.04.2010 at 15:14:01 +0300, Mihamina Rakotomandimby wrote:
> Manao ahoana, Hello, Bonjour,
> 
> We'd rather use GIT.
> But there is a project, that we regularily pull (Coova:
> http://coova.org/CoovaChilli/Developers) which is under SVN.
> 
> I first "svn export" this project.
> I initiate a new GIT repository based on what I "exported".
> I make my changes, and commit them.

Use git-svn(1) to clone the branch you want to track

$ git svn init -Ttrunk URL

now you have a master branch that is set up to track the svn trunk. I'd
recommend to put your commits into a different branch though and keep
'master' clean.

> I month (and several commits) later, I would like to sync with Coova
> SVN.

$ git svn rebase
will fetch all new svn commits and put them in remotes/trunk, master is
then forwarded accordingly.

Rebase your work on top of master now
$ git rebase master mybranch

> It's a one way "pull": I wont push my changes to their repository.
> 
> What's your recommended way to handle this?

git-svn, see above.

Uli
