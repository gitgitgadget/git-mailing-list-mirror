From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: testing for cloned repository
Date: Thu, 27 Jul 2006 16:10:16 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607271608260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <0AC9E5E7-52CC-4715-BB26-622A2177308B@mac.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 27 16:10:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G66ZD-00068X-G7
	for gcvg-git@gmane.org; Thu, 27 Jul 2006 16:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWG0OKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Jul 2006 10:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWG0OKU
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Jul 2006 10:10:20 -0400
Received: from mail.gmx.de ([213.165.64.21]:41952 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751334AbWG0OKT (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 27 Jul 2006 10:10:19 -0400
Received: (qmail invoked by alias); 27 Jul 2006 14:10:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp042) with SMTP; 27 Jul 2006 16:10:17 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Robert White <kranki@mac.com>
In-Reply-To: <0AC9E5E7-52CC-4715-BB26-622A2177308B@mac.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24291>

Hi,

On Thu, 27 Jul 2006, Robert White wrote:

> if [ -f ".git/remotes/origin" ]; then
> 	# this repository is a clone
> fi
> in a bash script to test if a repository was cloned and then do appropriate
> pulls and pushes which fit my situation.

I think it would be better to do this:

-- snip --
. git-parse-remote
test "$(get_remote_url origin)" != origin && echo "is cloned"
-- snap --

There are 3 different ways to store remote information ATM, and this 
method gets them all (even if, at a certain distant time in the future, 
the default should be changed).

Hth,
Dscho
