From: Christian Jaeger <christian@pflanze.mine.nu>
Subject: Re: Excluding files from git-diff
Date: Sat, 18 Oct 2008 18:08:55 +0200
Message-ID: <48FA0A17.9050506@pflanze.mine.nu>
References: <20081017145313.GA23471@eriks> <48F8ACC2.1010903@drmicha.warpmail.net> <48F8BDA7.50901@pflanze.mine.nu> <20081018155912.GA20387@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Erik Hahn <erik_hahn@gmx.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 18 18:10:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrENW-0001Hg-Rx
	for gcvg-git-2@gmane.org; Sat, 18 Oct 2008 18:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbYJRQI7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2008 12:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbYJRQI7
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Oct 2008 12:08:59 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:43688 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750962AbYJRQI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2008 12:08:58 -0400
Received: (qmail 8706 invoked from network); 18 Oct 2008 16:08:56 -0000
Received: from unknown (HELO elvis-jaeger.mine.nu) (127.0.0.1)
  by localhost with SMTP; 18 Oct 2008 16:08:56 -0000
Received: (qmail 10866 invoked from network); 18 Oct 2008 16:08:56 -0000
Received: from unknown (HELO ?127.0.0.1?) (10.0.5.1)
  by elvis-jaeger.mine.nu with SMTP; 18 Oct 2008 16:08:56 -0000
User-Agent: Mozilla-Thunderbird 2.0.0.16 (X11/20080724)
In-Reply-To: <20081018155912.GA20387@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98558>

Jeff King wrote:
> No, I don't think there is a way to do that currently. I would probably
> generate the file list with a shell snippet:
>
>   git diff -- `git ls-files | grep -v .gitignore`
>
> but obviously that is a lot more typing if this is something you are
> doing frequently.

The problem with this is that it won't show files that aren't there 
anymore but have been previously; in general, for that to work (also 
with git log, for example), the list of files would need to include all 
paths which have ever existed and which are not to be excluded. Even 
then, I'm not sure whether there are corner case where it would not work 
(when files are being renamed, for example?).

If I/we (after finishing my intergit-find-matching-commit-in experiment) 
finally decide that tracking generated files in the same repository is 
the right thing to do, then I guess the only way to ignore those cleanly 
would be to add an inverse match feature to the Git core.

Christian.
