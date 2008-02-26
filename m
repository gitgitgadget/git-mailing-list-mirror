From: Len Brown <lenb@kernel.org>
Subject: Re: warning: no common commits - slow pull
Date: Tue, 26 Feb 2008 14:38:16 -0500
Organization: Intel Open Source Technology Center
Message-ID: <200802261438.17014.lenb@kernel.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 26 20:41:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU5g9-0005UH-Gc
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 20:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757546AbYBZTkv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 14:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758174AbYBZTkv
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 14:40:51 -0500
Received: from hera.kernel.org ([140.211.167.34]:56133 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732AbYBZTku (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 14:40:50 -0500
Received: from [192.168.10.104] (pppbroadband177-132.gorge.net [209.216.177.132] (may be forged))
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id m1QJcW3p021046
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Feb 2008 19:39:08 GMT
User-Agent: KMail/1.9.6 (enterprise 0.20071204.744707)
In-Reply-To: <200802151643.30232.lenb@kernel.org>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.88.7/6004/Tue Feb 26 19:08:16 2008 on hera.kernel.org
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.2.3
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on hera.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75165>

On Friday 15 February 2008, Len Brown wrote:
> it happened again.
> 
> this morning I pulled linus' tree up through 
> 4ee29f6a52158cea526b16a44ae38643946103ec
> 
> then during the day, linus declared "rc2".
> 
> and now I pulled linus' tree again,
> which has a HEAD now of 
> 
> 101142c37be8e5af9b847860219217e6b958c739
> 
> and the pull sucked down 172 MB even though the uncompressed
> diff between the two is 0.3 MB.
> 
> -Len
> 
> [lenb@d975xbx2 linus (master)]$ git pull
> remote: Counting objects: 649, done.
> remote: Compressing objects: 100% (106/106), done.
> remote: Total 513 (delta 417), reused 503 (delta 407)
> Receiving objects: 100% (513/513), 116.67 KiB, done.
> Resolving deltas: 100% (417/417), completed with 103 local objects.
> warning: no common commits
> remote: Counting objects: 710725, done.
> remote: Compressing objects: 100% (125738/125738), done.
> remote: Total 710725 (delta 589584), reused 704450 (delta 584029)
> Receiving objects: 100% (710725/710725), 172.71 MiB | 1073 KiB/s, done.
> Resolving deltas: 100% (589584/589584), done.
> From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
>  * [new tag]         v2.6.25-rc2 -> v2.6.25-rc2
> Updating 4ee29f6..101142c
> Fast forward
>  Makefile                               |    4 +-
...
> [lenb@d975xbx2 linus (master)]$            
> [lenb@d975xbx2 linus (master)]$ git --version
> git version 1.5.4.1.122.gaa8d

It still happens with latest git. (linus has declared -rc3 this time)
unfortunately for me, i'm not on broadband this time so it is extremely painful --
to the point that i simply can't update this tree until i get home.

I started at 4fa2b1cde0e3797549f711ce9e51c395b3d6d2a7
and Linus' tree is at 7704a8b6fc4a8f51599eb2af4dcf1e2ac9c7e576

The diff between these commits is about 100KB uncompressed, but it seems
that I'm pulling down 175MB again...

remote: Counting objects: 661, done.
remote: Compressing objects: 100% (139/139), done.
remote: Total 501 (delta 411), reused 443 (delta 362)
Receiving objects: 100% (501/501), 73.89 KiB | 11 KiB/s, done.
Resolving deltas: 100% (411/411), completed with 101 local objects.
warning: no common commits
remote: Counting objects: 714841, done.
remote: Compressing objects: 100% (127590/127590), done.
Receiving objects:   1% (11116/714841), 3.96 MiB | 5 KiB/s

[lenb@t61 ~]$ git --version
git version 1.5.4.3.230.g2db511
