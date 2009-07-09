From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: 'git svn fetch' keeps giving a error after freezing
Date: Thu, 09 Jul 2009 14:01:39 +0200
Message-ID: <4A55DC23.7010806@drmicha.warpmail.net>
References: <h31vg6$b38$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Graeme Geldenhuys <graemeg@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 09 14:02:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MOsKH-0007tU-92
	for gcvg-git-2@gmane.org; Thu, 09 Jul 2009 14:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756714AbZGIMCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jul 2009 08:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756511AbZGIMB7
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jul 2009 08:01:59 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:51809 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756229AbZGIMB6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Jul 2009 08:01:58 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 2C0193B0570;
	Thu,  9 Jul 2009 08:01:57 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 09 Jul 2009 08:01:57 -0400
X-Sasl-enc: O2kkYxGpozS7HIK1OUt6QtvoW/kSgr71bn/c5Me6tt7K 1247140916
Received: from localhost.localdomain (heawood.math.tu-clausthal.de [139.174.44.4])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 99AB44BFF;
	Thu,  9 Jul 2009 08:01:56 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.1pre) Gecko/20090707 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <h31vg6$b38$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Graeme Geldenhuys venit, vidit, dixit 08.07.2009 13:21:
> Hi,
> 
> I'm using git-1.6.3.3 under Ubuntu Linux 8.04.2
> 
> I'm trying to convert (clone) a SubVersion repository to Git, so I can 
> host the mirror on GitHub, but for the last 4 days I don't get very far. 
> It seems to be getting a few files, then freezes and then gives the 
> error shown below. I'm now stuck around r2665 out of about 14,000 
> revisions. :-(
> 
> I have done such a clone before using a different SVN repository and 
> pulling in around 13,000 revisions, so my 'git svn' commands should work.
> 
> ==============================
> $ git svn fetch
> .....
>          A       fixes_2_0/fv/gadgets.pas
>          A       fixes_2_0/fv/colortxt.pas
>          A       fixes_2_0/fv/outline.pas
> RA layer request failed: REPORT of '/svn/fpc/!svn/vcc/default': Could 
> not read response body: connection was closed by server 
> (http://svn2.freepascal.org) at /usr/local/libexec/git-core/git-svn line 
> 4505
> ==============================
> 
> .git/config file contains the following (showing the SubVersion repository)
> 
> ======================
> ...snip...
> [svn-remote "svn"]
> 	url = http://svn2.freepascal.org/svn/fpc
> 	fetch = trunk:refs/remotes/trunk
> 	branches = branches/*:refs/remotes/*
> 	tags = tags/*:refs/remotes/tags/*
> ...snip...
> ======================
> 
> 
> Any thoughts on why I am getting this error?

Hmm, I cloned with standard layout and everything looks fine, see below.
Are you seeing the same problems on a fresh clone attempt (from an empty
dir)?

Between 2665 and 2674 I see no revisions, but those two are really small
changes. Can you 'svn log -r2664:2674' that range?

Michael

r13373 = c63340f4ac03767bcf049d88f0cd9a8ae3199090 (trunk)


Checking out files: 100% (10468/10468), done.


Checked out HEAD:


  http://svn2.freepascal.org/svn/fpc/trunk r13373

$ git branch -a
* master
  remotes/aspect
  remotes/avr
  remotes/cleanroom
  remotes/cpstr
  remotes/ctypes
  remotes/fixes_2_0
  remotes/fixes_2_2
  remotes/fixes_2_2_0_dos
  remotes/florian
  remotes/fpc_2_3
  remotes/generics
  remotes/genfunc
  remotes/inline
  remotes/janbruns
  remotes/linker
  remotes/linker@2665
  remotes/llvm
  remotes/merged
  remotes/newthreading
  remotes/objc
  remotes/rc_2_2_2
  remotes/release_2_1_2x
  remotes/release_2_2_4_rc1
  remotes/resources
  remotes/ssa
  remotes/tags/release_2_0_0
  remotes/tags/release_2_0_2
  remotes/tags/release_2_0_4
  remotes/tags/release_2_0_4_macos
  remotes/tags/release_2_0_4_rc1
  remotes/tags/release_2_0_4_rc2
  remotes/tags/release_2_0_4_rc3
  remotes/tags/release_2_1_2
  remotes/tags/release_2_1_4
  remotes/tags/release_2_2_0
  remotes/tags/release_2_2_2
  remotes/tags/release_2_2_2_rc1
  remotes/tags/release_2_2_2_rc2
  remotes/tags/release_2_2_4
  remotes/tags/test_2_0_4
  remotes/tags/test_2_0_4_1
  remotes/trunk
  remotes/tue
  remotes/unicodertl
  remotes/unicodestring
  remotes/unitrw
  remotes/wpo
