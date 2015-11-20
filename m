From: Peter van der Does <peter@avirtualhome.com>
Subject: git fetch with fetch.prune set bug?
Date: Fri, 20 Nov 2015 10:19:22 -0500
Message-ID: <564F39FA.2030107@avirtualhome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 20 16:39:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zznll-0002B5-CX
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 16:38:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760512AbbKTPid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2015 10:38:33 -0500
Received: from zandvoort.avirtualhome.com ([96.126.105.64]:42898 "EHLO
	mail.avirtualhome.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759785AbbKTPic (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 10:38:32 -0500
X-Greylist: delayed 1147 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Nov 2015 10:38:32 EST
Received: from [192.168.1.106] (c-69-248-80-32.hsd1.nj.comcast.net [69.248.80.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.avirtualhome.com (Postfix) with ESMTPSA id 3F32217649
	for <git@vger.kernel.org>; Fri, 20 Nov 2015 10:19:22 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.9.1 mail.avirtualhome.com 3F32217649
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=avirtualhome.com;
	s=mail; t=1448032763;
	bh=GYNK+UVROEZKByDhUkyqmhGUCOz8l7O6VujoBMw46pQ=;
	h=To:From:Subject:Date:From;
	b=HdJkSNkq+4cW5Y0GNnNZsVKqCHXZyE3Mt81qrDQGfUUlbZRyDlKSqxaVVON6UWrvJ
	 YgCaCMKVg1o+E12BwUeXqIlKVQ6Y9/xKnD7r+5nx9biPZqyMq8Qfjqy41FwzFofDJE
	 qzjk5Zu6hRPXCvoAJEaDv9wH9GqbW+ob36CXQXUQ=
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:44.0) Gecko/20100101
 Thunderbird/44.0a2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281526>

Hi,

Doing the following commands:
$ git config fetch.prune true
$ git co -b bug/bug-1
Switched to a new branch 'bug/bug-1'
$ touch bugfix
$ git add .
$ git commit -a
$ git push --set-upstream origin bug/bug-1
Counting objects: 2, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (2/2), 242 bytes | 0 bytes/s, done.
Total 2 (delta 1), reused 0 (delta 0)
To git@github.com:petervanderdoes/Testing.git
 * [new branch]      bug/bug-1 -> bug/bug-1
Branch bug/bug-1 set up to track remote branch bug/bug-1 from origin.
$ git fetch origin bug/bug-1:refs/remotes/origin/bug/bug-1
From github.com:petervanderdoes/Testing
 x [deleted]         (none)     -> origin/bug/bug-1
$ git branch -r
  origin/master
$ git branch
* bug/bug-1
  master

The branch still exists on the remote repository.
Is it correct that the git fetch deletes the remote reference?


Peter


-- 
Peter van der Does

GPG key: CB317D6E

Site: http://avirtualhome.com
GitHub: https://github.com/petervanderdoes
Twitter: @petervanderdoes
