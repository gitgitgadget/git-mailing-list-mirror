Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3C11207BD
	for <e@80x24.org>; Tue, 25 Apr 2017 11:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946819AbdDYLTf (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 07:19:35 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51464 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946452AbdDYLTa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 07:19:30 -0400
X-Greylist: delayed 374 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Apr 2017 07:19:30 EDT
Received: by jabberwock.ucw.cz (Postfix, from userid 1042)
        id 76B131C0179; Tue, 25 Apr 2017 13:13:15 +0200 (CEST)
Date:   Tue, 25 Apr 2017 13:13:15 +0200
From:   Stepan Kasal <kasal@ucw.cz>
To:     git@vger.kernel.org
Subject: Git For Windows SDK - cannot build
Message-ID: <20170425111315.GB13400@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
I have installed git for windows sdk from the web and tried to build it.

The build ended with a link bug; see below.

Could you please help me with debugging that?

I have tried various pacman -S libiconv; pacman -Su; pacman -S libiconv-devel
but I still do not understand pacman and its dependencies, I'm afraid.

Hints or pointers to doc welcome.

Stepan Kasal

$ make
    LINK git-credential-store
libgit.a(utf8.o): In function `reencode_string_iconv':
/usr/src/git/utf8.c:463: undefined reference to `libiconv'
/usr/src/git/utf8.c:463:(.text+0xf77): relocation truncated to fit: R_X86_64_PC32 against undefined symbol `libiconv'
libgit.a(utf8.o): In function `reencode_string_len':
/usr/src/git/utf8.c:524: undefined reference to `libiconv_open'
/usr/src/git/utf8.c:524:(.text+0xff1): relocation truncated to fit: R_X86_64_PC32 against undefined symbol `libiconv_open'
/usr/src/git/utf8.c:535: undefined reference to `libiconv_close'
/usr/src/git/utf8.c:535:(.text+0x1018): relocation truncated to fit: R_X86_64_PC32 against undefined symbol `libiconv_close'
/usr/src/git/utf8.c:529: undefined reference to `libiconv_open'
/usr/src/git/utf8.c:529:(.text+0x104a): relocation truncated to fit: R_X86_64_PC32 against undefined symbol `libiconv_open'
collect2: error: ld returned 1 exit status
make: *** [Makefile:2061: git-credential-store] Error 1

