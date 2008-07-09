From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] better git-submodule status output
Date: Wed, 09 Jul 2008 12:25:25 +0200
Message-ID: <48749215.6070307@op5.se>
References: <20080701150119.GE5852@joyeux> <20080709101330.GA3525@joyeux>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Sylvain Joyeux <sylvain.joyeux@dfki.de>
X-From: git-owner@vger.kernel.org Wed Jul 09 12:30:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGWvp-0004lL-2T
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 12:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbYGIK0L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 06:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbYGIK0K
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 06:26:10 -0400
Received: from mail.op5.se ([193.201.96.20]:49260 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750748AbYGIK0J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 06:26:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id E82F71B80375;
	Wed,  9 Jul 2008 12:25:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2DryKFzy4Ie; Wed,  9 Jul 2008 12:25:32 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.26])
	by mail.op5.se (Postfix) with ESMTP id E96971B80369;
	Wed,  9 Jul 2008 12:25:31 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
In-Reply-To: <20080709101330.GA3525@joyeux>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87866>

Sylvain Joyeux wrote:
> Here is a (tentative) summary of the whole discussion:
> 
> * doing fetch in status is EVIL. Therefore, status should only report
>   whatever information is available.
> * nonetheless, having a "peek" mode seem to be accepted as a useful
>   feature not only by me.
> * changing the output format of git-submodules is not right either,
>   because it would break existing tools which parses it at the moment.
> 
> Proposal
> - remove fetch from status, and make the new output enabled when
>   --verbose is set (can also be set in the config file I guess).
> 
>   On the symbols side, I propose:
>     > submodule commit is a direct descendant of the commit in the
>       superproject
>     < submodule commit is a direct ancestor of the commit in the
>       superproject
>     + no direct relation between submodule commit and commit in the
>       superproject
>     ? the commit in the superproject cannot be found in the submodule
>       (replaces the initial '!' in my patch)
> 
>   A 'M' is appended if the submodule has uncommitted changes
> 
> - define a git-submodule 'fetch' subcommand which call fetch in each
>   submodule and runs the verbose mode of git-status (can be disabled by
>   a --quiet option).
> 
> Comments ? (I'm sure there are some ...)
> 

Re-use the existing symbolism from fetch status output. Using '+' to
denote "no direct relation" in a tool that shows patches half the
time is just plain horrible.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
