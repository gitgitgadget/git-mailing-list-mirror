From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [PATCH 3/2] format-patch: use clear_commit_marks() instead of some adhocery
Date: Tue, 27 Jun 2006 10:20:51 +1200
Message-ID: <46a038f90606261520k7df8cb3ci7a4a609644e0be12@mail.gmail.com>
References: <Pine.LNX.4.63.0606250349280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	 <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, junkio@cox.net, martin@catalyst.net.nz
X-From: git-owner@vger.kernel.org Tue Jun 27 00:21:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuzRx-0001by-SO
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 00:20:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750860AbWFZWUy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Jun 2006 18:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751062AbWFZWUy
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jun 2006 18:20:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:47079 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750860AbWFZWUx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jun 2006 18:20:53 -0400
Received: by ug-out-1314.google.com with SMTP id a2so2285777ugf
        for <git@vger.kernel.org>; Mon, 26 Jun 2006 15:20:52 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LE+LL0Fcri5n4CQYFeQPt/SoiYiut58jfEythKgtOVUkUyW4uZruI0GmiQcORfMhcsvmOAiCDxDAyDqQeU1e4rmdXQnXHi3OnjiVvA0KuF7VvAVj3QtCaP5K+eJmCmIvyCTEiK+UK+LPHERKeNW38B8J+IubJV46hfudoWT+QIM=
Received: by 10.78.136.7 with SMTP id j7mr2307226hud;
        Mon, 26 Jun 2006 15:20:52 -0700 (PDT)
Received: by 10.78.117.11 with HTTP; Mon, 26 Jun 2006 15:20:51 -0700 (PDT)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0606261728340.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22680>

git-format-patch is rather broken on pu right now (pre these patches).
In my test git repo, git-format-patch.sh called with 2 parameters,
like

  git-format-patch <remotehead> <myhead>

when HEAD != myhead does the right thing, but git format-patch
doesn't, it seems to be messing up and not finding the merge base
correctly:

  0001-Initial-revision-of-git-the-information-manager-from-hell.txt

And it errors out with ignore-if-in-upstream:

  $ ./git format-patch --ignore-if-in-upstream -o .patches origin master
  fatal: Not a range.

I'll retest later with these patches and post again.


martin
