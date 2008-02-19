From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: cant get git to work over http
Date: Mon, 18 Feb 2008 23:09:39 -0800
Message-ID: <e26d18e40802182309l693b2099wb42573aca7348091@mail.gmail.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
	 <20080219063937.GB3819@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Mike Hommey" <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:10:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRMcL-0007sI-JD
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:10:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754733AbYBSHJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755009AbYBSHJl
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:09:41 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:54491 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754345AbYBSHJk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:09:40 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3281323wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 23:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Iz6LwW6y/xdHACvZb3uPHIh5f1OfjSWvKzrwZ2FkEOE=;
        b=NsTvdefwM0WTMBAwxrUv+rdyNtQSnNzQY35qyGh39jfDeGolcCiCo7WMBAJnmyT+Bgc4Btlp6DyE+F7rUIvM7nOARFZqaqiguPQArWqX4Qjg3YBI61zHF2xXBq7aEN1ckDy7vtOiEas44YfPtBgr4JJhGhAIy29N9B3StuAHRr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=vvnNlUANDtZ5U5eS41lNYjeQomp7mGeod3tlViBEBLxEWE+X4ZoDLNkl/TtWdr+zDgly9gZJIJ3u/GQm319oKDL0o9wpcd98DZG3ImH66ugFwpbuPq1jP0tFJcYGNs+54ldhR1IR8vlJyiUdbpKimsvSld6wF5TzcoH7Q4X5LcM=
Received: by 10.114.137.2 with SMTP id k2mr1799586wad.104.1203404979717;
        Mon, 18 Feb 2008 23:09:39 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Mon, 18 Feb 2008 23:09:39 -0800 (PST)
In-Reply-To: <20080219063937.GB3819@glandium.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74380>

> > *.*.*.*- foobar [18/Feb/2008:16:40:12 -0800] "PROPFIND /git/repo
> > HTTP/1.1" 301 320
>
> Try adding a / at the end of the url you use for your repo.

ah cool, that was it.  The initial push seems to have worked,

$ git push -v upload master
Pushing to http://aeyakovenko@myserver.com/git/repo/
Getting pack list
Fetching remote heads...
  refs/
  refs/tags/
  refs/heads/
'refs/heads/master': up-to-date


but i cant clone or just normally push and pull the repo.

$ git-pull
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

and

$ git-clone http://aeyakovenko@myserver.com/git/repo/ foobar
Initialized empty Git repository in /home/aeyakovenko/projects/foobar/.git/
cat: /home/aeyakovenko/projects/foobar/.git/refs/remotes/origin/master:
No such file or directory
/usr/bin/git-clone: line 450: cd:
/home/aeyakovenko/projects/foobar/.git/refs/remotes/origin: No such
file or directory
fatal: : not a valid SHA1
fatal: Not a valid object name HEAD
