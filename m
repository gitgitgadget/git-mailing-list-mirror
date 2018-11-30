Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6A32211B3
	for <e@80x24.org>; Fri, 30 Nov 2018 11:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbeK3WiI (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Nov 2018 17:38:08 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36415 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbeK3WiH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Nov 2018 17:38:07 -0500
Received: by mail-ed1-f68.google.com with SMTP id f23so4568564edb.3
        for <git@vger.kernel.org>; Fri, 30 Nov 2018 03:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=vz4GfAJLdGzkfbcF/g8hs7plMetLg5DnMQSbfpgXB04=;
        b=A0lW1bVIKuZZXU5VwnXyGYBuzibf6DLctMaygvNBHnNEElODl7LxDdVRlBZwDAWxrN
         78siEagK5T7Nzza8tM3pvhlaxeywGPhnEvw2kZnUPp7ud8j9l41vluHgw5Sbk/mcaX+K
         4bEr+AwjD9VCdZdNg/0S9dODRYZqn3qhIZpQkS2mR+OFSj3c0ggJNwOvDJPqaqE/nd/+
         brI34FDvpWzrf87vJsLD7u/1ZF94BchE68VGv5WAu1aa8/S3AbnNQ1RZRldDSUNN5PAa
         se/rdl5jd7LzdTHvW/Nvyigk1gs0+rVDh8h/HTP8ixqR6ycuCnjhZRXIgEfzIvc2LixZ
         t8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=vz4GfAJLdGzkfbcF/g8hs7plMetLg5DnMQSbfpgXB04=;
        b=T4hvqeKYB4i+4R5SQfS0ZHSoCUnocuha570+bFKtWUSIPS4BCeYQI/0eCgWMVDYTd/
         YZVmGZoK8pVs5z0+S1zRU5NQ4f23P8vE5Np/mqLGspBvX6CEiwWbJSR+Ew8aU84W6U/j
         aS+yf9x9G+L4xyzGJ+hGhPSJR2IVWpL8hPXT/oXzq22+U1KH3jNYk3ZzLjqux7q9D7V1
         Wylt6zk2PsvlGMXjp5zGqT3tgAXKOyJFevPmHlsZkrSYovBkHMuHh84wN8B5obKRSvxj
         dgPElZBFhZPHYepZE//wy6GJNLCieZbztbPo0CuIhI1rBn3cUJoJO2EPsBQ2th8V/Txq
         06Zw==
X-Gm-Message-State: AA+aEWbIZqup/11dA65zarO8HkyhyghG9squ9qlbV4Gse4K5HoF9WeHv
        Ywc9hDgcRwzTz8x6kttwet0Y3I02
X-Google-Smtp-Source: AFSGD/WR557ervdIu4lslZL4fTw3NRx5ilhZeVHbz8L/dxjOR3NeLm9KnhgdKugYRfGDsZGpyXAzqQ==
X-Received: by 2002:a50:95ce:: with SMTP id x14mr4927099eda.204.1543577347833;
        Fri, 30 Nov 2018 03:29:07 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id w13sm1310438edl.54.2018.11.30.03.29.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 03:29:06 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Stefan Xenos <sxenos@google.com>,
        Elijah Newren <newren@gmail.com>, dan@fabulich.com
Subject: Re: [PATCH/RFC v3 00/14] Introduce new commands switch-branch and restore-files
References: <20181127165211.24763-1-pclouds@gmail.com> <20181129215850.7278-1-pclouds@gmail.com> <87pnunxz5i.fsf@evledraar.gmail.com> <CACsJy8DCKQctO+rf=xP5gVVUy9XBq35Z1xSbfwB30nDJMMJsrA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8DCKQctO+rf=xP5gVVUy9XBq35Z1xSbfwB30nDJMMJsrA@mail.gmail.com>
Date:   Fri, 30 Nov 2018 12:29:05 +0100
Message-ID: <87zhtqvm66.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 30 2018, Duy Nguyen wrote:

> On Fri, Nov 30, 2018 at 12:05 AM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>> Assuming greenfield development (which we definitely don't have), I
>> don't like the "restore-files" name, but the alternative that makes
>> sense is "checkout". Then this "--from" argument could become "git
>> checkout-tree <treeish> -- <pathspec>", and we'd have:
>>
>>     git switch <branchish>
>>     git checkout <pathspec>
>>     git checkout-tree <treeish> -- <pathspec>
>>
>> Or maybe that sucks, anyway what I was going to suggest is *if* others
>> think that made sense as a "if we designed git today" endgame whether we
>> could have an opt-in setting where you set e.g. core.uiVersion=3 (in
>> anticipation of Git 3.0) and you'd get that behavior. There could be
>> some other setting where core.uiVersion would use the old behavior (or
>> with another setting, only warn) if we weren't connected to a terminal.
>
> core.uiVersion is a big no no to me. I don't want to go to someone's
> terminal, type something and have a total surprise because they set
> different ui version. If you want a total UI redesign, go with a new
> prefix, like "ng" (for new git) or something instead of "git".

I don't think that's a viable way forward. First, we're not talking
about a total change of the UI. Most the main porcelain will stay the
same. So we'd have a "ng" that's >98% the same UI, and then if we
discover warts in in 10 years we'd like to fix then what do wo do? Ship
"nng" and so forth?

We already have this UI problem with various config variables that
change things. I think we should just solve this general issue by a
combination of:

 a) Accepting that over the long term we will have Git's UI changing,
    sometimes in breaking ways (with sensible phase-in), hopefully for
    the better. E.g. we had this with "git-init" v.s. "git init". This
    is similar, there'd be an error due to ambiguity with a "hint"
    saying use the new thing if you e.g. feed "git checkout" a branch
    name.

 b) For the general problem of "user has exotic config" we should learn
    a "git -Q <cmd>" option similar to Emacs, which is another highly
    customizable piece of software that has a "don't read user config"
    escape hatch.

    That's a bit more complex than for Emacs since we need to actually
    read some config (e.g. remote config from .git/config), and maybe
    opt to keep some stuff like user.*. But there's no reason we can't
    have such a black/whitelist of config & env variables that impact us
    with a switch to get "make it as if nothing was configured" for
    whatever sane version of that we'd come up with.
