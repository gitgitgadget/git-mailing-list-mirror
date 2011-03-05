From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: Behavior of git ls-files
Date: Sat, 5 Mar 2011 09:47:33 +0100
Message-ID: <20110305084733.GA3039@toss>
References: <691824945.20110304183831@stzedn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Jaeckel <steffen.jaeckel@stzedn.de>
X-From: git-owner@vger.kernel.org Sat Mar 05 10:11:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PvnWm-00047m-Ul
	for gcvg-git-2@lo.gmane.org; Sat, 05 Mar 2011 10:11:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224Ab1CEJLh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Mar 2011 04:11:37 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:60968 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750933Ab1CEJLg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Mar 2011 04:11:36 -0500
X-Greylist: delayed 1419 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Mar 2011 04:11:35 EST
Received: from bsmtp.bon.at (unknown [192.168.181.104])
	by lbmfmo03.bon.at (Postfix) with ESMTP id E9AC7CE118
	for <git@vger.kernel.org>; Sat,  5 Mar 2011 09:47:55 +0100 (CET)
Received: from localhost (p5B22C3A6.dip.t-dialin.net [91.34.195.166])
	by bsmtp.bon.at (Postfix) with ESMTP id A5E9113004A;
	Sat,  5 Mar 2011 09:47:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <691824945.20110304183831@stzedn.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168482>

On Fri, Mar 04, 2011 at 06:38:31PM +0100, Steffen Jaeckel wrote:
> 
> Is the behavior of git ls-files correct or not?

Indeed, the behavior is not correct. It does not find any files
which are excluded only due to a directory exclude.

In the cases without -i we do not even have to look at files under
an ignored directory. So the matching rules are not applied
correctly in this case.

We have the same problem with git ls-files -i -o, unless you also
specify --directory (in which case, again, we do not need to look
at files under the ignored directory).

Clemens
