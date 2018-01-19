Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 538351FADF
	for <e@80x24.org>; Fri, 19 Jan 2018 00:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754793AbeASAP7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 19:15:59 -0500
Received: from mail-qt0-f182.google.com ([209.85.216.182]:40064 "EHLO
        mail-qt0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbeASAP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 19:15:57 -0500
Received: by mail-qt0-f182.google.com with SMTP id s39so21900qth.7
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 16:15:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=knlJAK5abFQVB6QSzQcasW9N074HXiMJhoZe9l7V8aw=;
        b=NocinmXUbZSJDU+O0tN/wYLhN6v47NRO1O3r/YfjzEJc+Q9v/oIiIsOqgxmSFIghCo
         v69u5hhYi0UNFBZBHLIW4277rveDnoxJ1XIUPC3Hp3u5o0qLO25LWvSAxnOD5xmAq6h3
         UQo8lP0XLWkLD7L3586hYvR6MaRSpoD2almQi0rXxQwKUZx/A7jFrsrt5n81gUbZkXIV
         /RkDm90Kv57o8sWZOjycINVHo3UoyxhGLZB5ZcMMaw1LYb4KEHidUXtOd5OV6MhSVzZX
         +APY1KOLRN7oZMJUX+Uvdedd039RRmLUrL1oMdLbb/bof6hdgvnj9OVAIVRw3gDGwW3F
         BolA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=knlJAK5abFQVB6QSzQcasW9N074HXiMJhoZe9l7V8aw=;
        b=oq9KtS13dIxwSAiDJZb489sSg93dZs011jutHHWTxK1He+SAZTbomtQV6GBPJ///YB
         7j4EhXOUmhS1M/BBBGcINMB2Y3JoiNlpalSS5dJm42cpYegD1IqvoNJ2SBC+enLMYXeE
         G5fNsZNdKt6OMMGVIAipIkscPidYwfWLKVQmRi5co0JwUsy/E9wKVYKYOyr5fbzymnZi
         DDR0v/ttgL3a8iXw41pVXWnMnRj70H9iUsgwJt4NSFwoicvraoEl/lhVPYze1FBQyY+W
         5hKWpz4bWU4Uv+iSMDxV+K4AoinY154gEVbx7cchGAARgAmCeNcsLR8ImhXq0R50yXaF
         1r6Q==
X-Gm-Message-State: AKwxytdDixGlMaKfQ2CfAEOquRcnCTwAfmZXJWnRWOZLdatrdeVIBHny
        U47dOyQg074i17vZ+eFRhnXtZcYJHEp1rDyx9+8=
X-Google-Smtp-Source: ACJfBos6RD0DJH/wW38/WH/5FOZ3kWyvfTbw4CNUnM/bGDWPYwSWFw3iJtlKbn4RZDGSZ8CIRHtEBS+FvxP+0qgRTAg=
X-Received: by 10.55.177.135 with SMTP id a129mr26530306qkf.112.1516320956870;
 Thu, 18 Jan 2018 16:15:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.143 with HTTP; Thu, 18 Jan 2018 16:15:56 -0800 (PST)
In-Reply-To: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
References: <CALwADsGfB10f5+nOFN-pHCt4z1SkWMcvSHn8KokcyCM0V6K-BA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 18 Jan 2018 19:15:56 -0500
X-Google-Sender-Auth: 5jmer1u4OausEP1qNbO7PgrBa2w
Message-ID: <CAPig+cTkBEGyoS93GYCtoDgccTF_UixqBkVTExg7Zf0M1J7KRQ@mail.gmail.com>
Subject: Re: git 2.16.0 segfaults on clone of specific repo
To:     =?UTF-8?B?0JDQu9C10LrRgdCw0L3QtNGAINCR0YPQu9Cw0LXQsg==?= 
        <aleks.bulaev@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[+cc:brian]

On Thu, Jan 18, 2018 at 3:55 PM, =D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B0=D0=BD=
=D0=B4=D1=80 =D0=91=D1=83=D0=BB=D0=B0=D0=B5=D0=B2
<aleks.bulaev@gmail.com> wrote:
> I found that git 2.16.0 segfaults on clone of vim-colorschemes repo.
>
> (lldb) run
> Process 25643 launched: '/usr/local/bin/git' (x86_64)
> Cloning into 'vim-colorschemes'...
> remote: Counting objects: 1457, done.
> remote: Total 1457 (delta 0), reused 0 (delta 0), pack-reused 1457
> Receiving objects: 100% (1457/1457), 1.43 MiB | 289.00 KiB/s, done.
> Resolving deltas: 100% (424/424), done.
> Process 25643 stopped
> * thread #1, queue =3D 'com.apple.main-thread', stop reason =3D
> EXC_BAD_ACCESS (code=3D1, address=3D0x48)

I can confirm that this crashes on MacOS; it does not crash on Linux or BSD=
.

git-bisect places blame on eb0ccfd7f5 (Switch empty tree and blob
lookups to use hash abstraction, 2017-11-12).
