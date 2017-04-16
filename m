Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 635381FA14
	for <e@80x24.org>; Sun, 16 Apr 2017 00:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754870AbdDPAcD (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 20:32:03 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34789 "EHLO
        mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754683AbdDPAcC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 20:32:02 -0400
Received: by mail-lf0-f46.google.com with SMTP id t144so53725648lff.1
        for <git@vger.kernel.org>; Sat, 15 Apr 2017 17:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OKBkg6lqQ3cpcDZ5Y8gbZbdCr46Mu0mW5D4Gpe5U+Cg=;
        b=tPVr4AcFyHc9xyadkPzHgLE9CD1NCGLBp5TELG5bRX/dJhYkBbzUKLFH3eFd4f0E7C
         MV/UkcSdxRKiyJr4yI9yF1xMe1VCuwPNhb8AbyHytaLS3RDhRC1hwxWg8wKrjS7N6Xa8
         cH70HALAHZ+4y9YL2iQplHA8pv5wpWTnUMjfAamXILfC+fMojl8rJmVxt9mLbqw6zXWV
         hM0bMarVDek53guaWsXC5ZvodUetw1KQt1P39QSAJMZ3T7IfIqfgaRaQs4L2of2Gr51j
         xxSuzGdLJa30zLNp+GiZ9uJlB5wE6tYBz3ZJETmHu9wvRCYc8IsiQaqcVT3dmXMqnIKo
         yoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OKBkg6lqQ3cpcDZ5Y8gbZbdCr46Mu0mW5D4Gpe5U+Cg=;
        b=G5Ww3UJ3M+mxQaCpvbvMm08sM3Gz/07qMiy54z+OCQMkaPG1e0P2DnlQ7nlyRshZNQ
         FBswTvVcpSCNpb4aDm+7k76sAc6Wgg4JPDztrM1OJTIkjU8dJXxtxEOeGYPCcxPCkpbz
         +kzxKAirh10zQas1nbdL6JbUrV3yxmMi8OigWw+1KMJt0syA6vF/DkFT53/LvhxXj/QJ
         xfcv/Mfi/G0EHmOeJ7PmZ+vpHii0h4IPnPhszH9do2Y2aqgBHPLbU/s6Zwj8XexQZ5f6
         hgZehVpm2J5xedPbLBMPcjiktL5PUXGXksqLJbvMqaabY0gKlwZmCK9B9PxoZy/HcQxO
         aUdQ==
X-Gm-Message-State: AN3rC/4WPBcOjMoR4qTU/RlhsuWTX451VmHDki3pGdHTbF/XtiCXJDik
        zziYj3vpFNMhomjC7VRWyrRkg8IE8A==
X-Received: by 10.25.100.5 with SMTP id y5mr1288328lfb.58.1492302720942; Sat,
 15 Apr 2017 17:32:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.17.155 with HTTP; Sat, 15 Apr 2017 17:31:40 -0700 (PDT)
In-Reply-To: <7a07a2a8-07a6-4342-80d0-7684e6242326@kdbg.org>
References: <CAELgYhf1s43p62t6W14S=nDt-O247cPqsPMUDfye1OTnDND3Gg@mail.gmail.com>
 <CAELgYhfwwLZXGN9yHZ04koDwGn3=KbuJOxhLM-+PCbumTmMunw@mail.gmail.com>
 <CACBZZX7Ajf1c9YKP=MO0T9SV7d0-XZsT=RthJocqZw4_TcCcQw@mail.gmail.com> <7a07a2a8-07a6-4342-80d0-7684e6242326@kdbg.org>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sat, 15 Apr 2017 17:31:40 -0700
Message-ID: <CA+P7+xo+wiTkByd_BrLUEyGc9z7USYT8Joo7OhjrYCUmbHjZ0Q@mail.gmail.com>
Subject: Re: Index files autocompletion too slow in big repositories (w /
 suggestion for improvement)
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Carlos Pita <carlosjosepita@gmail.com>,
        =?UTF-8?B?4oCcZ2l0QHZnZXIua2VybmVsLm9yZ+KAnQ==?= 
        <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 15, 2017 at 4:59 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Cc G=C3=A1bor.
>
> Am 15.04.2017 um 00:33 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>>
>> On Sat, Apr 15, 2017 at 12:08 AM, Carlos Pita <carlosjosepita@gmail.com>
>> wrote:
>>>
>>> This is much faster (below 0.1s):
>>>
>>> __git_index_files ()
>>> {
>>>     local dir=3D"$(__gitdir)" root=3D"${2-.}" file;
>>>     if [ -d "$dir" ]; then
>>>         __git_ls_files_helper "$root" "$1" | \
>>>             sed -r 's@/.*@@' | uniq | sort | uniq
>>>     fi
>>> }
>>>
>>> time __git_index_files
>>>
>>> real    0m0.075s
>>> user    0m0.083s
>>> sys    0m0.010s
>>>
>>> Most of the improvement is due to the simpler, non-grouping, regex.
>>> Since I expect most of the common prefixes to arrive consecutively,
>>> running uniq before sort also improves things a bit. I'm not removing
>>> leading double quotes anymore (this isn't being done by the current
>>> version, anyway) but this doesn't seem to hurt.
>>>
>>> Despite the dependence on sed this is ten times faster than the
>>> original, maybe an option to enable fast index completion or something
>>> like that might be desirable.
>>
>>
>> It's fine to depend on sed, these shell-scripts are POSIX compatible,
>> and so is sed, we use sed in a lot of the built-in shellscripts.
>
>
> This is about command line completion. We go a long way to avoid forking
> processes there. What is 10x faster on Linux despite of forking a process
> may not be so on Windows.
>
> (I'm not using bash command line completion on Windows, so I can't tell w=
hat
> the effect of your suggested change is on Windows. I hope G=C3=A1bor can =
comment
> on it.)
>
> -- Hannes
>

In cases like this, might it be worth somehow splitting it so Linux
can use the best thing, and Windows can continue using what's best for
it, since it is a pretty significant advantage on Linux.

Thanks,
Jake
