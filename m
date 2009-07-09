From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: default aliases (ci, di, st, co)
Date: Wed, 08 Jul 2009 17:13:57 -0700 (PDT)
Message-ID: <m3my7evhky.fsf@localhost.localdomain>
References: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Thu Jul 09 02:14:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOhH8-0007E9-Ry
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 02:14:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757109AbZGIAOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2009 20:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755475AbZGIAOC
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jul 2009 20:14:02 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:59378 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754661AbZGIAOA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jul 2009 20:14:00 -0400
Received: by ewy26 with SMTP id 26so2125431ewy.37
        for <git@vger.kernel.org>; Wed, 08 Jul 2009 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1kldfaT1uDJvjHQMENxlvKGlT8A7+sHtfLkMiXPYwiU=;
        b=IXe6QQbhBu3eZU/07ss71CA5Qge+3lopwMd5XnLLNYEazc3cxc7qHqyiCxbGl8WGzy
         LU2eDKt8EDeQUiWSJ9CpLnLeIZynF1sxJGKy8GbviEj+/n6lhS3gyeA7yDa+mPNYbVkT
         Y9wq5dG4oxIyIwOwxb5dSo0M7hhNYTd+6ktJg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=nYigQbu7i9OOLbzHpUrC7UecONEzCZh59TvUdyArA0l6J5zZEM/HPGxG1COrn2cEgo
         BE2ACAON7u5UYRiY7R4CQEZnmBthNd0zguymzVaZkHnIhwBOjXIEwnqe650bv2mKtvw6
         VxTxpfdqjyv30t5pegkFJMXyIZp2ZxhYdbfrk=
Received: by 10.210.91.7 with SMTP id o7mr136695ebb.54.1247098438713;
        Wed, 08 Jul 2009 17:13:58 -0700 (PDT)
Received: from localhost.localdomain (abwk32.neoplus.adsl.tpnet.pl [83.8.234.32])
        by mx.google.com with ESMTPS id 5sm1421290eyh.20.2009.07.08.17.13.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Jul 2009 17:13:57 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n690DwFN011198;
	Thu, 9 Jul 2009 02:13:58 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n690DoHP011190;
	Thu, 9 Jul 2009 02:13:50 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <85b5c3130907081649s37f726f7id1a64f2fdbe609f@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122928>

Ondrej Certik <ondrej@certik.cz> writes:

> coming to git from mercurial and svn, here is the alias part of my
> .gitconfig:
> 
> [alias]
>     ci = commit
>     di = diff --color-words
>     st = status
>     co = checkout
> 
> 
> And all is fine until I share commands to checkout my branch (for
> example) with other people, then basically I have to write those
> commands in full (e.g. commit, checkout, ...), since I cannot assume
> they have their .gitconfig setup the same way I do. Especially for
> people who are new to git.

If you have admin rights on the machine, you can do that either using
system git config file (git config --system) i.e. $(prefix)/etc/gitconfig
or rather $(sysconfdir)/gitconfig, or by providing 'config' template
(copied as default repository config on init) in some place like
/usr/share/git-core/templates/config .

> 
> What is the view on this in the git community? Do most of you write
> 
> git checkout -b branch ...
> 
> (possibly with TAB completion) or do most of you write
> 
> git co -b branch ...
> 
> (like I do all the time, except when sharing my commands with other
> people)?

I use tab completion for commands like "git commit", "git show", "git
checkout" etc. (most important part is branch completion, not command
completion IMVHO).

But I do have few aliases:

[alias]
        cat  =    cat-file -p
        less = -p cat-file -p
        alias = config --get-regexp ^alias\\.
        lg = log --pretty=oneline --abbrev-commit
        one = show -s --pretty='format:%h (%s)'
        llog = log --date=local
        who = "!sh -c 'git log -1 --pretty=\"format:%an <%ae>\" --author=\"$1\"' -"
        lb = for-each-ref --format='%(refname)' \
             --sort=-authordate --count=8 refs/heads/
        rllog = log -g --date=relative
        rlg   = reflog show @{now}
        sed = !git ls-files --stage | grep ^100 | awk '{print $4}' | xargs sed

I use most often "git one" aliase (hmmm... I have just noticed that
"git lg" alias is now superfluous with new '--oneline' option).

> Could in principle those aliases be even made default by git? Or is
> this not a good idea.

The "default/built-in aliases" idea was discussed on git mailing list
a few times in the past...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
