From: "Ben Williamson" <benw@pobox.com>
Subject: git-svn: Missing files
Date: Thu, 20 Jul 2006 12:02:38 +1000
Message-ID: <b6327a230607191902n47b81993x8caea2df3955d8c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Jul 20 04:02:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3NsM-00021U-Pn
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 04:02:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932556AbWGTCCk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 22:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWGTCCk
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 22:02:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:44437 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932556AbWGTCCk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jul 2006 22:02:40 -0400
Received: by ug-out-1314.google.com with SMTP id o2so584707uge
        for <git@vger.kernel.org>; Wed, 19 Jul 2006 19:02:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=gwVr+09gYuC3AprZJD7QAEf8IkjjPbQBN+Z+jsBgiiAiiFuInO4s6g6nwYCq6LjVJljgW3SIktCeI1TSOoL1Lh2wWno6BQcltLKq3AmQ8/lkK2EP+X4fx35sdjrL7UAD4JaF1+ZshNdtnTU/LZgYAe7cjQ1KTfpV6UApII1pngo=
Received: by 10.78.170.17 with SMTP id s17mr57684hue;
        Wed, 19 Jul 2006 19:02:38 -0700 (PDT)
Received: by 10.78.126.12 with HTTP; Wed, 19 Jul 2006 19:02:38 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
X-Google-Sender-Auth: 0a606a97e01c8f0b
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24013>

Hi all,

I'm probably confused, but it seems like git-svn has missed some files
while importing the buildroot sources. I did this:

  git-svn init svn://uclibc.org/trunk/buildroot
  git-svn fetch

Then I used gitk to find the revision corresponding to svn's r15711,
and checked that out:

  git-checkout -b test c84f9463b67bdb57c93bec571b1118b37cb597ce

commit c84f9463b67bdb57c93bec571b1118b37cb597ce
Author: vapier <vapier@69ca8d6d-28ef-0310-b511-8ec308f3f277>
Date:   Mon Jul 17 03:53:12 2006 +0000

    fix whitespace

    git-svn-id: svn://uclibc.org/trunk/buildroot@15711
69ca8d6d-28ef-0310-b511-8ec308f3f277

The resulting tree is missing a bunch of files, compared to what I
checked out with svn:

  svn export -r15711 svn://uclibc.org/trunk/buildroot buildroot

Also, if I use git-svn to only fetch r15711 then I get what I expect,
with no missing files. The tree is the same as the 'svn export' minus
a few empty directories:

  git-svn init svn://uclibc.org/trunk/buildroot
  git-svn fetch -r15711

I've listed the missing files below. There are no other differences -
all the files that did turn up are identical in all three trees ("svn
export", "git-svn fetch" and "git-svn fetch -r15711").

Disclaimer: I'm no subversion expert, and I'm fairly new to git. But
git rocks, and I'd love somewhere to locally commit my hacks to
subversion projects like buildroot.

Thanks!

- Ben.


diff -ur --exclude .git svn-export/buildroot git-svn-fetch-all/buildroot
Only in svn-export/buildroot/package: linux
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
003_kbuild_fixes.diff.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
004_386_emu.diff.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
005_modularize_vesafb.diff.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
006_init_unshare.diff.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
008-ieee1394-fix.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
009-always-inline.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
010-optimize-for-size.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
012-x86-check_gcc.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
015_cramfs_initrd.diff.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
017-printk.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
018-slab-loop-init.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
041-changeloop.patch.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
042-loopfixes.patch.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
062-silence-blk-queue.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
063-silence.kbd.patch.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
064-shutup-md.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
076-nmap-freak.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
077-orinoco-0.13e.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
078-hostap.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
079-jiffies64.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
089-no-touch-makedep.bz2
Only in svn-export/buildroot/target/device/Soekris/net4521/kernel-patches:
100_VERSION.bz2
Only in svn-export/buildroot/target/generic: access_point
Only in svn-export/buildroot/target/generic: firewall
Only in svn-export/buildroot/target/generic/target_skeleton/etc: fstab
Only in svn-export/buildroot/target/generic/target_skeleton/etc: hostname
Only in svn-export/buildroot/target/generic/target_skeleton/etc: hosts
Only in svn-export/buildroot/target/generic/target_skeleton/etc/init.d: rcS
Only in svn-export/buildroot/target/generic/target_skeleton/etc/init.d:
S40network
Only in svn-export/buildroot/target/generic/target_skeleton/etc: inittab
Only in svn-export/buildroot/target/generic/target_skeleton/etc: inputrc
Only in svn-export/buildroot/target/generic/target_skeleton/etc: issue
Only in svn-export/buildroot/target/generic/target_skeleton/etc: network
Only in svn-export/buildroot/target/generic/target_skeleton/etc: passwd
Only in svn-export/buildroot/target/generic/target_skeleton/etc: profile
Only in svn-export/buildroot/target/generic/target_skeleton/etc: protocols
Only in svn-export/buildroot/target/generic/target_skeleton/etc: random-seed
Only in svn-export/buildroot/target/generic/target_skeleton/etc: securetty
Only in svn-export/buildroot/target/generic/target_skeleton/etc: services
Only in svn-export/buildroot/target/generic/target_skeleton/etc: shadow
Only in svn-export/buildroot/target/generic/target_skeleton/etc: TZ
Only in svn-export/buildroot/target/generic/target_skeleton: root
Only in svn-export/buildroot/target/generic/target_skeleton: usr
Only in svn-export/buildroot/toolchain/binutils: 2.16.91.0.6
Only in svn-export/buildroot/toolchain/binutils/2.16.91.0.7:
300-001_ld_makefile_patch.patch
Only in svn-export/buildroot/toolchain/binutils/2.16.91.0.7:
300-006_better_file_error.patch
Only in svn-export/buildroot/toolchain/binutils/2.16.91.0.7:
300-012_check_ldrunpath_length.patch
Only in svn-export/buildroot/toolchain/binutils/2.16.91.0.7:
400-mips-ELF_MAXPAGESIZE-4K.patch
Only in svn-export/buildroot/toolchain/binutils/2.16.91.0.7:
702-binutils-skip-comments.patch
Only in svn-export/buildroot/toolchain/binutils: 2.17
Only in svn-export/buildroot/toolchain/binutils: 2.17.50.0.2
Only in svn-export/buildroot/toolchain/binutils: 2.17.50.0.3
Only in svn-export/buildroot/toolchain/gcc/3.4.6: 100-uclibc-conf.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6: 200-uclibc-locale.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6: 300-libstdc++-pic.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6:
600-gcc34-arm-ldm-peephole.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6: 601-gcc34-arm-ldm.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6:
601-gcc34-arm-ldm-peephole2.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6:
602-sdk-libstdc++-includes.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6: 700-pr15068-fix.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6: 71_all_sh-pr16665-fix.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6:
72_all_sh-no-reorder-blocks.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6: 73_all_sh-pr20617.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6:
800-powerpc-libc_stack_end-uclibc.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6: 900-nios2.patch
Only in svn-export/buildroot/toolchain/gcc/3.4.6:
arm-softfloat.patch.conditional
Only in svn-export/buildroot/toolchain/gcc/4.0.3: 100-uclibc-conf.patch
Only in svn-export/buildroot/toolchain/gcc/4.0.3: 200-uclibc-locale.patch
Only in svn-export/buildroot/toolchain/gcc/4.0.3: 300-libstdc++-pic.patch
Only in svn-export/buildroot/toolchain/gcc/4.0.3: 301-missing-execinfo_h.patch
Only in svn-export/buildroot/toolchain/gcc/4.0.3: 302-c99-snprintf.patch
Only in svn-export/buildroot/toolchain/gcc/4.0.3:
303-c99-complex-ugly-hack.patch
Only in svn-export/buildroot/toolchain/gcc/4.0.3:
602-sdk-libstdc++-includes.patch
Only in svn-export/buildroot/toolchain/gcc/4.1.1: 100-uclibc-conf.patch
Only in svn-export/buildroot/toolchain/gcc/4.1.1: 301-missing-execinfo_h.patch
Only in svn-export/buildroot/toolchain/gcc/4.1.1: 302-c99-snprintf.patch
Only in svn-export/buildroot/toolchain/gcc/4.1.1:
303-c99-complex-ugly-hack.patch
Only in svn-export/buildroot/toolchain/gcc/4.1.1: 304-index_macro.patch
Only in svn-export/buildroot/toolchain/gcc/4.1.1: 740-sh-pr24836.patch
Only in svn-export/buildroot/toolchain/gcc/4.1.1: 800-arm-bigendian.patch
Only in svn-export/buildroot/toolchain/gcc/4.2: 103-uclibc-conf-noupstream.patch
Only in svn-export/buildroot/toolchain/gcc/4.2: 203-uclibc-locale-no__x.patch
Only in svn-export/buildroot/toolchain/gcc/4.2:
204-uclibc-locale-wchar_fix.patch
Only in svn-export/buildroot/toolchain/gcc/4.2: 301-missing-execinfo_h.patch
Only in svn-export/buildroot/toolchain/gcc/4.2: 302-c99-snprintf.patch
Only in svn-export/buildroot/toolchain/gcc/4.2: 303-c99-complex-ugly-hack.patch
Only in svn-export/buildroot/toolchain/gdb: 6.5
