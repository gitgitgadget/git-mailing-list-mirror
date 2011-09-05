From: Vijay Lakshminarayanan <laksvij@gmail.com>
Subject: Re: "Your local changes ... would be overwritten" bug
Date: Tue, 06 Sep 2011 00:01:51 +0530
Message-ID: <87wrdmrgbs.fsf@gmail.com>
References: <8362l73qi6.fsf@kalahari.s2.org> <vpqty8rx774.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Hannu Koivisto <azure@iki.fi>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Sep 05 20:32:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0dxr-0005pk-IM
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 20:32:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753442Ab1IEScD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 14:32:03 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:60778 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411Ab1IESb6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 14:31:58 -0400
Received: by gya6 with SMTP id 6so3338981gya.19
        for <git@vger.kernel.org>; Mon, 05 Sep 2011 11:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=yrL7CfqdsSlqVLeGlMSTIYEkWh8KhgsLqIblKLouxNw=;
        b=Nd4ZhXozrpr/tQSASj/2tU0V5aAERGOXL0cekZ7iQnS81IiLVoCxC5lE3eM9f3Mj4u
         FubjDiKxIfb7yqa6UBQBlUPZwZ0+Ribw7rIaPVkZf1OexGRwL8uggtt7wmWU+O+Mbu6Z
         zq6L/4PMTXSG9CtHBYkANuak4aUtKQT4C09Xg=
Received: by 10.68.32.72 with SMTP id g8mr8440468pbi.181.1315247517510;
        Mon, 05 Sep 2011 11:31:57 -0700 (PDT)
Received: from BALROG ([59.92.44.5])
        by mx.google.com with ESMTPS id u10sm23765969pbr.12.2011.09.05.11.31.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Sep 2011 11:31:56 -0700 (PDT)
In-Reply-To: <vpqty8rx774.fsf@bauges.imag.fr> (Matthieu Moy's message of "Mon,
	05 Sep 2011 18:52:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (windows-nt)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180753>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Hannu Koivisto <azure@iki.fi> writes:
>
>> The following script can be used to reproduce the problem:
>
> [...]
>
> I cannot reproduce on Linux.

I can't either.

>> I'm running Cygwin git 1.7.5.1 in Windows XP.

I'm running cygwin git 1.7.5.1 in Windows Vista.

$ mkdir temp
d temp
git init
echo foo > testfile
git add testfile
git commit -m "test1"
echo foo > testfile2
chmod +x testfile2
git add testfile2
git commit -m "test2"
mkdir foo
cd foo
git co master~1

vijay@balrog ~/foo
$ cd temp

vijay@balrog ~/foo/temp
$ git init
Initialized empty Git repository in /home/vijay/foo/temp/.git/

vijay@balrog ~/foo/temp
$ echo foo > testfile

vijay@balrog ~/foo/temp
$ git add testfile

vijay@balrog ~/foo/temp
$ git commit -m "test1"
[master (root-commit) 7564449] test1
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 testfile

vijay@balrog ~/foo/temp
$ echo foo > testfile2

vijay@balrog ~/foo/temp
$ chmod +x testfile2

vijay@balrog ~/foo/temp
$ git add testfile2

vijay@balrog ~/foo/temp
$ git commit -m "test2"
[master 9675b55] test2

 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100755 testfile2

vijay@balrog ~/foo/temp
$ mkdir foo

vijay@balrog ~/foo/temp
$ cd foo

vijay@balrog ~/foo/temp/foo
$ git co master~1
git: 'co' is not a git command. See 'git --help'.

Did you mean one of these?
        commit
        clone
        log

vijay@balrog ~/foo/temp/foo
$ git checkout master~1
Note: checking out 'master~1'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b new_branch_name

HEAD is now at 7564449... test1

> Probably a dumb question (from a non-windows-user), but why not use the
> native Git for windows?

Do you mean msysgit?  As a GNU/Linux user, I probably don't need to
explain the luxuries a bash prompt gives you.  In this scenario, cygwin
is the closest approximation on Windows system.

msysgit comes with its own bash shell etc (which is good) but rather
than go that integration route, it's much simpler to have git working
within cygwin when you're already used to it.

Cheers
~vijay
