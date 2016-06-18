Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AEB7720189
	for <e@80x24.org>; Sat, 18 Jun 2016 23:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbcFRXUx (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 19:20:53 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:53344 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751074AbcFRXUx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 19:20:53 -0400
Received: from homiemail-a44.g.dreamhost.com (sub5.mail.dreamhost.com [208.113.200.129])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 941728F5F2
	for <git@vger.kernel.org>; Sat, 18 Jun 2016 16:20:52 -0700 (PDT)
Received: from homiemail-a44.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a44.g.dreamhost.com (Postfix) with ESMTP id 981C3118057
	for <git@vger.kernel.org>; Sat, 18 Jun 2016 16:20:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=eagerm.com; h=from:subject
	:to:message-id:date:mime-version:content-type:
	content-transfer-encoding; s=eagerm.com; bh=T2+eFC8iDqn5mtptg7Wp
	udIVNLc=; b=KVTMaEnDx0i1NJlBfgfcmfoM6xWJaFnNaHwRiy2epb3XE0QORsIX
	MB9JKWgKSCeyMxPi8EMXfW/1nBCZBRJpAhrh+s7Wq9BZf5HeqMQSOA+NzRBaXWCd
	sXn+41AQVmkRFA95brSktI5T45H+nOkSrwGz6o2qsZPfXI4AUjFoAIA=
Received: from vm-fedora21.eagercon.com (c-71-202-23-94.hsd1.ca.comcast.net [71.202.23.94])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: eager@eagerm.com)
	by homiemail-a44.g.dreamhost.com (Postfix) with ESMTPSA id 87FBA118056
	for <git@vger.kernel.org>; Sat, 18 Jun 2016 16:20:51 -0700 (PDT)
From:	Michael Eager <eager@eagerm.com>
Subject: Managing sub-projects
To:	Git Mailing List <git@vger.kernel.org>
Message-ID: <5765D752.4000404@eagerm.com>
Date:	Sat, 18 Jun 2016 16:20:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I'm trying to create a git repository for a tool chain for a proprietary
processor.  I'd like to create a private repo with documentation, build
scripts, etc., which includes several sub-projects: binutils, gcc, newlib,
etc.  Each of the sub-projects will have a branch which has support for
the new processor.  These branches need to be maintained in my repo, not
in the upstream repo.  I want to be able to periodically rebase these
branches from the upstream repo.

I've looked at several schemes, but each one seems to do something other
than what I want.

Git submodule:  Branches created in the sub-projects are pushed to the
upstream repo, not to my repo.  I tried to change origin and created an
upstream reference, but was not able to get changes pushed to my repo.

git subtree:  Does not maintain sub-project history or allow rebase.

git slave:  Requires multiple private repos.  Appears to require the
same branch names in each sub-project.

repo: Appears to work a bit like git submodules, where pushes on the
sub-projects go to the upstream repo, not to the private repo.

Any other ways to do what I want without creating a separate forked
repo for each of the sub-projects?  Or have I misunderstood one of
these schemes?

-- 
Michael Eager	 eager@eagercon.com
1960 Park Blvd., Palo Alto, CA 94306  650-325-8077
