From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to omit/alter the sigend-off line in a patch set?
Date: Mon, 16 Jun 2008 04:26:52 -0700 (PDT)
Message-ID: <m33andpqmi.fsf@localhost.localdomain>
References: <d0383f90806160324j3f1b2a09tbb4caa1e934c7635@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Ian Brown" <ianbrn@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 13:28:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Csa-0003qm-Op
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 13:28:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbYFPL1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 07:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbYFPL1J
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 07:27:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:44057 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751798AbYFPL1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 07:27:07 -0400
Received: by ug-out-1314.google.com with SMTP id h2so358538ugf.16
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=g94j5XDKsDptyJKdZKc9fKJgUr4HHt7gPHJCXwz4i1M=;
        b=D7GNN1pGV168BWZSAFKl5KUTzACHumJl+74VVe/uPr0b3auPuLqsZedgt1himUsfKp
         uu2ay2mpCJHfS2MvPnIdcB1Qk8WX4UwIGc6AOl2eECXsXT4PUTF9exHe7PW8GkxuuIJZ
         tY+zDzBHNeHNsW/7+/vjzIt29Qwdp4MAY6e2I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Cr5P5Lw6D9vfRvQH1bkpwMh2IeP0uK8bFoFhjaQAEoDUytdtYnQKkHYw5574t9jykV
         qzgRWahWK6AfGpl/Arz/Hp/4SeQCl7PtfjjgxADhWNFS5+gXMAOWSjlf1w1KrC0c91Y7
         w2/lqBuPeOWtSjb+u2Leo8nZumCM1zXQq0B7s=
Received: by 10.210.19.4 with SMTP id 4mr5996298ebs.58.1213615624691;
        Mon, 16 Jun 2008 04:27:04 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.236.117])
        by mx.google.com with ESMTPS id z34sm8425121ikz.9.2008.06.16.04.26.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 04:26:52 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5GBQmXv021916;
	Mon, 16 Jun 2008 13:26:49 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5GBQk6c021912;
	Mon, 16 Jun 2008 13:26:46 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <d0383f90806160324j3f1b2a09tbb4caa1e934c7635@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85179>

"Ian Brown" <ianbrn@gmail.com> writes:

> I am creating a patch set in this way:
>
> I make a change in one file, than commit it. (git commit file1)
> Then I make a change in a second file, than commit it. (git commit
> file1) and so on.

So you don't add Signed-off-by to yout commit.  If you plan on sharing
your work not only by sending patches, but by publishing your
repository somwehere, it would be better to signoff your commit, so
S-o-b is in "history", not only in mailing list archive...

This can be done by using '-s' option to git-commit, i.e.
  $ git commit -s file1
or by adding signoff to your commit template, if you use it.

By the way, usually one uses either
  $ git add file1; git commit
or
  $ git commit -a
(optionally with signoff).

> Then I create a patch set thus:
> 
> git-format-patch -M -s -n -o patchdir origin

Adding '-s | --signoff' option is what creates Signed-off-by line.

> And a number of patch files are created, according to the number of
> commits I had made.
> 
> 
> Now, in each created patch file there is a line saying:
> Signed-off-by: root <root@hostName.(none)>
> 
> 
> Which is caused as I am doing this patches as root, and the machine
> name is hostName (and the domain name is none).

WHY do you work as ROOT?

> Now, is there a way to cause git-format-patch to omit this
> Signed-off-by: root <root@hostName.(none)> line ?

Simply do not add '-s' option to git-format-patch, and if signoff line
was not present in commit, it wouldn't be present in patch.

> Or, altetnatively, is there a way to cause the git-format-patch to
> generate a different signed off by line (like signed off by
> ianbrn@gmail.com)?

You can configure git, either in repository config (.git/config),
or in your user config (~/.gitconfig) by adding the following

-- cut starts here --
[user]
	name  = Ian Brown
	email = ianbrn@gmail.com
-- cut ends here --

You can use git-config to set those config variables, but I think
editing simple ini-like text file is simpler.  But if you prefer,
there is scriptable solution:

  $ git config --global user.name "Ian Brown"
  $ git config --global user.email ianbrn@gmail.com

> I had tried using the --signoff option for git-format-patch, in
> these two ways, but got an error:
> 
> git-format-patch --signoff=ianbrn@gmail.com -M -n -o patchdir origin
> fatal: unrecognized argument: --signoff=ianbrn@gmail.com

According to git-format-patch(1) manpage the --signoff option does not
accept any parameters.  It always uses committer identity of yourself.

> I also tried to use the -a flag for commit
>   $ git-commit -a ianbrn@gmail.com
> but again it did not help either.

Please, please read the documentation.  git-commit -a has _nothing_ to
do with signoff...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
