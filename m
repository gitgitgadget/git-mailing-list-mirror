From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: pushing changes to a remote branch
Date: Tue, 10 Jul 2007 14:10:01 -0400
Message-ID: <844FC382-DFB3-4762-93C2-6512612136AC@silverinsanity.com>
References: <20070710143614.GA29681@piper.oerlikon.madduck.net> <20070710173401.GB5032@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 10 20:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8KAU-00014x-Hz
	for gcvg-git@gmane.org; Tue, 10 Jul 2007 20:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760315AbXGJSKG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Jul 2007 14:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763517AbXGJSKG
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jul 2007 14:10:06 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:54759 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761300AbXGJSKE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jul 2007 14:10:04 -0400
Received: from [192.168.1.3] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id B8EBE1FFC003;
	Tue, 10 Jul 2007 18:10:02 +0000 (UTC)
In-Reply-To: <20070710173401.GB5032@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52103>


On Jul 10, 2007, at 1:34 PM, Jeff King wrote:

> On Tue, Jul 10, 2007 at 04:36:14PM +0200, martin f krafft wrote:
>
>>   git checkout origin/vim
>>     Note: moving to "origin/vim" which isn't a local branch
>>   echo change > newfile; git add newfile
>>   git commit -m'make change'
>>     Created commit 64b8b2e: make change
>>      1 files changed, 1 insertions(+), 0 deletions(-)
>>       create mode 100644 newfile
>>
>> If I now checkout master and then return to origin/vim, the commit
>> is gone.
>
> That's because 'origin/vim' is a tracking branch for the remote; it's
> where you store the information "here's what the remote 'origin'  
> thinks
> is in the branch 'vim'." That's why you get the "note" warning above.
>
> If you want to make changes, you should make a local branch starting
> from that point:
>
>   git-checkout -b vim origin/vim
>   # hack hack hack
>   git-commit -m changes

Indeed, in master, git outputs a hint to that when you checkout the  
remote branch.

   $ git checkout origin/master
   Note: moving to "origin/master" which isn't a local branch
   If you want to create a new branch from this checkout, you may do so
   (now or later) by using -b with the checkout command again. Example:
     git checkout -b <new_branch_name>
   HEAD is now at f4855d4... 1

Perhaps git-commit should also also output a warning?  "Commit made  
on detached HEAD.  Use "git branch <new_branch_name>" to save your  
commit"?  That's bad wording, but the idea is there.

~~ Brian
