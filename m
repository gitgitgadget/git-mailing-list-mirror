Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 191B51F453
	for <e@80x24.org>; Fri,  8 Feb 2019 19:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfBHTbP (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 14:31:15 -0500
Received: from mail-wm1-f42.google.com ([209.85.128.42]:51146 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbfBHTbP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 14:31:15 -0500
Received: by mail-wm1-f42.google.com with SMTP id z5so5078800wmf.0;
        Fri, 08 Feb 2019 11:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OlZkjBvt63uBOn6BFfFGgWjfyh+5I3kivHJaozLXjE4=;
        b=St8v2TIswevdrwmb+cq9zjxJp0sv/kgtxNF2PZ8ulvfdmltobLUuKh0C5zbzhTX656
         WzE5C27xaeTxljI0AWuEm0gkmiYr5RLoOB+/lwV8VupOP5yyeexz1VeLlom4tHu2DaTo
         S8QszqGwbLZd8YCRzjhJpe6xewBfu+Vx12P1eikE4jT6SeHGgPy0l7Y+cPfvx3wHCPjZ
         WF9MJkWIy0F/a1iIlR/3Cx6lXzS85pOL7zDZDN4pU7fJLfX5SBuGY0F/Q7UwQWq671jr
         mqS5E5G8ICjA8vXxVnHDozZH3N4LPil9dGwrHGRO6eoG+zlx9tA9CGTrBdJ7NiaS+j7U
         gBOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OlZkjBvt63uBOn6BFfFGgWjfyh+5I3kivHJaozLXjE4=;
        b=ZY7ROcFgeX6aWuzQR4JMNw4t1IgPwh7SN2FnWA/q3qSTCZrB05xHgk/X3YiO1aXTuH
         WFXGAc5yvtnq8H8rWIzdf+WjP2DXrDBzkQX/S3+/58qwpFB7lRvn0F9NHbDVaCRjaTSm
         VKp7f/pBzfWbyj90fiMplyWzbBJSEYBue1b3ZCDhgT0ow31uXC0yf2eDZczviYdIgpKV
         ooE+K5tFmBmZKhCDhBjn6uVaYbnuxKD5xtObnJUJO8G19j+Dw+jCKU7AqPeBknzRGFCv
         zuUKxlY53GHu6u3G1GAPW1tqX+ShIhdfTr37pfpAV8KgtZg8lhpjqXv51/meGoJjZRgz
         3xcw==
X-Gm-Message-State: AHQUAuZy5PnYkghbAwLpIRVZaov+JfVOdrPFEflU3bUf8d/HZGhdIzMb
        KqhbjmTGwLISIXH95me+hgGTRjgO
X-Google-Smtp-Source: AHgI3IZuJGXgF9XuOeh0QhxF0OjfJ/EfdMSKtrgrQy1MWl4L9la5khvE1m8GThURKtereSn5tc4DfQ==
X-Received: by 2002:a5d:6b09:: with SMTP id v9mr18671507wrw.304.1549654272726;
        Fri, 08 Feb 2019 11:31:12 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id x81sm3864363wmg.17.2019.02.08.11.31.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 11:31:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>,
        "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        'Linux Kernel' <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: Re: [Breakage] Git v2.21.0-rc0 - t5318 (NonStop)
References: <000f01d4bf9e$a508eab0$ef1ac010$@nexbridge.com>
        <20190208165052.GC23461@sigill.intra.peff.net>
        <001101d4bfd6$b9430230$2bc90690$@nexbridge.com>
        <20190208180321.GB27673@sigill.intra.peff.net>
        <0694f2f1-040a-1d8c-cd01-2cf51cdbe426@kdbg.org>
Date:   Fri, 08 Feb 2019 11:31:11 -0800
In-Reply-To: <0694f2f1-040a-1d8c-cd01-2cf51cdbe426@kdbg.org> (Johannes Sixt's
        message of "Fri, 8 Feb 2019 19:29:33 +0100")
Message-ID: <xmqqlg2qjcw0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> If the data does not have to be a sequence of zero bytes, the
> alternatives are:
>
> * `test-genrandom seed-string $size` for a sequence of reproducible
> "random" bytes
>
> * `printf "%0*d" $size 0` for a sequence of '0' characters.
>
> In t5318, the zero bytes do matter, though.

Also some consumers of these bytes may not be easy to read from a
pipe.
