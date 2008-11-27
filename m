From: Andreas Ericsson <ae@op5.se>
Subject: Re: git fast-export | git fast-import doesn't work
Date: Thu, 27 Nov 2008 09:18:30 +0100
Message-ID: <492E57D6.3010703@op5.se>
References: <85b5c3130811250844u498fbb97m9d1aef6e1397b8c7@mail.gmail.com>	 <alpine.DEB.1.00.0811260113140.30769@pacific.mpi-cbg.de>	 <85b5c3130811260135g4646bf72iaf57f599fdd21a0c@mail.gmail.com>	 <85b5c3130811260218s7529914eyb56a05ec1ca34b8f@mail.gmail.com>	 <492D6CC3.2050408@drmicha.warpmail.net>	 <85b5c3130811260750y2e24436ye2426ccfc2f66071@mail.gmail.com>	 <alpine.DEB.1.00.0811261739110.30769@pacific.mpi-cbg.de> <85b5c3130811260921s474bc724hb74b54e21e8be912@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Fabian Seoane <fabian@fseoane.net>
To: Ondrej Certik <ondrej@certik.cz>
X-From: git-owner@vger.kernel.org Thu Nov 27 09:19:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5c6N-00069T-It
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 09:19:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbYK0ISi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 03:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbYK0ISi
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 03:18:38 -0500
Received: from mail.op5.se ([193.201.96.20]:36209 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbYK0ISh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 03:18:37 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5C1641B8145C;
	Thu, 27 Nov 2008 09:14:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FhbYESmnAqSP; Thu, 27 Nov 2008 09:14:22 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 1C4251B812BF;
	Thu, 27 Nov 2008 09:14:21 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (X11/20081119)
In-Reply-To: <85b5c3130811260921s474bc724hb74b54e21e8be912@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101798>

Ondrej Certik wrote:
> On Wed, Nov 26, 2008 at 5:40 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> Hi,
>>
>> On Wed, 26 Nov 2008, Ondrej Certik wrote:
>>
>>> I am also trying to make the example simpler. I tried to squash the
>>> first uninteresting ~1500 commits into one, but "git rebase -i" uterrly
>>> fails after squashing about 600 commits. Still investigating.
>> 1500... wow.
>>
>> The best idea would probably be to just "edit" the first, delete the rest
>> of the 1500, and then 'git read-tree -u -m <last-of-the-1500-commits>"' on
>> the command line (when git rebase stops after the "edit" command).
> 
> That worked, thanks! My original repo:
> 
> A -- B -- ... --- D --- E --- ...
> 
> where E and the rest of the commits (there are branches and merges in
> there) are the ones that I need to preserve, but all the commits
> between B and D can be squashed (~1500 of them). So I created a
> branch:
> 
> A -- B -- ... --- D
> 
> then squashed the commits using the technique you described above, so
> now I have:
> 
> A -- BD --
> 
> and now I would like to append "E -- ..." to it -- is there any way to
> do that? I tried rebase, but that destroys all the branches and merges
> and those are necessary to reproduce the fast-export bug.
> 

  git rebase -p

If your git is old, you'll need

  git rebase -i -p

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
