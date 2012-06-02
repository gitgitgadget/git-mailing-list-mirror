From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: remote.branch.tagopts = --tags not updating branches
Date: Sat, 02 Jun 2012 11:54:26 +0200
Message-ID: <4FC9E2D2.5060705@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 02 12:26:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SalXO-0005x1-1r
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 12:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760074Ab2FBKZo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jun 2012 06:25:44 -0400
Received: from mail.dewire.com ([83.140.172.130]:7201 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760059Ab2FBKZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 06:25:43 -0400
X-Greylist: delayed 1861 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Jun 2012 06:25:43 EDT
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id A60038FC77
	for <git@vger.kernel.org>; Sat,  2 Jun 2012 11:54:40 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKedK9l9ZkUo for <git@vger.kernel.org>;
	Sat,  2 Jun 2012 11:54:26 +0200 (CEST)
Received: from Robin-Rosenbergs-MacBook-Pro.local (h102n2fls33o828.telia.com [213.67.12.102])
	by dewire.com (Postfix) with ESMTP id CBD838FC78
	for <git@vger.kernel.org>; Sat,  2 Jun 2012 11:54:26 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120529 Thunderbird/13.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199034>

For some reason I had tagopt set in a remote of mine. The drawback
is that it does not update any remote refs.

[remote "gerrit"]
         url = git://git.eclipse.org/gitroot/jgit/jgit
         fetch = +refs/heads/*:refs/remotes/gerrit/*
         fetch = +refs/changes/*:refs/remotes/gerrit/changes/*
         tagopt = --tags

First force a remote ref to become "old", then update it with C Git (nothing happens).
Them update for real with JGit.

$ git update-ref refs/remotes/gerrit/stable-2.0 058c74d8adcfb5ef0eed203a64b7f9ff65e87c8c
$ git fetch gerrit
$ jgit fetch gerrit
Updating references:    100% (1/1)
 From git://git.eclipse.org/gitroot/jgit/jgit
    058c74d..23b8136  stable-2.0 -> gerrit/stable-2.0

 From the docs I cannot see that Git is supposed to behave this way. The man pages
only mention the effects of this option on tags.

-- robin
