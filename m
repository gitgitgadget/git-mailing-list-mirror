Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FA381F42D
	for <e@80x24.org>; Thu, 31 May 2018 18:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755912AbeEaSdb (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 14:33:31 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:38262 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755848AbeEaSd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 14:33:28 -0400
Received: by mail-it0-f53.google.com with SMTP id q4-v6so29252632ite.3
        for <git@vger.kernel.org>; Thu, 31 May 2018 11:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ex3+WrsKO2x2zVFhQqbwMfsSZcyaa/Q0wHVneuDWoN4=;
        b=SDygcfPpz3i2TPqW+uXoSas8/OBehrbRwCuAzHGXBEELtNALWBjC7d6z8+Wh/gj1pP
         jTrjr8cG6jZmDh475YxpNxxTYvAul91MhNhYTi6OjhQRcLukcp5zuwNQGi8uWkRTcWvF
         xu7PlQ8rBaJl4KMdYpN5846GnW3NZCYNXpadMN7xpHQupqVhSq7f1fWtxBBdy/+h7w5z
         Bmws6jK+7V42vEy8aQZm53Tu14xIVKoaxTHeDJkmOKJcpa20w8VGiLS4XoPQqE1b+nur
         aCzK7WXcH6EXeV6s6Mc2NWdVJGVLiTk7Z4Ip5hqwLSJTT63hNRNGhmEJ927tWDCBuXv/
         XSJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ex3+WrsKO2x2zVFhQqbwMfsSZcyaa/Q0wHVneuDWoN4=;
        b=qj/mJ/+Tyd88U1HEog+Xe9ypC+onetK/wAMj+4kmhJPwhZEixOlA4/KAXqlaGvg7GM
         Ilgq/i3Lq6J0XOAuMyOBKHvOuqFWXjGO4is3jUZjcrO0THa9lixe+r9+pT8d9TqOADXN
         2P9QexaDuAZZtd67/oif9+ocEsL6lMXawtDRgyUCGxFtmcsdePHLjI8SRRSjXzubG7yw
         lUvbvq+Ug6Ya13x/DxME7MefdimHDzEGRsdnx0hep7WRbv4TSfzVL88PlJLiRPecA+iJ
         e55j5ecDLPzfalchH34MUHcYl6r334xT6IZjEcZ2Us5HcsBpNDneW6Uf7VxA9bZ9T2Yc
         La8g==
X-Gm-Message-State: APt69E0T1lOmxw7BAeZXoZTMV5AcJqzvbyoay+JcRL8n/RnC6Uu9Yvkz
        a66mtGUGFo9ILgus6DftrnrGyazLOhgabZ0dvUApv/S1
X-Google-Smtp-Source: ADUXVKJivZkWJRj9U2br+5MoA67DX0uSPjDbq6IK9m3jtKA6be4msqE1AJ7KzWKOzQmvqLOM4KXufaXdHBy6IiFo9bE=
X-Received: by 2002:a24:3d8c:: with SMTP id n134-v6mr1197275itn.40.1527791607522;
 Thu, 31 May 2018 11:33:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:22d0:0:0:0:0:0 with HTTP; Thu, 31 May 2018 11:33:26
 -0700 (PDT)
In-Reply-To: <d464115b7c2ee5f9084ae9bd33cebea1@posteo.de>
References: <d464115b7c2ee5f9084ae9bd33cebea1@posteo.de>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 31 May 2018 20:33:26 +0200
Message-ID: <CAP8UFD10BW=WYmv2Vz8cFCt1OofpsrhBGR0z7C5tp0ixrpwwgg@mail.gmail.com>
Subject: Re: Bug: Install from .tar.xz fails without write permission on /usr/local/share/man/man3
To:     mlell@posteo.de
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, May 31, 2018 at 6:30 PM,  <mlell@posteo.de> wrote:
>
> I was trying to build git 2.9.5 as a normal user, as I have no root access
> on a cluster with outdated software.
>
> The build fails, unless I change the PREFIX=/usr/local line in
> per/perl.mak:80 to a folder where I have write permission.
> Apparently, perl.mak does not honour the --prefix= setting of ./configure.
>
> Is it possible to change perl.mak to honor the PREFIX?

I don't think we will support old versions like v2.9.X.

There was a security release and we only released v2.17.1, v2.13.7,
v2.14.4, v2.15.2 and v2.16.4:

https://public-inbox.org/git/xmqqy3g2flb6.fsf@gitster-ct.c.googlers.com/

So it looks like v2.13.X is the oldest version we support. Do you
really need v2.9.5?

Best,
Christian.
