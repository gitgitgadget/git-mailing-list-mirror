Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BEB91FEB3
	for <e@80x24.org>; Sun,  1 Jan 2017 05:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750791AbdAAFGo (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 00:06:44 -0500
Received: from mail.foxkit.us ([45.32.83.9]:44542 "EHLO mail.wilcox-tech.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750698AbdAAFGn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 00:06:43 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Jan 2017 00:06:43 EST
Received: (qmail 23984 invoked from network); 1 Jan 2017 04:59:19 -0000
Received: from ip68-13-242-69.ok.ok.cox.net (HELO ?10.1.1.57?) (awilcox@wilcox-tech.com@68.13.242.69)
  by mail.foxkit.us with ESMTPA; 1 Jan 2017 04:59:19 -0000
To:     git@vger.kernel.org
From:   "A. Wilcox" <awilfox@adelielinux.org>
Subject: Test failures when Git is built with libpcre and grep is built
 without it
X-Enigmail-Draft-Status: N1110
Organization: =?UTF-8?Q?Ad=c3=a9lie_Linux?=
Message-ID: <58688C9F.4000605@adelielinux.org>
Date:   Sat, 31 Dec 2016 22:59:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hello!

I'm attempting to package Git for our new Linux distribution and I
have run in to a failure on our PowerPC builder while running the test
suite.

The PowerPC builder runs a tiny version of grep(1) that was not built
with PCRE.  As such, grep -P returns 2 and prints:

grep: support for the -P option is not compiled into this
- --disable-perl-regexp binary

However, our Git build *does* link against libpcre.  This causes a
tests numbered 142 and 143 to fail in t7810-grep.sh.

I am not sure the best way to handle this but I felt it would be
prudent to inform you of this issue.  I will be happy to provide any
other information you may require.

Best,
arw

- -- 
A. Wilcox (awilfox)
Project Lead, Adélie Linux
http://adelielinux.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYaIycAAoJEMspy1GSK50U/g4P/AtPRfeOv8pENfI/PnlhXqSD
C28CR0Hzv4qBv/Ay8vpBfmkM177bBnra5GTcfnAZ0wvxJUiqnkluu+EJ2UWfPNse
r5ZbDkXCp42oek+vIi7jYi7UsyNqwyT1DziYLR5PDopT3L8YK7i9pZCQZ+mDSmVT
Iu3gYmLvyyEL7r104o6ACRw11P5CDL9bKFmSVacD9UvPL3EjOM9LrSdRDzvJmk0u
nqAOH6yw4wknxCWGPA3JT4DM9GD5DB/Y+UmVQrrpA+Txl8gbPjgzb1PX4qogHjNq
dNDk1jeKJd/CmwJdAU6eKQ3bgfnIXzLbTDVmaMTMlUUsHzlqE/7QYnrae76ECmmn
drmezgKRwTtVgQjQ8l/F/c+EQhux9c0zM9Lz+0Hrd7v1WwohLQDA0xYOE8cCaLw1
8WmXQWjNG1Ih2GpAZH7CRreWyiDAiaAZI2d/zOhsgG9edNEmNn+LkesajVdMywUJ
jKlxmKk6qK2uPDPVrD261ODtMxVdptG6/+m24iz56WRERWkkFBpZz15OtrtlLa2E
0LcFiu2f5lki12XDZsSJwkLeGfb6KyxfCPKtGP7TAVAYO43ORQHKhks8pheOMwJa
dpL4+72CzkI57LyCtl0NiSMZH2zKUvxp8OqKgE/gpDwbhwh8spAHdUaiaS6emiPj
MM6jb7ru9eo4gD6seRCp
=R9eQ
-----END PGP SIGNATURE-----
