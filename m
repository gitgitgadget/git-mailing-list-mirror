From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Fatal error running status in new repo
Date: Mon, 15 Feb 2010 20:19:45 -0800
Message-ID: <20100216041945.GB10296@vfb-9.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 05:25:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhF05-0002hY-0b
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 05:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604Ab0BPEZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 23:25:18 -0500
Received: from mail-px0-f173.google.com ([209.85.216.173]:58726 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932589Ab0BPEZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 23:25:17 -0500
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Feb 2010 23:25:17 EST
Received: by pxi3 with SMTP id 3so2305389pxi.28
        for <git@vger.kernel.org>; Mon, 15 Feb 2010 20:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=+BrzE8rlyGoJL9FcfdITZsK+vaW1reXsf+frDcRmeh8=;
        b=K+ji14Wyp3nqK1i9XukADlLNzL0cyRXz7MsbNcldNjDXczg4387QOubu2bAoNafnQ/
         XbWFu+yj+UR7Otc6XxkR/anltoHDZGbQnQRlIgxtSY+IF0CO3NGEjweWWUflRbaCT8mu
         F9Xo/Bg8evFrfZmUknjERlOb+KTZ4DHPP82og=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=XhGWQUF2KZ7Kj8QmDUSaXK4G8NXxyS8hx08gtZuuuWqwexhUTIqhzXGvMhMf3x+iuW
         XEmwTtUANJ1jUvujSMc6zSSAi5py5qKSTs9zucJR/egsrG13wOAZSyHWRzOTvqh2mO2T
         r8krfpg/LaoJiGeMGIfGWPm+9mKxj2/a/LD6c=
Received: by 10.141.89.6 with SMTP id r6mr4036924rvl.52.1266293988363;
        Mon, 15 Feb 2010 20:19:48 -0800 (PST)
Received: from vfb-9.home ([96.225.220.117])
        by mx.google.com with ESMTPS id 22sm6416934pzk.13.2010.02.15.20.19.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Feb 2010 20:19:47 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140066>

I just noticed this when creating a new repo for a project.


$ mkdir tmp
$ cd tmp
$ git init
Initialized empty shared Git repository in /home/jhe/projects/tmp/.git/
$ git status
# On branch master
#
# Initial commit
#
warning: ignoring dangling symref HEAD.
fatal: bad revision 'HEAD'
nothing to commit (create/copy files and use "git add" to track)
$ echo $?
0
$ git --version
git version 1.7.0


Seems a bit silly that "git status" should be issuing warnings, and
fatal errors (especially when the exit code is still 0), when run before
the first commit has been created in a brand new repository.

The warnings make sense if you know what's going on behind the scenes,
but seem like the kind of thing that could scare someone new to git when
they haven't actually done anything wrong at this point.

-- 
Jacob Helwig
