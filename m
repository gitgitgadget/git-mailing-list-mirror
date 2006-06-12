From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: svn to git, N-squared?
Date: Mon, 12 Jun 2006 12:22:38 -0400
Message-ID: <9e4733910606120922g181a5aaal623fd3f29b839f4c@mail.gmail.com>
References: <20060612043949.20992.qmail@science.horizon.com>
	 <9e4733910606120832xaf74e77pad7f70df864541fc@mail.gmail.com>
	 <Pine.LNX.4.64.0606120843340.5498@g5.osdl.org>
	 <9e4733910606120855p1cec9acfy62dadb89c11756b4@mail.gmail.com>
	 <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux@horizon.com" <linux@horizon.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 12 18:22:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FppBb-0006Qz-1H
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 18:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbWFLQWk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 12:22:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbWFLQWk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 12:22:40 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:47231 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751278AbWFLQWj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 12:22:39 -0400
Received: by nz-out-0102.google.com with SMTP id s18so1670732nze
        for <git@vger.kernel.org>; Mon, 12 Jun 2006 09:22:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=B7q3hBGEoaG4BaGeskm9wZjW9CeogVj7YP014DQcVmUW5TD0/i9rmFH+CVVHINYMdzauK9YcBuA55Is9TtzJeey1+pzLNZLGjNj4+r+Q1eKLSRXEO71hPWUtqpHaQ0u/LuE8DlVe7d7xRXSbHFugzad26MatPXkbKArZloCwb7k=
Received: by 10.37.2.45 with SMTP id e45mr9020153nzi;
        Mon, 12 Jun 2006 09:22:38 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Mon, 12 Jun 2006 09:22:38 -0700 (PDT)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606120906210.5498@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21712>

On 6/12/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 12 Jun 2006, Jon Smirl wrote:
> >
> >  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
> > 14525 jonsmirl  16   0  604m 391m 1904 S   24 38.7 916:53.39 git-svnimport
> > 20947 jonsmirl  17   0     0    0    0 R    1  0.0   0:00.03 git-svnimport
>
> Hard to tell, it's obviously got short-lived processes there too that it's
> not showing, but equally obviously that svnimport script itself is
> spending an alarming amount of CPU time. I don't think it should do that
> much processing, but since it's written in perl, I can't read it.
>
> Are there any other directories that seem to be growing (eg some temp-file
> directory where the old files aren't cleaned away?). I can't imagine what
> else it could be doing in kernel space than simply some silly filesystem
> operation, but dang it all, Linux filesystems are usually very efficient
> indeed, unless we're talking huge directories (and if it's not the git
> object directory any more, it must be something else).

64 files in tmp.
But the SVN repository itself has 411,000 files in it. Split between
two directories.

Is there some pack equivalent for svn that I haven't found yet?

> At least with the cvs importer I have _some_ clue what it's doing, since I
> wrote an earlier version myself (very different, but at least I know what
> the operations are). SVN has always just confused me, and I have no idea
> what svnimport does, so I think I'll have to defer to somebody who
> actually knows the code.
>
> Smurf, have you looked at any larger repositories?
>
>                 Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
