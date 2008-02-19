From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 10:19:06 -0800
Message-ID: <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
	 <20080219063937.GB3819@glandium.org>
	 <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
	 <alpine.LSU.1.00.0802191115440.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 19 19:20:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRX4R-0003cS-VT
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 19:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754583AbYBSSTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 13:19:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754472AbYBSSTL
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 13:19:11 -0500
Received: from wr-out-0506.google.com ([64.233.184.224]:47583 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbYBSSTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 13:19:09 -0500
Received: by wr-out-0506.google.com with SMTP id c48so2136612wra.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 10:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=7SgBoWJu7dz4spW2KbyqujkXAVyNPbAja4h/nvrrhHk=;
        b=IncSQ8n1t4oM3JcgYPGg/cRwpp7eGyYXBfwSC3qzDsEszrRi4wrQeQjcJD9trNK214/oI5KZ54hsQgYMFMZkXLe6Rf1R5Hl+U/PPKsHKuzBeibn7hmC1jAG/B/3HQFoLSxCHxkubI3kpMtT0RU82rY+bDGHZjh4jb5YWlRAfcxc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CR9RSHlvzGXUJ7vLKgScZ77ri8zeNISOA8uLxW8wQmi6psU5cLJClmJJtxvne7d20I6bH71I3aQwi4Mlv4e0MAk+hZ6aCR3QMpp6oFaFHAcY8yBxiuOIFEIKk+1n9wtdCsSe5beDaAXL51T5fqSiZKbh3FqkhsNo+gboa4hvYvM=
Received: by 10.114.171.1 with SMTP id t1mr3770386wae.83.1203445146517;
        Tue, 19 Feb 2008 10:19:06 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Tue, 19 Feb 2008 10:19:06 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802191115440.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74441>

> > $ git-pull
> > fatal: 'origin': unable to chdir or not a git archive
> > fatal: The remote end hung up unexpectedly
>
> Since you did not clone from anywhere, the remote "origin" is not set.
> You will have to do that yourself:
>
>         git remote add -f origin http://aeyakovenko@myserver.com/git/repo/

Thanks, that worked.  but push still gives me an error:

$ git pull
You asked me to pull without telling me which branch you
want to merge with, and 'branch.master.merge' in
your configuration file does not tell me either.  Please
name which branch you want to merge on the command line and
try again (e.g. 'git pull <repository> <refspec>').
See git-pull(1) for details on the refspec.

If you often merge with the same branch, you may want to
configure the following variables in your configuration
file:

    branch.master.remote = <nickname>
    branch.master.merge = <remote-ref>
    remote.<nickname>.url = <url>
    remote.<nickname>.fetch = <refspec>

See git-config(1) for details

>
> > $ git-clone http://aeyakovenko@myserver.com/git/repo/ foobar
> > Initialized empty Git repository in /home/aeyakovenko/projects/foobar/.git/
> > cat: /home/aeyakovenko/projects/foobar/.git/refs/remotes/origin/master:
> > No such file or directory
> > /usr/bin/git-clone: line 450: cd:
> > /home/aeyakovenko/projects/foobar/.git/refs/remotes/origin: No such
> > file or directory
> > fatal: : not a valid SHA1
> > fatal: Not a valid object name HEAD
>
> That smells like another "master"-less repository.  Why do people do that?
> Isn't it just _easier_ and more _hassle-free_ to just accept that the
> initial branch is called "master"?

what do you mean by master-less?  I would love to just be able to
create a normal git repo with "git-init" and clone it over http the
same way that i do over ssh and the filesystem.  but when I do that
over http i get this error:

$ git-clone http://aeyakovenko@myserver.com/git/repo/ repo
Initialized empty Git repository in /home/aeyakovenko/projects/repo/.git/
Cannot get remote repository information.
Perhaps git-update-server-info needs to be run there?

and running `git-update-server-info` does nothing.
