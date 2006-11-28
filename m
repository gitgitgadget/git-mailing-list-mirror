X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 22:43:24 +0100
Organization: At home
Message-ID: <ekiaed$9v1$1@sea.gmane.org>
References: <45357CC3.4040507@utoronto.ca>	<a7e835d40610250308v5d577482m139742e7fe1db185@mail.gmail.com>	<87slhcz8zh.wl%cworth@cworth.org>	<a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>	<7vu01ro20b.fsf@assigned-by-dhcp.cox.net>	<a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>	<20061026101038.GA13310@coredump.intra.peff.net>	<877iyne4dm.fsf@alplog.fr>	<Pine.LNX.4.64.0610260753090.3962@g5.osdl.org>	<456B7C6A.80104@webdrake.net>	<845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>	<ekhaeg$etk$1@sea.gmane.org>	<Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>	<Pine.LNX.4.64.0611280754050.30076@woody.osdl.org>	<456C7592.6020700@ableton.com>	<ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 28 Nov 2006 21:42:25 +0000 (UTC)
Cc: bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Followup-To: gmane.comp.version-control.git
Original-Lines: 79
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-24-209.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32583>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpAiU-0005Dv-Iy for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:42:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756867AbWK1VmM (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756871AbWK1VmL
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:42:11 -0500
Received: from main.gmane.org ([80.91.229.2]:33220 "EHLO ciao.gmane.org") by
 vger.kernel.org with ESMTP id S1756867AbWK1VmK (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:42:10 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1GpAiA-00057n-2e for git@vger.kernel.org; Tue, 28 Nov 2006 22:41:54 +0100
Received: from host-81-190-24-209.torun.mm.pl ([81.190.24.209]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 28 Nov 2006 22:41:54 +0100
Received: from jnareb by host-81-190-24-209.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 28 Nov 2006
 22:41:54 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Nicholas Allen wrote:

>> Just out of curiosity: How does git handle the case where one file is
>> renamed differently in 2 branches and then the branches are repeatably
>> merged? I know that bzr handles this very well and in various tests I
>> did there were absolutely no repeated conflicts. Would git behave as
>> well in this scenario?
>> 
> 
> Ok - I got curious and decided to install git and try this myself.
> 
> In this test I had a file hello.txt that got renamed to hello1.txt in
> one branch and hello2.txt in another. Then I merged the changes between
> the 2 branches.
> 
> Here is how it looked after the merge in bzr:
> 
>  bzr status
> renamed:
>   hello2.txt => hello1.txt
> conflicts:
>   Path conflict: hello2.txt / hello1.txt
> pending merges:
>   Nicholas Allen 2006-11-28 Renamed hello to hello1
> 
> 
> and here's how it looked in git:
> git status
> #
> # Changed but not updated:
> #   (use git-update-index to mark for commit)
> #
> #       unmerged: hello.txt
> #       unmerged: hello1.txt
> #       unmerged: hello2.txt
> #       modified: hello2.txt
> #
> nothing to commit

Er? What about merge printed?

  $ git pull . branch
  Trying really trivial in-index merge...
  fatal: Merge requires file-level merging
  Nope.
  Merging HEAD with c59706ee42aa7b6b2b203d4219210a684f5581f2
  Merging:
  8f43c37 Moved hello.txt to hello_master.txt
  c59706e Moved hello.txt to hello_branch.txt
  found 1 common ancestor(s):
  b7d5f1a Initial commit
  CONFLICT (rename/rename): Rename hello.txt->hello_master.txt in branch 
    HEAD rename hello.txt->hello_branch.txt in c59706e
  Automatic merge failed; fix conflicts and then commit the result.

I agree that git-status output could be more helpful in the case of
merges. Well, you can always check "git ls-files --stage"

  $ git ls-files --stage --abbrev
  100644 18249f3 1        hello.txt
  100644 18249f3 3        hello_branch.txt
  100644 18249f3 2        hello_master.txt

> So git is not telling me that I have a conflict due to the same file
> being renamed differently in 2 branches - well at least not in a way I
> can comprehend anyway! Whereas bzr made this very clear. Also, in git I
> ended up with 2 files:
> 
>  ls
> hello1.txt  hello2.txt
> 
> whereas in bzr there was only one file and I just had to decide which
> name it was to be given to resolve the conflict.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

