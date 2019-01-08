Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31C51F803
	for <e@80x24.org>; Tue,  8 Jan 2019 20:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfAHUib (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 15:38:31 -0500
Received: from mail-ot1-f73.google.com ([209.85.210.73]:53932 "EHLO
        mail-ot1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728945AbfAHUib (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 15:38:31 -0500
Received: by mail-ot1-f73.google.com with SMTP id o13so1915336otl.20
        for <git@vger.kernel.org>; Tue, 08 Jan 2019 12:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=4oNI48aVEp75wafcugtLpJ4LDRbTisfr6oykekCgDi4=;
        b=WXUVlPcfkOEnmgpVIESYeuda/wTXoBo9ZUP0HPYPspBMB1uBGxZTaCvA8kkTBy3weu
         +tS2Y3g5802PnSt1O0rtT9Zt6HN6DLTEpLQ8El6yXTth5Y/ufoHeLIBXLMySr3x2n/zF
         bWa96n+9GS2KRTfytlD/4Vu0dk7i1nROoeLhgggykUV1VjDjAIm86/8jghXH2MLM9Nfo
         xSdDdKU+kzCRuwjIAk6LgGeJpligSM5OQObRmsWBjQy49lFMlqqfeu+znDkfxXKCmMOh
         +wStMDskldo6Ijty/bXZZwBN4JjRr7ooJzcIcv/F+3lN7imbfOUIOfoxZkkgoy9vL6a1
         6YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=4oNI48aVEp75wafcugtLpJ4LDRbTisfr6oykekCgDi4=;
        b=rJH0DuMXudA+MToVmnsOIHvRGM3+ad9PQDbqFvz80GljGtlmtUP4A0cOgULs7OY9iZ
         zY13nrkFuQJxJJ0wRDRGC2I5FkKF+UwoPRn90jY4G4QJGsA0zgcbwfyTsHHZyOsioW9v
         hRZkePM6pvhlNwjP0TMEwRSi30iRkkzYdsdu03r5l1HA5Kk4u8lmO/Lt4myML5YqFXEL
         ceN4EeTPl9JXtTTXQibt8ifMX/c9QdM3OqiEE4OSQtnbQyzZTh6TV/FywFNZ2bs+wouB
         zR+uCx3BAZrmNjW5k7V+tr+GozDTxb8VgfrKu/HSiLjnHIk1H5juOZMHdh6hAgJCTXCV
         /dzA==
X-Gm-Message-State: AJcUukc4Y0v01bFBbJxae0rxWDBNmYv7VyPjsiXoHo6SssADV/G2VNjI
        2xZUucCGB9LX1JqjZ5UTJZtaroUwcsIJhPUWfiUa
X-Google-Smtp-Source: ALg8bN7Aeu3cfyNl7uVf7kmanGlKudugAMeRFhB4djeBDhiqwKt8Rbj+wzln533nY9CZYarJZnU6VcGdPAAmFp2GpoQf
X-Received: by 2002:aca:4b52:: with SMTP id y79mr2349279oia.37.1546979910386;
 Tue, 08 Jan 2019 12:38:30 -0800 (PST)
Date:   Tue,  8 Jan 2019 12:38:26 -0800
In-Reply-To: <xmqqva2z3pdp.fsf@gitster-ct.c.googlers.com>
Message-Id: <20190108203826.564-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqva2z3pdp.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 4/4] fetch-pack: support protocol version 2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, git@vger.kernel.org, peff@peff.net,
        bwilliamseng@gmail.com, jonathantanmy@google.com,
        steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>=20
> > From: Jonathan Tan <jonathantanmy@google.com>
>=20
>=20
> I was looking at the topics in 'pu' and noticed that I had v2 of
> this series, wanted to update to v3, but major part of it was
> superseded by another topic (jk/proto-v2-hidden-refs-fix).  That
> leaves only this patch in the v3 of this series.
>=20
> Is this one still relevant?

This patch is more relevant to the GIT_TEST_PROTOCOL_VERSION patches,
since it means that several tests work even if
GIT_TEST_PROTOCOL_VERSION=3D2 is set. I think it can be dropped until
someone restarts the GIT_TEST_PROTOCOL_VERSION effort, but I'm not sure
if =C3=86var has another opinion.
