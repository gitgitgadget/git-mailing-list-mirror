X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: git-svn and rebase causes duplicate  log entries in svn
Date: Wed, 15 Nov 2006 11:14:51 +0100
Message-ID: <455AE89B.2030201@transmode.se>
References: <00ff01c70836$ba7e3d00$1e67a8c0@Jocke> <m2zmatiqon.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 15 Nov 2006 10:15:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.7 (X11/20061017)
In-Reply-To: <m2zmatiqon.fsf@ziti.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31430>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkHnN-0008FH-3C for gcvg-git@gmane.org; Wed, 15 Nov
 2006 11:15:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965964AbWKOKO5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 05:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966111AbWKOKO5
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 05:14:57 -0500
Received: from [212.105.56.244] ([212.105.56.244]:16350 "EHLO
 dmz.lumentis.net") by vger.kernel.org with ESMTP id S965964AbWKOKO4 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 05:14:56 -0500
Received: from [192.168.1.15] (146.175.241.83.in-addr.dgcsystems.net
 [83.241.175.146]) (authenticated bits=0) by dmz.lumentis.net (8.12.8/8.12.8)
 with ESMTP id kAFAEpTI014774 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA
 bits=256 verify=NO); Wed, 15 Nov 2006 11:14:52 +0100
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon wrote:
> Hi Joakim,
>
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> writes:
>   
>> Now I want to rebase my svn branch against latest u-boot and commit
>> my rebased svn branch to svn.
>>
>> I use git-svn commit -b svn -q remotes/git-svn..svn to commit my latest
>> changes and when I do so I see my local changes once more in the svn
>> log:
>> Any way to avoid that?
>>     
>
> I think you want to use git-svn dcommit, and not commit.  See the
> notes in the git-svn man page.  The basic workflow
> that I've been using is:
>
> git-svn fetch  
> git rebase remotes/git-svn  ## on mybranch
> ## make commits on mybranch
> git-svn dcommit remotes/git-svn..mybranch
>
> This results in each commit that I made on mybranch being sent to svn
> as a separate commit.
>
> + seth
>   
Thanks, but for some reson I can't make dcommit work. I just get
git-svn dcommit  -q remotes/git-svn..svn
Unable to extract revision information from commit
3643783f1f2fbdec1514b5e842e97b27622ae8b8~1

My workflow is perhaps a little diffrent I do all dev in git and then
commit to SVN.
I start with creating an empty SVN tree and then do a
   git-svn commit <commit id where my dev started from u-boot>
then I do a
   git-svn commit  -q remotes/git-svn..svn
to add all my own commits.
