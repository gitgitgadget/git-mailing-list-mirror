From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: [PATCH v2] Add --track option to git clone
Date: Thu, 03 Dec 2009 06:07:08 +0900
Message-ID: <20091203060708.6117@nanako3.lavabit.com>
References: <1259707865-6561-1-git-send-email-sn_@gmx.net> <20091202192028.6117@nanako3.lavabit.com> <20091202190807.GB30778@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: David Soria Parra <sn_@gmx.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 22:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFwQP-0005Zk-MG
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 22:07:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753976AbZLBVHg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 16:07:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753016AbZLBVHf
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 16:07:35 -0500
Received: from karen.lavabit.com ([72.249.41.33]:58427 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752473AbZLBVHf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 16:07:35 -0500
Received: from e.earth.lavabit.com (e.earth.lavabit.com [192.168.111.14])
	by karen.lavabit.com (Postfix) with ESMTP id 1810611B7EC;
	Wed,  2 Dec 2009 15:07:42 -0600 (CST)
Received: from 6685.lavabit.com (212.62.97.23)
	by lavabit.com with ESMTP id 682HSHI63AYV; Wed, 02 Dec 2009 15:07:42 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=dT2MRk4HYL7EvL+x3075wcJWebERPESZb+kAYnOAwD3wXVtlT9H8msF4Ki7EnSGHQAll9k4VSMVeqR5L7XnJaJ0wQnyDDZucoiKdfCWus050OSXRUNBjQ1PSy3gM9EpsbmvMGrQxRQd/TfqAgs76zu3CMw0yvreXzek9cQjwsuE=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <20091202190807.GB30778@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134399>

Quoting Jeff King <peff@peff.net>

> I would find something like this useful for cloning git.git, where I
> explicitly fetch maint, master, next, and pu, but none of html, man, or
> todo. This makes "gitk --all" much nicer to view.

Thank you for explaining. I now can understand why it can be useful.

>   # most general case
>   git clone -f 'refs/heads/subset/*:refs/remotes/origin/*' remote.git

Because this is only about branches and no other kinds of 
references, I think this is an overkill.

>   git clone -f 'subset/*' remote.git

But I think this is a good idea.

>   # multiple -f should add multiple refspec lines
>   git clone -f maint -f master -f next -f pu git.git
>
>   # choose your favorite branch
>   git clone -f maint -f master -f next -f pu -b next git.git
> ...
> What do you think?

I think your rule to make first branch given by -f the default 
for -b is a good idea. But I'm not very happy with the example 
with four -f. Can we probably write it like this?

  git clone -f maint,master,next,pu git.git

If it isn't a good idea to use comma, we can use colon to split 
the list of branch names instead.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
