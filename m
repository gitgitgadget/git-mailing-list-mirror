Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7ED2C1F406
	for <e@80x24.org>; Sun, 17 Dec 2017 00:03:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756888AbdLQADB (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 19:03:01 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35462 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdLQADA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 19:03:00 -0500
Received: by mail-qt0-f194.google.com with SMTP id u10so16267213qtg.2
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 16:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=PfAjVJN2UQ4wou8hyFDa5xk2e6x5d6ajpwcqMqUcLsw=;
        b=TmTWQIl5ZkJ9hgK8loWSTeGhsb/rzivCw/WiKyH3SQ/X0efF3WVQ+0Mol6a3kiJ2XG
         lrF6M/GzxX7sCBXEnd4LvJeRzO7jsCCHCC8Jjqp5YZL8HLuWs5MqORJbzhSg/C76k1yv
         RZycOjLSjQJ6dw4OloqYI2iNSX+cdNr/UfPdKrvAH8Qjwx8ynjRU9C5oVdxbaPcmqgBH
         ShJXNsTStAjkfx9RzqufiWtm7e1pW+Fn3DWcE9JTHX49Hy4RJRo6pEll3JsRi2IkNwnM
         hcjvLVyniGi89vE0pqOBAB1gW6WfKR+nvlOtrB9LQ741BNlgAoJv/qDk2yxfEDCcIrs2
         4ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=PfAjVJN2UQ4wou8hyFDa5xk2e6x5d6ajpwcqMqUcLsw=;
        b=oERmfQlz8QlEGbJRdbTydWOknJwlyy6U1AWfdvrMndJdwac5oDaylMWpQgi1gSwrM8
         M3o8UImUGLqOPSlHKymjSotb/FWJ34oboI4KV8mqDlPVASWrrDDsOXiUt16iNk8VQTNo
         pcQZhQu/1LI32b/3uOe71zADJ//VmIprl0SDTlLBTwAwCcpESsvibc0zAbU4/T4jYkfa
         TRo413q9Dsg5lm9CDvq8twQ/mhn0Tqu9yh5G8jn/iBIGBKTaeHgPszJs6PoqbE3Z2Sac
         eBVE/s9MP0zwDEeSAY0TXbkadGmiUIc2PboQmbJBwjkyuinMzJ026orHLMfB2CwB3pLE
         Ycuw==
X-Gm-Message-State: AKGB3mJ+qJEOV+RQH7eXrvUAZDGm3ocN9V1hbFsoiJWLb2sGenjMvzjR
        8u7YLG2+9cb/pn4EnPhHQvaz2OmmVf4eYaeshkM=
X-Google-Smtp-Source: ACJfBovg2q72FfJGKgRViSAZyI+jT4I4rf7t6QXkU5rBGvulmgk09VMsoioqS8o6gkxjkbmtYEjgO5rbTSGUCa0LJmY=
X-Received: by 10.200.39.104 with SMTP id h37mr29010917qth.114.1513468979122;
 Sat, 16 Dec 2017 16:02:59 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Sat, 16 Dec 2017 16:02:58 -0800 (PST)
In-Reply-To: <20171216224839.11372-1-szeder.dev@gmail.com>
References: <CAPig+cTL5hU6R=L3M2i0kfM6_zMLvcHWvNooAr8BU3VQ=X0_Ww@mail.gmail.com>
 <20171216224839.11372-1-szeder.dev@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 16 Dec 2017 19:02:58 -0500
X-Google-Sender-Auth: eW2YCFr8wYewI3SWd5w5E2_36wQ
Message-ID: <CAPig+cR2FE1Gtw5LWUVHgiVwA1++YXKjLgkeN+3MjNzP1=Tguw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] travis-ci: only print test failures if there are
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 16, 2017 at 5:48 PM, SZEDER G=C3=A1bor <szeder.dev@gmail.com> w=
rote:
> On Sat, Dec 16, 2017, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> I'd think you'd want to capture the result of the expansion of
>> t/test-result/*.exit as a string and compare that instead.
>
> I'm not sure how the result of the expansion could be captured in the
> shell, because the shell performs the expansion only just before it
> executes a command.  And if we do have to execute a command anyway,
> then we can simply rely on the command exiting with an error code upon
> not finding any files, and there's no need to capture the expansion or
> for the comparison for that matter.
> So I propose this updated patch, using 'ls' instead of 'test':

To capture the expansion as a string, I was thinking along the lines of:

    x=3D$(echo t/test-results/*.exit)

but that's a minor point. Checking the explicit exit code of a
command, as you suggest, is probably cleaner.
