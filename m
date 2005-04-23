From: Russell King <rmk@arm.linux.org.uk>
Subject: Catching up: git-pasky-0.6.2 broken?
Date: Sat, 23 Apr 2005 12:47:58 +0100
Message-ID: <20050423124758.B32116@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Apr 23 13:44:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPJ3Z-0008V8-6D
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 13:44:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVDWLst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Apr 2005 07:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVDWLst
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Apr 2005 07:48:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:48137 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261558AbVDWLsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Apr 2005 07:48:04 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DPJ7A-0005pD-Fo
	for git@vger.kernel.org; Sat, 23 Apr 2005 12:48:01 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DPJ79-0003ox-2O
	for git@vger.kernel.org; Sat, 23 Apr 2005 12:47:59 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I've been away from git stuff since about Wednesday due to eye problems.
Yesterday and today, I've been trying to catch up, but I'm running into
problems.

I grabbed git-pasky-0.6.2, and followed Linus' message about converting
repositories.  I've updated all the "heads", and cleaned out all the old
sha1 files.  After updating, I did a read-tree for the tracked head,
followed by checkout-cache -f -a and update-cache --refresh.

Therefore, in theory, everything should be in sync.

However, git pull now has nasty side effects.  At first I thought this
was down to something still being out of sync.  However, on the second
pull, it's still producing the same complaints.

It's almost although git has a single patch file subversely written into
it to apply lpfc and qla changes which it's trying to apply irrespective
of the objects downloaded.

Any ideas what's going on?

First pull
==========

MOTD:	
MOTD:	Welcome to the Linux Kernel Archive.
MOTD:	
MOTD:	Due to U.S. Exports Regulations, all cryptographic software on this
MOTD:	site is subject to the following legal notice:
MOTD:	
MOTD:	This site includes publicly available encryption source code
MOTD:	which, together with object code resulting from the compiling of
MOTD:	publicly available source code, may be exported from the United
MOTD:	States under License Exception "TSU" pursuant to 15 C.F.R. Section
MOTD:	740.13(e).
MOTD:	
MOTD:	This legal notice applies to cryptographic software only.
MOTD:	Please see the Bureau of Industry and Security,
MOTD:	http://www.bis.doc.gov/ for more information about current
MOTD:	U.S. regulations.
MOTD:	


receiving file list ... done
00/2609c5adf1ac2cda36a0f0a70edd12f00216a2
...
ff/ba7c235ad94e3c1e0074cb209504e6ea25afe3

sent 6332 bytes  received 3234006 bytes  36613.99 bytes/sec
total size is 65480464  speedup is 20.21

receiving file list ... done
client: nothing to do: perhaps you need to specify some filenames or the --recursive option?
Tree change: c4d541106bc5d0a2134aaf9e8735eee3c70b0db2:efab7739d99eae948971140b2aa3dddf7f72c900
*100644->100644	blob	8e5f9bbdf4de94a1bc4b4da8cb06677ce0a57716->8da3a306d0c0c070d87048d14a033df02f40a154	Makefile
*100644->100644	blob	faab8c2a03ebda9eb4e12c35f5398733320484f0->3864b33562ee973643c7800e1129c1fa3239d2ed	arch/alpha/kernel/systbls.S
*100644->100644	blob	8d182e875cd72e64b49869386bf090ba23df6793->16dbc4151be43b8e671869b2a52220f47ec0b6ac	arch/i386/kernel/cpu/amd.c
*100644->100644	blob	6a717d4d2bc5d44f07b57c01683196ef7f51f349->c60785c046bebd09452b3c73b54df90e6dd3a937	arch/sparc64/kernel/time.c
*100644->100644	blob	f94ea8a44051524639412986ac1d86677df5c9c2->f80bafee8669fbcb0420d6e5173ea1f79e863082	arch/x86_64/lib/getuser.S
*100644->100644	blob	0dee1fdcb16280d3d0bb0053ab8634072adfda45->5828b8191667da13f3295034a685f474746ce3b2	arch/x86_64/lib/putuser.S
*100644->100644	blob	97ff364c04341ef866ecd4d70e60e0a1e415b743->6cb0b586c29761d2e3873219a692f83ace1017d6	drivers/ieee1394/ohci1394.c
*100644->100644	blob	3c092117a8eae4a7916967b065ac447f999946e9->260a323a96d38c07003f80b92c2b3dad5c2c025a	drivers/isdn/i4l/isdn_ppp.c
*100644->100644	blob	12de80884b1aa6e4240e5a40360369b9dd9b270b->f65ca3b2da6f3fcdb464cd8f9d0b53b5611103b1	drivers/net/tg3.c
*100644->100644	blob	d48887d9032501413515a7b53fcb183737de490f->8de6f21037bae13910b0f9c8f075a8d38b89db69	drivers/net/tg3.h
*100644->100644	blob	bf3273eb1c8b78764d4b7c563a2585181925e9a4->49d1cd99d5accfadf2eb276644f57a8f1ffec27a	drivers/sbus/char/rtc.c
*100644->100644	blob	d74b99dab7ec8d11003a176fa4685f2b9f85c4ae->e60f9338e44ad4a2eb938adcc70a491c9a09815d	drivers/scsi/aic7xxx/aic7xxx_osm.c
*100644->100644	blob	8caaf2e5e47c01815e5e570b67d1c329a0e91402->39b788d95e39d9eb8f11578552f03933ad0b4e52	drivers/serial/sunsab.c
*100644->100644	blob	23d19d39432080cf72a1b9ecfee9ca8a7c5eda4e->ddc97c905e14cc7a158a22f339379d0129e81551	drivers/serial/sunsu.c
*100644->100644	blob	3099630d0c3d0b0e4cd17513085c1c1500784dc3->9d9d2009ad8caa3af457d263afa5c8717227016a	drivers/video/tgafb.c
*100644->100644	blob	c4e70e8617eb6b269891c06ace602dce81f12998->535bc425f243bd7cb9fd0b469c50cc2d3bdb102c	include/asm-alpha/unistd.h
*100644->100644	blob	925d54cee475ed9976455fddb35f8768f6020ff0->7232528e2d0c13771f6f62af20de13455aedb30b	include/asm-ia64/bitops.h
*100644->100644	blob	7c357dfbae50dc400b63c39e0f6add7a214a28a7->4fb4e439b05c35eca06daf2762936939c3e1b333	include/asm-ia64/gcc_intrin.h
*100644->100644	blob	ccf2f5f82d7f516b29f8ce841d24e394612f4b47->1f9b1356a48e9e84261676e449597ba05ecaaf88	include/asm-sparc64/mostek.h
*100644->100644	blob	af9bf175a223cf44310293287d50302e0fd3f9e9->ae2cd5b09a7cc523e96640d805eb97e299da8907	include/asm-sparc64/pgtable.h
*100644->100644	blob	11efa474865bd20eef9b0a13f42749a6e999da2a->d1f91a4f24ae59f78ed81dbed825cb09f9677e5c	include/asm-sparc64/spinlock.h
*100644->100644	blob	f1f75fde8cd46d668b5fe68b64259939a0f0f17a->6a1897481942e5dcfd1314d5f7b81e2c6ae36280	include/linux/pci_ids.h
*100644->100644	blob	aa35797ebfbf773fae3203094d6c6628ed7bcf35->22b701819619cd6403b834284deecdbdcfb553d4	include/linux/skbuff.h
*100644->100644	blob	fb95ecb6fe0357de875dd66896b4d48a731927d4->875edbba396d2601fce49e8e1c88f90195b56698	include/net/ax25.h
*100644->100644	blob	d1fea5c3dda1b08989e8acfed841129e229421b5->876dbac71060860956f2e939c81efe2b91512775	net/appletalk/ddp.c
*100644->100644	blob	33f1685dbb771abd4db19520fa709a701909421c->a57a9268bd2436e565cdaf1e15cc9dcf10bb14c7	net/atm/resources.c
*100644->100644	blob	6ff803154c046d6e174713951962331e1fef7548->f7c449ac1800cffe9cb355806886f7d1d19e8950	net/atm/signaling.c
*100644->100644	blob	33b1a376302702fea9de736808a7923b0695e9b1->707097deac3deb4957741204c7944e01521f3c0f	net/ax25/af_ax25.c
*100644->100644	blob	04d711344d559e712f5389315e596684933e1fe1->bba0173e2d6500a44954871389fc5e35396dffa2	net/ax25/ax25_ip.c
*100644->100644	blob	3475a3ac9343e38e2d051402f34676b956fd65cf->94557b1a1fa2acedd47b30c3e51b9733eb02b53a	net/ax25/ax25_out.c
*100644->100644	blob	8cf72707af8bbcf7ede4fcf1775887cbe910df6e->99694b57f6f565d36f6787f58c8faa43cced25d2	net/ax25/ax25_subr.c
*100644->100644	blob	d69ad90e58116594de2d66a26f9bc78dfa183d95->44dfaf8f04afd7cbde0487a5a35ccef5eb4f48ce	net/core/rtnetlink.c
*100644->100644	blob	bf02ca9f80ac15bfaddf9ef0624e94c5623802e0->f65b3de590a96ff2ecc7df6b7a4b9020a641e549	net/core/skbuff.c
*100644->100644	blob	f52c87a9268a772398e937a80730d576ab32a066->4df4fa3c5de047e3ee099b64b38c4948b2dd406a	net/core/sock.c
*100644->100644	blob	9f91a116d91926df3ba936a80f020a6ab1084d2b->bb90a0c3a91eb52020d0db0e8b4f94d30e02d596	net/ipv4/route.c
*100644->100644	blob	6baddfbedca3f90adaef9f22e2e97d889cbdc945->8a213238f2873e8a985bf1c85b1f8f347d8f7d8c	net/ipv4/udp.c
*100644->100644	blob	5ffde14ddc09547085f02646e4399053429f3cbd->7196ac2f2d1688d410e2f51973f90c0118549c63	net/ipv6/addrconf.c
*100644->100644	blob	49208ba75094a32c18987070727b4f6998d78680->0f0711417c9da71d7595e6019033b8976d479b03	net/ipv6/ip6_output.c
*100644->100644	blob	5488ad0de4f6bd227665657fc65b7fce4fafcca4->1352c1d9bf4d35f6619d3dce4996b69578bdb2d2	net/ipv6/raw.c
*100644->100644	blob	1db59f11f37d687318ae8cbd5e2ea6e48142ca97->d11747c2a763f27a0a37eae59352bf61891a26b8	net/xfrm/xfrm_state.c
Tracked branch, applying changes...
Fast-forwarding c4d541106bc5d0a2134aaf9e8735eee3c70b0db2 -> efab7739d99eae948971140b2aa3dddf7f72c900
	on top of c4d541106bc5d0a2134aaf9e8735eee3c70b0db2...
diff: Documentation/scsi/qla2xxx.revision.notes: No such file or directory
diff: drivers/scsi/qla2xxx/qla_listops.h: No such file or directory
diff: drivers/scsi/scsi_obsolete.h: No such file or directory
The next patch would create the file Documentation/scsi/ChangeLog.lpfc,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/scsi/ChangeLog.lpfc.rej
The next patch would create the file Documentation/scsi/lpfc.txt,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/scsi/lpfc.txt.rej
The next patch would create the file arch/arm/lib/bitops.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file arch/arm/lib/bitops.h.rej
The next patch would create the file drivers/scsi/lpfc/Makefile,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/Makefile.rej
The next patch would create the file drivers/scsi/lpfc/lpfc.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_attr.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_attr.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_compat.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_compat.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_crtn.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_crtn.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_ct.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_ct.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_disc.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_disc.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_els.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_els.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_hbadisc.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_hbadisc.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_hw.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_hw.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_init.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_init.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_logmsg.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_logmsg.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_mbox.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_mbox.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_mem.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_mem.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_nportdisc.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_nportdisc.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_scsi.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_scsi.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_scsi.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_scsi.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_sli.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_sli.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_sli.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_sli.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_version.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_version.h.rej
The next patch would create the file drivers/scsi/qla2xxx/qla_attr.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/qla2xxx/qla_attr.c.rej
The next patch would create the file Documentation/aoe/todo.txt,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/aoe/todo.txt.rej
The next patch would create the file Documentation/kref.txt,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/kref.txt.rej

Second pull
===========

MOTD:	
MOTD:	Welcome to the Linux Kernel Archive.
MOTD:	
MOTD:	Due to U.S. Exports Regulations, all cryptographic software on this
MOTD:	site is subject to the following legal notice:
MOTD:	
MOTD:	This site includes publicly available encryption source code
MOTD:	which, together with object code resulting from the compiling of
MOTD:	publicly available source code, may be exported from the United
MOTD:	States under License Exception "TSU" pursuant to 15 C.F.R. Section
MOTD:	740.13(e).
MOTD:	
MOTD:	This legal notice applies to cryptographic software only.
MOTD:	Please see the Bureau of Industry and Security,
MOTD:	http://www.bis.doc.gov/ for more information about current
MOTD:	U.S. regulations.
MOTD:	


receiving file list ... done
0d/535d65eea6aa98bcd6e4e4b4f797c1fde76d7b
24/0676f75390f530b4b66521bbaf6b8b1a8e3df4
39/1f2ade8823149f217991eb02911bf3dacce050
43/765d4b40a4a3c64f2a32b684f4041e2f01644d
67/3f29d947909a1be0e3775c633d2067a032541c
68/0815c59c80b53903030462d797b828f903946f
71/30667107cd3ab9d6802b69bab63c7d22f20bd4
72/28a8ff004baa2eea325c0dc1286ef38306828d
73/5cd74942b2cb978b58e687bc398e965b14a6f9
7c/43aea5f7f7d9b96b7d9837fa029e16b62ef5df
8d/3a9291b47f835c43c25d916e400828d590798f
aa/aff8e835197c8bd0cbbbbabb7eefde0aabe1a8
ab/489271df7495243e4e0ca6e1f96cd29eb364a9
b4/467b2d08a139961e709cfb41bd1f9280249155
b4/f26bd7be080b1c231039213e92c654be69dedd
b8/d8b883e6f029e99c35c88f853501740e322131
c4/cb74271bca0d0da13cc650a1021f4c8a0a5b87
ca/1536db339408c146fad0eba08919d4fcc80d97
cc/e8ba589e47e268f952f50e8e84bf1e71e0daea
d5/35fc13bf9828e006c83a3eaf37f343ccbd43af
df/6c6804ce1d383c878ab071bce8125125d96abc
e8/0715f8be1ed15ce5e6721d3787e5f7071e4320
eb/b89be2aa2dba5acbcaf7773414ff7ca51a1b87
ef/3fd7265b67c8b6152ad3557162b8488d142231

sent 592 bytes  received 1020532 bytes  18072.99 bytes/sec
total size is 65546393  speedup is 64.19

receiving file list ... done
client: nothing to do: perhaps you need to specify some filenames or the --recursive option?
Tree change: efab7739d99eae948971140b2aa3dddf7f72c900:df6c6804ce1d383c878ab071bce8125125d96abc
*100644->100644	blob	19b02adce68cd315d7d44cc13ab7cdc29bb82c83->ebb89be2aa2dba5acbcaf7773414ff7ca51a1b87	arch/ia64/ia32/ia32_signal.c
*100644->100644	blob	105c7fec8c6d20b128631c1e46fb4c892cd274f9->8d3a9291b47f835c43c25d916e400828d590798f	arch/ia64/kernel/head.S
*100644->100644	blob	cf3f8014f9ad6fecfb5f0f43d257b539540074a6->ef3fd7265b67c8b6152ad3557162b8488d142231	arch/ia64/kernel/mca_asm.S
*100644->100644	blob	91293388dd2947c67d941f7b487b100bb7060fdc->7c43aea5f7f7d9b96b7d9837fa029e16b62ef5df	arch/ia64/kernel/process.c
*100644->100644	blob	5318f0cbfc260b3bd3295a5fd0b9daffe045d0c7->ca1536db339408c146fad0eba08919d4fcc80d97	arch/ia64/kernel/smpboot.c
*100644->100644	blob	ea1ed377de4cf5d7577b98a120267973abbdfce5->240676f75390f530b4b66521bbaf6b8b1a8e3df4	include/asm-ia64/sal.h
Tracked branch, applying changes...
Fast-forwarding efab7739d99eae948971140b2aa3dddf7f72c900 -> df6c6804ce1d383c878ab071bce8125125d96abc
	on top of efab7739d99eae948971140b2aa3dddf7f72c900...
diff: Documentation/scsi/qla2xxx.revision.notes: No such file or directory
diff: drivers/scsi/qla2xxx/qla_listops.h: No such file or directory
diff: drivers/scsi/scsi_obsolete.h: No such file or directory
The next patch would create the file Documentation/scsi/ChangeLog.lpfc,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/scsi/ChangeLog.lpfc.rej
The next patch would create the file Documentation/scsi/lpfc.txt,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/scsi/lpfc.txt.rej
The next patch would create the file arch/arm/lib/bitops.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file arch/arm/lib/bitops.h.rej
The next patch would create the file drivers/scsi/lpfc/Makefile,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/Makefile.rej
The next patch would create the file drivers/scsi/lpfc/lpfc.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_attr.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_attr.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_compat.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_compat.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_crtn.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_crtn.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_ct.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_ct.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_disc.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_disc.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_els.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_els.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_hbadisc.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_hbadisc.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_hw.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_hw.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_init.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_init.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_logmsg.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_logmsg.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_mbox.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_mbox.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_mem.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_mem.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_nportdisc.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_nportdisc.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_scsi.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_scsi.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_scsi.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_scsi.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_sli.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_sli.c.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_sli.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_sli.h.rej
The next patch would create the file drivers/scsi/lpfc/lpfc_version.h,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/lpfc/lpfc_version.h.rej
The next patch would create the file drivers/scsi/qla2xxx/qla_attr.c,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file drivers/scsi/qla2xxx/qla_attr.c.rej
The next patch would create the file Documentation/aoe/todo.txt,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/aoe/todo.txt.rej
The next patch would create the file Documentation/kref.txt,
which already exists!  Assume -R? [n] 
Apply anyway? [n] 
Skipping patch.
1 out of 1 hunk ignored -- saving rejects to file Documentation/kref.txt.rej


-- 
Russell King

