Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B34281F597
	for <e@80x24.org>; Wed,  1 Aug 2018 08:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbeHAKIo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 06:08:44 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33301 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387750AbeHAKIo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 06:08:44 -0400
Received: by mail-yw0-f193.google.com with SMTP id c135-v6so6872627ywa.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 01:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m55nfiKiZGRtufF2DBqqblM5QHT1GsbGZzJoCzN+JpI=;
        b=sXctFU2K0mfyE+jKYL9dd9/qh+ivCevAJMrZsFJm9a6Xp+bUldqgyFVwteCVu98chO
         ik4Do78LdmrBkLrB7Bi+GwYdrxZMKFrSvr9z/JOSLDX9rVs3Wt6vtI/eJingKBqbsKKD
         3geqrzrWyjR16romZeJnFrGKS8SNrRHayQd/yvavcD7qdcelvHe7XpftQ4BZxzK6SFLl
         ZrVhLElDq6OqeP+fKzLaOntWr7vD8wLoewxR5e2A7AaA2gTz3EW3L9kwbeZjA//pEtjY
         c1PTFvOpscJQm2RjDiaAZP6hcbaPZivdO/ICRKlaKIUrktvSfGtslA3CIJSdxggSin0P
         Rg0w==
X-Gm-Message-State: AOUpUlEwumMRLRs4vs+DnbVm3YUxqIcTClJtm8h3bWX5Vn9d0Pfew7t2
        +7WfSrKcv+0canrJZ5rARNtO9HnzrvSzUgJNISo=
X-Google-Smtp-Source: AAOMgpd1vGbijP8anPRYeE9z84xpWWkMRpJSNKbpBOXmvUvcst/XChBocbrqcOOYZZzJR6m9Eu3uhFrY+49ip4leFT8=
X-Received: by 2002:a0d:f3c7:: with SMTP id c190-v6mr12550038ywf.98.1533111851702;
 Wed, 01 Aug 2018 01:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180731173651.184716-1-hanwen@google.com> <20180731173651.184716-2-hanwen@google.com>
In-Reply-To: <20180731173651.184716-2-hanwen@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Aug 2018 04:24:01 -0400
Message-ID: <CAPig+cRv5sHSoAPVi=Dnu2HXcbGThdMsgOfvs-Kh2NbnGg-j8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] Document git config getter return value.
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 31, 2018 at 1:37 PM Han-Wen Nienhuys <hanwen@google.com> wrote:
> diff --git a/config.h b/config.h
> @@ -178,10 +178,16 @@ struct config_set {
> +/*
> + * The int return values in the functions is 1 if not found, 0 if found, leaving
> + * the found value in teh 'dest' pointer.
> + */

"teh"?

Instead of talking about "the int return values", simpler would be to
say "returns 1 if ...; else 0". Not worth a re-roll, though.

> +extern int git_configset_add_file(struct config_set *cs, const char *filename);
> +extern int git_configset_get_value(struct config_set *cs, const char *key, const char **dest);
