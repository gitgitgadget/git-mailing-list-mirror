Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7320B1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 19:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932141AbeFIT6m (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 15:58:42 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38807 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbeFIT6l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 15:58:41 -0400
Received: by mail-vk0-f68.google.com with SMTP id b77-v6so10176347vkb.5
        for <git@vger.kernel.org>; Sat, 09 Jun 2018 12:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=P1MsSvXZ8RRpg1YfZ8yW4vlK9SJbjOPgH+4vFiMbk40=;
        b=PA3JSIsLrSSSndImQ0MrMVenrrZukpTrYWJvCfFDOGlyIovIr+8R0UZTf3OxLc2xq1
         3sbZWCno2T+60bSOVjzrFs/GbBPETpzxCbauMs4DZl8YsJKEjKkspCG3BvKgKPf4Q67S
         EESlYVQskhIwGNmXQp3Fy0r0+NgRbD5xmUiduWuNoma7QxQE+IFB+0QFyCEqthxNn05v
         Y4Ssps52F8NUhbsyFYt1vqKmRlnm+O6W5FDZIurSYHhM68ym34cQPAhIlGuxj/fymj2K
         1v9SYZO0TTMlBCFfe4tcvWxHIzXblJaSM1xYz3R7zHgmV2peiSsoijFy5edNLQKbtNJQ
         LC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=P1MsSvXZ8RRpg1YfZ8yW4vlK9SJbjOPgH+4vFiMbk40=;
        b=BWaxcnHB6yffZXTePVXqoOGtcy+mQI/V7lOVMYj+PO2GC3kHcBbPkbLwNWPSpC4vEs
         tYUvUrZ3vDPAdFFmut9HRI49/t5TSskxEJJDnhM9+z5kAZEFo4E/YydDBDmOb7DfOcFZ
         7lO/4ha8E2gLs9/GjNs5wLdtAxfkeyF4cwiwk4UY1q6Mcai+FJdmCWpy6ZT6zBHq8Bz6
         1ANxVnras3Hb7HB5ZrzGojQhqKNTj38xuCrEUNILDJ9JdtaamFRPeo7wH6nh92hXp9OL
         QwihcpmHSsuVhwkUNr57570cS5XH0tf5zekovMcUJ5R6cXMdZoSjIIHsM4OLlsKFiY/8
         z9Dw==
X-Gm-Message-State: APt69E1i2vdZaftDqYgnzgHbpv0qOaK431ntvQuv3VU5x6OiDuZ8ZMu9
        Gbbcoiv+Mf085Rnib9WoCZRhPTjtATlpXN0OvWA=
X-Google-Smtp-Source: ADUXVKKY4KP9wxOEgxecgBKqH657sIf+mO8eB3vvicGD/2AtlMeDL2pkYEc446szQBHWs5kJ1HSSdApVB4aIr4IirHA=
X-Received: by 2002:a1f:4083:: with SMTP id n125-v6mr6941377vka.76.1528574320714;
 Sat, 09 Jun 2018 12:58:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f28:0:0:0:0:0 with HTTP; Sat, 9 Jun 2018 12:58:40 -0700 (PDT)
In-Reply-To: <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <CABPp-BEngspJMEpwoiTq7SCdsQt7fOT_uePS3c6nRxTVqOnNeQ@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Jun 2018 12:58:40 -0700
Message-ID: <CABPp-BGa+v2x1oeitVDMkQf3qFWx6kUT4wdWhCxjWwPyaW=3bg@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Fix incorrect use of the_index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 12:44 AM, Elijah Newren <newren@gmail.com> wrote:
> On Wed, Jun 6, 2018 at 9:49 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy=
 <pclouds@gmail.com> wrote:
>> v4 fixes some commit messages and killed a couple more the_index
>> references after I tried to merge this with 'pu'
>
> Thanks for tackling this.  The first 8 patches look good to me other
> than the typo I pointed out on patch 4.  However, my eyes glazed over
> a bit on the attr.c stuff in patch 7 that you specifically mentioned
> in the commit message, so my "looks good" doesn't count for as much on
> that one.

I re-read the attr.c stuff in patch 7; looks good to me and the new
series makes the code much more readable in the end.

> I'm getting sleepy, but I'll try to circle back and look over the rest
> of the patches in the next few days.

I read over the rest.  Found a small grammatical error in a commit
message.  Found multiple places that still need conversion, from
pushing up &the_index usages to callers of ll-merge.c and sha1-file.c
instead of having them in those files, to mixes of _cache_ and _index_
functions as in apply.c and merge-recursive.c.  However, Duy pointed
out there was more work to do, and this series is a step in the right
direction and a good start.
