From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git's database structure
Date: Thu, 06 Sep 2007 10:49:23 +0200
Message-ID: <46DFBF13.9040109@op5.se>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>	 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>	 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>	 <20070904212507.GA24434@thunk.org>	 <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>	 <46DE5861.4050201@op5.se>	 <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>	 <46DEC26E.7030809@op5.se>	 <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com>	 <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk> <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Julian Phillips <julian@quantumfyre.co.uk>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 10:49:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITD3N-0002sG-7B
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 10:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753680AbXIFIt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 04:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbXIFIt2
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 04:49:28 -0400
Received: from mail.op5.se ([193.201.96.20]:52098 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753141AbXIFIt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 04:49:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id A8E0E19446A;
	Thu,  6 Sep 2007 10:49:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Wc6ug-g-lCW1; Thu,  6 Sep 2007 10:49:25 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id A4C9C194466;
	Thu,  6 Sep 2007 10:49:24 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57841>

Jon Smirl wrote:
> On 9/5/07, Julian Phillips <julian@quantumfyre.co.uk> wrote:
>> On Wed, 5 Sep 2007, Jon Smirl wrote:
>>
>>> On 9/5/07, Andreas Ericsson <ae@op5.se> wrote:
>>>> Jon Smirl wrote:
>>>>> The path name field needs to be moved back into the blobs to support
>>>>> alternative indexes. For example I want an index on the Signed-off-by
>>>>> field. I use this index to give me the SHAs for the blobs
>>>>> Signed-off-by a particular person. In the current design I have no way
>>>>> of recovering the path name for these blobs other than a brute force
>>>>> search following every path looking for the right SHA.
>>>>>
>>>> Ah, there we go. A use-case at last :)
>> But not a brilliant one.  You sign off on commits not blobs.  So you go
>> from the sign-off to paths, then to blobs.  There is no need to go from
>> blob to path unless you deliberately introduce such a need.
> 
> Use blame for an example. Blame has to crawl every commit to see if it
> touched the file. It keeps doing this until it figures out the last
> author for every line in the file. Worse case blame has to crawl every
> commit in the data store.
> 

Estimated daily uses of git-blame, world-wide: few
Estimated daily uses of git-{merge,diff}, worldwide: lots

Code and benchmarks, or I'm not buying it.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
