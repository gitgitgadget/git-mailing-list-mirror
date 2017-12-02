Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3318B20A40
	for <e@80x24.org>; Sat,  2 Dec 2017 20:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbdLBUd4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 15:33:56 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:33211 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752106AbdLBUdz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 15:33:55 -0500
Received: by mail-it0-f51.google.com with SMTP id o130so7275287itg.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2017 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uGG3XCIvGQMxjMMv0RDJs6C1+GOeZafEyha4Qk/gt4w=;
        b=PpTpYkZk2pJIvE8KYcbVHltC75SYy+OTZtie7t5ut2aZY61xyyALfVc90hiZ1k7s0H
         aNHiFdXej43TbcVWQjs/3rO8uRSidadD1XwsUS0nwKjeGb5bSlXMOCL1Ep+gHfjbaSnL
         Pl1LUSb1xNRhbJRTcR1W59OpuOcNIVAcZZPfu3XGG+KitaIMQd4vuyohxOvi84ZaNsW0
         91hcOFz4NN6l0YJeG/2Unsp45+JIPdOjLAeR2ncjbYanVBbu8AU2gs/v2sU2sEhoo9Qn
         RLn5It7efLLY1+h4VWpJOgsd5YC3MrQO2uoVbtYtHMLstrqtMk2QagdKHM5HrbVpcOdl
         kMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uGG3XCIvGQMxjMMv0RDJs6C1+GOeZafEyha4Qk/gt4w=;
        b=JsB8YaHbhAX5rsnG458ibGrnEKy5BDRPELL3lXF1QHcjSlzAIm20T9+QLYvdbSrLl/
         iMcfUNZ7h1PVIMhuZTxsuPadf4QAz8cUmp5g/frpdjaajnCxXQH4T+t3PHIlEEgOoKbZ
         4usdFrY+pL6nJY0qSYyeA75psZZ/53FrUhodWG2yxmH7vrtcSS7sH/J6ZW77rKWQetW9
         KRbtxm+/8jOeRItuEeTVMbJBpNSKxLeLrtbpCRBdomhPtojmBEjF6ztdjYxzRBVRAd4e
         TDUQ6osAHFlPFyfmRVIwcV42tgcecy5B2b7NVK27wtC6QqPORto4k0kJSg2NMZy3GxWM
         M3RQ==
X-Gm-Message-State: AJaThX7dSQAfbeG2s8CtF1uYtctNrlySbXAYZK16XAZUUmhOaQzqE11X
        AXUvD9DeFApuL3S89L68z8yr6uYIuGA/iePiMmg=
X-Google-Smtp-Source: AGs4zMbqHRwCEDNnC72Fso6g8QLg/SXI6ks1v2FLTvmh80qsmiwq2LzJ9auuBVFCeEbOF5NzhqLqax/fD/0rlZyGSls=
X-Received: by 10.36.0.209 with SMTP id 200mr7334995ita.55.1512246834544; Sat,
 02 Dec 2017 12:33:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.28.137 with HTTP; Sat, 2 Dec 2017 12:33:54 -0800 (PST)
In-Reply-To: <20171121210720.21376-8-git@jeffhostetler.com>
References: <20171121210720.21376-1-git@jeffhostetler.com> <20171121210720.21376-8-git@jeffhostetler.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 2 Dec 2017 21:33:54 +0100
Message-ID: <CAP8UFD1dm4EJXU3VdgGMDawy3jCT20hHQXwZxvtwy7_eomz9Fw@mail.gmail.com>
Subject: Re: [PATCH v5 07/10] introduce fetch-object: fetch one promisor object
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 21, 2017 at 10:07 PM, Jeff Hostetler <git@jeffhostetler.com> wrote:
> From: Jonathan Tan <jonathantanmy@google.com>

> +void fetch_object(const char *remote_name, const unsigned char *sha1)
> +{
> +       struct remote *remote;
> +       struct transport *transport;
> +       struct ref *ref;
> +
> +       remote = remote_get(remote_name);
> +       if (!remote->url[0])
> +               die(_("Remote with no URL"));
> +       transport = transport_get(remote, remote->url[0]);
> +
> +       ref = alloc_ref(sha1_to_hex(sha1));
> +       hashcpy(ref->old_oid.hash, sha1);
> +       transport_set_option(transport, TRANS_OPT_FROM_PROMISOR, "1");
> +       transport_set_option(transport, TRANS_OPT_NO_HAVES, "1");
> +       transport_fetch_refs(transport, ref);
> +}

I think it would be interesting to return what transport_fetch_refs()
returns, so that a caller could know if an error happened.
