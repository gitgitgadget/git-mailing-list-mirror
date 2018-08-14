Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,BODY_8BITS,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,WEIRD_PORT
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 496A51F428
	for <e@80x24.org>; Tue, 14 Aug 2018 17:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389610AbeHNUmR convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 14 Aug 2018 16:42:17 -0400
Received: from mout.gmx.net ([212.227.15.18]:46875 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389577AbeHNUmQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 16:42:16 -0400
Received: from [192.168.1.31] ([5.10.50.58]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Luxaj-1fyOvQ3qTZ-01084O for
 <git@vger.kernel.org>; Tue, 14 Aug 2018 19:54:02 +0200
User-Agent: Microsoft-MacOutlook/10.f.0.180709
Date:   Tue, 14 Aug 2018 19:54:01 +0200
Subject: Bug with Git submodules and submodule.recurse setting 
From:   Jochen =?UTF-8?B?S8O8aG5lcg==?= <jochen.kuehner@gmx.de>
To:     <git@vger.kernel.org>
Message-ID: <929572FA-6B1D-4EC7-825B-93B96053A82C@gmx.de>
Thread-Topic: Bug with Git submodules and submodule.recurse setting 
Mime-version: 1.0
Content-type: text/plain;
        charset="UTF-8"
Content-transfer-encoding: 8BIT
X-Provags-ID: V03:K1:ZwXRgP4gwKLX2Yd0Km7WIpP6n59Lt2diRbp5tSf67X09ycnwcag
 Rx21V+zDcYl9xQt73Mz0p/BZWmXURKa6uLpjMIcpkQ0ZEMCJIQTnDOY3XWOB9qd9v54G0He
 kCl2mRXGvXQPv2cNZQwT1SnDw8fA2SzA42hejPrOKBo30ZyFI2qGQ/WiBrx7n/57Oj0qhRs
 4GhiCaMnxeDo29jxV0vZw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YYdhB+HWZ7Y=:bY4rzuVSbz72kvQjMCGQ2P
 A8KH5GTbyUIz8tT9/h2iGoNTvds8SgYztw+tE7v/F5hYG88DuBuh4snpvpBZtn3nc5uWZbigF
 nhRZe8WBLVMml4FCIhIG8jeOzlqMSJvr45u+hWJHX/Rmd0YptN4caLrOirqH5iVFCwNqS22fu
 oJsFg8U5P0baBvYTD31nDRMlSoYVL7A4vrwaBcjixMFvCM/pQJiQs6s7SPNfVCG9aXxVOuYQG
 C0vu8utDJeAnSa9kSzWGEbwIIHG1SuCgAUeMkapcTuBeg93YO1sL6CXR7H4TP6Mo4E9Aw4G3s
 EL4qOmOk6h8wa7Igsxf2r28aUYndo9lklbngo2a0SdbE9e7KJucyAyhyz8KBWL2RV/g9Aa+A1
 x1r6LKOpPmq3K+0IfuPUhFdpk4tuPcPxXHiNeUMYC9eigvJZgzKyptGzT/uiqaAysV8js6o2x
 GxoSMyOxW5SA+m1az+I0YTgZJE+TLu08VOrWu0wcsWub5aHJBaLW/tmtcOk/U+dKJZXbDCWy/
 AjAMhphiln6rGw1cqTgTGTYmcIHSUpsP8lrJtxNESeEZEHeTN2jmONBC+WIzsD7XJrfuPItke
 edZaykAej7oiqrMXI/XWAjBXrYq04EgI/xqFbjNAF/lJHc++1eFeLSEj4IPpZv1tw8pQis/9o
 o/Cyafdwnoerf4RhseFfZhuopImWL1BEnNGlEaePFnCGobtSvdQzKZ9ZhkikHUVQ5VQkOZItZ
 u/3GUIbMyQtUBOCo4BN3zsF3KPyQwWBJ5W/SHFp7jMpMK2LRpKEmgKaJg/v/0QFGhqqshaH8g
 IQTDSqt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If I set 



 

git config --global submodule.recurse true





and run git via:



 

git pull --progress -v --no-rebase "origin"





The command will fail with following output (Errorlevel is 1)

 



Fetching submodule submodules/tstemplates



From http://10.0.102.194:7990/scm/mcc/tstemplates



= [up to date]      feature/robin -> origin/feature/robin



= [up to date]      master        -> origin/master



Already up to date.



usage: git submodule [--quiet] add [-b <branch>] [-f|--force] [--name <name>] [--reference <repository>] [--] <repository> [<path>]



   or: git submodule [--quiet] status [--cached] [--recursive] [--] [<path>...]



   or: git submodule [--quiet] init [--] [<path>...]



   or: git submodule [--quiet] deinit [-f|--force] (--all| [--] <path>...)



   or: git submodule [--quiet] update [--init] [--remote] [-N|--no-fetch] [-f|--force] [--checkout|--merge|--rebase] [--[no-]recommend-shallow] [--reference <repository>] [--recursive] [--] [<path>...]



   or: git submodule [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]



   or: git submodule [--quiet] foreach [--recursive] <command>



   or: git submodule [--quiet] sync [--recursive] [--] [<path>...]



   or: git submodule [--quiet] absorbgitdirs [--] [<path>...]



 



seams that the “verbose” parameter “-v” is also sent to “git submodules” wich does not support it.



 



If I remove “-v” it will work.



 



Problem is, I use TortoiseGit, wich will automatically create this command!



 









