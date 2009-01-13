From: Andreas Ericsson <ae@op5.se>
Subject: Re: How to pull remote branch with specified commit id?
Date: Tue, 13 Jan 2009 10:16:19 +0100
Message-ID: <496C5BE3.2040206@op5.se>
References: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Emily Ren <lingyan.ren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 10:17:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMfPB-0004xC-II
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 10:17:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756305AbZAMJQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 04:16:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753831AbZAMJQY
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 04:16:24 -0500
Received: from mail.op5.se ([193.201.96.20]:43555 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753284AbZAMJQW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 04:16:22 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 744F824C1411;
	Tue, 13 Jan 2009 10:17:20 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id h8OTpSmtKvKc; Tue, 13 Jan 2009 10:17:18 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 9EDC224B0B3E;
	Tue, 13 Jan 2009 10:17:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
In-Reply-To: <856bfe0e0901130108q3af1345cy31751dd09e030c96@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105476>

Emily Ren wrote:
> Git experts,
> 
> I want to pull remote branch with specified commit id, how to do it?
> 
> Below command can get remote branch
> $git pull remote refs/heads/$branch_name
> 
> Below command doesn't work
> $git pull remote objects/$commit_id
> 

You need to fetch it first, and then merge the commit you want. The
tools operating the fetching protocol only use refs, so if you want
to fetch (or pull) a specific version that has neither a tag nor a
branch head pointing to it, you'll have to write a new tool for that.

The end-result of the following command will be, barring side-effects
in the remote-tracking branches, identical to what you're trying to
do though:
git fetch remote && git merge $commit_id

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
