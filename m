Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5D31F731
	for <e@80x24.org>; Sat, 10 Aug 2019 22:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbfHJWlT (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Aug 2019 18:41:19 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:43655 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfHJWlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Aug 2019 18:41:19 -0400
Received: by mail-ot1-f68.google.com with SMTP id e12so2036385otp.10
        for <git@vger.kernel.org>; Sat, 10 Aug 2019 15:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rWgBLDJ94rHPyfSM62I/nVmky/F9P06fw0Tt+jt1Gtw=;
        b=e1Zy7VV2+IYt0jxE1uhT5mz40oS+yIT2dHgGJUDbhXLfunuqK4QMv6IMnGvL9qSfdE
         cbaQM4fnfCVqEVc4f8LXFFK/WSWYKfdIC7KP9mvxhrpKrSnIFV0xERpfE+FkQ7FyBHkt
         Te5ipVRge0fwueA0ag/yHuWuHEcGCK0vBifqduBUe92Ce7i/REhMbD5P3bXhx0QK7jur
         6wl4OZNBvEUWhu3ImQznoev6mZd8e2qjFyHw0ov5xO3NuLSfZVF7n9BHd3JrLB9Zm5JZ
         m2Orudxg9PRiUtmKPSSuSSBgFJjIUjwhxqg0eEy2qIJUbECQuQLxFCQgZw6NffSm63am
         u/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rWgBLDJ94rHPyfSM62I/nVmky/F9P06fw0Tt+jt1Gtw=;
        b=XDaZZUsjnnnqZbTM4KOSIZVPntQFvOSDhgKsQsPA1xjy7RwDjZfato6cCEbTKInrRQ
         IhecqyPUYwCAPs/oD57nyEj9IIjKgzqOyurwhyyzjuxz1qkIG0D1I0dw1uu3yiA1tMK/
         vyOhTJBGLZrVpRRkEH+5IBPoJABRUwwVgwrpCXhPgQ3nHmpS8kbTgaxAPJJtCoKOdCV8
         sQ6UFB7eL0s35OEGBn/4Zls7qVhBRXmIjTnqYRF3Gfa3fRdxSFSY6phcHxCWmXf5wDXr
         kTCy2Zj5Wj5m83g9jRIcGnQInoemRbK6WLlmKFW5j9YKqCri7hnhDNMpq7XiOicA40ds
         VTiA==
X-Gm-Message-State: APjAAAWDmq9rosDxYW1LO2wRPy89CXbAcRoMMegiz4R3AhOcEniqczDL
        DqfcFwg3Y25PakusBZwIpX9fxNyCSCFopEio0D0=
X-Google-Smtp-Source: APXvYqyBwZgG5td+6HgD7awH5J1YZyPylvfPuSORfoeVkQRS0PKY6/kPlkx5/+hwkfgsxLwU2YQzlaEF31Yvmq7Z8Fc=
X-Received: by 2002:a6b:8f0b:: with SMTP id r11mr25332666iod.70.1565476877863;
 Sat, 10 Aug 2019 15:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190810220251.3684-1-carenas@gmail.com> <alpine.DEB.2.20.1908110011490.26798@tvnag.unkk.fr>
In-Reply-To: <alpine.DEB.2.20.1908110011490.26798@tvnag.unkk.fr>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 10 Aug 2019 15:41:06 -0700
Message-ID: <CAPUEsph0vZmSfMwxDWZJNEsOARo2PHgxvb5HpudZ-3fBiC6S9w@mail.gmail.com>
Subject: Re: [RFC PATCH] http: use xmalloc with cURL
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     git@vger.kernel.org, l.s.r@web.de, Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 10, 2019 at 3:17 PM Daniel Stenberg <daniel@haxx.se> wrote:
>
> On Sat, 10 Aug 2019, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > tested in macOS 10.14.6 with the system provided cURL (7.54.0)
> > and latest (7.65.3) and while the API used should be added starting aro=
und
> > 7.12.0 (mid 2014).
>
> Let me just gently point out that 7.12.0 was relased mid *2004*, see
> https://curl.haxx.se/docs/releases.html

Indeed; just a typo but relevant to get right for the discussion,
thanks for the gentle clarification

Carlo
