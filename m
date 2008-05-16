From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: git-svn, merging et al.
Date: Fri, 16 May 2008 16:50:07 +0100
Message-ID: <320075ff0805160850r473582d9qc33f71ba7f56dd51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 16 17:51:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx2D3-0001vh-1f
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 17:51:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756951AbYEPPuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 11:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756332AbYEPPuL
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 11:50:11 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:30093 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756777AbYEPPuJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 11:50:09 -0400
Received: by fg-out-1718.google.com with SMTP id 19so750234fgg.17
        for <git@vger.kernel.org>; Fri, 16 May 2008 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=GQiBPPMEpD2Cw3XN+siUyLXIRwQDTr7MnBuMYI5KJjo=;
        b=meRPN3NmwHcw3XSao98hKkXZzGnp0doWUqYaPUIQc37FgwfznE8wtXQkWlp1ZQVXtYqnQzQ6Vuxbzv91Uy/TnNcfb7A/qEhPio5x0yjeN2m6ajZLB/WiC5jEQK83ukqFMWDVYxABGWMSSRpHMyRFeIWETD9uf5IpJicf2GMDyZU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=L3J5+jsias0afaKJvGOdwtt2xq6FIwYF/y2zLGBsWu7NqAzu/XpW+x/8Vt3bcactq7Qh9qIWVVD33NlE5FcKVEreTVBCWOsXTvn9OAgJGuhFyJOgF8a11Rk/cnuthhrjgRR1hYAjhqbYX397BY8UJ0t5xvUaJ/Jgv+1o6g3bbtY=
Received: by 10.82.182.18 with SMTP id e18mr529471buf.50.1210953007309;
        Fri, 16 May 2008 08:50:07 -0700 (PDT)
Received: by 10.82.168.20 with HTTP; Fri, 16 May 2008 08:50:07 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82305>

Ok - it's Friday and I've got to interact with svn again..

I'm using git-svn, and I've not followed the guidance. Development has
gone on in git branches and merges - but now I need to commit the
changes back into svn, and dcommit is, understandably, not very happy.

I'm intending to instead do something like a
  git format-patch svn-branch..git-branch
  git checkout svn-branch
... apply all the patches ...
  git commit
  git svn dcommit
  # back to the git work
  git checkout git-branch
  # this shouldn't have to do merging - but it will have the parents
to make it clear where the last merge happened from ?
  git merge svn-branch


I'm happy that I'm bludgeoning changes in one big blob into SVN, as I
can reasonably say 'if you want the real details, go look at gitweb)

I've tried doing this with
 git checkout svn-branch
 git merge --squash git-branch

But I don't get the result I'm expecting - what have I missed?
