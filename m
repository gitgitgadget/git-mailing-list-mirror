From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git tree browsing in redmine
Date: Tue, 18 Nov 2008 02:06:19 -0800 (PST)
Message-ID: <m3ej19l57c.fsf@localhost.localdomain>
References: <b8f2e1780811172034w6828ddc8n62cf85b5fa366e22@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Burt Culver" <burt@fishpond.co.nz>
X-From: git-owner@vger.kernel.org Tue Nov 18 11:09:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2NVv-0007cV-TJ
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 11:08:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751061AbYKRKGX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 05:06:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbYKRKGX
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 05:06:23 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:12161 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbYKRKGW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 05:06:22 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2414989fgg.17
        for <git@vger.kernel.org>; Tue, 18 Nov 2008 02:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=/zow7kXNYoiLDn9Gfwk8YJTy9I6dWTPAZVMYe6QDORA=;
        b=UZW+0ZGn9ymNGFM7TmHYCVMjydSxNEX7MxuynoV78QR3uvJqw404dGjfK1dpnL0VeR
         zfsT7OeAcbDOjbHMSo4aaVyFW/hnCpx10m72TCNGOVPOJ2veWCBbRvopi7OylOE1P0mv
         RABYSOFGQimMMcXAKgqFjl4pNu11Jyo6xeMCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=MiwS1XRFqM51XAXaDaCwJLYXhm6654kNDekahS/o/xKKvlarDfMpaDKZbg9IKXqRIa
         E2rZcd3BD2rNMe+NuBQx2t/srC8PmILrSNjf41WBm3qTfMLXMpK/bwjydZO8Qmu29hZG
         AM6aD+tBSkNPPhN6U4vlLrFuHQ5muldNiuwnA=
Received: by 10.181.11.3 with SMTP id o3mr1258209bki.172.1227002780424;
        Tue, 18 Nov 2008 02:06:20 -0800 (PST)
Received: from localhost.localdomain (abxb103.neoplus.adsl.tpnet.pl [83.8.251.103])
        by mx.google.com with ESMTPS id z10sm1221005fka.15.2008.11.18.02.06.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 18 Nov 2008 02:06:19 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mAIA5il8020627;
	Tue, 18 Nov 2008 11:05:55 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mAIA5S7b020623;
	Tue, 18 Nov 2008 11:05:28 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <b8f2e1780811172034w6828ddc8n62cf85b5fa366e22@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101267>

"Burt Culver" <burt@fishpond.co.nz> writes:

> I'm trying to find some ideas for a better way to implement browsing
> of a git repository within the redmine application.
> 
> My top level directory in my git repository has 300 files. Redmine
> wants to display each file name, its most recent revision, and the
> comment for that revision. Currently it does a git log -1 on each file
> to find the latest revision.  Is there a quicker way of doing this for
> a whole directory?  git log runs from .2 seconds to 3 seconds
> depending on the file on my server.
> 
> Here is the open issue at redmine.org which has more details:
> http://www.redmine.org/issues/show/1435
> 
> A fix for this would help a whole bunch of redmine / git users
> including myself.

First, while it might be common and cheap view (information) for
Subversion, it is not the case for Git.  Git is whole project snapshot
based, not per-file snapshot based, or patch based.  Take a look at
one of git web interfaces: gitweb, or cgit, or ViewGit to see how
repository browsing is implemented there: it is log-like view, then
tree, not tree, then history of files.  Note also that for example
history of two files is more than union of histories of individual
files (history simplification, including merge simplification).

Second, I tried to implement such view (which I named 'tree blame'
view, because it looks a bit like blame/annotate, but for
directories/trees) for gitweb.  You can view my attempts in
'gitweb/tree_blame' branch of my git fork:

  http://repo.or.cz/w/git/jnareb-git.git?a=shortlog;h=refs/heads/gitweb/tree_blame

But I think the correct solution, if you decide that you absolutely
need so unnatural (and I think not that useful) view, would be to
implement such view in git core, allowing 'git blame' to work for
trees (directories).  You would probably need to implement also some
kind of '--porcelain' output for script/Redmine.

Or as suggested add your work to libgit2 library, and make use of it
in Redmine...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
