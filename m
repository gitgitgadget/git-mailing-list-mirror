From: Andreas Ericsson <ae@op5.se>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 02 Nov 2007 10:39:14 +0100
Message-ID: <472AF042.5080208@op5.se>
References: <20071022063222.GS14735@spearce.org> <7vzly84qwf.fsf@gitster.siamese.dyndns.org> <7vmytycykt.fsf@gitster.siamese.dyndns.org> <alpine.LFD.0.999.0711011129460.3342@woody.linux-foundation.org> <916BE4AD-5BD9-48E6-8026-B1AC7387E28D@adacore.com> <7v4pg5btis.fsf@gitster.siamese.dyndns.org> <20071101214257.GB7161@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Geert Bosch <bosch@adacore.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 10:39:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Int04-0003Gx-C9
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 10:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752858AbXKBJjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 05:39:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752852AbXKBJjW
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 05:39:22 -0400
Received: from mail.op5.se ([193.201.96.20]:45542 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831AbXKBJjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 05:39:21 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B82071730731;
	Fri,  2 Nov 2007 10:38:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DZmKKNolMZ6g; Fri,  2 Nov 2007 10:38:24 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 6A0541730746;
	Fri,  2 Nov 2007 10:38:23 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071101214257.GB7161@artemis.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63087>

Pierre Habouzit wrote:
> On Thu, Nov 01, 2007 at 08:27:55PM +0000, Junio C Hamano wrote:
>> Geert Bosch <bosch@adacore.com> writes:
>>
>>> I often type "make clean" as well many "git xyz" commands
>>> during development, and so it happens that at times, I type
>>> "git clean" by accident.
>> Happened to me once.  I hate that command.
>>
>>> So, I propose *not* converting git clean to a C builtin,
>>> but instead adding --untracked and --ignored options to
>>> git-rm.
>> I think what you are trying to do is to deprecate or remove "git
>> clean".
>>
>> I do not know where "git clean" came from.  I am suspecting that
>> it was to give counterparts to some other SCMs, but do not know
>> which ones.  Some people wanted to have it --- so you need to
>> convince them that it is a bad idea first.  Adding an equivalent
>> options to "git rm" alone does not solve that issue.
> 
>   FWIW I do use git clean a _lot_. I don't mind if it's doable from
> another kind of command, but I do use git clean and even git clean -x a
> lot, because it achives cleansing my repository faster (and sometimes
> faster) than a `make distclean` would do.
> 

I'm of two minds about this. On the one hand, it's incredibly useful to
clear out an imported repository where distlcean doesn't quite distclean.
We also use it for our autobuild tools (although that's just us being lazy).

On the other hand, I've been bit by the brain-bug once and done a git clean
when I really meant make clean.

Changing it to the wimpy 'rm -i' equivalent would reduce risk substantially
while maintaining its usefulness, so +1 to Junio's patch, I guess.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
