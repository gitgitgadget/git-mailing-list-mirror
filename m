Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B364DC433DB
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 17:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C4664DF2
	for <git@archiver.kernel.org>; Sun,  7 Feb 2021 17:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbhBGRhE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 12:37:04 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:43274 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229491AbhBGRhE (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 7 Feb 2021 12:37:04 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id A183660B19;
        Sun,  7 Feb 2021 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1612719352;
        bh=3wNN0wdK/F0FdpDVbcaZ+CRxkSDX86ldHbm9JOMLumI=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=kiCIK0uvru09FK4dshIJQr6oikHvpF/hc5CPM5hnwIFWRI/tPoK5h62UzrCPxMpZn
         +GjsmWxyyomJ1w+NDNnIYq8N1UU/sGuhMk7S92DCAPk3CszEAR82WUmRPt+ka8/TuT
         Mkr+yPppfXB6ueNu/G5pimPQr6v4UafwGEvSluHaAskiNxmQ9TzTbIcfzA2ciiLK82
         v+mBbOTudKUVn89P7ieeUjCcYWJoq0Cago9Rf91R/uddWf82jV5IcUNtHIYkUfKuRy
         qvm/V0KBokvVM8X1lQQtwO6obcTivsbxrls7zKwiH7H7oLb++rzOfbBmqLBXO7ZJgE
         CbqBK78GxiCVIkOlKCuDv0SiOSiGTlLuAPDwy7lrcjqU7mdHjeoO12SRJHV/0VO5b9
         Fj59jwaJ/G7rkqokLlj+XxOxJcY1B7ertdPw7AcUnZ6f5QIUSyY7VlTQ2QVNeZKhDM
         7wXdIF82iGLHcxr4vIBhTRTtNTwgdOK09b4unObYY8rp210Q5YX
Date:   Sun, 7 Feb 2021 17:35:45 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>
Cc:     git@vger.kernel.org
Subject: Re: default editor
Message-ID: <YCAk8Zx8KvZhaJMx@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        M Douglas McIlroy <m.douglas.mcilroy@dartmouth.edu>,
        git@vger.kernel.org
References: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bGVN7WjdKoFKeyVn"
Content-Disposition: inline
In-Reply-To: <CAKH6PiWS5DvqctFnvZ+uyOzBs75hcy9HzbW_3gUCu+RE+oOYyw@mail.gmail.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bGVN7WjdKoFKeyVn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-02-07 at 13:24:07, M Douglas McIlroy wrote:
> While downloading git, I was asked to name a default editor, which I
> did: ed. from cygwin. It worked in the enuing test, but was rejected
> because it returned an error. I suppose this is because
> cygwin return  conventions are those of Unix, not Windows. That raises
> the question: does it matter? Does any other part of git depend on the
> editor's return value?

First of all, I don't use Windows and this sounds like a
Windows-specific problem, so you may have more help at the Git for
Windows issue tracker.  But I'll try to help anyway.

At the command line, what does "git var GIT_EDITOR" print?  Is it
"/usr/bin/ed" or the like?  Or is it something like "/c/..."?  Also,
what is the exact error message you receive from trying to run your
command (copy and paste)?

The reason I ask is that Git for Windows ships with a POSIX-like
environment called MSYS, and as such, Unix-style paths are interpreted
according to that.  So to specify a path for Cygwin, you'd need to
specify it as a Unix-style path under /c (or /d, or whatever drive) so
that it could be invoked as a normal Windows program and not something
relative to the MSYS environment.  However, the path is handed off to
the shell, so it needs to be in a form that uses slashes.

I don't think the return value is the problem.  Both Unix and Windows
return 0 on success and nonzero on error, and Git will interpret
editor return codes that way.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--bGVN7WjdKoFKeyVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.20 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYCAk8QAKCRB8DEliiIei
gQ43AP9NeBAH37WcI57GV+zxiuYpmTPNsj9rigYaE7JSj01pvAEA6Smay7NfojuT
g5LDRhuEyaPajto0EFtO2QCRPye+6QA=
=KS7x
-----END PGP SIGNATURE-----

--bGVN7WjdKoFKeyVn--
