X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Wink Saville <wink@saville.com>
Subject: Re: Resolving conflicts
Date: Fri, 01 Dec 2006 00:22:26 -0800
Message-ID: <456FE642.6020102@saville.com>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org> <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0611302353580.3695@woody.osdl.org> <Pine.LNX.4.64.0611302359400.3695@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 08:22:32 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
In-Reply-To: <Pine.LNX.4.64.0611302359400.3695@woody.osdl.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32871>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3f7-0005wG-Vq for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:22:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967492AbWLAIWW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:22:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967537AbWLAIWW
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:22:22 -0500
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net
 ([70.91.206.233]:46251 "EHLO saville.com") by vger.kernel.org with ESMTP id
 S967535AbWLAIWV (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006
 03:22:21 -0500
Received: from [192.168.0.52] (unknown [192.168.0.52]) by saville.com
 (Postfix) with ESMTP id A327B57A6F; Fri,  1 Dec 2006 00:18:24 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 30 Nov 2006, Linus Torvalds wrote:
>> No, kdiff3 probably doesn't have the same semantics, so better get the 
>> "real" merge. It's almost certainly in the rcs package, so "emerge rcs" 
>> should do it.
> 
> ..and just to be safe, remove the symlink first, so that you don't end up 
> overwriting the "kdiff3" binary by mistake when you install the real 
> "merge". Not that I think emerge is quite that stupid a package manager, 
> but anyway..
> 
> 		Linus
> 

Ubuntu is debian based and I use Synaptic GUI, a front end to apt-get. My earlier problem
was I couldn't find which package "merge" was in. But now I just figured it out by going
to debian.org and using "Search the contents of packages" for "merge". Turns out "merge"
is in devel/rcs which of course the whole world knows, unless your a neophyte like me:)

Any way after getting the real merge, I reverted the first pull and re-did it and all was well:

wink@winkc2d1:~/linux/linux-2.6$ git-checkout -f
wink@winkc2d1:~/linux/linux-2.6$ git-status
# On branch refs/heads/ace
nothing to commit
wink@winkc2d1:~/linux/linux-2.6$ git-pull . master
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with 0215ffb08ce99e2bb59eca114a99499a4d06e704
Merging:
d7083db038fb98266e331a7f96198ec35a12367a A partial fix BUG 061124 (crashing when 1ms interrrupts).
0215ffb08ce99e2bb59eca114a99499a4d06e704 Linux 2.6.19
found 1 common ancestor(s):
1abbfb412b1610ec3a7ec0164108cee01191d9f5 [PATCH] x86_64: fix bad page state in process 'swapper'
Auto-merging kernel/fork.c
Auto-merging kernel/spinlock.c

Merge made by recursive.
  Documentation/rtc.txt                         |  463 ++++++++++++++++---------
  Makefile                                      |    2
  arch/arm/configs/assabet_defconfig            |    1
  arch/arm/configs/cerfcube_defconfig           |    1
  arch/arm/configs/corgi_defconfig              |    1
......
  sound/pci/emu10k1/emu10k1_main.c              |    1
  sound/pci/hda/patch_realtek.c                 |    2
  sound/pci/hda/patch_sigmatel.c                |   14 -
  sound/usb/usbaudio.c                          |    3
  usr/Makefile                                  |    2
  92 files changed, 888 insertions(+), 371 deletions(-)
  create mode 100644 arch/mips/kernel/topology.c
  create mode 100644 arch/um/os-Linux/execvp.c
  create mode 100644 include/asm-arm/mach/udc_pxa2xx.h



Thank you very much,

Wink
