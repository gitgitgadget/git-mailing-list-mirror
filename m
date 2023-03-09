Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00BDC64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 22:36:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjCIWgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 17:36:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbjCIWgL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 17:36:11 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206B1106A1D
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 14:35:59 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c4so2543181pfl.0
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 14:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678401358;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3C1QyEkZE13KU5p0hxSeYiKxXJX+StXmcky1u4cmv0=;
        b=R59naW0COQggmOMpPQNWnui+ORJSLrXg16oeArzK4pOpa0/TIg/Fy4Kh4BXz0GjJkP
         xB0kcNtxSqym8DeC8e0tR+9IUIcKQVmMZULif7wqqssU1lpwCHLXPu7iBcD5BXCmsr8x
         8rOtenNRXSeNTTkk3gUXqVbKEVuAeziLVCRZtb5gBN1dWNpb7x/02Z8pF8Uu+I13J8Nt
         Jv6T/qltBNvUORGDBdu/rE18oPRS+8NIOFdpclQzpZRiHy/kKAYl8q4/Dh1xQLKK3WwJ
         UKzOntWLYv2PRIFCoBeU2IPyO/+XC9AIPi66dfkQTI5xtVPfx6IGaCE/vwY+mZhsI9vX
         +jYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678401358;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z3C1QyEkZE13KU5p0hxSeYiKxXJX+StXmcky1u4cmv0=;
        b=EO/lBo8BPuGA7v/2txZ89Mb53D1RUWECYnTQMY2BGEzaTu6HkjpJyZXe+MmKvJ7BcL
         LrDQXZoBXbJRLT7z9emjKrSJLslZ5ep6QcEbpzaQZbxeZ4DlnrBNXF5bpHuaDLlp+I1L
         yb6E74OQEV2Ca53krgv1IMyOx7nbS55EkNGhxwAxea/yFuUTH4uZIPqxtvj5mCBEVUFh
         /LlB444+sOinTV+zzVmN2nmL7kcf3eJ3MCEeL0DexnABqn2EU1SknAPXJ3ATFVWOQKP4
         V8pozFk5Xn97n0Alb2Wpw8pEWP2xTH/On+M+M6fLG3UBSELgIlSiZYEwmJPidy13BTDV
         azPg==
X-Gm-Message-State: AO0yUKVJbKJxMHlaI3BFQG0B21cpvRkwnLQFrtG68SbBrc+Gvq7Dr3kW
        77iy7EE6RZgD1xqgdmi+CqMC+ohFKxA=
X-Google-Smtp-Source: AK7set8JROhzFwxHbDIy0x9rnHu6wIUbUYRcX5ABwxoMVivZe+SphhxRb/Hn/YJoX1qr/qcWTHhhig==
X-Received: by 2002:a62:1751:0:b0:5db:c07e:9e4d with SMTP id 78-20020a621751000000b005dbc07e9e4dmr18854952pfx.6.1678401358497;
        Thu, 09 Mar 2023 14:35:58 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id m21-20020aa78a15000000b00571cdbd0771sm86133pfa.102.2023.03.09.14.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 14:35:58 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Emir SARI <emir_sari@icloud.com>, git@vger.kernel.org
Subject: Re: Feature Request - Better i18n support
References: <ZAnXddDN7v0AOBdm@mbp.local>
        <ZApdaAMrkmFcxarq@tapette.crustytoothpaste.net>
Date:   Thu, 09 Mar 2023 14:35:57 -0800
In-Reply-To: <ZApdaAMrkmFcxarq@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 9 Mar 2023 22:27:52 +0000")
Message-ID: <xmqq7cvp8sdu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> More specifically, I think it could be fixed for progress output, but
> there are a few places in diff output where it couldn't because it might
> be parsed.  Would you be willing to try a patch for this?  I think the
> code you're probably thinking about is in progress.c (search for "%%"),
> but there might be other places you have in mind as well.

Ah, my earlier grep missed this, as it tried only to catch [fdi]%%
and the progress thing uses "%u%%" like so:

		if (percent != progress->last_percent || progress_update) {
			progress->last_percent = percent;

			strbuf_reset(counters_sb);
			strbuf_addf(counters_sb,
				    "%3u%% (%"PRIuMAX"/%"PRIuMAX")%s", percent,
				    (uintmax_t)n, (uintmax_t)progress->total,
				    tp);
			show_update = 1;
		}

With the PRIuMAX thing, it won't be as simple as enclosing the
entire format string inside _(), though.

Thanks.
