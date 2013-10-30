From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: git svn already set =?utf-8?Q?=E2=80=A6?= wanted to set to:
Date: Wed, 30 Oct 2013 16:06:49 +0100
Message-ID: <87ppqmg5me.fsf@linux-k42r.v.cablecom.net>
References: <1771383029875@web26g.yandex.ru>
	<87iowgiloj.fsf@linux-k42r.v.cablecom.net>
	<87941383056091@web26h.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: DimanNe <dimanne@ya.ru>
X-From: git-owner@vger.kernel.org Wed Oct 30 16:07:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbXMN-00015s-FX
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 16:07:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093Ab3J3PG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 11:06:59 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:59465 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753224Ab3J3PG6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 11:06:58 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id AA2C24D6516;
	Wed, 30 Oct 2013 16:06:57 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id gkCmyCQzmw-C; Wed, 30 Oct 2013 16:06:51 +0100 (CET)
Received: from linux-k42r.v.cablecom.net.thomasrast.ch (unknown [213.55.176.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 196094D6414;
	Wed, 30 Oct 2013 16:06:51 +0100 (CET)
In-Reply-To: <87941383056091@web26h.yandex.ru> (dimanne@ya.ru's message of
	"Tue, 29 Oct 2013 18:14:51 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237022>

DimanNe <dimanne@ya.ru> writes:

>> What does your config look like now?
>
> [core]
>         repositoryformatversion = 0
>         filemode = true
>         bare = false
>         logallrefupdates = true
>
> [svn-remote "svn"]
>         url = https://some_host/trunk/
>         fetch = :refs/remotes/git-svn
>
> [merge]
>         renameLimit = 50000
>
> [svn-remote "stable-2012-09-13"]
>         url = https://some_host/branches/stable-2012-09-13/
>         fetch = :refs/remotes/stable-2012-09-13

Sounds like you should instead have only a single remote, along the
lines of:

[svn-remote "svn"]
        url = https://some_host/
        fetch = trunk:refs/remotes/git-svn
        fetch = branches/stable-2012-09-13:refs/remotes/stable-2012-09-13

or possibly, instead of manually listing the branches you want,

        branches = branches/*:refs/remotes/svn/*

-- 
Thomas Rast
tr@thomasrast.ch
