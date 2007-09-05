From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git's database structure
Date: Wed, 05 Sep 2007 16:51:26 +0200
Message-ID: <46DEC26E.7030809@op5.se>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com>	 <9e4733910709040928n6535e49esaf713b2c63ba0831@mail.gmail.com>	 <7vtzqany0z.fsf@gitster.siamese.dyndns.org>	 <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com>	 <20070904212507.GA24434@thunk.org>	 <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com>	 <46DE5861.4050201@op5.se> <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 05 17:19:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISwfK-0005WU-4e
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 17:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162AbXIEPTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 11:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752137AbXIEPTc
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 11:19:32 -0400
Received: from mail.op5.se ([193.201.96.20]:50636 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756091AbXIEPTb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 11:19:31 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 5C9C3194441;
	Wed,  5 Sep 2007 16:51:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Gc780lWnqnSF; Wed,  5 Sep 2007 16:51:28 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id BC70F19441E;
	Wed,  5 Sep 2007 16:51:27 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57714>

Jon Smirl wrote:
> 
> The path name field needs to be moved back into the blobs to support
> alternative indexes. For example I want an index on the Signed-off-by
> field. I use this index to give me the SHAs for the blobs
> Signed-off-by a particular person. In the current design I have no way
> of recovering the path name for these blobs other than a brute force
> search following every path looking for the right SHA.
> 

Ah, there we go. A use-case at last :)

So now we have a concrete problem that we can formulate thus:
"How can one create a database listing the relationship between 'signers'
and blobs?"

So the second question: Do you seriously argue that git should take a
huge performance loss on its common operations to accommodate a need that
I suspect very few people have?

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
