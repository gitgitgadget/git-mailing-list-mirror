Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_NXDOMAIN,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9CE1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932185AbeDWRpS (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:45:18 -0400
Received: from s019.cyon.net ([149.126.4.28]:39100 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932168AbeDWRpO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:45:14 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Apr 2018 13:45:14 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Tbb4hTRZrt1z0r4XLJEYSjb72vAw1CEMjUF4ruNL2QQ=; b=HSGDRfQ+E3/duygi5Rcw7V3tBG
        svbLpvXF875mdvOJl4Yj3wy5Rmoj0Uo5xc41Q2jhk6MGoCvJeARHPTb0Z927sCG+lXs2OE4iUSNVD
        Z2QN1k60NjPsEoXzjzHjbieVPI9zu7+X4mgvahdia4B33Q6Q3fV/71pUhlzXYeqQJ4yvT5wCO8gf6
        m0EbLgYlRZzM1iU/v22LJbanqKbdhtO9apgBFkMJsG3yfsgQ3cevkWbVclgcDzQqbqzfdhuXf80PS
        m1KV6i/XIACDeQBCxp7jzF+xTwZlFTzQoXJlV2gDbEgU+j2R5tmqdxYrjcfN0/c4lKZ3euz4Uucwu
        lOS7fG8A==;
Received: from [10.20.10.233] (port=3198 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.89_1)
        (envelope-from <bb@drbeat.li>)
        id 1fAfQj-0002C4-Pb
        for git@vger.kernel.org; Mon, 23 Apr 2018 19:39:14 +0200
Received: by drbeat.li (Postfix, from userid 1000)
        id 63FCC201E8; Mon, 23 Apr 2018 19:39:09 +0200 (CEST)
Date:   Mon, 23 Apr 2018 19:39:09 +0200
From:   "Beat Bolli <bbolli@ewanet.ch>" <bb@zbox.drbeat.li>
To:     git@vger.kernel.org
Subject: Re: SEC_E_BUFFER_TOO_SMALL on Windows
Message-ID: <20180423173909.GA9916@zbox.drbeat.li>
References: <2048535297.1044.1524500021908.JavaMail.zimbra@tresgeek.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <2048535297.1044.1524500021908.JavaMail.zimbra@tresgeek.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 23, 2018 at 11:13:41AM -0500, Jason B. Nance wrote:
> Hello all,
>=20
> We are seeing intermittent errors with Git 2.16.2.windows.1 on Windows
> 7 connecting to TFS 2017 (running in a Jenkins slave process):
>=20
>     ERROR: Error cloning remote repo 'origin'
>     hudson.plugins.git.GitException: Command "C:\tools\Git\bin\git.exe
>     fetch --tags --progress
>     https://internal-tfs-server/tfs/project/_git/repo
>     +refs/heads/*:refs/remotes/origin/*" returned status code 128:
>     stdout: stderr: fatal: unable to access
>     'https://internal-tfs-server/tfs/project/_git/repo/': schannel:
>     next InitializeSecurityContext failed: SEC_E_BUFFER_TOO_SMALL
>     (0x80090321) - The buffers supplied to a function was too small.
>=20
> I found the following thread from 2015 on a cURL list that seems to be
> similar:
>=20
>     https://curl.haxx.se/mail/lib-2015-04/0136.html
>=20
> However, it looks like a patch was released for that issue:
>=20
>     https://curl.haxx.se/mail/lib-2015-04/0152.html
>=20
> Rebooting the Windows client appears to resolve the issue for a time.
>=20
> Has anyone else experienced this and found a resolution or workaround?

This answer seems relevant: https://stackoverflow.com/a/39217099/232775 .
The link in the answer is no longer available; the current link is
https://developer.microsoft.com/en-us/microsoft-edge/platform/issues/490670=
5/ .

The obvious workaround would be to retry the request, because the error
happens randomly depending on the value of a Diffie-Hellman ephemeral
key parameter.

Cheers,
Beat

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRJ1XlK6nf5B3ZP2J4wS5PPUGqQOgUCWt4aNwAKCRAwS5PPUGqQ
Ot/5AKCgg5z0yEebLI6pKmksXo8MXG2OkACgrckfAULaxFh+MHbxK4G60NVmcdk=
=WZK3
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
