Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B52721F404
	for <e@80x24.org>; Thu, 15 Feb 2018 20:46:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161943AbeBOUqj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 15:46:39 -0500
Received: from mail-wr0-f172.google.com ([209.85.128.172]:41268 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161064AbeBOUqi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 15:46:38 -0500
Received: by mail-wr0-f172.google.com with SMTP id f8so974059wrh.8
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 12:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=qM7RjiNjTlh2LB4Xt/NhK7pwIYVn7Pxr7VwxQrNpiEo=;
        b=PbUWTTfcy/Qx9uoI+NVcwoRydg1lnj7biDmq1hZZ8dKtTO1zxj5cNxI70tJWU1fhPJ
         HCbPyc9KOOK3shQY13P5k6KU3+cnapIX69EwfQuocs1N1IGZ3dlx47KyGXOf56iOkeAp
         ZAQV4qcgHkd1ftvktOg6FgWyT0LfnSzuB0xuJGKSxAtLPMj36xrFkwiMjPUQXh03t/b4
         cE8uES1WKDbL7gMljjg+QwZGVJ0CiY+VrSSGu/7doPqJAK7zpKSaUv5M/0ffnBMDRZ/X
         ZqvxpzV5C2lbTOnmnPD7CnvrQ5Sr4/tZX546JX8qe9KhpD944q6t91aThKF0qr2r1v7j
         JODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=qM7RjiNjTlh2LB4Xt/NhK7pwIYVn7Pxr7VwxQrNpiEo=;
        b=UThYUeAepkHoeBp6elqJaJad+knj6VV8KCXEJuxqioNFtoZgWrTqQ0pcoSFUKMOilL
         L7lpPGPl2ljIhejip4Zk5ASwXHCH2O2BzOcP1Dk/t9VW+QSDT3+lhO5Kcuy/xMoStfYd
         jdcqBLcIDM9479BXKGVoYgrvCMHJvdnrvPNhp51m5Q/WIddKhmsOmj6CCUxMcoSx/TAw
         YLsQaimkiN897Q4b3MsMcF45EGrHcyohO/LOBu20eeEV7i70JdU3YnOWEGd6TK72tonb
         DuPyQ3KbYJNU8BFxzyHKNtWmbNJkTKelFr2H24LjJI3rqqUfHwQTKdGSLTT92JQt6beN
         Dpzg==
X-Gm-Message-State: APf1xPDT+wnV8eUQ+o2a9fCHYc+ZJVaQsjpvdyPt/5P83V3BuN2pka0S
        grWun9OGf8IBTtIfTnLbdSidZzVr
X-Google-Smtp-Source: AH8x226ltoNITlQYtNZfJEgbndcQG12r/ccvpWVsf7l4otmdPatLk9yr9vwUIGLcmsE8XGXKSQmPJA==
X-Received: by 10.223.161.15 with SMTP id o15mr3446401wro.274.1518727596713;
        Thu, 15 Feb 2018 12:46:36 -0800 (PST)
Received: from evledraar (static-2-73-24-46.ipcom.comunitel.net. [46.24.73.2])
        by smtp.gmail.com with ESMTPSA id 62sm17530263wml.24.2018.02.15.12.46.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 12:46:35 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Benoit Bourbie <bbourbie@splunk.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 4/8] perl: update our ancient copy of Error.pm
References: <20180214222146.10655-1-avarab@gmail.com> <20180214222146.10655-5-avarab@gmail.com> <20180214230359.GD136185@aiede.svl.corp.google.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180214230359.GD136185@aiede.svl.corp.google.com>
Date:   Thu, 15 Feb 2018 21:46:34 +0100
Message-ID: <87o9kqf0b9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 14 2018, Jonathan Nieder jotted:

> Ævar Arnfjörð Bjarmason wrote:
>
>> The Error.pm shipped with Git as a fallback if there was no Error.pm
>> on the system was released in April 2006, there's been dozens of
>> releases since then, the latest at August 7, 2017, let's update to
>> that.
>
> Comma splices:
>  s/, there's/. There's/
>  s/, let's/. Let's/
>
> The one piece of information I was curious about that this (quite clear,
> thank you) commit message is missing is what changed in the intervening
> time.  Is this just about keeping up with upstream to make it easy to
> keep up later, or has upstream made any useful changes?  E.g. did any
> API or behaviors get better?

Will note that in v2, nothing we need changed, this is just a matter of
keeping up, and e.g. if I run Git on Debian I get a few month old
Error.pm, but if I build Git from source I get one that's more than a
decade old.

> Related: do we have to worry about in-tree users taking advantage of
> improved API and packagers forgetting to add a dependency on the new
> version?  Do we declare the minimal required Error.pm version somewhere
> (e.g. in the INSTALL file)?

We don't, but if that situation arises we could just start doing 'use
<module> <version>' to declare it, see "perldoc -f use", but right now
we work on seemingly every version of these modules ever released.
