Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AFE11F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 22:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730690AbeKMI3V (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 03:29:21 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41651 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbeKMI3V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 03:29:21 -0500
Received: by mail-ed1-f68.google.com with SMTP id c25-v6so8741373edt.8
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 14:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KBLSi44DIAz5py6/+IMUMOyQ/8sgAePbuxUtqfiNMM=;
        b=gagpqQDA3dhlP0w0+bjllYDZRF7Z2MpTAEBXGhHbRhRaAreFsGPdyCjxqzEWnmI167
         36kNjqfle14fD+cw+eSNm7tafXtCkIXCBI6rv2GAZz6qunhK339zQ+i61ieO0Na4Mvih
         TtrJ8hc3pAvPN4KrF4rJ6rLOsMWiBjaWUpUha9h9/lAuzKSJIFr4qCq2GffXR40xTScS
         ofPAHG44J8r5A9XbC0CDIoKy697J+DEQln69Rln9Mic3ycp/3NKyx7Yac2ZPRZIBvjbi
         5qbYpA3mWU4E/7dnpbarIlpHvJP7mSwmUuu2+v91+NbvVL2yMzhkWOu+B054Zg1xQkPP
         r5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KBLSi44DIAz5py6/+IMUMOyQ/8sgAePbuxUtqfiNMM=;
        b=pPsbu1qGp+bIQbSDRNnCN7OMH7av5aAEm82Nv3Kj45Co/+YutiDrfLBSqBQr2UIQkZ
         JZWbbw4Ecs5FMIWxmnkKOtxSpWxnkmfuc4VO1LEYT6DpRoRpFwUNQec/zH2/FnmL9+6J
         NFL70n+/NSsPE7dD4UkuH4cX672Vjf7Ai+O9vSyaCIoB8j5op+x7cmAfiXOHJre2RpEj
         2cV4u3mNojwXY3u1cKiUnufnmmfOSo+7aWfgvL00yBNVv7o4lSwtuS6JuU7H+p6tRkk0
         gg94VPEHaDU/l1EwjEU1wyIWrA4vCCBivV7t3ZxkJ8Nx3lVVCxpmXSox11gU9TMEQJMb
         vDGQ==
X-Gm-Message-State: AGRZ1gKfwtS4YSNw80MRud8uvZnRjkmtKz//HCOTPkTHCZqkvnq7nti0
        BrLYesDrlKU4TA9Jyr3t+idjMyvOfYvmZgN3+NuMow==
X-Google-Smtp-Source: AJdET5ejhDrveRPO5X8MK4TBv2UtaRm6aTlpGFa/m84a7GriYJoV+e3SjeWLM4UBjRVb54wIAFSTeEOSiaL6uwRzhsw=
X-Received: by 2002:a17:906:45d8:: with SMTP id z24-v6mr10493142ejq.19.1542062048696;
 Mon, 12 Nov 2018 14:34:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1539305180.git.steadmon@google.com> <cover.1542059029.git.steadmon@google.com>
 <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
In-Reply-To: <b9968e3fb005a00e9f78627467b4fc86a6259977.1542059029.git.steadmon@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 12 Nov 2018 14:33:57 -0800
Message-ID: <CAGZ79kaPjw3UbYY=XL0gyKp2VxghwaUOJJoDhiO5sQpT8OWerQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] protocol: advertise multiple supported versions
To:     Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 1:49 PM <steadmon@google.com> wrote:
>
> Currently the client advertises that it supports the wire protocol
> version set in the protocol.version config. However, not all services
> support the same set of protocol versions. When connecting to
> git-receive-pack, the client automatically downgrades to v0 if
> config.protocol is set to v2, but this check is not performed for other
> services.
>
> This patch creates a protocol version registry. Individual operations
> register all the protocol versions they support prior to communicating
> with a server. Versions should be listed in preference order; the
> version specified in protocol.version will automatically be moved to the
> front of the registry.
>
> The protocol version registry is passed to remote helpers via the
> GIT_PROTOCOL environment variable.
>
> Clients now advertise the full list of registered versions. Servers
> select the first recognized version from this advertisement.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>

Thanks for resending this patch!

+cc Jonathan Tan, who works a lot on the protocol side of things.

> +void register_allowed_protocol_version(enum protocol_version version)
> +{
> +       if (have_advertised_versions_already)
> +               BUG(_("attempting to register an allowed protocol version after advertisement"));

If this is a real BUG (due to wrong program flow) instead of bad user input,
we would not want to burden the translators with this message.

If it is a message that the user is intended to see upon bad input
we'd rather go with die(_("translatable text here"));


> diff --git a/protocol.h b/protocol.h
> index 2ad35e433c..b67b2259de 100644
> --- a/protocol.h
> +++ b/protocol.h
> @@ -16,6 +16,23 @@ enum protocol_version {
>   */
>  extern enum protocol_version get_protocol_version_config(void);
>
> +/*
> + * Register an allowable protocol version for a given operation. Registration
> + * must occur before attempting to advertise a version to a server process.
> + */
> +extern void register_allowed_protocol_version(enum protocol_version version);

We keep extern here as to imitate the file-local style, although
Documentation/CodingGuidelines would prefer to not have the extern keywords.
Okay.

Bonus points for converting the file to omit all extern keywords in a
resend. :-)
(I think there is no other series currently in flight touching this header file,
so it is safe to convert it "while at it", `git log --grep "while at
it"` is shorter
than expected.)

All that said, it's only nits that I contributed to this code review;
the code/design
looks good to me, and if I were maintainer I'd include it as-is, as it
fixes a long(ish)
standing protocol error.

Thanks,
Stefan
