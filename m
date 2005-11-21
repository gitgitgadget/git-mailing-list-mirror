From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] git-format-patch options
Date: Mon, 21 Nov 2005 18:59:20 +0100
Message-ID: <43820AF8.5060208@op5.se>
References: <20051121173603.73700.qmail@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 21 19:03:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EeFww-0004a0-MZ
	for gcvg-git@gmane.org; Mon, 21 Nov 2005 18:59:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVKUR7X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Nov 2005 12:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbVKUR7W
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Nov 2005 12:59:22 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:51331 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750961AbVKUR7W
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Nov 2005 12:59:22 -0500
Received: from [192.168.1.19] (unknown [213.88.215.14])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id EE7E36BD08; Mon, 21 Nov 2005 18:59:20 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: ltuikov@yahoo.com
In-Reply-To: <20051121173603.73700.qmail@web31806.mail.mud.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12462>

Luben Tuikov wrote:
> --- Andreas Ericsson <ae@op5.se> wrote:
> 
> 
>>Please don't. git-format-patch is generally used to send 
> 
> 
> Ok, so then when I want to extract a single commit into a patch in a patch format, I loosely do
> (scripted):
> 
>   git-rev-list --pretty=raw --max-count=1 <commit-ish>
> 
> Then I record the parent <parent> of the commit-ish and do:
> 
>   git-format-patch [output options] <parent>..<commit-ish>
> 
> Which gives me the commit with id <commit-ish> as a
> formatted patch.
> 
> Is there an alernative to this, as opposed to the two
> step procedure above?
> 

Here's how to automate it.

git format-patch $(git rev-list --max-count=2 <commit-ish> | tail -n 
1)..<commit-ish>

Either way, you need to know <commit-ish>, but this format should be 
fairly easy to add to git-format-patch. If you do, please let the user 
specify the --max-count (but default to 1) so it can be used to extract 
a series of patches rather than just one.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
