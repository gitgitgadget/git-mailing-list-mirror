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
	by dcvr.yhbt.net (Postfix) with ESMTP id DC08B1F731
	for <e@80x24.org>; Sun,  4 Aug 2019 00:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbfHDAZ6 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 20:25:58 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:36565 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbfHDAZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 20:25:58 -0400
Received: by mail-io1-f66.google.com with SMTP id o9so56615380iom.3
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 17:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uEsmPKavrZKTXvJ9aa8RvJ6lq9keZxxMCO9kV26MBI4=;
        b=KbbujYUlSPT18xH6fe9xW3V1WUysCL01xJqbwuyKEzfbrSSe6zNThicQk8kLEd9U0v
         bVYE24MYb1sF6SzPouIKh/f7mhzJJQ2R7Zosm5ikhRkLGfQSAFIkFg+WHUH/7IY5Kuj4
         XD/xI7ddHFYhUhQ4Kzpa0t1xMNvgvuidIDSeDbZj4d79ci5Th1XQJeGg+yQ2G1f2bwOF
         UVGAkD0gex35rB20JUdzDbMv5sg5WdfR8r4xUj1dQM7F4ZggK2UStRpUR2hU/vwu4Hoo
         5pP8yDJV2yqL5lL8TTeDyl9M2OpdgAIURA0/H/jDB4lz4Tv4NAipSAkblzGHnQh4EzwE
         FJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uEsmPKavrZKTXvJ9aa8RvJ6lq9keZxxMCO9kV26MBI4=;
        b=khkzB3M5zPy3PpL/VtFQs3zEa1WvYnJPWimS2qpEYYlPjMmuizMfsL86tqnzg2fdZm
         2ijfZxlIqVL8xYpg8p7/oXYInHwArwhqslKpLuqjlReFBy44bVmLRE2eqjxDDF9pT5c0
         SB5uLTjiKm+5kYV1+Poee7NzL4V1+J8uuqwWCv2UUSDHxzMjg5ur+4xRxaSYebATAaB9
         iqI/b4Ep/SgqI82jmHkrNU7u1ptAaQklSEVDg7VU2u1bTgmNdqKbvKP1SSxfX07KajY5
         Vims7bPilHdOQqnZn6ibL7lUfwXkeJ+fMJZKSS5To083QKtNXcyI1VVISHEBpPN9YDz1
         g/gw==
X-Gm-Message-State: APjAAAUXPgZDCdcb+qGPeuYQyWl8ODDCUcDRJZVWKBsqtDDPGqpDkCGj
        onTmzp4bOM9UDxQ8tpjjyffSO/bvzhalqyaVr+I=
X-Google-Smtp-Source: APXvYqyoqGNVwV6KYHzhc9WRm23Rt6D3HQlHW/Om80GJhZGMsar5Jo1XmxZVNIZXmnAWIxPr8qPAL8V1QUYR8i5UmXs=
X-Received: by 2002:a5d:890d:: with SMTP id b13mr16658291ion.124.1564878357327;
 Sat, 03 Aug 2019 17:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190728235427.41425-1-carenas@gmail.com> <20190729105955.44390-1-carenas@gmail.com>
 <nycvar.QRO.7.76.6.1907311426290.21907@tvgsbejvaqbjf.bet> <87o91a5k0d.fsf@evledraar.gmail.com>
In-Reply-To: <87o91a5k0d.fsf@evledraar.gmail.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Sat, 3 Aug 2019 17:25:45 -0700
Message-ID: <CAPUEsphQVjptjZVh2mmXWdDj4rEohgtWw5UWUmN_qKc0XC9psg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] grep: allow for run time disabling of JIT in PCRE
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        gitster@pobox.com, dev+git@drbeat.li
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 31, 2019 at 7:57 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> What hasn't been supported is all of that saying "yes, I support JIT"
> and the feature then fail whaling. I had not encountered that before.
>
> So far that seems like because Carlo just built a completely broken PCRE
> v2 package, so I don't know if that's worth supporting on our
> side. I.e. this isn't something I think could plausibly happen in the
> wild.

since you are in Debian please follow the instructions here:

  https://wiki.debian.org/SELinux/Setup

no need to rebuild git or pcre (but to enable selinux will need to
reboot twice), then type as root the following:

  # set enforce 1

Carlo
