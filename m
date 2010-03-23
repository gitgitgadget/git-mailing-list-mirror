From: Thomas Kistler <tkistler@nvidia.com>
Subject: RE: git-p4 and git clone
Date: Tue, 23 Mar 2010 08:37:48 -0700
Message-ID: <B978892CA0FBD142827E74F92AC4BBD429B2444D5C@HQMAIL03.nvidia.com>
References: <B978892CA0FBD142827E74F92AC4BBD429B2444D4D@HQMAIL03.nvidia.com>
 <4880E32B-7880-40BF-8AFD-AC00DA457CEE@meyerhome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "'git@vger.kernel.org'" <git@vger.kernel.org>
To: 'Benjamin Meyer' <ben@meyerhome.net>
X-From: git-owner@vger.kernel.org Tue Mar 23 16:38:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu6B6-0004Sz-Ao
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 16:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754816Ab0CWPhw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Mar 2010 11:37:52 -0400
Received: from hqemgate03.nvidia.com ([216.228.112.145]:7408 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754735Ab0CWPhv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Mar 2010 11:37:51 -0400
Received: from hqnvupgp03.nvidia.com (Not Verified[172.17.102.18]) by hqemgate03.nvidia.com
	id <B4ba8e07e0002>; Tue, 23 Mar 2010 08:38:38 -0700
Received: from hqemhub02.nvidia.com ([172.17.108.22])
  by hqnvupgp03.nvidia.com (PGP Universal service);
  Tue, 23 Mar 2010 08:37:50 -0700
X-PGP-Universal: processed;
	by hqnvupgp03.nvidia.com on Tue, 23 Mar 2010 08:37:50 -0700
Received: from HQMAIL03.nvidia.com ([172.17.200.13]) by hqemhub02.nvidia.com
 ([172.17.98.27]) with mapi; Tue, 23 Mar 2010 08:37:49 -0700
Thread-Topic: git-p4 and git clone
Thread-Index: AcrKHf4IgJ5h6i83QrCAdzShEhG5YwAgIAiw
In-Reply-To: <4880E32B-7880-40BF-8AFD-AC00DA457CEE@meyerhome.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143025>

That doesn't seem to work. With --import-local, I can't even submit back from the original repository.

    $ cd tmp1
    $ git-p4 clone --import-local //foo/bar
    $ cd bar
    $ git checkout p4/master
    $ git-p4 submit --verbose
    
Reading pipe: git name-rev HEAD
Reading pipe: git config git-p4.allowSubmit
Reading pipe: git rev-parse --symbolic  --remotes
Reading pipe: git cat-file commit HEAD~0
Reading pipe: git cat-file commit HEAD~1
fatal: Not a valid object name HEAD~1 


-----Original Message-----
From: Benjamin Meyer [mailto:ben@meyerhome.net] 
Sent: Monday, March 22, 2010 5:15 PM
To: Thomas Kistler
Cc: 'git@vger.kernel.org'
Subject: Re: git-p4 and git clone


On Mar 22, 2010, at 7:16 PM, Thomas Kistler wrote:

> I'm probably missing something fairly fundamental but I'm running into problems with cloning a git-p4 repository:
> 
> First, I'm setting up a git-p4 master repository:
> 
>    $ cd tmp1
>    $ git-p4 clone //foo/bar
> 
> Then I'm cloning it through git:
> 
>    $ cd tmp2
>    $ git clone tmp1/bar
> 
> Finally, I'm trying to submit back to p4:
> 
>    $ git-p4 submit
> 
> This now fails because the remotes/p4/master seems to get lost when doing the "git clone". Is this supposed to work?
> 
> -Thomas

There is a -import-local option you can use.  Then the p4/master branch is local and when you do the second clone you will get the p4/master branch.

-Benjamin Meyer
-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------
