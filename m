From: =?ISO-8859-1?Q?Dirk_S=FCsserott?= <newsletter@dirk.my1.cc>
Subject: Re: removing a commit from a branch
Date: Wed, 04 May 2011 19:53:36 +0200
Message-ID: <4DC192A0.6010808@dirk.my1.cc>
References: <BANLkTimtpvVRU=1iCbrteyHixaWGuVKDjQ@mail.gmail.com> <alpine.DEB.2.00.1105041014480.16939@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Gergely Buday <gbuday@gmail.com>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed May 04 19:53:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHgGe-0005o6-Lk
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 19:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941Ab1EDRxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 13:53:39 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.25]:48625 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab1EDRxi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 13:53:38 -0400
Received: from [217.87.122.39] (helo=[192.168.2.100])
	by smtprelay02.ispgateway.de with esmtpa (Exim 4.68)
	(envelope-from <newsletter@dirk.my1.cc>)
	id 1QHgGW-00032K-Az; Wed, 04 May 2011 19:53:36 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <alpine.DEB.2.00.1105041014480.16939@ds9.cixit.se>
X-Df-Sender: 757646
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172751>

Am 04.05.2011 11:17 schrieb Peter Krefting:
> Gergely Buday:
>
>> I have a problematic commit in a series of commits on a branch. It
>> contains adding a large binary file, which I would like to avoid to
>> push to our main repository. How can I remove that from the series of
>> commits? A command-line solution, please, if possible.
>
> If the branch is simple (no merges and such), I'd use "git rebase
> --interactive branchpoint" (where "branchpoint" is where the branch is
> rooted), or "git rebase --interactive problematic^" (where "problematic"
> is the commit you want to edit, note the trailing "^" to start from its
> parent commit).
>
> Then change the "pick" for the problematic commit to "edit", run the
> rebase, fix up the commit by using "git rm" and "git commit --amend"
> when it pauses, and then let it finish using "git rebase --continue".
>
> "git --help rebase" for more information.
>

If your "problematic" commit contains only that "large file" and nothing 
else, then you'd probably like to remove the whole commit instead of 
editing it (as Peter described). Just do:

$ git rebase --interactive problematic^

Again, notice the ^ after "problematic"

An editor pops up with the history since problematic's parent, i.e. 
"problematic" is the first item in the list. Simply delete the line with 
the "problematic" commit. It should be the first line. Save the file, 
exit the editor. That's it.

     Dirk
