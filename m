From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Wed, 09 May 2007 15:44:28 -0700
Message-ID: <46424ECC.6030907@zytor.com>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home> <46413565.3090503@zytor.com> <81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com> <4641FDAF.3090608@zytor.com> <20070509213902.GA2593@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 00:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlutm-00063d-Qt
	for gcvg-git@gmane.org; Thu, 10 May 2007 00:44:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754745AbXEIWog (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 18:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbXEIWog
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 18:44:36 -0400
Received: from terminus.zytor.com ([192.83.249.54]:37358 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754745AbXEIWoe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 18:44:34 -0400
Received: from tazenda.hos.anvin.org (c-67-169-144-158.hsd1.ca.comcast.net [67.169.144.158])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l49MiSRG001504
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 9 May 2007 15:44:29 -0700
User-Agent: Thunderbird 2.0.0.0 (X11/20070419)
In-Reply-To: <20070509213902.GA2593@steel.home>
X-Enigmail-Version: 0.95.0
X-Virus-Scanned: ClamAV 0.88.7/3224/Wed May  9 08:25:29 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=1.7 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_03_06,RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL,TW_LR,TW_RW,TW_WX,
	TW_XR autolearn=no version=3.1.8
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46805>

Alex Riesen wrote:
>>>> Either way, it's still a bug that it stops for either checkin, ...
>>> Right. And because it is a bug, I'd like to have it fixed.
>>> So, what did you do in that fixup?
>> I'm sorry, I'm not sure I understand the question, in particular, I'm
>> getting the feeling I'm not sure what "that fixup" refers to.
>>
> 
> From your original report:
> 
> "git rebase dies horribly; on the first change it requires manual fixup,
> but it crashes on the second, with or without -m."
> 
> You mentioned that on the first change (I assumed it is the first time
> git-rebase stopped, complained, and asked for your help) "it" requires
> a "manual fixup". Which I assume you did, as it crashed on "second"
> (stop?). The "manual fixup" from the original report, what was it?
> Can you remember or find the sequence of commands you did before "it
> crashed on second"?

Ah, I used your technique of removing everything manually when the
rebase failed, and then doing a "git checkout" of arch/x86_64/boot.
That seemed to work.  I actually logged the commands, but threw out the
log after it worked, figuring it didn't tell you anything new :(

Trying to do a rebase again with 1.5.1.4 and see how it works gives only
one stop instead of two, so it's "halfway there":

: tazenda 14 ; git rebase stock
First, rewinding head to replay your work on top of it...
HEAD is now at a989705... Merge
git://git.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6

Applying 'x86 setup code rewrite: initial development snapshot'

Wrote tree bf3a4e990978bad7669dac117b0d482e53f1bcd7
Committed: f98b2dc7eff7f2ce9d039af794e7f0062cc42bf9

Applying 'MAINTAINERS: formally take responsibility for the i386 boot code'

Wrote tree 237806033e5c789752aa555a5aaba17c8b650c4c
Committed: e4fb08878f0fe2c2e72665315c35e698ece08101

Applying 'x86 setup: printf.c needs code16gcc.h'

Wrote tree 8be170c7240961ff47d13045412b2f8d66d54e20
Committed: 2a103e2db001d0d6a852861ea209b34ba97ffc6a

Applying 'x86 setup: in tty.c, actually tell it what character to print'

Wrote tree 0e487f781b874a8025e7fcd74e055abeee5ebe2e
Committed: da62daaf237756aab1330f8dc4842ca5e5fa4ac9

Applying 'build: setup sectors doesn't include the boot sector'

Wrote tree 66192f639721713010b65ddb6c40f0d7a1f51a0b
Committed: 5794cf95386551f0f97b7cae877845cbbb3ebfea

Applying 'x86 setup: segment descriptors need to be Present'

Wrote tree a3aa7db9741d1dc57007d97152a337b6532fc588
Committed: de616f57959c3b62a1ac544858a8bd41696d59dd

Applying 'x86 setup: make the video setup code actually do something...'

Wrote tree 9358db854ca73d9f6ac344c9dbc397a9913b4c86
Committed: 13a363f40ff51d61d5c553e529555c32425d7553

Applying 'x86 setup: fix missing semicolon in video-ati.c'

Wrote tree 0bbd82ef2e2bc2128c29ee8f8ca04399b86f8a98
Committed: d948a8ebb7f26f030264153fd801aca5dca47603

Applying 'x86 setup: fix memcmp_[fg]s()'

Wrote tree 368f27ee12eeeebfaad11bfabf6e087638e94b10
Committed: d5a63882787f4a927910307f2e8f3df0534643f6

Applying 'x86 setup: advance one e820 descriptor at a time...'

Wrote tree e7fb596232ed18cbddb6507ce8cb67e09a6326c9
Committed: ccfd63579f5df793701d44c46dd575629eabad85

Applying 'x86 setup: Call INT 15h AX=E820h properly'

Wrote tree bb010d0e1224ccbf4a0e201dab191448e84405d5
Committed: a84a8eab7e7d3708ad9cfdee67981eafe3a21b38

Applying 'x86 setup: remove assembly implementation of putchar and puts'

Wrote tree dc8d970b62d1be70175e04bed26dfa644f521cfd
Committed: 7356f51c11fc0e5f363a5f06df5274a7ccea73f5

Applying 'x86 setup: Sadly, Cirrus removed extended text modes from
their BIOS.'

Wrote tree 48560789f0ed319f77b529ea3f31e11126df6221
Committed: 06a5abda109eeadb34f3087b51e8a1f4cc69c3f3

Applying 'x86 setup: if no specific video mode ID is given, generate one'

Wrote tree 0366a71399c33ca08590aaa67df6438122529867
Committed: 56eb2476b71a917747bf6ea111568f9e5ba85e2c

Applying 'x86 setup: drop video mode range checking'

Wrote tree bd90ee84715e4eff9f1fafe7efc3c6440e6be69e
Committed: 668bf617eb273ddcefb007e3c5ec9bb4aa022894

Applying 'x86 setup: video.c: clean up unused stuff'

Wrote tree 1a2d47f784b5b64e7893a3364cbef1c8ba2a39cd
Committed: f38134d1296f5a09887b79cc6c4b13e34f77f293

Applying 'x86 setup: a20.c: make empty_8042() return status'

Adds trailing whitespace.
.dotest/patch:26:
warning: 1 line adds trailing whitespaces.
Wrote tree 0f46a1846afcaf61d7c4416d7f308ffd9d87d69c
Committed: 18a9e385504b85daa0e293e2a60309e34de4548e

Applying 'x86 setup: Modern ATI cards pass the probe but lacks the modes.'

Wrote tree 775608a82bd3783f5ba5dc00f7b4b7c39eb463ed
Committed: 0ed82f2809ec04d4db243d833e8cb5fcc029cd3e

Applying 'x86 setup: video.c: correct the handling of special mode numbers'

Wrote tree 9dae6d4dcc4bc2b98114a5a3ae6ff88bea7c60c3
Committed: af2b591e9c529b35b4cbb006b417cd6f16b87504

Applying 'x86 setup: remove references to obsolete probes'

Wrote tree f5605b2ab57ef0e52129c1809fa03c4b804b05cd
Committed: 30448725fe01982ab4ce7d28af609783c9d7eb32

Applying 'x86 setup: implement APM BIOS probe'

Wrote tree e46f5c4e318fa5f30ea221b90bdaa301876945cf
Committed: 293ae9fb21ebbfa6c834a016a20037a19b97bc5e

Applying 'x86 setup: clobber registers in keyboard BIOS call'

Wrote tree 98610c0970730f62d05412eaaadcec1528d94a98
Committed: 4b89273f6c78fe28b6f4aea161f64aa7ac2b8724

Applying 'x86 setup: tag functions noreturn; error message on A20 failure'

Adds trailing whitespace.
.dotest/patch:78:
warning: 1 line adds trailing whitespaces.
Wrote tree 605c96e3555b7bbbfd7b06306b225becff4ab09e
Committed: 72bd91360bbe365dc152e39f03229152c1e4f978

Applying 'x86 setup: whitespace cleanup'

Wrote tree 27230a23ba2f8b0aac3dddc264d7f4a28d18f8dc
Committed: 35f72771c466d83cc551bf81dfed22326048080e

Applying 'x86 setup: add CPU feature detect/abort on insufficient featurage'

Adds trailing whitespace.
.dotest/patch:20:setup-y                += header.o main.o mca.o
memory.o pm.o pmjump.o
warning: 1 line adds trailing whitespaces.
Wrote tree 405fde3817d89e7aba618bda965d4bcc24e825d5
Committed: 18e25bde0d246d828931ebd6450c63a4091e0fc1

Applying 'x86 setup: whitespace cleanup'

Wrote tree 8124b48b7b985ae31062356df521462e4420f09a
Committed: 91d417b3def3b38aeba165282746fa82e6de0fad

Applying 'x86 setup: files missing from previous checkin (cpu.c, cpureq.c)'

Wrote tree 2be68b923f0b413701f5f57b93aaca42cc126e49
Committed: a312ada92fdff09e0ca6cf60724353f8f5d3578a

Applying 'x86 setup: remove unused verify_cpu.S'

Wrote tree 7f3ebf06770406f4936ace5aef8a1b20e2676563
Committed: 0eaf9d747d1e0677aef4c762333b8b1988fe5ce3

Applying 'x86 setup: compile with -DSETUP'

Wrote tree 475e43922e02adad5ff1e9e1c77df1ff26cbdcc6
Committed: b843ca098801e962fed08f20ee99fb2f5cbd18fd

Applying 'x86 setup: cpu detection cleanups'

Wrote tree d72cabf9f1812da55506c38ddd88ef5dcd42f535
Committed: 45adb1922193dc5204d5bf07de9e5a8939b2688c

Applying 'x86 setup: remove bogus "static"'

Wrote tree 17281ee44c7ce686366464985b8d1a436d6d7468
Committed: 79ed2a26f0de632d0fb9cf36ccd30d99267975a2

Applying 'x86 setup: use CONFIG_X86_MINIMUM_CPU_MODEL'

Wrote tree 1e3a29b3de3dd86c46d2900485ef8206f948a72d
Committed: ed41358ab168c7e7e9eb1ddff44d995eb339879e

Applying 'x86: Kconfig.cpu: the minimum CPU model is always 3;
WP_WORKS_OK = i486'

Wrote tree d174addf546223baf87598db7673872608f6cb2c
Committed: 84c13f3993b812efbc781ae106fecc0e7478809e

Applying 'x86: make the handling of required features consistent'

Wrote tree c96d44bd1b12f0b4090db2bc60ffec5c54c1c4da
Committed: 48091cdd868350c0c98b0b11592606e850058737

Applying 'x86 setup: use the required masks from <asm/required-features.h>'

Adds trailing whitespace.
.dotest/patch:145:
Adds trailing whitespace.
.dotest/patch:156:
Adds trailing whitespace.
.dotest/patch:190:
Adds trailing whitespace.
.dotest/patch:200:
Adds trailing whitespace.
.dotest/patch:248:
warning: squelched 1 whitespace error
warning: 6 lines add trailing whitespaces.
Wrote tree 7f53ccc902a878e6bdae0446147b79f693bbbfe3
Committed: 22f4301757277e2d542fab95529c664413225efe

Applying 'x86 setup: remove reference to obsolete cpureq.c'

Wrote tree c77da037a2247c8f577e5167d6bfed833484c3a5
Committed: ed056f881d6c0698c233ee888d9c4e798c8ba736

Applying 'x86 setup: apparently $(src) is insufficient, needs
$(srctree)/$(src)'

Wrote tree 53ed308ffc67dd7bbca326facb578bc56091855c
Committed: 530888f2f6f9dceb7a3d1d5e2e5a5c4d56606136

Applying 'x86 setup: bootlin is *so* dead...'

Wrote tree 65574110a6702b6d2616441ce74e5c02bd53cb6c
Committed: f20bb507355d38b871f4bb2034b9303f4b0742e0

Applying 'x86 setup: paranoia: clear the high half of %esp'

Adds trailing whitespace.
.dotest/patch:15:
warning: 1 line adds trailing whitespaces.
Wrote tree 52d253ca3ff8dd7f8394762720501c99614a1b83
Committed: f9040dd40db9f08650201f2f32f56186b31a7dcb

Applying 'x86 setup: add missing linker script'

Wrote tree f9dd325985592248b878c4df0646fbc430e9cdd6
Committed: 877594775c44a72c802f4e8cba9db5db63223aa4

Applying 'x86 setup: cleanups for compatibility with x86-64'

Adds trailing whitespace.
.dotest/patch:125:
warning: 1 line adds trailing whitespaces.
Wrote tree d83528199922e40076dc373cd9d24daba9a15516
Committed: 907963662ce663a8deb3594c6c7f9783de1cbe3b

Applying 'x86-64: add CONFIG_PHYSICAL_ALIGN to match i386'

Wrote tree f6d6abdee2fceed761eef217dcc1c7ed0de9877e
Committed: a015ea48164d9e6a8ab317c26cbe555c3032f699

Applying 'x86-64: <asm/segment.h>: add boot segment descriptors'

Wrote tree e3abd746b0f94b58ed510264a62b123e995f08b6
Committed: 8e00cfafbf108a2801fb0ec8b824962b1e073d55

Applying 'x86-64: fix compilation errors due to required-features.h change'

Wrote tree a1626723ccdd339ac8ef0764c77b2cdccdfb2f26
Committed: 355b0dc242a05f72c7bc1ad8f73fdc6e82a39afc

Applying 'x86-64: verify_cpu.S: use new masks'

Wrote tree 117fbd16776cc9b201a0f76c9f3910cc7c1f8fa6
Committed: 14b6bc6f64844958c7f923ee46ce4e2356e21c08

Applying 'x86: unify <asm/boot.h>'

Wrote tree ce269d002a4645b5ef54b1f8eef086a43498c81e
Committed: d84e3cc9eb73c7feb084b35303e45828917e3115

Applying 'x86: Complete <asm/cpufeature.h> with the union of i386 and
x86-64'

Wrote tree 3f40077f38ceb45312a780390f8d8d5eb98ffe17
Committed: 03d199b61342108a9f37978bec06626710284cd1

Applying 'x86-64: rearrange includes due to unifications and inclusion
from setup'

Space in indent is followed by a tab.
.dotest/patch:44:               "661:\n\tlock; "
warning: 1 line adds trailing whitespaces.
Wrote tree 8f86e02ef672c98ae3519b9b3fabb3701a0ab1b9
Committed: 147328a824c71437259baf9a63fe03762bba74e0

Applying 'x86-64: Make arch/x86-64/boot a symlink to arch/i386/boot'

Wrote tree 9bc7ffd5d07a49c5a83fc8f9a680473995aa6c57
Committed: a859f67570bf62d2a602d27aa34a674e6645ca24

Applying 'x86: fix the definition of struct screen_info'

Wrote tree 258e5053597a572954943cb5b895e4462e6491fb
Committed: 951cf2086f5c2055e93b0db22c1064829bedc74e

Applying 'x86: fix differences between i386 and x86-64 <asm/e820.h>'

Wrote tree 6e4f4ed1de0a6736fb298d4e1adcae3b60f7a151
Committed: 3bec0726b8cfa624492b35659c5a13d484a1bc89

Applying 'i386: change %lu to %u in arch/i386/kernel/e820.h'

Wrote tree b05d8462dd9ce61fb32f61d2c9819877afe6be94
Committed: 7ab473d60f7bda2e7f7341bd9ca88610c5c440c5

Applying 'x86: move the bootparam structure definition into include/'

Wrote tree 3865d940f5be27cf70fe54aff3825b1f6c676a01
Committed: 3b5b95528bcf5487f79e659fe6346377955dd654

Applying 'x86 setup: E820MAX is a definitional constant; no need to use
sizeof hacks'

Wrote tree 6ba2914fb480e88633a7da7700dce60b1e619c22
Committed: 3db11fa860f9b06bf1b50f3fe698f0c6fb9e55ca

Applying 'x86 setup: boot_params.e820_map is just the map, not the
count; adjust'

Wrote tree 75308a18a561335d5a6a3613b51e130f43fcb00c
Committed: 4d6dea0f6c8ec5ac8580bcaee1c8d52f5d35e55a

Applying 'x86 setup: use 0x1e4 as scratch, instead of 0x3c'

Wrote tree 55fe315b3a931bdb3f1ea96ebc5098bcc24b0610
Committed: eca97ac06fa0f8d17b1ec974c890642afea62555

Applying 'x86-64: It appears MTRR isn't a required feature after all.'

Wrote tree 56fc138a5b01818142e200fa35921570270b53ac
Committed: 72c0fc6ecc2661245ae1fc42210a808a0ef63da1

Applying 'Revert "x86-64: Make arch/x86-64/boot a symlink to
arch/i386/boot"'

Adds trailing whitespace.
.dotest/patch:117:FDARGS =
Adds trailing whitespace.
.dotest/patch:350: * Page 0 is deliberately kept safe, since System
Management Mode code in
Adds trailing whitespace.
.dotest/patch:352: * useful for future device drivers that either access
the BIOS via VM86
Adds trailing whitespace.
.dotest/patch:648: *
Adds trailing whitespace.
.dotest/patch:649: * This is a collection of several routines from
gzip-1.0.3
error: arch/x86_64/boot/.gitignore: already exists in working directory
error: arch/x86_64/boot/Makefile: already exists in working directory
error: arch/x86_64/boot/compressed/Makefile: already exists in working
directory
error: arch/x86_64/boot/compressed/head.S: already exists in working
directory
error: arch/x86_64/boot/compressed/misc.c: already exists in working
directory
error: arch/x86_64/boot/compressed/vmlinux.lds: already exists in
working directory
error: arch/x86_64/boot/compressed/vmlinux.scr: already exists in
working directory
error: arch/x86_64/boot/install.sh: already exists in working directory
error: arch/x86_64/boot/mtools.conf.in: already exists in working directory
error: arch/x86_64/boot/tools/.gitignore: already exists in working
directory
error: arch/x86_64/boot/tools/build.c: already exists in working directory
Using index info to reconstruct a base tree...
Adds trailing whitespace.
<stdin>:117:FDARGS =
Adds trailing whitespace.
<stdin>:350: * Page 0 is deliberately kept safe, since System Management
Mode code in
Adds trailing whitespace.
<stdin>:352: * useful for future device drivers that either access the
BIOS via VM86
Adds trailing whitespace.
<stdin>:648: *
Adds trailing whitespace.
<stdin>:649: * This is a collection of several routines from gzip-1.0.3
warning: squelched 26 whitespace errors
warning: 31 lines add trailing whitespaces.
Falling back to patching base and 3-way merge...
fatal: Untracked working tree file
'arch/x86_64/boot/compressed/Makefile' would be overwritten by merge.
Failed to merge in the changes.
Patch failed at 0058.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To restore the original branch and stop rebasing run "git rebase --abort".
: tazenda 15 ; ls -ld arch/x86_64/boot
lrwxrwxrwx 1 hpa hpa 12 May  9 15:41 arch/x86_64/boot -> ../i386/boot/
: tazenda 16 ; rm -f arch/x86_64/boot
: tazenda 17 ; head -1 .dotest/0058
From cd312503f8e8a88895b12bf810677406284142e6 Mon Sep 17 00:00:00 2001
: tazenda 18 ; git checkout cd312503f8e8a88895b12bf810677406284142e6
arch/x86_64/boot
: tazenda 19 ; ls -ld arch/x86_64/boot
drwxrwxr-x 4 hpa hpa 4096 May  9 15:42 arch/x86_64/boot/
: tazenda 20 ; git rebase --continue

Applying 'Revert "x86-64: Make arch/x86-64/boot a symlink to
arch/i386/boot"'

Wrote tree 454be72b74038289064303704fa095e220539518
Committed: 7f942303bf26e31d10bf96b8d3fb3f1ee50a73a9

Applying 'x86-64: use 0x1b4 as the scratch area in boot_params, not 0x3c'

Wrote tree a9634c1b3aa7bdc5d7de6d8fcdafaef851181f2b
Committed: 3f23a6bd448bc9b00718b412170ee2ed752eec8f

Applying 'x86 setup: share code between i386 and x86-64'

Wrote tree 8397248a3723de8f0b31c6b5ed7f60d968c1631b
Committed: 72fe7620458f84e676dd40fdbe66835135e8a77c

Applying 'x86-64: remove -traditional from AFLAGS'

Wrote tree 5a27b91ebc542b2769347837734890e2043d1b4a
Committed: 2f8b9521f04effda7b8150c4302aff469245c5ef

Applying 'x86 setup: move all VESA-related code into video-vesa.c; add EDID'

Adds trailing whitespace.
.dotest/patch:86:
warning: 1 line adds trailing whitespaces.
Wrote tree e3289a29203434e4d683254f2aee077ddd4ae63c
Committed: f579842ed1a0dbabadc5359a7490c6a990bc7cb6

Applying 'x86 setup: allow setting of VESA graphics modes; cleanups'

Adds trailing whitespace.
.dotest/patch:68:
warning: 1 line adds trailing whitespaces.
Wrote tree 44eebedb0cb6cb40a10aec011103d0271a5e3fd3
Committed: e9cbeb161b71ac237d9bf8c8afd15f9a35eedb20

Applying 'x86 setup: whitespace cleanup'

Wrote tree eec8d62c5c9db76d918815f113d802a7a3d0d7f5
Committed: e3c55080c3db6dd3a9836fe7cd99bbdbb98bf84d

Applying 'x86 setup: implement screen contents save/restore'

Wrote tree f135c21ddd2b6af70f97c1380dbcd460267ec177
Committed: 53be00bc3919c2c565776bb408ecdc0ea5dbc261

Applying 'x86 setup: coppyright rPath, Inc.'

Wrote tree 47f7505f0436b527839190ee26029d520f17d25e
Committed: 2bf2c30e18fef98061ec0272e957d8faa387b6a0

Applying 'i386 boot protocol: boot loaders should allow more heap for
bzImage'

Wrote tree 4c5790a4a6ccf697e94729c3f5dec8d4d34a3dbc
Committed: 7439514e936c899639c6731f29a4988e7b66aa36

Applying 'x86 setup: actually check the end of the heap.'

Wrote tree 3ed25ec4913189031ccfd5368969cfd77a1fbece
Committed: ab7cd52538086dc095289a981c9177e956abf354

Applying 'x86 setup: when watching the setup size, take the stack into
account'

Wrote tree 34fa356d84aaa5241a281a8b01f04a059b5b353b
Committed: f3691d413e883e956213fc45cc132f7f76d7d3b7

Applying 'x86 setup: Factor out the environment-independent part of the
CPU check.'

Adds trailing whitespace.
.dotest/patch:239:
Adds trailing whitespace.
.dotest/patch:263:
warning: 2 lines add trailing whitespaces.
Wrote tree bae2277d4c4d40ba7b8fc11a25342ff4c023ef49
Committed: 85a238ecc2371cde07117d34524c71f9c96bc2f7

Applying 'x86 setup: be more paranoid about the stack setup in header.S'

Wrote tree 1b5fa9f3d37d361e6b47bb4e7142ecbe89eb552c
Committed: 58643e76ef2630ae5e7b0541c5fd0e8183141a10

Applying 'x86 setup: compile with -fomit-frame-pointer'

Wrote tree 3cd438bea06b27992940ce53fc56f16737d77c74
Committed: b36cd32f74a8be03dc23cd20b65c5c08dfae50ae

Applying 'x86 setup: remove double nesting of a20_test()'

Wrote tree 941b5ec12d8a1e82949ad0cd3932537f91eb5e8d
Committed: 53cdb8049013d6f72d3cfb5be0bd9999fbff2a97

Applying 'x86 setup: remove code moved from cpucheck.c -> cpu.c'

Wrote tree d83b020d216f92186026208576b5170b61ffd382
Committed: d5afa72f8eb28cc1e245b321dfa19fb620970900

Applying 'x86 setup: swap cpu.c and cpucheck.c; rename functions'

Adds trailing whitespace.
.dotest/patch:489:
Adds trailing whitespace.
.dotest/patch:512:
warning: 2 lines add trailing whitespaces.
Wrote tree 41d79ce765e1174464c47bff61c4330e23bf6382
Committed: f2c63bb8e16d9b3c67ad1fdbc7ae1f5e18286662

Applying 'x86 setup: add -fno-stack-protector; other Makefile fixes'

Wrote tree 65c5d385ff3bc54b65881629f72e4583c69a737e
Committed: 7ea7f8dbb4103d43b90fb6cc6f32c923b1f658e8

Applying 'x86 setup: add missing file "bitops.h" missing from previous
checkins'

Wrote tree 01beebe04609804ef88762e794fdd71daff89bf1
Committed: 7eaa98edb81e9937128ce342f626177ee8a68941
: tazenda 21 ;
