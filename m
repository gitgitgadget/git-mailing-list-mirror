Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA3AC1FC44
	for <e@80x24.org>; Mon,  8 May 2017 16:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbdEHQZb (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 12:25:31 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:33341 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751216AbdEHQZa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 12:25:30 -0400
Received: by mail-pg0-f50.google.com with SMTP id u187so29502632pgb.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 09:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tzjYYnf+szrqFx3vqM2Nm/O2FbHUoXT72X74l/pvM2E=;
        b=Gh/ZOAonCw5iqC3eNTv78TJHYEvmHTe8qB10cjwTZbxM7pfuUtLxn4ozXBETqicSQy
         2ypDSLb3KFdTelbOhs0CqP5wg7jFPAronFC4Z/sTbISmqxq30H5k30kE2xJNXX+WT0Vx
         RzOPf89gK1hei9k7vgjKK0urKPE1yqOz7+xx3N46/OrwbtqqNU/an16yIPEB/dsMHy/w
         qUfFT0wZr4TNzjj3ueijETmTz9bggARXeY5EUaEr93os+Qn9/8PJT02E3A29jF/Z4lFp
         B+8RouVcQsU2agkg/b4EmuM3vbOkvGxnpyjibS4D5BKNj2nFgdcGYoMWM0a8XusubItR
         DAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tzjYYnf+szrqFx3vqM2Nm/O2FbHUoXT72X74l/pvM2E=;
        b=cWAXcnhPKbl2lrmTDcX0uCbOrgR07nFZdkSwTJV8SVv6QQCP4uzE3CimnuyTuXvGPa
         56U/rTKsLepe++5RaCaiuvNUJ7ujTrbg47ysXBUeX6UZLsjQv5CVKjPP+ASAwjb+FpZD
         BxEaYi3IqsESYgs1Iy0GTjf0OaOnsiGfWs4m03bODny+pwkVqhWQqhWzrkL/ZSS6e0N7
         x9fZDkLsno5e0qcvpqkzmtb43DpW02ONVOtY6nCPk0bO/PZCQwiIv0to/yQpfJ6k5r1L
         ouPDbAQDCHkvbhFjGQGXrc28kTq1J09SGOabqWtBrECylGjFcEyHw766W5Wl6RyU1cbt
         axyA==
X-Gm-Message-State: AN3rC/4ugu5/MLy0bHHv02SiT2+qFlCTppw5PeyQfqvkSQesNyRjSwtP
        BPfq5VosRS/Ql7mrJXQnG850nLxLzaIx
X-Received: by 10.84.228.207 with SMTP id y15mr46057345pli.172.1494260730143;
 Mon, 08 May 2017 09:25:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.140 with HTTP; Mon, 8 May 2017 09:25:29 -0700 (PDT)
In-Reply-To: <001b01d2c809$62ac8520$28058f60$@nexbridge.com>
References: <CAFXrp_do8Jn-k18_FSRNeHQrWNydwdj2y3y5gw+XoZPGAzPL-w@mail.gmail.com>
 <001b01d2c809$62ac8520$28058f60$@nexbridge.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 8 May 2017 09:25:29 -0700
Message-ID: <CAGZ79kaES-3ftadorYnx2wMDc-q7qsG376E1zy-C67Ldt2BO5g@mail.gmail.com>
Subject: Re: Add an option to automatically submodule update on checkout
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Ciro Santilli <ciro.santilli@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 8, 2017 at 7:42 AM, Randall S. Becker
<rsbecker@nexbridge.com> wrote:
> On May 6, 2017 4:38 AM Ciro Santilli wrote:
>> This is a must if you are working with submodules, otherwise every git c=
heckout requires a git submodule update,
>> and you forget it, and things break, and you understand, and you go to s=
tack overflow questions
>> http://stackoverflow.com/questions/22328053/why-doesnt-git-checkout-auto=
matically-do-git-submodule-update-recursive
>> http://stackoverflow.com/questions/4611512/is-there-a-way-to-make-git-pu=
ll-automatically-update-submodules
>> and you give up and create aliases :-)

The upcoming release (2.13) will have "git checkout --recurse-submodules",
which will checkout the submodules at the commit as recorded in the
superproject.

I plan to add an option "submodule.recurse" (name is subject to bikesheddin=
g),
which would make the --recurse-submodules flag given by default for all com=
mands
that support the flag. (Currently cooking we have reset
--recurse-submodules, already
existing there is push/pull).

> I rather like the concept of supporting --recurse-submodules. The complex=
ity is that the branches in all submodules all have to have compatible sema=
ntics when doing the checkout, which is by no means guaranteed. In the scen=
ario where you are including a submodule from a third-party (very common - =
see gnulib), the branches likely won't be there, so you have a high probabi=
lity of having the command fail or produce the same results as currently ex=
ists if you allow the checkout even with problems (another option?). If you=
 have control of everything, then this makes sense.

I am trying to give the use case of having control over everything
(or rather mixed) more thought as well,
e.g. "checkout --recurse-submodules -b <name>" may want to
create the branches in a subset of submodules as well.

Thanks,
Stefan

>
> Cheers,
> Randall
>
