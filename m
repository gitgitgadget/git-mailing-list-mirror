Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 593831F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933691AbeGJQr3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 12:47:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44027 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933307AbeGJQr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 12:47:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so15345557wrv.10
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 09:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+hw0ArnSHSYoJdiIvWLIgJ311tVdhqv3dQcD5a8k/9Y=;
        b=SevC25EnLaJTW7MJCB77G/eDgmcD3XdQZrE7XZZTUI1D8/4x6r3vNBdMU/NGzXwADS
         PAs0IxrhAWMjMzxUfRi8otTepW6HV+JK2z6RhiZ/RyovZNFArYKk4kbNWQTidgoyedU+
         VfYreljZMsPEw0gn03xnPaY0FT/k2RHCrXV2tFRaIfwuUN4zpF+BO/5rgadpHJ91VLT9
         5jgTJ0aFAj5NL7s1GR0xGeRNNt7LxViP7grD27XeAO9X2lFYNnL4zUfiSF0IR+ML4r+9
         vZHxpyH7DZrRzbUUt8maP30hfrvWcqrq4v9J1Owgf26s2HEaf6YbLGrS/c5KAIA1nHGW
         3EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+hw0ArnSHSYoJdiIvWLIgJ311tVdhqv3dQcD5a8k/9Y=;
        b=CDGSPZdRBJX0oQisWzW44Cn8+taZ3tnj/tANV7wEYBh2LLIuybUd3zJRFzbCZyhjcq
         0Ax00nPMqqvadVoVDQOMn+IqcbZlw7+Q1KBl9eMr79ki1gtJ9SVicBYBXVKdKofp4Zys
         yp1YC0L1wuGnRUXKCiDXn2Jzj4Rfy5VqXNly9vZfsuuwa7HgLv+0MfKjIFDHL4jNwrFn
         rCjvwVk6m38N5O7ccFzQQKSvCYelgGpp2eQWA7EZAdM1bndLlsR340tDM99dQICwrIvf
         kHAmJADK103P5OyZZ8OHH4YxB2FBuVHRYwunnDUGbvUSYxdLUVPeWs5/bi2kVKWBHaS6
         xnDw==
X-Gm-Message-State: APt69E093ZrQZdEhgJRLgie8PpKC1HopmjPjVAqjpUxgMJgbmjPCaA/m
        oRHPd+QFaRmuUbwlJxMGhLI=
X-Google-Smtp-Source: AAOMgpclDhU5gBX3Mop/hAwRO2E4mFtRZP/JhrAY/49G4fU8js9bzOQI1rS2Quhw0yKaUvW8g64KJw==
X-Received: by 2002:adf:da4e:: with SMTP id r14-v6mr18031855wrl.154.1531241247133;
        Tue, 10 Jul 2018 09:47:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q200-v6sm11622949wmg.8.2018.07.10.09.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 09:47:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 2/9] gpg-interface: make parse_gpg_output static and remove from interface header
References: <cover.1531208187.git.henning.schild@siemens.com>
        <cover.1531208187.git.henning.schild@siemens.com>
        <192cf9fc4e7a601d2639ec2d82c777d4c7b26e99.1531208187.git.henning.schild@siemens.com>
Date:   Tue, 10 Jul 2018 09:47:26 -0700
In-Reply-To: <192cf9fc4e7a601d2639ec2d82c777d4c7b26e99.1531208187.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 10 Jul 2018 10:52:24 +0200")
Message-ID: <xmqqwou382ch.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> This commit turns parse_gpg_output into an internal function, the only
> outside user was migrated in an earlier commit.

It is not too big a deal but as we prefer to see our history speak
in consistent voice, we would usually phrase the above as if we are
giving an order to "make it so" to the codebase, e.g.

	Turn parse_gpg_output() into a static function, as the only
	outside user was removed in the previous step.

or something like that.

These two steps, as you said earlier, are nice clean-up patches
whose goodness can be measured independently, regardless of the
gpgsm support which is the primary focus of this series.

Thanks.

>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  gpg-interface.c | 2 +-
>  gpg-interface.h | 2 --
>  2 files changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/gpg-interface.c b/gpg-interface.c
> index 0647bd634..09ddfbc26 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -35,7 +35,7 @@ static struct {
>  	{ 'R', "\n[GNUPG:] REVKEYSIG "},
>  };
>  
> -void parse_gpg_output(struct signature_check *sigc)
> +static void parse_gpg_output(struct signature_check *sigc)
>  {
>  	const char *buf = sigc->gpg_status;
>  	int i;
> diff --git a/gpg-interface.h b/gpg-interface.h
> index a5e6517ae..5ecff4aa0 100644
> --- a/gpg-interface.h
> +++ b/gpg-interface.h
> @@ -33,8 +33,6 @@ void signature_check_clear(struct signature_check *sigc);
>   */
>  size_t parse_signature(const char *buf, size_t size);
>  
> -void parse_gpg_output(struct signature_check *);
> -
>  /*
>   * Create a detached signature for the contents of "buffer" and append
>   * it after "signature"; "buffer" and "signature" can be the same
