From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 11:45:25 +0200
Organization: At home
Message-ID: <eh28mn$3vh$1@sea.gmane.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <Pine.LNX.4.63.0610170128350.14200@wbgn013.biozentrum.uni-wuerzburg.de> <1161077599.9020.66.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Cc: bazaar-ng@lists.canonical.com
X-From: git-owner@vger.kernel.org Tue Oct 17 11:46:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZlWK-0001I0-1k
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 11:46:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423198AbWJQJp5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 05:45:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161040AbWJQJp5
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 05:45:57 -0400
Received: from main.gmane.org ([80.91.229.2]:8896 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161031AbWJQJp4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Oct 2006 05:45:56 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GZlVv-0001Br-3e
	for git@vger.kernel.org; Tue, 17 Oct 2006 11:45:35 +0200
Received: from host-81-190-17-207.torun.mm.pl ([81.190.17.207])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 11:45:35 +0200
Received: from jnareb by host-81-190-17-207.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 17 Oct 2006 11:45:35 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-17-207.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29044>

Robert Collins wrote:

> On Tue, 2006-10-17 at 01:45 +0200, Johannes Schindelin wrote:
>> 
>> If you really, really think about it: it makes much more sense to record 
>> your intention in the commit message. So, instead of recording for _every_ 
>> _single_ file in folder1/ that it was moved to folder2/, it is better to 
>> say that you moved folder1/ to folder2/ _because of some special
>> reason_!
> 
> Just a small nit here: bzr does /not/ record the move of every file: it
> records the rename of folder1 to folder2. One piece of data is all thats
> recorded - no new manifest for the subdirectory is needed.
> 
> Of course, a user can choose to move all the contents of a folder and
> not the folder itself - its up to the user.
> 
> By recording the folder rename rather than the contents rename, we get
> merges of new files added to folder1 in other branches come into folder2
> automatically, without needing to do arbitrarily deep history processing
> to determine that.

Hmmm... I wonder how well git manages that (merge with renamed directory).

  folder1/a  -->  folder2/a  --------> folder2/a
  folder1/b  -->  folder2/b       /    folder2/b
      \                          /     folder2/c
       \------->  folder1/a  ---/
                  folder1/b
                  folder1/c


I wonder how bzr manages "separate some files into subdirectory" (and how
well git does that), i.e. we have

   sub-file1
   sub-file2
   filea
   fileb

In the 'main' branch we separated "sub-*" files into subdirectory

   sub/file1
   sub/file2
   filea
   fileb

How would that merge with adding new sub-* file on the branch to be merged?

   sub-file1
   sub-file2
   sub-file3
   filea
   fileb


Or how bzr manages sub-level movement, such as splitting file into two,
or joining two files into one file.


P.S. is anyone working on --follow option for renames following path
limiting?
-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
