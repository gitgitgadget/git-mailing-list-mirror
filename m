Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAB41C2D0A3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 00:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64BDC22265
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 00:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="HU/EN++r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKBAFd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Nov 2020 19:05:33 -0500
Received: from avasout06.plus.net ([212.159.14.18]:59548 "EHLO
        avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727333AbgKBAFd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Nov 2020 19:05:33 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id ZNLmkw2KQhO4HZNLnkg7EN; Mon, 02 Nov 2020 00:05:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604275532; bh=xvzxKZQ0O+StJJSsk7PMkhE4NnShnwsJJ9PIU/6Uys0=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=HU/EN++rEkDCeMPhmRr1UgLmXLE9/HSpCzByXQKwnk49hrYSwuPI9qa6Ulp9rln7V
         olbBON/DUAf9B360muJGMjWtFAaqpF2JPPAX+aFu5CrQnGLi98jL8IPGLieYs1OA84
         6AKicC7jqr8Uy6bs4if6s1cqBVc06arM89IzPSMVQdvImGtYiNy82R56BwLHI3F4JQ
         s8iXKBmcKIlUqRVt+t4fUu/l1Dvxk9u6J8Z9YvDIPl5RAovVSXCUSlZJC49Sw/P5GT
         BxcN0tWRSeZ4OIteNtYy0kM1jwu9Rbnn6qJ7175ZmmVIfX25I869xnyniHzIxTN7jH
         9NMHKmQ6d6+cg==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=SPPZqNnH c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8 a=lWwUsjGKPwoPn-2AUXUA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH] Makefile: enable -Wsparse-error for DEVELOPER build
To:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <eaf5ac83-af3f-5028-3a9e-1669c9cde116@ramsayjones.plus.com>
 <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <6676a08d-0c25-14ba-4ea6-677bc7ab0e20@ramsayjones.plus.com>
Date:   Mon, 2 Nov 2020 00:05:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <xmqqsg9uxchb.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKOH2/jbiD6x73lskxd9s0ph9SqtXKT8uoyhdkFWxUkdi2JyA68+IzVXtGfazcvUTPl+WDHyaPmWMwKv6+KCRpnBXmsiyKG9ENoWoKIA+q9kjm+k/MOb
 XAioDORvZH09hPSv0ri+uEO4dKWwb09tF3njVFTsr/DoipzNZZojDGjP4Muzq2ikSJ4fs+Ommhe3tg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 31/10/2020 22:22, Junio C Hamano wrote:
> With -Wsparse-error, "make sparse" would fail, instead of just
> giving a warning message.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  config.mak.dev | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git c/config.mak.dev w/config.mak.dev
> index 3126a5364d..022fb58218 100644
> --- c/config.mak.dev
> +++ w/config.mak.dev
> @@ -1,5 +1,6 @@
>  ifeq ($(filter no-error,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS += -Werror
> +SPARSE_FLAGS += -Wsparse-error
>  endif
>  ifneq ($(filter pedantic,$(DEVOPTS)),)
>  DEVELOPER_CFLAGS += -pedantic
> 

I certainly wouldn't object to such a patch, but I'm not sure who it
would actually help. ;-)

As you may already know, I 'make sparse >sp-out 2>&1' on the master
branch, use vim to check for warnings/errors, and then diff the
corresponding files for 'next' and 'seen' branches (nsp-out, ssp-out).
Similarly, I 'make -k hdr-check >hcout 2>&1' on the master branch,
use vim ... etc. Note, however, the use of '-k' on the make invocation
to make sure I catch all warnings/errors, since '-Werror' is given with
the DEVELOPER variable set. So, I would have to do the same with the
'make sparse' invocation after this patch [1].

Yes, anybody who just does 'make sparse' will notice the failure, so
that would be a definite improvement. (How many people run 'make sparse'
though?). It probably would help anybody using 'cgcc' to develop, but
this doesn't quite work (I just tried this for the first time in ages
and was surprised to find it almost works for me, YMMV):

  $ git branch -v | grep '^\*'
  * seen         4141ae2199 Merge branch 'dd/upload-pack-stateless-eof' into seen
  $ make clean >/dev/null
  $ 

  $ make CC=cgcc >sout2 2>&1
  $ ./git version
  git version 2.29.2.389.g4141ae2199
  $ git describe
  v2.29.2-389-g4141ae2199
  $ 

  $ grep 'warn' sout2
  pack-revindex.c:66:23: warning: memset with byte count of 262144
  upload-pack.c:1114:86: warning: Using plain integer as NULL pointer
  $ 

So, this would have failed, because some extra flags ('SP_EXTRA_FLAGS' to
be precise) are not being passed to sparse. We can see that:

  $ grep SP_EXTRA_FLAGS Makefile
  SP_EXTRA_FLAGS = -Wno-universal-initializer
  http-push.sp http.sp http-walker.sp remote-curl.sp imap-send.sp: SP_EXTRA_FLAGS += \
  pack-revindex.sp: SP_EXTRA_FLAGS += -Wno-memcpy-max-count
  compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
  		$(SPARSE_FLAGS) $(SP_EXTRA_FLAGS) $<
  $ 

(Note that you can't see -DCURL_DISABLE_TYPECHECK being set for all the
libcurl using files). So, either sparse has improved to the point that
the 'typecheck' shenanigans used in the libcurl headers don't cause it
problems anymore, or the headers have changed sufficiently. (Hmm, that
header doesn't seem to have changed much).

I don't build with nedmalloc, but last time I did it was littered with
uses of '0' as a NULL pointer (hence the -Wno-non-pointer-null). Given
that we will probably not re-import that code, I suppose all of those
sparse warnings could be fixed.

Which leaves 'pack-revindex.c'. Unfortunately, I don't see an easy fix
for that (-Wno-universal-initializer is now the default, so we don't
need that anymore). Well, I suppose anybody could add 'CFLAGS+=-Wno-\
memcpy-max-count' to their config.mak file (this '-W' argument is
filtered out by cgcc and not passed to gcc). [EDIT: I just tried this
and, yes, this does work! I'm still surprised about curl headers ;-) ]

Note also that my build slowed down by 14% using CC=cgcc, since it is
running both sparse and gcc on each source file.

I guess it would be most useful on a CI build, but I don't know what
would be involved in setting that up.

ATB,
Ramsay Jones

[1] It took about one month for me to get used to the 'pu'->'seen' change,
    but that was mostly training my fingers to type all of the output
    files that are keyed by the branch name: pout->sout, psp-out->ssp-out,
    psc->ssc, phcout->shcout and ptest-out->stest-out. :D

