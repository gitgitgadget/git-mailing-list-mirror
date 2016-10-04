Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D9E320986
	for <e@80x24.org>; Tue,  4 Oct 2016 18:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbcJDSF2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 14:05:28 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:33641 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbcJDSF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 14:05:27 -0400
Received: by mail-qt0-f174.google.com with SMTP id s49so27216139qta.0
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 11:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=MLStRiWLoxqq4ByPz+XT9kVLsPYNAS8I8x9gyUQlZbw=;
        b=oW9F/cFqrvU5CryyP1sVjV8mbNMhxHHJWW8ThtQAY/KHGaUaSrG+YBpbEbotzSyhXV
         YazzW5qT7lmLnlwf/+rIMM0+j632NrlB7Uo177Fib/suVToTx2ZjY+N41dNNaxY82tnz
         6z0zBYe8VMPXUu+so3YFewHpuiXDghR40f+LehZ5Ir218hQJVKyHkXDS/bM0NCRRGm+G
         aC4A3k0K49ZNbPPGMjuXCZSY0o0w/SRLyqOc2cw/KRWjok4GnfvQ06RlN8AnnYQNPOTa
         s8pnGQnOfbDpT+/N+UIF8HtDc91t7TlIMF8fgt3Bb7dIfV68fcSFk5TiibZeDQlmDvT7
         P6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=MLStRiWLoxqq4ByPz+XT9kVLsPYNAS8I8x9gyUQlZbw=;
        b=NinjPQEcKzkHvuJ1FxW9FujMs/iU6gLw3T5hnXJpN/vwncw8E+RGzjZcFpF7/BBQwg
         fs4AivOTj1q+fZ+eHSdYmV7m/vH2OyB0dDKOqMFY+lHrgUJ/5PoRlXPzd6h9HegcFf+h
         A9Wof8tLr/eL3HK6CU3S7ZOOSYxRBphCTJ/0I6b3KL3LK4PLGcLM1/+dnft/UkRSgV3B
         FJa3x2LrXoPWY0LlQnwFS92ERjv87yPyPpeG3jbSd4S/D42sjUVDUrOhKmUf8PzAq6LC
         eMIKM3xIW1FBBJ8jA4wkenuvAfPdKGFAc55LxOc8Rab8894AswwO2K3FFhEVR0meRX4Q
         AgwA==
X-Gm-Message-State: AA6/9RmEaTM3P+XH62zhLZceht18mGBDPZ4Fs6QPvKkjQZW1TluZsqa3bw3by+ASiXQ1moEme+BHKuYMswltbzNg
X-Received: by 10.200.51.240 with SMTP id d45mr971564qtb.18.1475604326574;
 Tue, 04 Oct 2016 11:05:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Tue, 4 Oct 2016 11:05:26 -0700 (PDT)
In-Reply-To: <xmqqfuocuh92.fsf@gitster.mtv.corp.google.com>
References: <20161004162102.rwofudnx3g3fsyul@sigill.intra.peff.net>
 <20161004164036.6584-1-sbeller@google.com> <xmqqfuocuh92.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 4 Oct 2016 11:05:26 -0700
Message-ID: <CAGZ79kb=q9vCMxKTCfuGGDZdHMdAmh5RP0KN=vCbSS=oerPH3Q@mail.gmail.com>
Subject: Re: [PATCH] push: change submodule default to check
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 4, 2016 at 11:00 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +static void preset_submodule_default(void)
>> +{
>> +     if (file_exists(".gitmodules"))
>
> Don't we need to see if we are in a bare repository?

See discussion with Jeff; instead of checking the file, we rather want to check
if $GIT_DIR/modules/ is populated, as that is version agnostic
("Was a submodule initialized and fetched at any time in the
life time of this repository?"), as well as bare/non-bare agnostic.

>
>> +             recurse_submodules = RECURSE_SUBMODULES_CHECK;
>> +     else
>> +             recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>
> Hmph, why "_DEFAULT" not "_OFF"?

You answered yourself below, and that was indeed my thought. I was
also wondering
whether to remove the else, but then I thought that we'd rather do not
want to rely on
compiled-in at all, and have one init function which sets out the new
world order.
