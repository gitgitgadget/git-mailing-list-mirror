From: Teemu Likonen <tlikonen@iki.fi>
Subject: Re: [PATCH 1/4] Add history graph API
Date: Mon, 7 Apr 2008 10:26:29 +0300
Message-ID: <20080407072629.GA5168@mithlond.arda.local>
References: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Simpkins <adam@adamsimpkins.net>
X-From: git-owner@vger.kernel.org Mon Apr 07 09:27:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jill7-0006aQ-Ae
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 09:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752147AbYDGH0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 03:26:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752642AbYDGH0d
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 03:26:33 -0400
Received: from pne-smtpout4-sn1.fre.skanova.net ([81.228.11.168]:58649 "EHLO
	pne-smtpout4-sn1.fre.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752128AbYDGH0c (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Apr 2008 03:26:32 -0400
Received: from mithlond.arda.local (80.220.180.181) by pne-smtpout4-sn1.fre.skanova.net (7.3.129)
        id 47A7970A00378402; Mon, 7 Apr 2008 09:26:30 +0200
Received: from dtw by mithlond.arda.local with local (Exim 4.63)
	(envelope-from <tlikonen@iki.fi>)
	id 1JilkL-0001Mu-NN; Mon, 07 Apr 2008 10:26:29 +0300
Content-Disposition: inline
In-Reply-To: <1207507332-1866-1-git-send-email-adam@adamsimpkins.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78952>

Adam Simpkins kirjoitti (6.4.2008 klo 11.42):

> [...] graphing API [...] is more similar to gitk's graph, which many
> people are already familiar with. It also doesn't require a terminal
> with Unicode support.

As I've spent some time in testing the --graph functionality I'm
spamming my discoveries here.

When limiting the log output to a subdirectory or to a file the graph
becomes quite hard to understand. Probably the easiest way to
demonstrate my point is to compare side by side (for example)

  git log --graph --pretty=oneline -- Documentation/
 
and

  gitk -- Documentation/

in the Git repository. gitk draws lines between commits even when they
are not in direct parent-child relationship (i.e. there is longer series
of commits between them). With log --graph it's hard to tell which
development line some commits come from.

The whole-repository log graphs seem to work nicely though.
