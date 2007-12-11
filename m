From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 12:14:56 -0800 (PST)
Message-ID: <m3bq8xrntc.fsf@roke.D-201>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	<alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	<74ED838F-4966-42A9-BC8A-906FD0B4B46F@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Berlin <dberlin@dberlin.org>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:15:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2BVi-0000Dm-Cz
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbXLKUPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752657AbXLKUPB
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:15:01 -0500
Received: from mu-out-0910.google.com ([209.85.134.186]:20132 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752395AbXLKUPA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:15:00 -0500
Received: by mu-out-0910.google.com with SMTP id i10so3336081mue
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 12:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=L9jxrhBqoI/dnFPhlT4hk58xXyhPhuETmZ35fJ15X6c=;
        b=tblADkleTk1N6uggZYCFthRczBOsI6f6lciBvU+DT39RJ8F/0DIL5kGC8b2meOZxUWwZkbHst0r2FrjuSZhm4liWjNiwVtEZdzPIfKlopbZu5Qxae7F1Vdlj0JW4HeR7TmFzYzfInqUGeMI5km7Sr7X2biWEEHD3Ccxh2kEs2Go=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=iXA6Q/qHnrHRRFz0kbxSOUROjn8l+WKe995RJz44P9q6didfo9KWFP/B6ObO3+K4u3UKZcN7ge1eWARQZRNRMhEbKNLNtjkJfEwwPVdWC8Fs6bsM/scohcqc/X/ZS/0cR+sgDZk79A5iuxgQYBr+LgsfD+g0lA+aWks4OglhNFE=
Received: by 10.82.148.7 with SMTP id v7mr13234114bud.1197404098537;
        Tue, 11 Dec 2007 12:14:58 -0800 (PST)
Received: from roke.D-201 ( [83.8.252.236])
        by mx.google.com with ESMTPS id e11sm3452972fga.2007.12.11.12.14.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Dec 2007 12:14:56 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lBBKEmWb012213;
	Tue, 11 Dec 2007 21:14:51 +0100
Received: (from jnareb@localhost)
	by roke (8.13.4/8.13.4/Submit) id lBBKEdxO012203;
	Tue, 11 Dec 2007 21:14:39 +0100
X-Authentication-Warning: roke: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <74ED838F-4966-42A9-BC8A-906FD0B4B46F@midwinter.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67930>

Steven Grimm <koreth@midwinter.com> writes:
> On Dec 11, 2007, at 10:40 AM, Linus Torvalds wrote:

> > To git, "git annotate" is just about the *last* thing you ever want
> > to do.
> > It's not a common operation, it's a "last resort" operation. In git,
> > the
> > whole workflow is designed for "git log -p <pathnamepattern>" rather
> > than
> > annotate/blame.
> 
> My use of "git blame" is perhaps not typical, but I use it fairly
> often when I'm looking at a part of my company's code base that I'm
> not terribly familiar with. I've found it's the fastest way to figure
> out who to go ask about a particular block of code that I think is
> responsible for a bug, or more commonly, who to ask to review a change
> I'm making.
> 
> "git log" is too coarse-grained to be useful for that purpose; it
> usually doesn't tell me which of the 500 revisions to the file I'm
> looking at introduced the actual line of code I want to change.

There is always "pickaxe" search, i.e. 
  $ git log -p -S'<string>' -- <file or pathspec>
which can be used instead of blame (perhaps with --follow).

And you can limit blame to the interesting region of file, and to
interesting (important) range of revisions.


[about blame cache]

"git gui blame" uses incremental blame; if only it accepted range
(file fragment) limiting, and if "reblame" (blame --reference=<rev>,
blaming incrementally only lines which changed wrt. given revision)
was implemented.

BTW. qgit actually does blame using it's own "multiple files bottom-up
blame" code (it would be nice to have it in core-git if possible,
hint, hint), and does some caching, although I'm not sure if blame
info also. You should try it, I think.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
