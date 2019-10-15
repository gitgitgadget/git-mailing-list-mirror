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
	by dcvr.yhbt.net (Postfix) with ESMTP id 03D1A1F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 00:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJOAjZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 20:39:25 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:59347 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfJOAjZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 20:39:25 -0400
Date:   Tue, 15 Oct 2019 00:39:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571099962;
        bh=J5txPpgMbPRHHFjpAnVPxf7+ubmVAz0arIOvtRJFPSY=;
        h=Date:To:From:Reply-To:Subject:In-Reply-To:References:Feedback-ID:
         From;
        b=SDQKQkG6kq8v1ZLg+0q2mGpnvBPZZVh0YkDJhOEeunDPr5/2n7MRZDqDoCB3YsQgI
         Q5xL5zUxp31hCwAaY6jCLPZzZm7aFb96O1x/1mMT913p/RrOBFXL8HfxM7/yJ453gF
         IYIOkqJSGHzfV+W/5vRZrjqKO4Pei5WQ0aN1ZtWs=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Ron <ronazek@protonmail.com>
Reply-To: Ron <ronazek@protonmail.com>
Subject: Re: Local Config File: Submodule initialization looks broken with the --recurse-submodules option when cloning a repository
Message-ID: <XqdveI1_zW78uGKUxGnJanJ87mg_lJaw9tKylbfgadEeKlVUlOx5juZWpXC0OPDC4lD60mbRTHDm64HqP1Jxw-A9byDF9le2YfuECuatGQk=@protonmail.com>
In-Reply-To: <ZkLbpInDB0A-uWL3lVcy67PplIX56Pr7qakiHnXnP4OInRFs20ZPH3wDZl-LNoCNRv-_4HlTwa9LLkrWjdVFPshEi-JXVAhHwsLdp2ivJew=@protonmail.com>
References: <Otial29UjnjP-PuGN9Mwnd8k4q8Alof6wWOxFqYv_mXpNbumrljWGN44RvNZYIkC-in7KSXzjFjbceYglTW4iACRcven7CyHUUSUcPCWbL4=@protonmail.com>
 <ZkLbpInDB0A-uWL3lVcy67PplIX56Pr7qakiHnXnP4OInRFs20ZPH3wDZl-LNoCNRv-_4HlTwa9LLkrWjdVFPshEi-JXVAhHwsLdp2ivJew=@protonmail.com>
Feedback-ID: RMis9b9KHKlvsb8KKkeurfBt3UTu5TN-1L1t5jXjkqXfFdr8BIyQs5Ws7O_ywm8jXx2U-EI3XDzu_Y-JlzMpfw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I've got someone to test this with the latest 2.23.0 version on archlinux=
.
>
> It is still happening:
>
> git clone --depth=3D1 --recurse-submodules --origin upstream https://gith=
ub.com/git-for-windows/git;
> git -C git config --get submodule.active
> expected true, got .
>
> Anything more I need to add to help this get solved?
>
> Sent with ProtonMail Secure Email.

This appears to have been a false positive, there are 2 different kind of "=
active" parameters in the config file
and this is, according to the docs, expected behavior. I'm not sure if the =
other tester wrote the last line
himself or did git wrote that for him, because on GFW that command only out=
puts the value if there is one.

I cannot reproduce the error anymore that I thought was happening because o=
f this, it never caused a problem
when cloning or when applying submodule later, it must have been a coincide=
nce at the time.

The effect is "equivalent" as the docs say, whether doing "--recurse-submod=
ule" (without specifying pathspec)
at clone time or doing a normal clone and running "git submodule update --i=
nit --recursive" afterward,
but technically the config file will not be the same.

Sorry for the inconvenience.

