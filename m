Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB26C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 10:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347191AbiHSKPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 06:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346861AbiHSKO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 06:14:58 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6559EDAA34
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 03:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660904095;
        bh=qRENCrn2BesZof1gyesj9+NG2UpHlQclekWx77R95BI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kzQbsZU1M9jDkdHRjSsZhfoffGk3erbXeh2TgxyW5xV4lZFKRIolIU/fEjFxO+fs3
         nBtlExnKh9aLxT8ZjYdHMC7BBZX98FYwGrvQYWftVToZ/LlomuXldghWVpfUhEll1A
         j3rABJBoNfI98sVIgq1pofsTisO7P2ff5FurlED0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.212.11]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MIMfW-1oAfgh1Tqm-00EJdO; Fri, 19
 Aug 2022 12:14:55 +0200
Date:   Fri, 19 Aug 2022 12:15:02 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Mark Fulton <mfulton26@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: Programmatic patches (transform commits)
In-Reply-To: <CAED_RJPh28o8bFsBEEzAYvp1DXhff2JWiTk3zHh3VbaHZephgg@mail.gmail.com>
Message-ID: <n7prrp62-41o1-r280-qo55-9q7rnqs723p1@tzk.qr>
References: <CAED_RJPh28o8bFsBEEzAYvp1DXhff2JWiTk3zHh3VbaHZephgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:J9dRgr0+YbdS8G3HU6VO8VTuwqLreSrlXeBsmN98YQu3D7KEUoF
 M7dBSySWqyJfNP+hL5l/+aDZT4rrnj7qUME1mQccbwVmY3YT/bK/G4xDu8zIroVO6cq46ZY
 Ue3ZzxanLSb+H7H4cbnYGiYcbVJh/kTMpGMH+yI0ESwLYFl5wXkREgdi+NLKstlJzrUerey
 zrGBSXzjJ3mk2+6RioI0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TJyX+wG0Vao=:hYY3XEYI9c6XX7XNjIBhlU
 7Khj4TyAkveZZ0u5J6GUwFm3q2fE8SNyAJf+l3tJsn78sYkSlN8QJd4HLPpfO8NGjBqFo4BWR
 1ja4+USIiZTI/nsiuXzyJSK/5aJWjxBZUsjbzrGKufhWUAOwE0KyNuJCF835P3koC9+6vAnB+
 nCs3qN0KxAIgtHjbajLfUi1b+4DSKheKbP3kk7iqtubYwjgiA6JSXk8XbnoehlPiC71gAUWqY
 2dmWgEHiss89DJWNUxN9xWGnw89/F0x58Mr1acsVgpeDghHgfo3oMLVVXYM9uI0gzTjRd8ELu
 Yzj6FWnEYUE7356D7LKx+abWLDVSSPgkdMv+LYsuuK6xBmeP8klekdurVlUU7+JuftpGhzZFd
 eUb6bIDklzl9p/unw1q/qhzsCruvTcwvE5zKNhQP1excoVHJGdacPOmiexJeV8o5RWisA5erj
 fkgofvB2C4oqIaVskvB9jK0pUjM++nJFG7WDrzMxSITq+QaX0Ulp/DwGUDlI+nhe6i2TztTGf
 3IX2vziVpAtH/8bGyVzZeSv+EbTi0fUJApKE3j9/OF3UTUKOT41f1EFk5Z9PRerwOiWlG/B0L
 aj9+S0bdtP1kbuNXCtsCIYW/jyA6FPb+hf0wiAHDPIi0G606I5QTqd9SX7qGuqow5cJJWlzCp
 MZJY762iGrnaA7A9BUGH6xgWAS24UcAAThEc1PDUR33MrFPOWAdjyHkyG5ZhiwCd6tARIAIsV
 czOuD21QLVelF2UowQipxWem4Tw9FcNRDqXJnqAgDGhrTsrJlyX2MQLghrgPwK9AVmgSjEFrF
 eQAvKuUFYh5BU+RAOMIJpHYngeETIcBjcvK1cNE8dASFEgXaSHOLvoNz8BZFe5p09wbGh/sq9
 CQVKJnjfYHiJoYov0/u3rCOD9gaLntDZnVF3y7KHkfIKa7Si8AmZrWYbUTM35n05ofCKAzvXJ
 kgzAtdIK/0zkSxv/+/ZXAmBIAEVzkuCOx5T1MCYCrkDA1W8q9+VJh4dcFGKY3Lxpu/PRuJIU8
 raMSJCHP8nrXiuOei5fxrTblUzjq25mfcKu1G2lqM6T7FsPyEnk9I6s/nxsKzjQwVYGjrpNT2
 NlkSkuwnODknZ8SumJBiRVQcRyGvsyemS/cWENLxfx4xekju0R4JmTNBg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Mark,

On Thu, 18 Aug 2022, Mark Fulton wrote:

> Is there a way to commit a transform script that programmatically
> applies file changes rather than committing the file changes directly?
>
> e.g. Imagine in a large repository that a contributor wants to replace
> certain instances of "abc" with "xyz". A transform script might be
> like the following:
>
> ```sh
> #!/bin/sh
>
> sed -i 's/abc/xyz/g' $(find .)
> ```

I do have a script to do such a thing, and I am sure other users do, too.
It would be a simpler script if it did not have to accommodate for `sed`'s
`-i` option behaving differently between GNU and BSD variants. For the GNU
variant, I use

	git grep -zl "$regex" | xargs -0r sed -i "s/$regex/$replacement/g"

and for the BSD variant I use `sed -i ''` (i.e. an extra, empty argument)
and skip the `-r` option because BSD `xargs` does not understand it.

> Applying such a "programmatic patch" will potentially edit many files.
> Doing a code review on such a change is error prone due to authors
> resolving merge conflicts manually, etc. while reviewing the patch in
> some circumstances is much easier (especially tools for specifically
> this type of file transformations are used to make it easy to parse
> code, traverse abstract syntax trees, make edits, etc.).

In the Git project, we do have a track record of mentioning the exact
commands for automated transformation in the commit message, see e.g.
https://github.com/git/git/commit/8dcf73c5c940.

The idea is that any reviewer could run the same command, verify that the
outcome is the same, and give their ACK. Or, in case of merge conflicts,
they would re-run the command and commit the result using the original
commit message.

Ciao,
Dscho
