Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 951C01F576
	for <e@80x24.org>; Fri, 16 Feb 2018 18:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751455AbeBPSrK convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 16 Feb 2018 13:47:10 -0500
Received: from mail.colheli.com ([107.1.156.227]:39983 "EHLO mail.colheli.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751214AbeBPSrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 13:47:09 -0500
Received: from mail2.colheli.loc (172.16.0.66) by mail2.colheli.loc
 (172.16.0.66) with Microsoft SMTP Server (TLS) id 15.0.1178.4; Fri, 16 Feb
 2018 10:47:08 -0800
Received: from mail2.colheli.loc ([::1]) by mail2.colheli.loc
 ([fe80::a5f4:b310:f137:795%14]) with mapi id 15.00.1178.000; Fri, 16 Feb 2018
 10:47:08 -0800
From:   Derek Foulk <dfoulk@colheli.com>
To:     "'git@vger.kernel.org'" <git@vger.kernel.org>
Subject: Git Stash Creates sh.exe.stackdump (STATUS_STACK_OVERFLOW)
Thread-Topic: Git Stash Creates sh.exe.stackdump (STATUS_STACK_OVERFLOW)
Thread-Index: AdOnVov8R9LF+DpVSuyL4r1/gyc3qA==
Date:   Fri, 16 Feb 2018 18:47:08 +0000
Message-ID: <ec9aec59d4d6497a84431f1abeae147d@mail2.colheli.loc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.16.0.187]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

An issue has arisen sometime between 2.16.1.windows.1 and 2.16.1.windows.4 in Git.

When you execute `git stash` commands (stash/pop/apply?), a sh.exe.stackdump file is generated that contains the following:

Exception: STATUS_STACK_OVERFLOW at rip=7FFB2C324B97
rax=0000000000000010 rbx=0000000000000000 rcx=0000000000000010
rdx=000000000000000C rsi=00000000FFFFAAE0 rdi=00007FFB23B8D4F0
r8 =00000000FFFFAA18 r9 =00000000FFFFAA50 r10=00000000FFFFA000
r11=00000000FFE03E70 r12=00000000FFFFB500 r13=000000000015C000
r14=000000000000014C r15=0000000000000000
rbp=00000000FFFFAA50 rsp=00000000FFFFAA08
program=C:\Program Files\Git\usr\bin\sh.exe, pid 41552, thread unknown (0x949C)
cs=0033 ds=002B es=002B fs=0053 gs=002B ss=002B
Stack trace:
Frame        Function    Args
000FFFFAA50  7FFB2C324B97 (00000000104, 000FFFFAAC8, 7FFB2C302178, 00000000000)
000FFFFAA50  7FFB2C302277 (7FFB23B8D4F0, 7FFB23B8D4F0, 00000000001, 00000230022)
000FFFFAAC8  7FFB28D1D1F4 (7FFB2C280000, 7FFB2C3021F0, 7FFB2C2EFAE0, 7FFFFFFEFFFF)
000FFFFAC90  7FFB28D1D071 (9E09000600010000, 365AE1E0F447, 00000000023, 000FFFFADB8)
000FFFFAC90  7FFB28D1CA44 (7FFB23B8D700, 00000000000, 00000000000, 7FFB23B8D700)
000FFFFAC90  7FFB23AF03A0 (000FFFFAC90, 000FFFFADB8, 000000F3DF0, 00000091380)
000FFFFAC90  7FFB23AC37DB (000FFFFB5C0, 00000000000, 000FFFFB970, 000000F3DF0)
000FFFFB3F9  7FFB23A9E4D0 (00000000002, 000FFFFB7E8, 00000000000, 00180010018)
00180010018  7FFB23A9CFDD (00000000000, 000FFFFB720, 00000000000, 000FFFFB7C0)
000FFFFB720  7FFB23A95543 (000FFFFB890, 000000001C8, 00000000000, 00180271780)
00000000420  7FFB28D1D7F6 (00000000001, 00000000000, 000FFFFB970, 00100000001)
00000000420  7FFB29C4E4E3 (00000000020, 00000000000, 000FFFFBAF0, 00000000001)
00000000420  001800AB022 (000FFFFBA90, 00000000000, 00000000000, 00180300748)
000FFFFBB10  001800ABBD5 (00100410FBB, 00000000000, 0060004DF10, 001004E9740)
000FFFFBD10  0018011C93B (00100410FBB, 00000000000, 0060004DF10, 001004E9740)
000FFFFBD10  00002DEE458 (00100410FBB, 00000000000, 0060004DF10, 001004E9740)
End of stack trace (more stack frames may be present)

The end result is you cannot pop your stashed changes (the .stackdump file injects itself into the stashed changes, then one is created before the pop occurs):

I've confirmed updating to the latest Git causes this to occur on three different workstations (and repositories).

I've tried downgrading to 2.15, but the issue has persisted (it did not exist prior to updating to 2.16).

Thanks,
-Derek

Environment:
Windows 10 (Fall Creators Update)
Git v2.16.1.windows.4 (Default installation options w/ Added context menu options)
Git Bash
