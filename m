From: Sylvain Joyeux <sylvain.joyeux@dfki.de>
Subject: Re: [PATCH] better git-submodule status output
Date: Wed, 9 Jul 2008 13:01:54 +0200
Message-ID: <20080709110154.GC3525@joyeux>
References: <20080701150119.GE5852@joyeux> <20080709101330.GA3525@joyeux> <48749215.6070307@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jul 09 13:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGXRo-00009h-Ev
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 13:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666AbYGILB6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 07:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752078AbYGILB6
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 07:01:58 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:56858 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047AbYGILB5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 07:01:57 -0400
Received: from [134.102.219.50] (helo=joyeux)
	by smtprelay01.ispgateway.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.68)
	(envelope-from <sylvain.joyeux@dfki.de>)
	id 1KGXQp-0007Ff-Lm; Wed, 09 Jul 2008 13:01:55 +0200
Content-Disposition: inline
In-Reply-To: <48749215.6070307@op5.se>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Df-Sender: [pbs]965142
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87868>

On Wed, Jul 09, 2008 at 12:25:25PM +0200, Andreas Ericsson wrote:
> Sylvain Joyeux wrote:
>> Here is a (tentative) summary of the whole discussion:
>>
>> * doing fetch in status is EVIL. Therefore, status should only report
>>   whatever information is available.
>> * nonetheless, having a "peek" mode seem to be accepted as a useful
>>   feature not only by me.
>> * changing the output format of git-submodules is not right either,
>>   because it would break existing tools which parses it at the moment.
>>
>> Proposal
>> - remove fetch from status, and make the new output enabled when
>>   --verbose is set (can also be set in the config file I guess).
>>
>>   On the symbols side, I propose:
>>     > submodule commit is a direct descendant of the commit in the
>>       superproject
>>     < submodule commit is a direct ancestor of the commit in the
>>       superproject
>>     + no direct relation between submodule commit and commit in the
>>       superproject
>>     ? the commit in the superproject cannot be found in the submodule
>>       (replaces the initial '!' in my patch)
>>
>>   A 'M' is appended if the submodule has uncommitted changes
>>
>> - define a git-submodule 'fetch' subcommand which call fetch in each
>>   submodule and runs the verbose mode of git-status (can be disabled by
>>   a --quiet option).
>>
>> Comments ? (I'm sure there are some ...)
>>
>
> Re-use the existing symbolism from fetch status output. Using '+' to
> denote "no direct relation" in a tool that shows patches half the
> time is just plain horrible.
Could you be more specific ? AFAIK, 'fetch' symbolism is based on files,
the one I need is comparing commits.

And I don't like the '+' either. I chose it because it is the current
symbol to show that there is a difference between
superproject/submodule.
-- 
=======================================================================
Dr. Ing. Sylvain Joyeux                          sylvain.joyeux@dfki.de
Researcher
DFKI Robotik Lab -- Bremen                   http://www.dfki.de/robotik
Tel: 0049 421 218 64136
=======================================================================
