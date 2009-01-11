From: Alexander Potashev <aspotashev@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2009, #02; Sun, 11)
Date: Sun, 11 Jan 2009 15:21:28 +0300
Message-ID: <20090111122128.GA16108@myhost>
References: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 11 13:22:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLzLE-00058c-KU
	for gcvg-git-2@gmane.org; Sun, 11 Jan 2009 13:22:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbZAKMVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Jan 2009 07:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbZAKMVd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Jan 2009 07:21:33 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:35126 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZAKMVc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Jan 2009 07:21:32 -0500
Received: by fg-out-1718.google.com with SMTP id 19so3741826fgg.17
        for <git@vger.kernel.org>; Sun, 11 Jan 2009 04:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=gviXSIZEPgpRXQXz8wCQmsQgh1f4EMM5DqQQXWOizCQ=;
        b=SfnzZWOzX1RxPOTajCLg2aHRAv91B/J+jFyIHhnaoKc7MtMgleqtsLKANlPV2J+BN8
         gE4Cy5QXCmAqfaRssZ31swOl9RzXdD0+v//kVsm1h8qMk0lOVJxFWL2lcot2PsKAbRpJ
         KuLQ/wRke3Xxf+HlTLRjfv+YsZbzclHbkZF5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=rkhU/4lWL7VFLRhkXWpijvogqda0NiabyD7TemR3URc3DBbjZ1VsDnAR6qaxlWzNJv
         ixd7k37dcfJNEQxkitQymIzdTgAccd5x2dS4yfQjBb6Uy1cEaD2joTqwVdNAi6VE5MjE
         IUU0arSQ4+yalD5LD6ljX/6gfFs68FioCJo4s=
Received: by 10.86.92.4 with SMTP id p4mr16066947fgb.36.1231676490457;
        Sun, 11 Jan 2009 04:21:30 -0800 (PST)
Received: from smtp.gmail.com (ppp83-237-189-41.pppoe.mtu-net.ru [83.237.189.41])
        by mx.google.com with ESMTPS id 3sm43662077fge.57.2009.01.11.04.21.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 11 Jan 2009 04:21:30 -0800 (PST)
Received: by smtp.gmail.com (sSMTP sendmail emulation); Sun, 11 Jan 2009 15:21:28 +0300
Content-Disposition: inline
In-Reply-To: <7v63kmtbk6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105173>

On 01:51 Sun 11 Jan     , Junio C Hamano wrote:
> [New Topics]
> 
> Need to clean up the log message, perhaps rebase it to maint-1.6.0 and
> start cooking in 'next'.
> 
> * jc/maint-format-patch (Sat Jan 10 12:41:33 2009 -0800) 1 commit
>  + format-patch: show patch text for the root commit

My testcases ([PATCH] Add new testcases for format-patch root commits)
for this don't satisfy the target behaviour.

> 
> All of the above 'pu' topics are ready for 'next'.
> 
> * ap/clone-into-empty (Fri Jan 9 02:24:23 2009 +0300) 2 commits
>  - Use is_pseudo_dir_name everywhere
>  - Allow cloning to an existing empty directory

As far as I understood from your message, you don't think that cloning
into empty directories is necessary. So, I thought, the best solution for
yesterday was "[PATCH] add is_dot_or_dotdot inline function" (to make you
happy ;)).

But the workarounds like this:

|    $ git clone -n $there it.git
|    $ mv it.git/.git . && rmdir it.git && git checkout -f

are painful, especially for newbies who have no idea about anything but
'git clone'.

> 
> There is an updated patch that only refactors the repeated code to check
> if a dirent is dot or dot-dot posted, which I should have picked up to
> replace these but I haven't yet (the "clone into empty" can and should
> build on top of it).
> 


Btw, I've sent some worthwhile patches, I but haven't got any reply from you:
	[PATCH] use || instead of | in logical expressions
	[PATCH] Replace deprecated dashed git commands in usage
	[PATCH] remove unnecessary 'if'
It's better if you say "No" than nothing.
