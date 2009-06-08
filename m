From: Andreas Ericsson <exon@op5.com>
Subject: Re: Merge into locally modified files?
Date: Tue, 09 Jun 2009 01:10:02 +0200
Message-ID: <4A2D9A4A.60804@op5.com>
References: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Tue Jun 09 01:10:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDnyn-0004xJ-E7
	for gcvg-git-2@gmane.org; Tue, 09 Jun 2009 01:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755514AbZFHXKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 19:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbZFHXKD
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 19:10:03 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57188 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753736AbZFHXKB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Jun 2009 19:10:01 -0400
Received: from source ([209.85.219.213]) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSi2aSM6WaRjxGrMMxZyTJVQApYR8DgXD@postini.com; Mon, 08 Jun 2009 16:10:04 PDT
Received: by ewy9 with SMTP id 9so315911ewy.45
        for <git@vger.kernel.org>; Mon, 08 Jun 2009 16:10:00 -0700 (PDT)
Received: by 10.210.36.8 with SMTP id j8mr1603598ebj.40.1244502600294;
        Mon, 08 Jun 2009 16:10:00 -0700 (PDT)
Received: from ?192.168.25.19? (90-227-179-205-no128.tbcn.telia.com [90.227.179.205])
        by mx.google.com with ESMTPS id 10sm956929eyz.21.2009.06.08.16.09.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Jun 2009 16:09:59 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121128>

skillzero@gmail.com wrote:
> If I have some local changes to a file that I don't want to commit
> (e.g. temp debug changes like printf's) and I see somebody else has
> pushed some changes to that file, how do I merge their changes to the
> file while trying to preserve my local changes (and conflicting if
> it's not possible)?
> 
> After a git fetch, I tried 'git checkout --merge origin/master <path
> to my locally modified file>', but that just overwrote my local
> changes.
> 
> I'm converting people from CVS to git and this is a common thing
> people do with CVS. They have some local changes and see that the
> server has some other changes so they do 'cvs up' and it tries to
> merge changes from the server into the locally modified file. The
> local changes are often things that will never be committed. I know
> git tries to avoid things you can't undo, but like a 'git checkout
> <file>' that can't be undone, is there a way to say "merge what you
> can and generate conflict markers for things you can't?".
> 
> I think what I want to do is the equivalent of rebasing for local
> modified files rather than committed files.


git stash && git pull && git stash pop

should do roughly what you want.

/Andreas
