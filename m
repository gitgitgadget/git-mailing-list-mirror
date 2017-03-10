Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C321320311
	for <e@80x24.org>; Fri, 10 Mar 2017 13:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936432AbdCJNXd (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 08:23:33 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:38709 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936563AbdCJNX2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 08:23:28 -0500
Received: by mail-it0-f46.google.com with SMTP id m27so7704480iti.1
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 05:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0BQbp81qqqN1XKPrJaNARX0S0xM5aNhLdjyFhoR8KGw=;
        b=DV5RuQScqxukq8nUKiSbtiKGp564Ll4LNzi9i3LEZojIwMH+nzn20qYNTkFSQ5Ptdf
         tAbZ0EGreuVVR+DAhpolaVbIl2qblgAlrKL63pTpXsWlG1NHLAYv8e1JFmf0SUwXfilN
         I3ZUXQ2f3ub/hRDI4qKsrCRCLDuNj0u51Cd0ZkZVwqLo1lMbuMlV6DihtPtqyusMpa+Y
         LVj3JTOZw7MSUzgtuVIkRUDAzT5SIDiBHW1F6QGxh4OZefqwmoApeQSsp68KiXt0YODj
         MBeLBn6wPTnHB8TxIC3LkgEb2eXzAcWLBPcFJN26nZwi3MjI+Kdy3UMpggF5BWon1tK1
         kn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0BQbp81qqqN1XKPrJaNARX0S0xM5aNhLdjyFhoR8KGw=;
        b=cuViuZ56XgZfkjP5lkvCSvpV7MiPNfcWv8Z3BOUM6O9nf+ziK0EJuXMkiR7xxX1xsq
         3CC/aRYoseG2S2pIKTfrervH1peahAQ7tid2BNOXQcqAil6l5hMaSloNxiGMXzAHQLjZ
         yEqRpGLK4jP4Z/KH9MEgH9Dv4RpZH5NkMdCnv7903pdEY8tB9/lu2We/2tpC0Y6yuY4C
         sOw9PlcC1hVnVPSIIBir0yVJmrbEUCl+1dkDvEElp9Rmie+njtWj377vHtz8jo5w+jcQ
         eZ/BJkyvVjGKHpBJKGcfki3ga3IHmMAPP2+HnLVJJVIhPBQCTk86fJpaPNmI+ISDCVRj
         qqWQ==
X-Gm-Message-State: AFeK/H2vbzD9GPWlvVwwqiMBOduReLSCtJGiKBHCjrbgbG/ENYnX/kK9VjZVp6BT2ZexlaQN+3F1yV1r5mJvTA==
X-Received: by 10.36.181.65 with SMTP id j1mr1811003iti.91.1489152206609; Fri,
 10 Mar 2017 05:23:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Fri, 10 Mar 2017 05:23:06 -0800 (PST)
In-Reply-To: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
References: <CACBZZX7OSH_dSJ+kswbv2g1Hv6JieDxHHRmqazppgih0d1+hVg@mail.gmail.com>
 <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Fri, 10 Mar 2017 14:23:06 +0100
Message-ID: <CACBZZX7Npivd9bSsA2_D1Xgk9Qjru00KbeNFRgNQUJ5_NBh3bA@mail.gmail.com>
Subject: Re: BUG: "git branch --contains <commit> <name>" does nothing,
 silently fails
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 10, 2017 at 1:42 PM, Jeff King <peff@peff.net> wrote:
> On Fri, Mar 10, 2017 at 11:43:15AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> Ran into this when preparing my --no-contains series, this is a long
>> standing bug:
>>
>>     $ ./git branch -D test; ./git branch --contains v2.8.0 test; echo
>> $?; git rev-parse test
>>     error: branch 'test' not found.
>>     0
>>     test
>>     fatal: ambiguous argument 'test': unknown revision or path not in
>> the working tree.
>
> Isn't that asking to list branches starting with "test" that contain
> v2.8.0? There are none to report (since you just made sure to delete
> it), so the empty output is correct.
>
>> I.e. this should return an error like "git tag" does:
>>
>>     $ ./git tag -d test; ./git tag --contains v2.8.0 test; echo $?;
>> git rev-parse test
>>     error: tag 'test' not found.
>>     fatal: --contains option is only allowed with -l.
>>     128
>>     test
>>     fatal: ambiguous argument 'test': unknown revision or path not in
>> the working tree.
>
> The difference between "branch" and "tag" here is that "branch
> --contains" implies "--list" (and the argument becomes a pattern).
> Whereas "tag --contains" just detects the situation and complains.
>
> If anything, I'd think we would consider teaching "tag" to behave more
> like "branch".

Yes you're right, sorry about the noise, e.g. this works:

    git branch --contains v2.8.0 'a*'
    git branch --contains v2.8.0 --list 'a*'

Whereas with "git tag" you always need -l as you point out.
