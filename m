From: Ivan Lyapunov <dront78@gmail.com>
Subject: git log - crash and core dump
Date: Tue, 16 Apr 2013 20:55:59 +0400
Message-ID: <CANKwXW1EXLiWgdVM4+k_11wu1Nyixp05PUXmQYP_gUXQKek_OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 16 18:56:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1US9BV-000086-Br
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 18:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935981Ab3DPQ4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 12:56:41 -0400
Received: from mail-ia0-f179.google.com ([209.85.210.179]:46060 "EHLO
	mail-ia0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935693Ab3DPQ4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 12:56:40 -0400
Received: by mail-ia0-f179.google.com with SMTP id l25so612863iad.24
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 09:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=6WQr1eiDqvuB7jYxTlwTKRLdVyXuIVrmr9GzCGr9UHg=;
        b=bD3LFE6SxxF06JonzYnQrrSL0Vi1adFaLWJ6qsGB6/8Qd9PVH90/eBgNxVmIDrtWwV
         CJkbpbqzF2j2MFXUWVgVnYQfRXdSnVyVWIlZJAv9DtfVCppT5brumNz+j3rYhJV7HHK2
         d/b7IKMC072AVXT6KaqHZ36YJVxlLcvcs4xHeSiokJodZQ1wtyeqz8IT42fiyH6YAFaC
         HyLvVvux+WW7CWhfAOX24shDQGuVm2ONKroLY1Lg4YiUZTHqA6KcEgJ2yGIiRbo8CfSB
         OZJ3w4u51tPSmKmsUUGrb81NsiqTp55kc4+zx6tFoQrPxKUM4mOtLixNKWVu3lFx1zfK
         li0g==
X-Received: by 10.50.150.146 with SMTP id ui18mr8317698igb.21.1366131399724;
 Tue, 16 Apr 2013 09:56:39 -0700 (PDT)
Received: by 10.64.39.100 with HTTP; Tue, 16 Apr 2013 09:55:59 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221429>

git version 1.8.2.1 crashes on my ArchLinux x86_64 on git log command
gdb bt is attached

git log | less
does not crash in same repo

I cannot share a repo for a debug purposes since it's private repo of
my employer
but I can perform any suitable tests on repo to help this bug to be fixed

#0  0x00007ffff722b3e6 in ____strtoull_l_internal () from /usr/lib/libc.so.6
#1  0x00000000004b31d4 in pp_user_info (pp=pp@entry=0x7fffffffd310,
what=what@entry=0x521379 "Author", sb=sb@entry=0x7fffffffd290,
    line=line@entry=0x7b3a45 "Ivan Lyapunov <ilyapunov@trueconf.ru>-
<> 1354083115 +0400\ncommitter Ivan Lyapunov <ilyapunov@trueconf.ru>
1354083115 +0400\n\n- small merge fixes",
encoding=encoding@entry=0x505400 "UTF-8") at pretty.c:441
#2  0x00000000004b533a in pp_header (sb=0x7fffffffd290,
msg_p=0x7fffffffd228, commit=0x7c1e10, encoding=0x505400 "UTF-8",
pp=0x7fffffffd310) at pretty.c:1415
#3  pretty_print_commit (pp=pp@entry=0x7fffffffd310,
commit=commit@entry=0x7c1e10, sb=sb@entry=0x7fffffffd290) at
pretty.c:1545
#4  0x00000000004a0b45 in show_log (opt=opt@entry=0x7fffffffd4d0) at
log-tree.c:683
#5  0x00000000004a1616 in log_tree_commit
(opt=opt@entry=0x7fffffffd4d0, commit=commit@entry=0x7c1e10) at
log-tree.c:859
#6  0x0000000000438b03 in cmd_log_walk (rev=rev@entry=0x7fffffffd4d0)
at builtin/log.c:310
#7  0x00000000004395dd in cmd_log (argc=1, argv=0x7fffffffdd30,
prefix=0x0) at builtin/log.c:582
#8  0x000000000040562d in run_builtin (argv=0x7fffffffdd30, argc=1,
p=0x754d18 <commands.21404+1080>) at git.c:282
#9  handle_internal_command (argc=1, argv=0x7fffffffdd30) at git.c:444
#10 0x0000000000404a6f in run_argv (argv=0x7fffffffdbd0,
argcp=0x7fffffffdbdc) at git.c:490
#11 main (argc=1, argv=0x7fffffffdd30) at git.c:565
