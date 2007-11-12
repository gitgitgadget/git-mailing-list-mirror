From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] status&commit: Teach them to show submodule commit summary
Date: Mon, 12 Nov 2007 17:45:56 +0100
Message-ID: <47388344.6010008@viscovery.net>
References: <1194877277-31777-1-git-send-email-pkufranky@gmail.com>	 <4738784F.7010106@viscovery.net> <46dff0320711120835h31166370k64e9c92e9cf3432c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 17:46:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrcQW-00008t-7l
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 17:46:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755932AbXKLQp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 11:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbXKLQp7
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 11:45:59 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:39176 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbXKLQp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 11:45:58 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IrcPd-0003aX-GW; Mon, 12 Nov 2007 17:45:25 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5734B54D; Mon, 12 Nov 2007 17:45:56 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <46dff0320711120835h31166370k64e9c92e9cf3432c@mail.gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64661>

Ping Yin schrieb:
> On Nov 12, 2007 11:59 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> 
>> But at this time git-commit is about to be made a builtin, and since your
>> implementation contains a lot of non-portable constructs ($'', >&) and a new
>> dependency on awk (and, hence, has little chances of being accepted), I
>> suggest that you stay tuned, and implement this in the forth-coming
>> builtin-commit.c.
> Implement this in shell scripts is just a piece of cake, but not so
> easy in builtin-commit.c.

I'm with you. But git-commit.sh is a dead horse, no matter how hard you beat it.

BTW, maybe you can keep the log generation in a helper script, 
git-status--submodulesummary, and invoke that from builtin-commit.c. This 
way you get both: integration and ease of implementation.

>>> A configuration variable 'submodule.status' is used to turn this summary
>>> behaviour on or off (default off). Also --submodule and --no-submodule options
>>> are added.
>> There is already 'status.color', I suggest the configuration to become
>> 'status.submoduleSummary'.
> There is 'status.color', but 'color.status' is prefered as said in the
> documentation. So i follows this rule, name the variable submodule.*
> just as the ones for git-submodule. I think it's a good idea to put
> all submodule related configuration variables in the submodule.*
> namespaces.

"I think it's a good idea to put all status related configuration variables 
in the status.* namespace."

But I don't care too deeply. I don't have the big picture about which 
configuration variables namespaces exist and which one to pick in this case.

-- Hannes
