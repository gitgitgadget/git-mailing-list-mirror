From: "Don Zickus" <dzickus@gmail.com>
Subject: committing empty diffs
Date: Mon, 12 Feb 2007 14:49:36 -0500
Message-ID: <68948ca0702121149p4d87ae07jd3aa532a0df79156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 12 20:49:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGhBG-0006gQ-AI
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 20:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965348AbXBLTti (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 14:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965350AbXBLTti
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 14:49:38 -0500
Received: from nz-out-0506.google.com ([64.233.162.225]:22882 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965348AbXBLTth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 14:49:37 -0500
Received: by nz-out-0506.google.com with SMTP id s1so1728827nze
        for <git@vger.kernel.org>; Mon, 12 Feb 2007 11:49:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kiBlI1YIwocNJQ8GJv/iiO3Swz+8krT2trYzXg3mlCA2Y7Pawy2D5GFP8tcPvrV8iw+AYrYGf/byqDTxsKcKZDVitCN2bwRIacRmQFa/4UWjd1MJ4AiOP35NkzpnBRbBV6nOIqN9mG9DCwvhVVykPYadtXBx2O/uAdcCaHQHpYQ=
Received: by 10.114.197.1 with SMTP id u1mr6282537waf.1171309776547;
        Mon, 12 Feb 2007 11:49:36 -0800 (PST)
Received: by 10.114.80.9 with HTTP; Mon, 12 Feb 2007 11:49:36 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39428>

I was toying around with the idea of keeping track of scripts or
config files in my home directory.  Most of the time my commits would
include a change to the file I was tracking.  However, there are a
couple of cases where I wanted to commit empty diffs.  For example,
ideas or todos about that particular file that I didn't want to embed
in the file itself nor write it in yet another file labeled ideas or
todos.  I thought it would be easier to just to run a 'git log' on the
file and see my whole thought process.

Considering git-commit doesn't allow this (probably for good reason),
is it technically safe to do the following sequence of events?

tree=$(git-write-tree)  #basically the same tree HEAD points to
commit=$(echo $IDEAS | git-commit-tree $tree -p HEAD)
git-update-ref HEAD $commit HEAD

I figured all a commit is doing is taking a snapshot of a particular
tree at a moment in time.  And taking multiple snapshots at that same
moment and stringing them together (pointed to by HEAD) wouldn't be a
big deal.

Am I going to wind up shooting myself in the foot later or will this
work?  Light testing didn't show any issues.  Thought I would ask the
experts.  Thanks.

Cheers,
Don
