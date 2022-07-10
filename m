Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D462CCA479
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 08:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGJIBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJIBn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 04:01:43 -0400
X-Greylist: delayed 458 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 10 Jul 2022 01:01:39 PDT
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6130BE095
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1657440098;
        bh=E5EfEHIaNDZlQAs3mSHPA1wgWtP1fU3aGS6oHBrkZeY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=g0oQwBm2dKcIi/vLBx6PftWU8hlC9Nr3eOyuqAAd6lGpnNiaFGhSAKsAXeAeUnheQ
         FzUJMV5E4EohUuvHdAOoVjJxYTAwxIByLwlcbJH9gBgkBFnL4J27vHYrZtdDAaQsZX
         LEF+0baOuJ7W7kce1oqhrBf195NEcn9/55iuRYsA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M3V28-1o9tid2DzO-000qpL; Sun, 10
 Jul 2022 09:48:49 +0200
Date:   Sun, 10 Jul 2022 09:48:48 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
Message-ID: <20220710074848.ku2zobuck6vyim5d@tb-raspi4>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:R85igM/cmYuM2INX4ileGIPMM32aJ/KdhZXlMQF9erJBTMcjiQu
 BOBddLYOT+19c1bHWW0C1mJJzIKfL9nJ/L5eUlnRa1asfM/jTglwABRYa7/5xwXZXJ9gaob
 0jUw+4xTcnoBk7S+fhFARwD66knYLW9t9M0JQs8nKRCJhGOnvixqXZVnWa4JGVLP/W5wK1J
 XWvHRbsEsiA16rkcYlF7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DfQGF9ie8qE=:TeLHX+8Sup3gN0dvinZgXk
 +V6cblesHEU9PiMJHjZ69Gb/b/axAfGJ2DOpprf8fQKirixBC6D7Qxc/LRsGZa2JcSt+ogefZ
 2RLNDpt8zpzHiSCvuVuLkXwDrXFyxxixErXHGC6doozoDhDTiA23UfF33N9TmF27xUPfWajWy
 QN5NZhZw/JqdBKVe0umOfbIe4EOFOjNfGpa9T3+k9PMugHelf6zfwFhtR5fXwzlLn/wbKDaBT
 pEPGL7XAZh5AgY6FjMxm8nkCTbvk81ZRbbCK2CKqXYwCSyOdaGHH+vmco2TcqJq+Hn/pqt4aM
 QxxocHpY/CWZlVNFCOp7vZ2yH4Gdt0ztbeLa16bIpZ4Mwa5JExaGoBrbepj+nfzp5xlFh97z9
 j2cKwXYa8+3TykAECC06vsVhIMAaUvPGOIIA2bZFHsD7uVYknCo9d5ydcV9wYKYHvKuP0A6ao
 O/rgceiq0ZZ7k245YJ8wE64mkqJj101iGX/regKV55khCVGzS0BVhlgLnRIvhNEJOV4+fBdO7
 q7jyLU72oOM/xc3kLFptCJU0w4iYnIPj5HpQEeCk11KR7LVclCo6UDDFasRKzCrPluzjitA+a
 lGiKMluDOL4vkCNSYQbUfJk8HRUbVec28SXPxrZ065VJNxJogUB/a9jpbCX7cdRpKb+kkT761
 fXAyLkel+EA2+l6iI7H1iu3JPrLEopYgbpTmqMiHAPKI3msMnH7Jt+iajhBBauDFYcbBP6ujB
 NG28p+cn+BKRQQuqv8kaO6YnzGC7gw4AFKWEHlrQxuyYWmuF2z3vQnE29Ogs7SM48WyQIT5wH
 lyKtu2iR/3zVpCOIUqHoenuqNNXB5n41EMmDj8nh45v4oXjOZMO6j1rMXNZLlGw2sBi7Wkgwb
 Tf9KaaI6p71u4dZZ09NA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 09, 2022 at 04:56:21PM +0000, Philip Oakley via GitGitGadget w=
rote:
> From: Philip Oakley <philipoakley@iee.email>
>
> Bug report
>  https://lore.kernel.org/git/AM0PR02MB56357CC96B702244F3271014E8DC9@AM0P=
R02MB5635.eurprd02.prod.outlook.com/
> noted that a file containing /r/r/n needed renormalising twice.
>
> This is by design. Lone CR characters, not paired with an LF, are left
> unchanged.

This is all fine.

> Note the lack of idempotentness of the "clean" filter in the
> documentation.

The clean filter is idempotent, I would claim, see below.
You can run it, and re-run, and re-run, there will no other changes.
CRLF in the worktree will become LF in the repo,
'lone CR' stay as they are.
In that sense, CRCRLF in the worktree will become CRLF in the repo.
You can the renormalize again and again.

The "trick" is that the user has to decide what CRCRLF mean and what
should happen in the repo:
CRCRLF in the worktree becomes one line ending (one LF in the repo)
or
CRCRLF in the worktree becomes two line endings ( LFLF in the repo)

For a) you can use dos2unix twice.
Or run `git add --renormalize` followed by
`rm git.bdf`
`git restore .`

The thing is that we used a combination of different commands
$ git add --renormalize .
$ git commit -m "Renormalize bdf.txt"
$ rm git.bdf
$ git restore .
$ git add --renormalize .
$ git commit -m "Renormalize a second time bdf.txt"

... to clean up this very situation.

And, if CRCRLF should have become LFLF instead ?
Probably a python script is needed to fix this.
(or some other script/program in the language of your choice)

We could argue that
`git add --renormalize` is idempotent, but a series of carefully crafted
commands is not.
In short, what is missing is the documentation how CRCRLF is handled by
Git.

>
> Renormalize was introduced at 9472935d81e (add: introduce "--renormalize=
",
> Torsten B=F6gershausen, 2017-11-16)
>
> Signed-off-by: Philip Oakley <philipoakley@iee.email>
> ---
>  Documentation/git-add.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 11eb70f16c7..c4a5ad11a6b 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -188,7 +188,8 @@ for "git add --no-all <pathspec>...", i.e. ignored r=
emoved files.
>  	forcibly add them again to the index.  This is useful after
>  	changing `core.autocrlf` configuration or the `text` attribute
>  	in order to correct files added with wrong CRLF/LF line endings.
> -	This option implies `-u`.

> +	This option implies `-u`. Lone CR characters are untouched, so
> +	cleaning not idempotent. A CRCRLF sequence cleans to CRLF.

How about this:

This option implies `-u`. Lone CR characters are untouched. CRCRLF cleans =
to CRLF.

