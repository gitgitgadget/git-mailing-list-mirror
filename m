From: Johan Herland <johan@herland.net>
Subject: Re: git pull/merge master on other branch
Date: Fri, 9 May 2008 11:06:47 +0200
Message-ID: <200805091106.47447.johan@herland.net>
References: <g00nb3$dlm$1@ger.gmane.org> <200805090824.12772.johan@herland.net> <g011ve$8ln$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: SungHyun Nam <goweol@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 11:10:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuOZr-0007pu-2d
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 11:07:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753296AbYEIJGy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 05:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbYEIJGy
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 05:06:54 -0400
Received: from sam.opera.com ([213.236.208.81]:59346 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752802AbYEIJGx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 05:06:53 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id m4996lwk016307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 9 May 2008 09:06:48 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <g011ve$8ln$1@ger.gmane.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.92.1/7076/Fri May  9 07:38:02 2008 on smtp.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81609>

On Friday 09 May 2008, SungHyun Nam wrote:
> Johan Herland wrote, at 5/9/2008 3:24 PM:
> > On Friday 09 May 2008, SungHyun Nam wrote:
> >> Hello,
> >>
> >> If I am on a branch (reguarly rebased), I don't want to switch to
> >> master branch, but merge origin into master.
> >> If I switch to master and pull and switch to branch, I have to
> >> rebuild almost of sources.
> >>
> >> How I can pull origin into master without switching to master
> >> branch?
> >
> > You can't; merging requires use of the working tree (to resolve
> > conflicts).
> >
> > However, what you can do is make a local clone of your project
> > (cheap, because it just hardlinks files from the original repo),
> > and checkout the master branch in the clone, perform the merge
> > (after having set up the same origin and retrieved its contents),
> > and then fetch (or push) the result back into the original repo
> > (remember: "fetch" instead of "pull", since the latter will
> > initiate a merge with your current branch).
>
> I tested and it seems work fine.
>
> $ mkdir repo; cd repo; git init; echo 'aaa' > a; git add .; git ci -m
> 'aaa'; cd ..
> $ git clone repo t; cd t; git co -b test; cd ..
> $ cd repo; echo 'bbb' >> a; git ci -m 'bbb' a; cd ..
> $ git clone t t2; cd t2; git remote add central ../repo; git pull
> central master; git push origin; cd ..
> $ cd t; git log; git log master; git rebase master
>
> Did I do correctly?

Looks good, AFAICS


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
