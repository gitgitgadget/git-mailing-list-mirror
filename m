Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A73121F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 01:35:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfJNBfZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Oct 2019 21:35:25 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:13862 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729444AbfJNBfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Oct 2019 21:35:25 -0400
Date:   Mon, 14 Oct 2019 01:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571016922;
        bh=eEON2EeDZ7HPeFKlA9j7sPvrMMnvnLOJrd0yoGNYX8g=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=BIypkmDK0w3e2SZqkmv9k1FYInD/lyXGoKQRylTO+9OexBbwIQthtbllLKWWtjXg7
         fz4la5Bho6cObg2jydjDZgK+iMJWYgSoyAjvH+uxjevmpXXj7Swof7LzhEPuPSWOq2
         F7uELyj93JWHHDxmtDVMNtEySZ2JWeRqour3KwVo=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Ron <ronazek@protonmail.com>
Reply-To: Ron <ronazek@protonmail.com>
Subject: Re: Local Config File: Submodule initialization looks broken with the --recurse-submodules option when cloning a repository
Message-ID: <ZkLbpInDB0A-uWL3lVcy67PplIX56Pr7qakiHnXnP4OInRFs20ZPH3wDZl-LNoCNRv-_4HlTwa9LLkrWjdVFPshEi-JXVAhHwsLdp2ivJew=@protonmail.com>
In-Reply-To: <Otial29UjnjP-PuGN9Mwnd8k4q8Alof6wWOxFqYv_mXpNbumrljWGN44RvNZYIkC-in7KSXzjFjbceYglTW4iACRcven7CyHUUSUcPCWbL4=@protonmail.com>
References: <Otial29UjnjP-PuGN9Mwnd8k4q8Alof6wWOxFqYv_mXpNbumrljWGN44RvNZYIkC-in7KSXzjFjbceYglTW4iACRcven7CyHUUSUcPCWbL4=@protonmail.com>
Feedback-ID: RMis9b9KHKlvsb8KKkeurfBt3UTu5TN-1L1t5jXjkqXfFdr8BIyQs5Ws7O_ywm8jXx2U-EI3XDzu_Y-JlzMpfw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Initially reported for GFW on version 2.20.1, I have tested with Linux Mi=
nt Mate 19.1 Tessa which by default uses git version 2.17.1
>
> It produces a config file with the relevant submodule entries looking lik=
e this:
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-------------------------------------------------------------------
>
> [submodule]
> active =3D .
>
> [submodule "Submodule/Path"]
> url =3D https://github.com/organization/submodule.git
>
> -------------------------------------------------------------------------=
--------------------------------
>
> Instead of that, which is produced by manually initializing a submodule a=
nytime after cloning:
>
> -------------------------------------------------------------------------=
------------------------
>
> [submodule "Submodule/Path"]
> active =3D true
> url =3D https://github.com/organization/submodule.git
>
> -------------------------------------------------------------------------=
----------------------
>
> Sent with ProtonMail Secure Email.

I've got someone to test this with the latest 2.23.0 version on archlinux.

It is still happening:

git clone --depth=3D1 --recurse-submodules --origin upstream https://github=
.com/git-for-windows/git;
git -C git config --get submodule.active
expected true, got .


Anything more I need to add to help this get solved?

Sent with ProtonMail Secure Email.

