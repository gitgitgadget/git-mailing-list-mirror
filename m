From: "Sean Kelley" <svk.sweng@gmail.com>
Subject: Re: Cherry-picking to remote branches
Date: Sat, 7 Jul 2007 08:00:25 -0500
Message-ID: <a2e879e50707070600qc89b4dey4847d7bb6d01e1e5@mail.gmail.com>
References: <a2e879e50707060709oc9fe8b3k8e594f1cb6e10437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 07 15:00:39 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I79tt-00007L-06
	for gcvg-git@gmane.org; Sat, 07 Jul 2007 15:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753657AbXGGNA1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Jul 2007 09:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753590AbXGGNA1
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jul 2007 09:00:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.181]:22452 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753138AbXGGNA0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jul 2007 09:00:26 -0400
Received: by wa-out-1112.google.com with SMTP id v27so660834wah
        for <git@vger.kernel.org>; Sat, 07 Jul 2007 06:00:25 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EEy6NKINEUgIXOjDfWqL1PvirTqfxKAlM8OxTY3HT/qZvjVt1si1sQEtPH0dBqWZY9iwPWbUJMIyak0wYmkIiKN5WweKCexxRV50XMqDFpiJP+WB8VSvW1mI98uWQdXADYS1cNPAvdyKVEAtw3LHKRn08DGE89RXlYSSHyMZncE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Khx1xBVK0B0LBXScjm9NhrDK1w0YXg3Gj/i3aGzq5lMMHLPkTMCjqz4uXAhcVqeVgsCp5W28OsTfJlATSetAq9H8TB96LPzGqyIR2Us1ZpLgAzb+4d3TDTR0tY8F9AYYLtXe2UVfthYq1+TMTMTEtWhNDFmOPtnjK3fJrBjYJFY=
Received: by 10.114.12.9 with SMTP id 9mr1527772wal.1183813225403;
        Sat, 07 Jul 2007 06:00:25 -0700 (PDT)
Received: by 10.115.73.1 with HTTP; Sat, 7 Jul 2007 06:00:25 -0700 (PDT)
In-Reply-To: <a2e879e50707060709oc9fe8b3k8e594f1cb6e10437@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51815>

On 7/6/07, Sean Kelley <svk.sweng@gmail.com> wrote:
> I have been having trouble with the following workflow.  I am trying
> to push changes to a remote from a branch that is tracking it.


Is there a better way to do this?  Basically I want to push from the
branch to the remote.  But it doesn't seem to work at least without
pushing the branch itself as a new head to the remote.  Perhaps the
better way to do it is to have two different directories:

1) clone the linux-devel.git and have a read-only remote to
linux-stable to fetch changes and cherry-pick.
2) clone the linux-stable.git and have a read-only remote to
linux-devel to fetch changes and cherry-pick

So you would just cd to the specific one you want to work with.

Sean
>
> git clone git://mysite.com/data/git/linux-devel.git linux-devel
>
> cd linux-devel
>
> git remote add -m master -f linux-stable
> git://mysite.com/data/git/linux-stable.git
>
> git branch -r
>
>   linux-stable/HEAD
>   linux-stable/master
>   origin/HEAD
>   origin/master
>
> git checkout -b stable linux-stable/master
>
> git cherry-pick  b3b1eea69a   (a commit from linux-devel)
>
> git push linux-stable
>
> error: remote 'refs/heads/master' is not a strict subset of local ref
> 'refs/heads/master'. maybe you are not up-to-date and need to pull
> first?
> error: failed to push to 'git://mysite.com/data/git/linux-stable.git'
>
> Thanks for your help,
>
>
> Sean
>
