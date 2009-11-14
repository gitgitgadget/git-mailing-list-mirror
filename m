From: Nanako Shiraishi <nanako3@lavabit.com>
Subject: Re: Question about "git pull --rebase"
Date: Sun, 15 Nov 2009 08:16:49 +0900
Message-ID: <20091115081649.6117@nanako3.lavabit.com>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 00:24:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Ryc-0004rH-0i
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 00:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751618AbZKNXT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Nov 2009 18:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbZKNXT5
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Nov 2009 18:19:57 -0500
Received: from karen.lavabit.com ([72.249.41.33]:59816 "EHLO karen.lavabit.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbZKNXT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Nov 2009 18:19:56 -0500
Received: from c.earth.lavabit.com (c.earth.lavabit.com [192.168.111.12])
	by karen.lavabit.com (Postfix) with ESMTP id C5D3911B7E0;
	Sat, 14 Nov 2009 17:20:02 -0600 (CST)
Received: from 8727.lavabit.com (customer-148-233-239-23.uninet.net.mx [148.233.239.23])
	by lavabit.com with ESMTP id E4FK32B3703L; Sat, 14 Nov 2009 17:20:02 -0600
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=lavabit; d=lavabit.com;
  b=ouztZ9v+hZBUjqrakHqGTetPtqLhXMt1xXs8a03R1WdnOj63VvsZtbA2zl4zq7QPeT8EbPb43x8W6W7lzrpP1JxT2HmMTsN3bS7a9jzX4HwHeg7erd1ExQqBXHqcAh31JZW3EpqbYfZ/fEMOzEi4QJXeS55g3tipO/1cDB3efY8=;
  h=From:To:Cc:Subject:References:In-Reply-To:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
In-Reply-To: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132894>

Quoting Francis Moreau <francis.moro@gmail.com>

> Let's say I'm on a branch called 'foo'.
> ...
>     $ git pull --rebase origin master:foo

With this command line, you are asking:

 1) Please first fetch master from origin and update the local 
    'foo' with it, but please fail if this doesn't fast forward;

 2) If the first step was successful, please rebase the current 
    branch on top of that commit.

If your current branch 'foo' doesn't fast forward, the first step 
should fail, and that is the failure you saw.

Your request doesn't make any sense. The first step would succeed 
only when your 'foo' doesn't have anything to replay on 'master' 
from origin, and the second step either isn't executed (when 'foo' 
has some commits), or it doesn't do anything (when 'foo' doesn't 
have any commit).

>     $ git pull --rebase origin master

With this command line, you are asking:

 1) Please first fetch master from origin, but don't store it anywhere;

 2) Then on top of that fetched commit, please rebase the current branch.

That is a much saner request.

-- 
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/
