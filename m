From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Removing alternates -- but how?
Date: Wed, 14 Apr 2010 09:25:43 +0200
Message-ID: <4BC56DF7.4030502@drmicha.warpmail.net>
References: <20100413125704.GA29552@dirichlet.schwinge.homeip.net> <20100413155819.GI19595@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Thomas Schwinge <thomas@schwinge.name>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Wed Apr 14 09:29:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1x2A-0004Xc-TM
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 09:29:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753304Ab0DNH2r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 03:28:47 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:49477 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753208Ab0DNH2p (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 03:28:45 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 11206EB181;
	Wed, 14 Apr 2010 03:28:45 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Wed, 14 Apr 2010 03:28:45 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=mg/wcatEpYnuFXtDNkGldULJKag=; b=B7VpXITs7WAbgjhHE5yt7QjYpZSFMrXs2EjjZl8BPLCp/3kUWwIGrrrjqzXqBMWKRzTJN+vAlhQq1gBbdijr+w/Y2e0kDg3KOunJVHD3I6BvPCo3F5ozbW9ULRsGTy+plmIdFp9dRcDhd/Vb/DJcyKTfYX8ZkzWfHeFE6nmnoAg=
X-Sasl-enc: GNSkd+plqeC7IGeXt/ga/h+up64b5G15JDwhClMAZ461 1271230124
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 54E379C24;
	Wed, 14 Apr 2010 03:28:44 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.10pre) Gecko/20100319 Lightning/1.0b2pre Shredder/3.0.5pre
In-Reply-To: <20100413155819.GI19595@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144856>

Miklos Vajna venit, vidit, dixit 13.04.2010 17:58:
> On Tue, Apr 13, 2010 at 02:57:04PM +0200, Thomas Schwinge <thomas@schwinge.name> wrote:
>>     $ cat .git/objects/info/alternates
>>     ../../../glibc/.git/objects
>>     ../../../../O/work.new/.git/objects
>>     $ git repack -a
>>     Counting objects: 18670, done.
>>     Compressing objects: 100% (7655/7655), done.
>>     Writing objects: 100% (18670/18670), done.
>>     Total 18670 (delta 10218), reused 18670 (delta 10218)
>>     $ mv .git/objects/info/alternates{,.DEFUNCT}
>>     $ git branch
>>     error: refs/remotes/grubber/master does not point to a valid object!
>>     error: refs/remotes/sourceware/cvs/fedora-2_3-branch does not point to a valid object!
>>     error: refs/remotes/sourceware/cvs/fedora-2_5-branch does not point to a valid object!
>>     [...]
>>     error: refs/tags/cvs/sparc-980522-merge does not point to a valid object!
>>     error: refs/tags/cvs/start does not point to a valid object!
>>     error: refs/tags/master-2008-11-27 does not point to a valid object!
>>     error: refs/tags/master-2009-02-10 does not point to a valid object!
>>     error: refs/tags/master-2009-07-10 does not point to a valid object!
>>     error: refs/top-bases/t/IOCTL_decode_argument does not point to a valid object!
>>     error: refs/top-bases/t/IOCTL_types does not point to a valid object!
>>     error: refs/top-bases/t/____longjmp_chk_cleanup_linux_x86_64 does not point to a valid object!
>>     error: refs/top-bases/t/bits_posix_opt.h__POSIX_THREADS does not point to a valid object!
>>     error: refs/top-bases/t/bits_pthreadtypes.h does not point to a valid object!
>>       baseline
>>       posix/regex_internal.c/MAX_undefined
>>       t/IOCTL_decode_argument
>>       t/IOCTL_types
>>       t/____longjmp_chk
>>       t/____longjmp_chk_cleanup_linux_x86_64
>>       t/__rtld_lock_recursive_t
>>     [...]
>>       t/verify.h
>>     * tschwinge/Roger_Whittaker
> 
> What git version are you using?
> 
> It seems to work for me:
> 
> $ mkdir s
> $ cd s
> $ git init
> $ echo a > a
> $ git add a
> $ git commit -m i
> $ cd ..
> $ git clone -s s c
> $ cd c
> $ git repack -a
> $ mv .git/objects/info/alternates .git/objects/info/alternates.orig
> $ git branch
> * master

Well, according to the log it worked for some branches for Thomas, just
not for all of them. I'm not surprised your test succeeds. In Thomas'
case it seems that repack is missing some dependencies, but it doesn't
even have an --all option or such.

Thomas: In addition to your git version, it would be good to know
whether you use any of

- grafts
- replaced objects
- multiple roots (branches without common commits)
- alternate chains (source repo borrowing objects from a third repo)

Michael
