Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D95D1F404
	for <e@80x24.org>; Sat, 24 Mar 2018 20:43:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752872AbeCXUnK (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Mar 2018 16:43:10 -0400
Received: from mout.web.de ([212.227.17.11]:54805 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752822AbeCXUnJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Mar 2018 16:43:09 -0400
Received: from [192.168.178.36] ([79.237.251.165]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVtxM-1f6RhL0oqO-00X04f; Sat, 24
 Mar 2018 21:42:59 +0100
Subject: Re: Null pointer dereference in git-submodule
To:     Jeremy Feusi <jeremy@feusi.co>
References: <20180324174234.GA3779@feusi.co>
Cc:     git@vger.kernel.org, Prathamesh Chavan <pc44800@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a7ad9dbf-1b0f-efc6-3a17-51cf25381ce5@web.de>
Date:   Sat, 24 Mar 2018 21:42:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180324174234.GA3779@feusi.co>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:IspwVdA0BfD2neqOdJdPjLxmM4JZo//ShUGAjSlottuzQCoRrBu
 /v7T3rrG7vHe+QbuPc9jiLFQ9UxX1QRCKtGZ23F8o3aKFVqRrR4oo65hCUpu02jAe4rl28i
 IlbpCUcaXLS5FYggkB1Z4AQGUVWQrtR2V3eRgMGYKwvipfyjza/R6Ao4UBnqiPnydf4uwvu
 ie3qT10fpxN18quU99BRQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JojBLn0ao/w=:0DXgafrr4BiQVBny2tMgxH
 nY/X1V5TM850GvsabR8graibOErVcveBkGvK4pPi2+e8D+cpY7+polV/YKkIo03UfS8YfrMli
 EUDYdmp2tYInWlUX7xKucLokCiqt+RhMthLYEcGBqjnChfZrEzcUG8iHxo16EVeBeNn+0EsE7
 bIYhvOcE6L6ojcp0NSNtPoXvkc5bjIu0n8RGbI/GY/OXTVDlbxq0fhyfNd7QyQ5gBkUitWzcs
 YSG3b+DXjpLeV3RvcPbsgRSjDgq65UnIyZTQwDdtMuXWfGXRmpcvwh/2RRgngzJOVdkkEEVVm
 Qa3bH64jRuHmXUvde3k7oidOuqRWMpvcp0XRMANpnkr1KhWcKAJQ9X61ngeO/nc0IWvK0Czmi
 KGtHzkTt9JYshd8IvqM8UR2AzRO/liBSLqnagLbpZBs/uYHFvWmjLYAsiHFtm82B4thIZ8jvZ
 HR2IB3mR0yO8zY2BdhAlgAhXf/oIlMX5FivBUutliJezBOXQpIU8vjhSrSH44S9ZEUtLi5bYt
 D3q3nxrrDnCHvharn9VUYPPFj+L06omW5oILN60U1VaChnLfusE8a16r2v3TGKB/lRhJ215Ca
 j5Lr0DTR17kdB6lFyi0CYTRXBxA2JB/Ctxvij2KNgMnp9ZxtLDHlcC455qtXhzMN3uuuN+lkf
 n3GKSrnBwH7RnGBFB31M2yWXF63JGPIQfktj4uhZSR4yTLQvf5N6TK4yAvQQpdGy9h0pqNyYr
 L2ole5FbiqZI7dE6j+hmTh3zqh1k+m3JlKxKXTZ65VNOwNNkmTt1j0wWPYtQwixDIOb7mY7xJ
 v7utuGe6aRy7soZmAqS0EuTFq8nd1YmYeZkVuEuyepJZxRYd2Q=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.03.2018 um 18:42 schrieb Jeremy Feusi:
> Hi,
> While bootstrapping a gnu repository I noticed that git segfaulted when
> called as "git submodule status". After compiling git with address
> sanitizer and minimizing the directory I finally narrowed it down to the
> files which I have attached as a tar archive. Here is a detailed backtrace:
> 
> AddressSanitizer:DEADLYSIGNAL
> =================================================================
> ==63400==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000 (pc 0x000000c27a93 bp 0x7ffdcb4eec10 sp 0x7ffdcb4eeb80 T0)
> ==63400==The signal is caused by a READ memory access.
> ==63400==Hint: address points to the zero page.
>      #0 0xc27a92 in refs_read_raw_ref /home/jfe/git/refs.c:1451:20
>      #1 0xc174a6 in refs_resolve_ref_unsafe /home/jfe/git/refs.c:1493:7
>      #2 0xc1826a in refs_read_ref_full /home/jfe/git/refs.c:224:6
>      #3 0xc26d53 in refs_head_ref /home/jfe/git/refs.c:1314:7
>      #4 0x8071e6 in status_submodule /home/jfe/git/builtin/submodule--helper.c:658:7
>      #5 0x806a89 in status_submodule_cb /home/jfe/git/builtin/submodule--helper.c:699:2
>      #6 0x80523e in for_each_listed_submodule /home/jfe/git/builtin/submodule--helper.c:438:3
>      #7 0x7f7e9a in module_status /home/jfe/git/builtin/submodule--helper.c:732:2
>      #8 0x7efd69 in cmd_submodule__helper /home/jfe/git/builtin/submodule--helper.c:1859:11
>      #9 0x51e024 in run_builtin /home/jfe/git/git.c:346:11
>      #10 0x5192c2 in handle_builtin /home/jfe/git/git.c:554:8
>      #11 0x51d0f0 in run_argv /home/jfe/git/git.c:606:4
>      #12 0x518600 in cmd_main /home/jfe/git/git.c:683:19
>      #13 0x8501d6 in main /home/jfe/git/common-main.c:43:9
>      #14 0x7f49fdaf2f29 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x20f29)
>      #15 0x41f4b9 in _start (/home/jfe/git/inst/libexec/git-core/git+0x41f4b9)
> 
> AddressSanitizer can not provide additional info.
> SUMMARY: AddressSanitizer: SEGV /home/jfe/git/refs.c:1451:20 in refs_read_raw_ref
> ==63400==ABORTING
> 
> As mentioned above, this bug is triggered by issuing the command
> "git submodule status" while in the attached directory.
> 
> This bug was confirmed on Debian with version 2.16.1 and
> 2.17.0.rc1.35.g90bbd502d as well as on Arch Linux with version 2.16.2
> where further output is given by git:
> 
> /usr/lib/git-core/git-submodule: line 979:  8119 Segmentation fault      (core dumped) git ${wt_prefix:+-C "$wt_prefix"} ${prefix:+--super-prefix "$prefix"} submodule--helper status ${GIT_QUIET:+--quiet} ${cached:+--cached} ${recursive:+--recursive} "$@"
> 

You may have minimized too much.  With the patch below I get:

	fatal: no ref store in submodule 'gnulib'

I guess you'll get a different one in your original repo.

The patch seems like a good idea in any case, though.

-- >8 --
Subject: [PATCH] submodule: check for NULL return of get_submodule_ref_store()

refs_head_ref() requires a valid ref_store pointer to be given as its
first argument.  get_submodule_ref_store() can return NULL.  Exit and
report the failure to find a ref store in that case instead of
segfaulting.

Reported-by: Jeremy Feusi <jeremy@feusi.co>
Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/submodule--helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index ee020d4749..0f74e81005 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -654,9 +654,11 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			     displaypath);
 	} else if (!(flags & OPT_CACHED)) {
 		struct object_id oid;
+		struct ref_store *refs = get_submodule_ref_store(path);
 
-		if (refs_head_ref(get_submodule_ref_store(path),
-				  handle_submodule_head_ref, &oid))
+		if (!refs)
+			die(_("no ref store in submodule '%s'"), path);
+		if (refs_head_ref(refs, handle_submodule_head_ref, &oid))
 			die(_("could not resolve HEAD ref inside the "
 			      "submodule '%s'"), path);
 
-- 
2.16.3
