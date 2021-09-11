Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A3C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 06:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79D4560F56
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 06:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbhIKGpQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 02:45:16 -0400
Received: from mout.web.de ([217.72.192.78]:46187 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229487AbhIKGpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 02:45:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631342638;
        bh=27TVCya2oRRb5uptpU3dw3PtcA/H69BtN7SSUSZV4QM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=NkGZN8cgd8urIq9YYvyUqqWgZD4NyQnFnTAajRi3/tUhThD1HNc0GJ+yXi3woFvhV
         y6OX2cCC0+pts5V7T1VE6vj2EMPszRNq2WLpHvBAXnohOj+AnhuVwlprqLJ4rIwYYS
         xfCyiATHtwgKSR3LMJxRigOitlJj1B8ySN2EXsHA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MRUBA-1mVWK62Xf6-00SjWo; Sat, 11
 Sep 2021 08:43:58 +0200
Date:   Sat, 11 Sep 2021 08:43:57 +0200
From:   Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>
To:     "Mirochnik, Oleg V" <oleg.v.mirochnik@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git apply can convert LF file into CRLF when .gitattributes file
 is a part of a patch
Message-ID: <20210911064357.r7cpmxkt5w5davzb@tb-raspi4>
References: <SJ0PR11MB49429B90AA71A06BD4A3BD15C6D49@SJ0PR11MB4942.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR11MB49429B90AA71A06BD4A3BD15C6D49@SJ0PR11MB4942.namprd11.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:WvlsE7XHnD2nNQBhHEkbeC0UCpB15mj8fFPe2kzdPUNgAFTE7nS
 YWU4Cw0D1L/PIIK5lKGpRxafkG4LBAYN1rI1Kq/EXp7RJuw7zd00hCO6zWfuwJWbB2uy+FA
 uAxxUpAmMeY9hjZX6uLfbdSlGOvQ1awc8bpaab/AX6W6/iWDpO3dYeSQ+hmAQPT+mjDh6Fn
 blHzmFKEjmX1K+GJAROmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XOQlL2CT+lg=:UylowG83f4SEO/JCAyG8Hw
 2WctTHNdO74mWGig5GxiPyjHi5JEZgBWNphSOR8snNYBxpcD2epLuxYm2c+Scmu+HOpkXDovE
 9bchWEMQ+NxxzxQN9PwOOwF3r4P97cUAE/eE4m2lwj3oY16gZeNzbvCprJMHIu59KXywbNVtr
 s2pZWSuexSCrGfEKOV9y89OKMq1prosK68KrrvZoeBiLQhMhZTJcpU08BUygv4ATgeOSmYwnr
 Mpx0zM9WGjxFNuqrU2gFod/AZvcR+wnAX+mXr52648XSfwv7nyBuaf6kjnU6CUbKiVfDhEnji
 bcVQGQljDXkvmqhtzBT7NL3z+cJXPyqbZI3V0q5ZGBuiQHSH9u4jj5E8iPpARqDOGZl86bcFV
 R9CDker9dMrFpQT64K6ULtRHnsTcblniaVU95zV1VC1thPTtxXrWTge8FZyU0MDf+vomqXTwv
 +Ie1BYHVEbBGFGttRSHNx7D4Ciht9bcPB3jGi77CHAyO7twm3M30fD4RtwUel7elmaBWaNf8u
 1e8KWp9y7TjGg8wV5CEVzPGXjs/pI+/BmUXv3ou/kLHsnkJhbQrpjBPRwBAAl/uawG6ljmoA8
 3ogo1Q2AYWAci28eGmmIW8vBhCXytOgsTXdrll63j0RZWSv1tepN8HEUx1xb8pMAJHyG/C9+3
 CS3yk9kAhk6rUoXSUajNBxN0BtnUlbVOLqrry6nOpj13Qua3WIgdktZuCVtNJHp4Nu8JfrHUe
 bv6h2wUVbxBdS3xEJYdg2lBlgEdp8pIjHwO2fxMIG1i0b0pr+61Oq4dJXEerMoCVyA3e5FnkU
 WoObg21stFW1m95FcDYL4i46R0cXp5pkN2kqOo698WlwifwGHxqrR43DuKB77+8toOMIfrD98
 CuMY8Lz8Tcj5Tyni/loj+cdEPd/aAe4EamOX39ecqyOVu9eaO+aTuTvjSDhadVWxzs9rORUZY
 hWFNaSaSLPawmJNFMueJaXX+ySr551eNFmhIJ/kdg8xQsGQ4N17w2uNS6WyvZFPmgxLS8ymBX
 he/tRln2Yxn/0+uvquYWjHjUltIZckcO/EKwATlAn/nqbcuMsx1n82OtK4BuWz2pQrV6AsJxC
 ZFwPoTmSyZvzkY=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 12:53:42AM +0000, Mirochnik, Oleg V wrote:
> Hi,
>
> Originally the issue was reported in https://github.com/git-for-windows/=
git/issues/3409
> But I was asked to report it in the mail list as the issue is not a Wind=
ows related.
>
> As you can see below "git apply --binary" converts files into CRLF mode =
if .gitattributes file modification is included into a patch file.
> IMO behavior should be consistent - "git apply --binary" should not conv=
ert files into CRLF mode because of unrelated change in .gitattributes fil=
e.


It was probablty me who suggested to report this issue here on the mailing=
 list.
Thanks for doing so.

I extracted your test script, run it on a Mac,
and it seems to give a different result then your run.

Just to quote the las lines:
+++ patch no CR
HEAD is now at a47b66d init
+++ After reset and before patch
LF cr/foo
LF lf/foo
LF lf/.gitattributes
+++ After patch
LF cr/foo
LF lf/foo
LF lf/.gitattributes
=2D--------

Seeing this, I am unsure what is going on.
It may be an idea to convert the script into a real git test case,
and send it to the list.
There is a command
git ls-files --eol
to let Git report the line endings of files

Using
=2D---------------
echo "this is what I expected" >expect &&
git ls-files --eol >actual &&
test_cmp expect actual
=2D-----------------

would allow everybody to see what is possible wrong.
And somebody may be willing to dig deeper - and if it
a bug, send a patch



>
> Steps:
> $ cat doit
> git --version --build-options
> git config --global core.autocrlf true
>
> rm -rf tst
> mkdir tst
> cd tst
> mkdir repo.git
> cd repo.git
> git init --bare
> cd ..
> git clone repo.git 1
> cd 1
> mkdir cr lf
> echo '* -text' > lf/.gitattributes
> for d in *; do for b in {1..5}; do echo foo >> $d/foo; done; done
> git add *
> git commit -m init
> git push
> cd ../
>
> git clone repo.git/ 2
> cd 2
> for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR =
|| echo LF` $a; done
> for a in `find * -type f`; do echo '# dummy' >> $a; done
> git commit -a -m dummy
> echo ""
> echo +++ After commit and before diff
> for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR =
|| echo LF` $a; done
> git diff --binary HEAD~ -- cr lf     > ../patch.with
> git diff --binary HEAD~ -- cr lf/foo > ../patch.without
> git diff --binary HEAD~ --    lf     > ../patch.lf-only
> cd ..
>
> echo ""
> echo +++ Patches
> for a in patch*; do echo `od -c $a | grep -q '\\r' && echo CR || echo LF=
` $a; done
>
> git clone repo.git 3
> cd 3
>
> echo ""
> echo +++ patch w/o .gitattributes
> git reset --hard
> echo +++ After reset and before patch
> for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR =
|| echo LF` $a; done
> git apply --binary ../patch.without
> echo +++ After patch
> for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR =
|| echo LF` $a; done
>
> echo ""
> echo +++ patch with .gitattributes
> git reset --hard
> echo +++ After reset and before patch
> for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR =
|| echo LF` $a; done
> git apply --binary ../patch.with
> echo +++ After patch
> for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR =
|| echo LF` $a; done
>
>
> echo ""
> echo +++ patch no CR
> git reset --hard
> echo +++ After reset and before patch
> for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR =
|| echo LF` $a; done
> git apply --binary ../patch.lf-only
> echo +++ After patch
> for a in `find * -type f`; do echo `od -c $a | grep -q '\\r' && echo CR =
|| echo LF` $a; done
>
> git config --global core.autocrlf false
>
> $ sh doit
> git version 2.29.2
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8
> sizeof-size_t: 8
> shell-path: /bin/sh
> Initialized empty Git repository in /tmp/issue3409/tst/repo.git/
> Cloning into '1'...
> warning: You appear to have cloned an empty repository.
> done.
> warning: LF will be replaced by CRLF in cr/foo.
> The file will have its original line endings in your working directory
> [master (root-commit) fc793f1] init
>  3 files changed, 11 insertions(+)
>  create mode 100644 cr/foo
>  create mode 100644 lf/.gitattributes
>  create mode 100644 lf/foo
> Enumerating objects: 6, done.
> Counting objects: 100% (6/6), done.
> Delta compression using up to 24 threads
> Compressing objects: 100% (3/3), done.
> Writing objects: 100% (6/6), 378 bytes | 378.00 KiB/s, done.
> Total 6 (delta 0), reused 0 (delta 0), pack-reused 0
> To /tmp/issue3409/tst/repo.git
>  * [new branch]      master -> master
> Cloning into '2'...
> done.
> CR cr/foo
> LF lf/foo
> LF lf/.gitattributes
> warning: LF will be replaced by CRLF in cr/foo.
> The file will have its original line endings in your working directory
> [master 718534d] dummy
>  3 files changed, 3 insertions(+)
>
> +++ After commit and before diff
> CR cr/foo
> LF lf/foo
> LF lf/.gitattributes
>
> +++ Patches
> CR patch.lf-only
> CR patch.with
> CR patch.without
> Cloning into '3'...
> done.
>
> +++ patch w/o .gitattributes
> HEAD is now at fc793f1 init
> +++ After reset and before patch
> CR cr/foo
> LF lf/foo
> LF lf/.gitattributes
> +++ After patch
> CR cr/foo
> LF lf/foo
> LF lf/.gitattributes
>
> +++ patch with .gitattributes
> HEAD is now at fc793f1 init
> +++ After reset and before patch
> CR cr/foo
> LF lf/foo
> LF lf/.gitattributes
> +++ After patch
> CR cr/foo
> CR lf/foo
> CR lf/.gitattributes
>
> +++ patch no CR
> HEAD is now at fc793f1 init
> +++ After reset and before patch
> CR cr/foo
> LF lf/foo
> LF lf/.gitattributes
> +++ After patch
> CR cr/foo
> LF lf/foo
> LF lf/.gitattributes
