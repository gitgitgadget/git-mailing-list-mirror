Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244F5C433DF
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E886A20707
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 11:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AVdKkPNT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbgHZLrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 07:47:52 -0400
Received: from mout.gmx.net ([212.227.15.18]:47283 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728873AbgHZLUl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 07:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598440784;
        bh=yV7fo/7Sa8ejBP4efGUQlwoZzYAg4tvmG0XWG5X3aQ0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AVdKkPNTLjqJhcwepYxgaBZ0/sSiyOKeU6Vo4N+PZOISrwA2h+ngYUStaFzrHniBL
         ZjVOHjdmAeXjON9t32Hf9xnmkOtmf8jm/aGr97cIR8VMrOsbaCnJSInofTVqErwi6V
         GKh57C3GGPAeXfqm0xmYkOaJ6sgtQ7vrizFiOOb0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.212.143]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1ML9uK-1jsg5q1Tik-00IGi7; Wed, 26
 Aug 2020 13:19:44 +0200
Date:   Wed, 26 Aug 2020 06:19:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] ci: stop linking built-ins to the dashed
 versions
In-Reply-To: <xmqq364a3f6r.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008260615280.56@tvgsbejvaqbjf.bet>
References: <pull.411.git.1597655273.gitgitgadget@gmail.com>        <pull.411.v2.git.1598283480.gitgitgadget@gmail.com>        <ea23ba5e269305b660a1722254e2a933c14e5b57.1598283480.git.gitgitgadget@gmail.com>        <20200825134714.GC25052@szeder.dev>
 <xmqq364a3f6r.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1697021862-1598415594=:56"
X-Provags-ID: V03:K1:3o11zo5vA9q5Nds42D157zbIQfgQpj2bBRSvhMnzbaVEBmqO/WW
 xv0mZfD4YhTMfYexCEoO9CJmKHiye2J32GhoCCqClhrsKh5yiuNPApqB0z0d7JFhwBdq491
 8WXQ6lIEyYKV67zgYXyK7JPEFVdV+kWKNiY2HyDAuuukwZ2sHBLhPSJNOwFI726BnhCBWJq
 BtCySLEPUlq2fqWSj86TQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9jSjjiuinzg=:ZnJuWMq4VMSPs1l+e94hmJ
 AfWvrRXsJ1QNKDDxM7ryO9/pOnH0763ebS8diGV6hnBfSofrJGWgLNVJX/WQ1k5xXt+kznWEP
 TMIE9z/SBgBo7Vymi42IHAsGHN2cl4sXgeUJ9kyyhvvu8OGFKcKAtNKgiCyWba0xB9ouarYW8
 72be5jIXQz5VwhFXtXtUbp6jaQzRJGlsmwzkPVMWW9UeSuGDMgYL3YFIPoekgtO22BR+4OiJ7
 6R0btsGZ1RQaIwl+DOuaRJm/YFw4VCIFrzOs3xr+LIMahr5VsZaGwZmkP82fXUuAM7TaJRk31
 TqHTsBjUGf4ibreRuqpGR1RV2ey+0rbDjeijdS4knCj6PXm+p2nsuDAsxzwPtmIyip8PO7gp6
 P6ELkllY6NpXYfM2WG3TBayG/LxdEMxJ90PVhZjVaV0EkM3rQrl6CKvflDK8v1fu0lFJK1l3p
 YUKDuheGRlPqYeIFRnqyEOU+PO6ZDwV5GIP9i9/4voYxen9f6WKnnmOBWcRKZPDuTu4DE4Mzs
 c2cBI5WQ0H/8gPjMjfpSA5p6NUmp2qHKqj2v8Goxf0HmzgeLQb+VAgVs3xFVBRrM676b5WzZh
 IARGkAfvOWwDFbrU4219NcTMDlz89MApTC6DzJFzJSZmBwCtjer9ftKueIpaU6fkOSpzdhrH4
 rcmA+HIAKOFFcEwSAZm36CM/Z4+a5Il0cDO5ynd2YyleM38zWGZM6PUZtoM0kCQnjaFi9FHMF
 VM5OuB3cq3QdsfKUtNBujh+tMrjJrLIMhGZn+XAxaHf5FiUV1Ji6soE4B+b5o1tU4HAcMt1Il
 GhYSpk5MxqW1vi/qM4ALJKRbw/uxN33NnTCUZMcyaQdPYkEGMy+N5aSckCb7FrrU6LojKE+O4
 7a9YWYxXr8dQDkfmC23L8SGtcbl4MwYhG+dniYXyjnkg3EHxXSMaVOR4+LgXai7EtzyplOLzp
 iEuGpLOeHo9dUnQgwe+3Q7ASKJfqcfNmj07MD9NoirLpuxGgPJ5sPOT9ifT99frVjvpX0s0hg
 RMhY+j0UQoq+PcDLGzT0wZPO9DAKlpnk6GPcgNmRb5U1yJXsfDhKFHUGEaHpbUnCJqGH1Pstt
 /6uqnLiJTACVblyy0GLWXmB9RUoX/gHtVZX4or+IJ4rsQxp5v3g4A0j9fIOZcwtdZhWWQGV1N
 ssJgW/289calUxPL7hLdGgWcblw+UvKl3VHzwLZv+p5ss3RQvFdgEnMLDXvtYI+uHAa/eMZhD
 CDvRFOjamFAFRlvLeuuxX84rGlMbvRJ92sZ85aQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1697021862-1598415594=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 25 Aug 2020, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> > I'm afraid I don't understand this patch or the previous one (or
> > both?).  So this new Makefile knob stops hard-linking the dashed
> > builtins _during 'make install'_, but it doesn't affect how Git is
> > built by the default target.  And our CI jobs only build Git by the
> > default target, but don't run 'make install', so setting
> > SKIP_DASHED_BUILT_INS wouldn't have any affect anyway.
>
> Very very true.  Let's drop 3/3 if it is not testing anything new.
>
> I do understand the concern 2/3 wants to address, and it would be a
> real one to you especially if you come from Windows.  People on the
> platform wouldn't be able to use shell scripts written in 12 years
> ago or written with the promise we made to our users 12 years ago,
> and unlike hardlink-capable platforms it incurs real cost to install
> these individual binaries on disk.

Actually, `SKIP_DASHED_BUILT_INS` does not _only_ have an impact on `make
install`:

	$ rm git-add.exe && make
	    BUILTIN git-add.exe
	    BUILTIN all
	    SUBDIR git-gui
	    SUBDIR gitk-git
	    SUBDIR templates

	$ rm git-add.exe && make SKIP_DASHED_BUILT_INS=3D1
	    BUILTIN all
	    SUBDIR git-gui
	    SUBDIR gitk-git
	    SUBDIR templates

See how `git-add.exe` is linked in the first, but not in the second run?

So the difference 3/3 has is that those hard-linked executables are not
even generated. Now, _technically_ this should not result in any change
because we run the test suite without `--with-dashes`.

Practically, it _does_ make a difference, though, as `bin-wrappers/git`
_specifically_ sets `GIT_EXEC_PATH` to the top-level directory, i.e.
`git-add.exe` _would_ be found if any core Git command that is still
implemented as a script called `git-add`.

Therefore, 3/3 makes sure that we really, really, really do not use those
dashed invocations ourselves.

Ciao,
Dscho

--8323328-1697021862-1598415594=:56--
