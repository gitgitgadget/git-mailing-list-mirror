From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: move git repository out of a folder?
Date: Wed, 04 Jun 2008 13:14:42 -0700 (PDT)
Message-ID: <m31w3dyn2n.fsf@localhost.localdomain>
References: <1086fb5f0806041303v7856404dxb95b5a450ac30ae1@mail.gmail.com>
	<20080604200724.GV12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sean Brown <seanmichaelbrown@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:15:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zOW-0006sx-37
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756348AbYFDUOr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:14:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755557AbYFDUOq
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:14:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:31270 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754159AbYFDUOp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:14:45 -0400
Received: by fg-out-1718.google.com with SMTP id 19so140882fgg.17
        for <git@vger.kernel.org>; Wed, 04 Jun 2008 13:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=Hf3awHRvxLYlat2I36kU1o9lpwILB5bIYsQ99wq7pOE=;
        b=au7AHNB+6bh6NSl+TSCJdWETsmYdfBkwcB1nWHhoxD5gIwuUtxEaYmY4vJWgiDpG74
         ilAZp/lmfs/kRIXwds/6rlvwM5lzWWUCm9YdCGhttcVXaIqzbxRuLpUm5u/g0A49UVh3
         eA7h3C4CUBOJ00QehrdrbZAO5RiHgovQwpjwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=q1aKwVc08Nl2nhDWiPz1PgWFY4XkCguuSuKD4FBQrA6JEEXu2rbQ6M/BwWjTScOR4e
         fji7WxU3OlLBNekZLftWK5jeVDBNSjIbwlaXXJEwP0qplD9w5X8PLu0rI1AmOG8LIHoX
         pbVuL1u5C3QrTFAI/UndxA78Pc3SSvz1eHyNA=
Received: by 10.86.70.8 with SMTP id s8mr752557fga.31.1212610483581;
        Wed, 04 Jun 2008 13:14:43 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.210.131])
        by mx.google.com with ESMTPS id d6sm2267039fga.2.2008.06.04.13.14.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Jun 2008 13:14:42 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m54KEgDk013513;
	Wed, 4 Jun 2008 22:14:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m54KEehg013510;
	Wed, 4 Jun 2008 22:14:40 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080604200724.GV12896@spearce.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83824>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Sean Brown <seanmichaelbrown@gmail.com> wrote:
> >
> > Let's say I've got this directory structure of source files:
> > 
> > /folderA
> > /folderA/sourcecode/
> > /folderA/sourcecode/file1.txt
> > /folderA/sourcecode/file2.txt
> > etc...
> > 
> > When putting the project under git source control, I did this:
> > 
> > cd /folderA
> > git init
> > 
> > So now when colleagues clone my repository, they get the source code
> > in the "sourcecode" folder.  I'd like to just make the repository
> > simply give them the source files, not in a directory.  In other
> > words, as if I had originally been smart and done this:
> > 
> > cd /folderA/sourcecode
> > git init
> > 
> > Can I make that happen without losing all of the history?
> 
> git mv sourcecode/* .
> rmdir sourcecode
> git commit

What he said.  Git should automatically detect renames.  When pulling
code from someone who hasn't made this change yet, you might need to
use 'subtree' merge strategy, as currently git would put files added
as sourcecode/filename in sourcecode/filename, not as top dir filename
when pulling from side branch.

If you want to _change history_, as if you made correct decision at
the start (and convince everyone to reclone, or to do the same
surgery; or if you for the time being are solo contributor to the
project), you can use git-filter-branch (formerly cg-admin-rewrite-hist ;-).

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
