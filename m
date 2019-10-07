Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 025971F4BD
	for <e@80x24.org>; Mon,  7 Oct 2019 23:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbfJGXzh (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 19:55:37 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:44077 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbfJGXzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 19:55:36 -0400
Received: by mail-yw1-f74.google.com with SMTP id n3so13998506ywh.11
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 16:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LETxP+kVL7TDFO1i64ajpD0bl+W1buuQ/QWsXb+vEww=;
        b=KrgIGTyAOZCp67YolnvM6JvdHjWooWcxKqNJLbUIGDtnjviwEXGskR43tAs63A1Kyn
         3FZ/6wYxgJ1ICZoP0w0SkiUgW4NsV/I8r9xWBfJXspL83aAcwzwap2wFWNmTlvdrwAG3
         kzqvr8eZSHCwiT8bTJzj9+0zZcAmwbtjW+213YFILGr80cGcdpS/DqrYSinXpPU2CDCs
         kFLLbuAvFIJltf82jIjyw+wMl3KSw+TwQ9iYbR7TR3vrxWBOrF7IecniGBRrI8O9CIBQ
         MTmCuUaYDL07lOCRoJYPe6fjQ+Zb0WQdfZF2ssQK/52E/M6/cS1Ptv+GoOWZk8yyFs8L
         0igg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LETxP+kVL7TDFO1i64ajpD0bl+W1buuQ/QWsXb+vEww=;
        b=mLU72T3yuxtM5ZInCn5uSOhgzVhiyzVWVjFkLJtJO88CC1DAYaICzUjDFOpL57kB35
         dceYZYUKgCyMx816cbMkc3RN2C3y41UeBEHydscRIhlA4mtKuCIsa+zJLtsv1e1193uy
         Ew+Qh3+4TDvOpS3njn0XrrMAAavIpcMHnTGxL+hZeRGm2QW4RuPoAOA48XZJXGxBBYJ0
         wzWDOl+BpHV6Bde2kUDjafgXDpLNBeZiwlmnEQntYXJ8zBrISQgtmAu5pOvnVxqLDZIV
         shzq5eTPFxZkA8wEWZtjZrMK3TIEQrxaQgsDZR/3l9vFBP9eNX4/gNA0ny+LuRWPkri1
         Lwwg==
X-Gm-Message-State: APjAAAWam0oX437f2AgEez0XRYjWAQZ+zrQyTCBtShOm2gxawefSFI1S
        DiodBt5U2YyvQ1DAaa39IE68LaalOrhPKAvnJPMh
X-Google-Smtp-Source: APXvYqxG0xgAGMnG2gdyhaLWern2h1865Svey9xsFjlJVvVxY+0vqZWULXyFA9WRuyGsNKdsFiVUBEzFD3qSuzyQW628
X-Received: by 2002:a0d:c001:: with SMTP id b1mr23613581ywd.6.1570492535881;
 Mon, 07 Oct 2019 16:55:35 -0700 (PDT)
Date:   Mon,  7 Oct 2019 16:55:32 -0700
In-Reply-To: <cover.1570487473.git.steadmon@google.com>
Message-Id: <20191007235532.9320-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570487473.git.steadmon@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: Re: [PATCH v2 0/2] add trace2 regions to fetch & push
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Changes since V1:
> * Use the repository struct argument in transport_push(), rather than
>   the global the_repository.

Thanks, the patches now look good to me. I verified that the repository
argument to the trace functions just cause a different repo ID to be
printed, which is what we want (e.g. fn_region_enter_printf_va_fl() in
tr2_tgt_event.c, which appears in the vtable defined at the bottom of
the file).
