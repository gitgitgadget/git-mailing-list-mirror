From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git's database structure
Date: Tue, 04 Sep 2007 18:10:47 +0200
Message-ID: <46DD8387.3040801@op5.se>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <46DD7FE4.1060908@op5.se> <20070904160726.GA17509@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Sep 04 18:10:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISazP-0006DK-GK
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 18:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbXIDQKv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 12:10:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbXIDQKv
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 12:10:51 -0400
Received: from mail.op5.se ([193.201.96.20]:39398 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751339AbXIDQKu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 12:10:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 77480194424;
	Tue,  4 Sep 2007 18:10:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2muzSWntfgbb; Tue,  4 Sep 2007 18:10:49 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.178])
	by mail.op5.se (Postfix) with ESMTP id F132E1943F9;
	Tue,  4 Sep 2007 18:10:48 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070719)
In-Reply-To: <20070904160726.GA17509@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57605>

Mike Hommey wrote:
> On Tue, Sep 04, 2007 at 05:55:16PM +0200, Andreas Ericsson <ae@op5.se> wrote:
>> Each root tree can only ever belong to a single commit, unless you
>> intentionally force git to make completely empty commits. git
>> won't complain about this, so long as you don't make two in the
>> same second, because it relies more heavily on the DAG than on
>> developer sanity.
> 
> Actually, you don't need to be insane to have multiple commits pointing
> at the same root tree. It is actually very easy:
> - git clone
> - do some stuff on your master branch and commit
> - send your changes upstream
> - upstream applies as is
> - git pull
> 
> You now have everything merged, and the last commit on your master branch,
> while being a different commit object due to its parenting, has the same
> root tree as the tip of the remote branch.
> 

That explains why it felt so awkward writing that sentence. :)
Thanks for correcting me. Even so, one more M<->M relation-ship
certainly speaks for rather than against the current model.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
