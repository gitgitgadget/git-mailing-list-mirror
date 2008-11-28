From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Removing part of the history
Date: Fri, 28 Nov 2008 14:38:22 -0800 (PST)
Message-ID: <m3fxlbjx41.fsf@localhost.localdomain>
References: <49306150.6010701@datacom.ind.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br>
X-From: git-owner@vger.kernel.org Fri Nov 28 23:39:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Bzy-0007Tk-MM
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 23:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752720AbYK1Wi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 17:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbYK1Wi0
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 17:38:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:37877 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752642AbYK1WiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 17:38:25 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2098579ugf.37
        for <git@vger.kernel.org>; Fri, 28 Nov 2008 14:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=WbFlbOBMrn+P2PbNe6equP0iRg/LBB5jW9hAvbHwi+8=;
        b=NrwDnm5uxRispiXk3RenHxnL4H9Kf7hhuoBFoU84o/2xFa+AYZMC//J7z0LzFa12kk
         N4BBylK6H6fwBUHmIV6HlLq8FU3Ne+AtA9xlMh+Wt5qVGyGfyU8Z64+tCBWBDFa87/QU
         1Ncx1PYiFbQPx+Fz0Dgl0b2MgXl93H5vqL2EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=hBdQDClMPtMAF+c3jo/2lzUJ+jT80r9tfeQ73+3mbBhv7Zd5iGg5/+lVTOY3Cg7Gr5
         wx2jfYroR9w+vj+yG/nrgeb3okQBznxsFvpL/Iv5+lFAa6UxOaE3/NprkYYOnQuv7Yf5
         WPyULVhauBfY0RRaaHh6oW3eymbgoNGFSQEIE=
Received: by 10.67.15.15 with SMTP id s15mr1351720ugi.39.1227911903605;
        Fri, 28 Nov 2008 14:38:23 -0800 (PST)
Received: from localhost.localdomain (abvh10.neoplus.adsl.tpnet.pl [83.8.205.10])
        by mx.google.com with ESMTPS id p32sm1369302ugc.57.2008.11.28.14.38.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 28 Nov 2008 14:38:22 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id mASMbZEt021408;
	Fri, 28 Nov 2008 23:37:46 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id mASMbIRt021402;
	Fri, 28 Nov 2008 23:37:18 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <49306150.6010701@datacom.ind.br>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101890>

Samuel Lucas Vaz de Mello <samuellucas@datacom.ind.br> writes:

> I have a repository with code imported from CVS.
> 
> I first imported from CVS using git 1.5.6 and we started to develop
> in git branches.  I run cvsimport periodically and merged the
> changes from CVS (legacy developers) to our git branches.  After
> some time, I realized that the import was broken, upgraded to git
> 1.6 and reimported the data.  Now the imported data seems to be
> correct and I finished with a history tree like this:
> 
> (our branch1)             X--Y--Z
> merges>                  /    \
> (our branch2)       J--K--L--M--N--O--P
> merges>             /     /     /
> (cvs old) ...A--B--C--D--E     /
> merges>                       /
> (cvs new) ...A'-B'-C'-D'-E'-F'
> 
> 
> There is any way to get rid of the (broken) cvs-old tree?
> 
> I've tried to rebase, but the commits from A' and A are different,
> it tries to reapply all history in CVS.
> 
> I've tried to checkout a point before our changes start (B') and
> then, using a script, cherry-pick all commits up to HEAD that are
> not in cvs-old branch. This approach didn't handled well merges
> between our branches (K-L-M and X-Y).
> 
> The history from the beginning up to the point where our changes
> started (...A--B) is quite large, so it would be nice for us to get
> rid of it.
> 
> Any suggestion on how to handle this?

You can use grafts (see "Repository Layout" documentation) to prune
'cvs old' branches, by adding for each merge commit <c_i> with one
side leading to 'cvs old' branch line to .git/info/grafts
  <c_i> <c_i^1>
where <c_i> is full hexadecimal object name.

Then check in gitk or some other history viewer if the history now
looks like you wanted (looks sane).

Then use "git filter-branch --all" to turn grafts into reality, check
out correctness, then remove refs/original/* and do git-gc.

HTH
-- 
Jakub Narebski
Poland
ShadeHawk on #git
