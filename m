From: Michael Ludwig <michael.ludwig@xing.com>
Subject: Re: git status showing phantom modifications
Date: Tue, 26 Jan 2010 10:14:31 +0100
Message-ID: <59B5C4C4-6E95-4BAA-9351-B88B6309E022@xing.com>
References: <9B3C1167-7667-4B1F-BEE5-F47FE89F8692@xing.com>
 <be6fef0d1001250303p2c12381ao7d3a8a1d48eebb56@mail.gmail.com>
 <4017EB11-4B29-4599-B19A-91BC39632BBF@xing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 26 10:14:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZhVO-0007Oq-Lg
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 10:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039Ab0AZJOe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 04:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009Ab0AZJOd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 04:14:33 -0500
Received: from mail43-3.xing.com ([62.96.140.163]:56534 "EHLO
	mail43-3.xing.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971Ab0AZJOc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 04:14:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail43-3.xing.com (Postfix) with ESMTP id 7846D30007B96
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 10:14:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xing.com; h=
	mime-version:content-transfer-encoding:content-type
	:content-language:accept-language:in-reply-to:references
	:message-id:subject:date:from:received:received:received:
	x-virus-scanned; s=main; t=1264497270; bh=C16j3aVg+JHQ9xyVIgTXOr
	7UYvkWaBNyobQeBEmtxwE=; b=IYws4Gflxn0jncRxlhGBiPWwzD28c12kPJ1DUC
	Ui3O/LqzSFpfMP+nc9o6plIO5wVMCOqOSYv2B7eilIQNMEjhGev713y6Ds7gTKN6
	IRixKXRhuatR6SbdRRl7BI2bq8v9pzXX1TRyLihF9vtoR3HdiotbaZkwZsEP2Elt
	FAP0A=
X-Virus-Scanned: Debian amavisd-new at obc-mail43-3.rz.xing.com
Received: from mail43-3.xing.com ([127.0.0.1])
	by localhost (obc-mail43-3.rz.xing.com [127.0.0.1]) (amavisd-new, port 10030)
	with ESMTP id SxQq0Deh7wU8 for <git@vger.kernel.org>;
	Tue, 26 Jan 2010 10:14:30 +0100 (CET)
Received: from luftpostix.xing.hh (unknown [172.20.1.5])
	(using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail43-3.xing.com (Postfix) with ESMTPS id 60BDA30000781
	for <git@vger.kernel.org>; Tue, 26 Jan 2010 10:14:29 +0100 (CET)
Received: from luftpostix.xing.hh ([172.20.1.5]) by luftpostix.xing.hh
 ([172.20.1.5]) with mapi; Tue, 26 Jan 2010 10:14:29 +0100
Thread-Topic: git status showing phantom modifications
Thread-Index: AcqeZ/Z3lMhE4ux+SOmIyssItKs3lw==
In-Reply-To: <4017EB11-4B29-4599-B19A-91BC39632BBF@xing.com>
Accept-Language: de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138025>

Am 25.01.2010 um 12:43 schrieb Michael Ludwig:

> Reading up about core.fileMode in git-config(1), I think you've pointed
> me to the solution. I should probably just set it to false. If that doesn't
> solve the issue, I'll report back.

Back with more info:

git version 1.6.4.2

Before adding any core.filemode setting to ~/.gitconfig or .git/config:

michael@wladimir:/cygdrive/m/REPOS6.TECH.git/comp :-) git config -l
user.name=Michael Ludwig
user.email=...
core.repositoryformatversion=0
core.filemode=true                      <= filemode already present
core.bare=false
core.logallrefupdates=true
core.ignorecase=true
core.autocrlf=false
svn-remote.svn.ignore-paths=^(some|paths)
svn-remote.svn.url=svn://localhost
svn-remote.svn.fetch=:refs/remotes/git-svn
svn.authorsfile=authors.txt

My git status output after cd to subdir shows many files "modified". But
they aren't! Edited ~/.gitconfig to include core.filemode = true [sic].
Here's the diff for the git config output:

--- /home/michael/a     2010-01-25 20:36:53.140625000 +0100
+++ /home/michael/b     2010-01-25 20:37:01.421875000 +0100
@@ -4,6 +4,7 @@
alias.ci=checkin
alias.co=checkout
alias.br=branch
+core.filemode=true
core.repositoryformatversion=0
core.filemode=true
core.bare=false

We're seeing core.filemode appear *twice*. Why that?

michael@wladimir:/cygdrive/m/REPOS6.TECH.git/comp :-) git st
# On branch master
nothing to commit (working directory clean)

So it seems adding core.filemode = true has fixed the issue, or at least
covered the symptoms. Adding core.filemode = false did not cause the
phantom modifications to disappear. Note that from reading git-config(1),
I had rather assumed this latter setting to have the desired effect.

And something seems to be wrong here. Why are modifications flagged when
doing git status from a subdir but not from the topdir?

-- 
Michael.Ludwig (#) XING.com
