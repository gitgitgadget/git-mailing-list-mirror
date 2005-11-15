From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH] GIT commit statistics.
Date: Tue, 15 Nov 2005 10:04:32 +0000
Message-ID: <b0943d9e0511150204h25417993l@mail.gmail.com>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	 <20051107225807.GA10937@c165.ib.student.liu.se>
	 <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	 <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	 <43758D21.3060107@michonline.com>
	 <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
	 <46a038f90511120419v70166c60t93d58b7544e03e3b@mail.gmail.com>
	 <20051112125331.GB30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <junkio@cox.net>,
	Ryan Anderson <ryan@michonline.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 11:06:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ebxg4-0006GI-A1
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 11:04:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVKOKEd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 05:04:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbVKOKEd
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 05:04:33 -0500
Received: from xproxy.gmail.com ([66.249.82.207]:39020 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932336AbVKOKEc convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 05:04:32 -0500
Received: by xproxy.gmail.com with SMTP id i30so1376600wxd
        for <git@vger.kernel.org>; Tue, 15 Nov 2005 02:04:32 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g/4VD7zqIlnbCnfRXqlRkN/uTehLnRftGi9vB8lG9+/79+xlwrZ9m85QG10NigTZuzHvyDRnirjfInx45f1LHWJnrcahekDK27eUqLfXJX3M0eYnL8t6fsJIsWMEipiZCGtvCfV5s2LecC6kYYV1PRGCshR43ySviMS/2xjFT5U=
Received: by 10.70.54.2 with SMTP id c2mr2581390wxa;
        Tue, 15 Nov 2005 02:04:32 -0800 (PST)
Received: by 10.70.27.12 with HTTP; Tue, 15 Nov 2005 02:04:32 -0800 (PST)
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051112125331.GB30496@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11892>

On 12/11/05, Petr Baudis <pasky@suse.cz> wrote:
> On the same note, I would like StGIT to drop functionality not really
> belonging to patch stack manager (stg add, stg rm, stg status, ...) so
> that its commandset gets smaller and more focused

This was the case with the first StGIT implementations but I slowly
began to want to only use StGIT and not switch to something else for
trivial SCM operations. I eventually added 'stg commit' which stores
the patches permanently into the base of the stack to enable some kind
of maintainer mode for StGIT. My main use for this was to import
patches directly into the main branch and not keep a separate one and
pull between them.

> - but before I would
> suggest dropping stg status, cg-status must be able to do conflicts
> tracking, so I will dedicate another mail to this sometime in the
> future, with a more detailed proposal.

The gitmergeonefile.py script in StGIT adds every conflict to the
.git/conflicts file which is read by 'stg status'. My goal is not to
leave any unmerged entried in the index even if there are conflicts.
Maybe this could be changed and .git/conflicts file avoided entirely.

Anyway, while I'll try not to add more SCM functionality to StGIT, I
don't think I should remove the existing add/rm/status functionality.
It's just handy not to use a different command when you want a new
file added to a patch.

--
Catalin
