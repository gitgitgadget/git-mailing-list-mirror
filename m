Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967A5C43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 14:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiGKO4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 10:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiGKO4Y (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 10:56:24 -0400
Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927A27172C
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 07:56:22 -0700 (PDT)
Received: from [10.0.2.15] ([147.147.167.40])
        by smtp with ESMTPA
        id AupfotprzaLeZAupgofW69; Mon, 11 Jul 2022 15:56:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1657551380; bh=MkEfrUWQCuVu2weys1F7Y/MdH6d955hYrIIzlhzafaQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=UnawglTav8hMadYxT3zoqMzBUzJGDYsaDx2ejn0yrfxms3Kl6In3pCl0gLg7NiQyi
         JmHLnQHwBfr0OsKK0kL/3RaZPYshMEbt2Tx/5kEwNQ5uozzh5+Y6z6kHX8QFH9P6FE
         gxJ0RCXXATD00BFwvpiDMsBn5wJ3RCXGp4lBc221LTU6ekAxxUOJvKdlDabjz10xVl
         Z+vxEw5aCMLqNRNMb3YbCdGZTrboNXb7kR13m/TAyFfw2vXQhTDIf4asBdASrlQsrz
         ujTScTnS7zoYz0YC0TXmWh7AfIXwDFZ7U1w0YPJJpsOFm5KFfutdq+FrXp3HAuyW2f
         ebLJPBgOxXHyQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=D+hUl9dj c=1 sm=1 tr=0 ts=62cc3a14
 a=nyqnwr6A7Kzjd6EpZhiMcA==:117 a=nyqnwr6A7Kzjd6EpZhiMcA==:17
 a=IkcTkHD0fZMA:10 a=uROMCa6cPbON8WaM-xYA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Message-ID: <51972253-c1a1-8be7-39f5-3093ac83ffb1@ramsayjones.plus.com>
Date:   Mon, 11 Jul 2022 15:56:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: t0301-credential-cache test failure on cygwin
Content-Language: en-GB
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
 <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
 <CA+kUOakjnOxs_FGojdZXaiaY4+68pvyBHsbue+AQHp7PLXqNJw@mail.gmail.com>
 <CA+kUOak29RkU-ooMgOz8yCg9-q6vb1VfdP8_VLay_V650ttwjA@mail.gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
In-Reply-To: <CA+kUOak29RkU-ooMgOz8yCg9-q6vb1VfdP8_VLay_V650ttwjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP+jkvsxcux8RkK3KJJuzimd7L2HkOBXRqiy/eplimNL6vXtTdeHj4LgzeMERL5qZ6TqvnKGBMfhLWG80k1PP1sM7eRgmEpqKDXtD188XKNb4qr4ybM8
 9ZQBQ1U3ff8oMTsp0+99vNVpvV+sDk5SXRQ37l6llZvSsfprju0hfUATVBRpiH1HF23hBUyxVS3kX4YqWzMSYuCzSbrVOKnD1EE=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/07/2022 14:39, Adam Dinwoodie wrote:
[snip]

> 
> Minor progress update: I've now confirmed the failure was introduced by
> a change in the Cygwin library between the binaries for Cygwin versions
> 3.2.0-1 and 3.3.1-1. Specifically, the test passes with Cygwin from the
> 27 October 2021 package archive[0], and fails with Cygwin from the 28
> October 2021 archive[1], and the only difference between the two that
> has any chance of being relevant is that bump in the Cygwin release.

Heh, I was just about to email you with similar news! I had a look at
my setup.log to see what I actually updated (and from what) and the
only thing that seemed to make sense was an update of the cygwin .dll
from v3.2.0-1 to v3.3.2-1 (I will add below an extract from my setup.log
for that day, in case you see anything else of interest).

[The previous entry was for 25th October 2021 and had some more interesting
entries, like binutils, libcurl, etc., but I don't think it is relevant]

Sorry I didn't think to look sooner.

Happy Hunting!

ATB,
Ramsay Jones

--- >8 ---

[snip]
2021/11/09 02:52:01 Augmented Transaction List:
2021/11/09 02:52:01    0 install cygwin               3.3.2-1  
2021/11/09 02:52:01    1   erase cygwin               3.2.0-1  
2021/11/09 02:52:01    2 install cygwin-debuginfo     3.3.2-1  
2021/11/09 02:52:01    3   erase cygwin-debuginfo     3.2.0-1  
2021/11/09 02:52:01    4 install cygwin-devel         3.3.2-1  
2021/11/09 02:52:01    5   erase cygwin-devel         3.2.0-1  
2021/11/09 02:52:01    6 install cygwin-doc           3.3.2-1  
2021/11/09 02:52:01    7   erase cygwin-doc           3.2.0-1  
2021/11/09 02:52:01    8 install perl-DateTime-Locale 1.33-1   
2021/11/09 02:52:01    9   erase perl-DateTime-Locale 1.32-1   
2021/11/09 02:52:01   10 install perl-URI             5.10-1   
2021/11/09 02:52:01   11   erase perl-URI             5.09-1   
2021/11/09 02:52:01   12 install libpcre2_8_0         10.39-1  
2021/11/09 02:52:01   13   erase libpcre2_8_0         10.38-1  
2021/11/09 02:52:01   14 install libpcre2_16_0        10.39-1  
2021/11/09 02:52:01   15   erase libpcre2_16_0        10.38-1  
2021/11/09 02:52:01   16 install libopenldap2_5_0     2.5.9-1  
2021/11/09 02:52:01   17   erase libopenldap2_5_0     2.5.8-1  
2021/11/09 02:52:01   18 install libidn12             1.38-1   
2021/11/09 02:52:01   19 install libarchive13         3.5.2-2  
2021/11/09 02:52:01   20   erase libarchive13         3.5.2-1  
2021/11/09 02:52:01   21 install git                  2.33.1-1 
2021/11/09 02:52:01   22   erase git                  2.33.0-1 
2021/11/09 02:52:01   23 install gawk                 5.1.1-1  
2021/11/09 02:52:01   24   erase gawk                 5.1.0-1  
2021/11/09 02:52:01   25 install perl-libwww-perl     6.58-1   
2021/11/09 02:52:01   26   erase perl-libwww-perl     6.57-1   
2021/11/09 02:52:01   27 install libpcre2-posix3      10.39-1  
2021/11/09 02:52:01   28   erase libpcre2-posix3      10.38-1  
2021/11/09 02:52:01   29 install lynx                 2.8.9-13 
2021/11/09 02:52:01   30   erase lynx                 2.8.7-2  
2021/11/09 02:52:01   31 install gitk                 2.33.1-1 
2021/11/09 02:52:01   32   erase gitk                 2.33.0-1 
2021/11/09 02:52:01   33 install git-email            2.33.1-1 
2021/11/09 02:52:01   34   erase git-email            2.33.0-1 
2021/11/09 02:52:01   35 install git-gui              2.33.1-1 
2021/11/09 02:52:01   36   erase git-gui              2.33.0-1 
[snip]
2021/11/09 02:52:19 Uninstalling cygwin
2021/11/09 02:52:19 Uninstalling cygwin-debuginfo
2021/11/09 02:52:20 Uninstalling cygwin-devel
2021/11/09 02:52:20 Uninstalling cygwin-doc
2021/11/09 02:52:26 Uninstalling perl-DateTime-Locale
2021/11/09 02:52:28 Uninstalling perl-URI
2021/11/09 02:52:29 Uninstalling libpcre2_8_0
2021/11/09 02:52:29 Uninstalling libpcre2_16_0
2021/11/09 02:52:29 Uninstalling libopenldap2_5_0
2021/11/09 02:52:29 Uninstalling libarchive13
2021/11/09 02:52:29 Uninstalling git
2021/11/09 02:52:30 Uninstalling gawk
2021/11/09 02:52:30 Uninstalling perl-libwww-perl
2021/11/09 02:52:31 Uninstalling libpcre2-posix3
2021/11/09 02:52:31 Uninstalling lynx
2021/11/09 02:52:31 Uninstalling gitk
2021/11/09 02:52:31 Uninstalling git-email
2021/11/09 02:52:31 Uninstalling git-gui
[snip]
2021/11/09 02:55:50 Changing gid to Administrators
2021/11/09 02:55:54 note: In-use files have been replaced. You need to reboot as soon as possible to activate the new versions. Cygwin may operate incorrectly until you reboot.
2021/11/09 02:55:54 Ending cygwin install
