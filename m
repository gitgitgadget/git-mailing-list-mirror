From: Robert Mitwicki <robert.mitwicki@opensoftware.pl>
Subject: Bug: Segmentation fault (core dumped)
Date: Fri, 04 Oct 2013 15:54:30 +0200
Message-ID: <524EC896.3050703@opensoftware.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000705030302060808050602"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 04 15:53:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS5p8-0000LK-Rm
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 15:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754959Ab3JDNxj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 09:53:39 -0400
Received: from ks3293474.kimsufi.com ([5.135.188.67]:60926 "EHLO
	solaris.opensoftware.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754871Ab3JDNxi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 09:53:38 -0400
X-Greylist: delayed 605 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2013 09:53:37 EDT
Received: from [192.168.0.100] (unknown [188.113.109.165])
	by solaris.opensoftware.pl (Postfix) with ESMTPSA id 073E8CA6B3
	for <git@vger.kernel.org>; Fri,  4 Oct 2013 15:43:04 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
X-Enigmail-Version: 1.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235711>

This is a multi-part message in MIME format.
--------------000705030302060808050602
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

When I am trying to clone an empty repository and I will use together
--depth 1 and -b branch_name (branch does not exist) then I get
Segmentation fault (repo seems to be cloned correctly).

Please see attachment for more details.
Best regards
Robert Mitwicki

--------------000705030302060808050602
Content-Type: text/plain; charset=UTF-8;
 name="Log.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Log.txt"

>  git clone --depth 1 -b test https://github.com/mitfik/coredump.git /tmp/coredump.git
Cloning into '/tmp/coredump.git'...
warning: You appear to have cloned an empty repository.
Segmentation fault (core dumped)
Unexpected end of command stream

> git --version
git version 1.8.4

(gdb) info registers
rax            0x0      0
rbx            0x0      0
rcx            0x0      0
rdx            0x72     114
rsi            0x519d04 5348612
rdi            0x58     88
rbp            0x7d9680 0x7d9680
rsp            0x7fffffffd8f8   0x7fffffffd8f8
r8             0x7fffffffe30b   140737488347915
r9             0x58     88
r10            0x7fffffffd6c0   140737488344768
r11            0x7ffff72c1d50   140737340251472
r12            0x0      0
r13            0x1      1
r14            0x58     88
r15            0x0      0
rip            0x7ffff72c1d68   0x7ffff72c1d68
eflags         0x10206  [ PF IF RF ]
cs             0x33     51
ss             0x2b     43
ds             0x0      0
es             0x0      0
fs             0x0      0
gs             0x0      0



(gdb) bt
#0  0x00007ffff72c1d68 in ?? () from /lib/x86_64-linux-gnu/libc.so.6
#1  0x00000000004204a0 in ?? ()
#2  0x0000000000405b84 in ?? ()
#3  0x0000000000404f6d in ?? ()
#4  0x00007ffff71af76d in __libc_start_main () from /lib/x86_64-linux-gnu/libc.so.6
#5  0x00000000004053b9 in ?? ()
#6  0x00007fffffffe078 in ?? ()
#7  0x000000000000001c in ?? ()
#8  0x0000000000000008 in ?? ()
#9  0x00007fffffffe2eb in ?? ()
#10 0x00007fffffffe310 in ?? ()
#11 0x00007fffffffe337 in ?? ()
#12 0x0000000000000000 in ?? ()


(gdb)  x/60x $sp
0x7fffffffd8f8: 0x00000000      0x00000000      0x007d9680      0x00000000
0x7fffffffd908: 0x00000000      0x00000000      0x00000001      0x00000000
0x7fffffffd918: 0x00000058      0x00000000      0x00000000      0x00000000
0x7fffffffd928: 0x004204a0      0x00000000      0xffffe30b      0x00007fff
0x7fffffffd938: 0xf7fdcd20      0x00007fff      0x007d1fd0      0x00000000
0x7fffffffd948: 0x00000000      0x00000000      0xffffdd60      0x00007fff
0x7fffffffd958: 0xffffdad0      0x00000000      0x00000000      0x00000000
0x7fffffffd968: 0x00000000      0x00000000      0x00000000      0x00000000
0x7fffffffd978: 0xf7fdb630      0x00007fff      0x00000001      0x00007fff
0x7fffffffd988: 0x00000000      0x00000000      0x00000001      0xffffefbd
0x7fffffffd998: 0xf7fdc9c8      0x00007fff      0x003b4700      0x00000000
0x7fffffffd9a8: 0x003b4700      0x00000000      0x00003900      0x00000000
0x7fffffffd9b8: 0xffffddd0      0x00007fff      0xffffde50      0x00007fff
0x7fffffffd9c8: 0xf7ffa4c8      0x00007fff      0x00000000      0x00000000
0x7fffffffd9d8: 0xf7fdcd20      0x00007fff      0xffffdb30      0x00000001

--------------000705030302060808050602--
