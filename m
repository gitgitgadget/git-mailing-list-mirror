From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [JGIT PATCH]  Test and fix handling of quotes in ~/.ssh/config
Date: Thu, 25 Sep 2008 08:26:56 +0200
Message-ID: <200809250826.59765.robin.rosenberg.lists@dewire.com>
References: <12219428213749-git-send-email-ggoudsmit@shebang.nl> <20080922210734.GE3669@spearce.org> <20080924232519.GA15318@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, sverre@rabbelier.nl,
	git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Thu Sep 25 17:41:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kisxd-0001lh-OF
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 17:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbYIYPjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 11:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751734AbYIYPjs
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 11:39:48 -0400
Received: from av12-1-sn2.hy.skanova.net ([81.228.8.185]:48166 "EHLO
	av12-1-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYIYPjs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 11:39:48 -0400
Received: by av12-1-sn2.hy.skanova.net (Postfix, from userid 502)
	id 561A538943; Thu, 25 Sep 2008 17:39:46 +0200 (CEST)
Received: from smtp4-1-sn2.hy.skanova.net (smtp4-1-sn2.hy.skanova.net [81.228.8.92])
	by av12-1-sn2.hy.skanova.net (Postfix) with ESMTP
	id 17AC138A6C; Thu, 25 Sep 2008 17:39:46 +0200 (CEST)
Received: from [10.3.4.244] (h250n1fls32o811.telia.com [213.67.100.250])
	by smtp4-1-sn2.hy.skanova.net (Postfix) with ESMTP id 9F0BB37E49;
	Thu, 25 Sep 2008 17:39:45 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <20080924232519.GA15318@diku.dk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96779>

torsdagen den 25 september 2008 01.25.19 skrev Jonas Fonseca:
> Using exceptions seems a bit harsh, since the quote is not really fatal
> in anyway. Also, for badly formatted Port values the value is simply ignored.

For this case OpenSSH complains about a missing parameter. It does not
even attempt to look up the host. For malformed port numbers I get "Bad number"
(and no attempt to connect. I think an exception is the right way to solve the
problem si nce the caller doesn't have to do the error checking. and the error
is more obvious to the user. OpenSSH also gives the line number. Maybe we
should too. 

The OpenSSH i'm referencing is openssh-5.1p1-1mdv2009.0

-- robin
