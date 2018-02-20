Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C69C1F576
	for <e@80x24.org>; Tue, 20 Feb 2018 11:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751726AbeBTLSw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 20 Feb 2018 06:18:52 -0500
Received: from cam1mail01.ubisense.net ([194.72.180.48]:23164 "EHLO
        cam1mail01.ubisense.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751683AbeBTLSv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 06:18:51 -0500
Received: from CAM1MAIL01.ubisense.local ([fe80::7dde:355:4f14:b23d]) by
 CAM1MAIL01.ubisense.local ([fe80::7dde:355:4f14:b23d%14]) with mapi id
 14.03.0339.000; Tue, 20 Feb 2018 11:18:50 +0000
From:   Tim Mayo <Tim.Mayo@ubisense.net>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Stackdump from stash save on Windows 10 64-bit
Thread-Topic: Stackdump from stash save on Windows 10 64-bit
Thread-Index: AdOqPE21hLuAQ6S0T8iywYqbkfxpdw==
Date:   Tue, 20 Feb 2018 11:18:49 +0000
Message-ID: <3859F9D06DD39A44AB88A072AD53704DD08E9925@CAM1MAIL01.ubisense.local>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.16.120]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

As of yesterday, stash save stopped working on my Windows 10 box - I get:

       > git stash save
       Cannot save the current worktree state

and a stackdump file (see below).  This is with the 64-bit version of 2.16.1.  Switching to the 32-bit version resolved the problem for me.

Cheers
Tim

PS. I think the problem was provoked by Windows security update KB4074588. Unfortunately, I am unable to uninstall this update to verify.


Exception: STATUS_STACK_OVERFLOW at rip=7FFB793F4B97
rax=0000000000000010 rbx=0000000000000000 rcx=0000000000000010
rdx=000000000000000C rsi=00000000FFFFAAC0 rdi=00007FFB7164D4F0
r8 =00000000FFFFA9F8 r9 =00000000FFFFAA30 r10=00000000FFFFA000
r11=00000000FFE03E50 r12=00000000FFFFB500 r13=00000000027AD3E0
r14=000000000000014C r15=0000000000000000
rbp=00000000FFFFAA30 rsp=00000000FFFFA9E8
program=C:\Program Files\Git\usr\bin\sh.exe, pid 9752, thread unknown (0xB24)
cs=0033 ds=002B es=002B fs=0053 gs=002B ss=002B
Stack trace:
Frame        Function    Args
000FFFFAA30  7FFB793F4B97 (00000000104, 000FFFFAAA8, 7FFB793D2178, 00000000000)
000FFFFAA30  7FFB793D2277 (7FFB7164D4F0, 7FFB7164D4F0, 00000000001, 00000230022)
000FFFFAAA8  7FFB761ED1F4 (7FFB79350000, 7FFB793D21F0, 7FFB793BFAE0, 7FFFFFFEFFFF)
000FFFFAC70  7FFB761ED071 (9E09000600010000, 310F3245BC40, 00000000023, 000FFFFAD98)
000FFFFAC70  7FFB761ECA44 (7FFB7164D700, 00000000000, 00000000000, 7FFB7164D700)
000FFFFAC70  7FFB715B03A0 (000FFFFAC70, 000FFFFAD98, 00002744620, 00000161140)
000FFFFAC70  7FFB715837DB (000FFFFB5A0, 00000000000, 000FFFFB950, 00002744620)
000FFFFB3D9  7FFB7155E4D0 (00000000002, 000FFFFB7C8, 0000000000E, 00180010018)
00180010018  7FFB7155CFDD (00000000000, 000FFFFB700, 00000000000, 000FFFFB7A0)
000FFFFB700  7FFB71555543 (000FFFFB870, 000000001B0, 00000000000, 00180271780)
00000000420  7FFB761ED7F6 (00000000001, 00000000000, 000FFFFB950, 00100000001)
00000000420  7FFB779CE4E3 (00000000020, 00000000000, 000FFFFBAD0, 00000000001)
00000000420  001800AB022 (000FFFFBA70, 00000000000, 00000000000, 001803007C0)
000FFFFBAF0  001800ABBD5 (00100410FBB, 00000000000, 00600089010, 001004E9740)
000FFFFBCF0  0018011C93B (00100410FBB, 00000000000, 00600089010, 001004E9740)
000FFFFBCF0  00002DEE458 (00100410FBB, 00000000000, 00600089010, 001004E9740)
End of stack trace (more stack frames may be present)

--------------------------------------
Dr Tim Mayo
Software Architect

Ubisense Ltd
St Andrew's House
St Andrew's Road, Chesterton
Cambridge, CB4 1DL
+44 1223 53 5170

