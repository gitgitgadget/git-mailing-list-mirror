Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689C81F516
	for <e@80x24.org>; Wed, 27 Jun 2018 17:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964890AbeF0R6W (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 13:58:22 -0400
Received: from mail-io0-f201.google.com ([209.85.223.201]:53707 "EHLO
        mail-io0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934333AbeF0R6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 13:58:21 -0400
Received: by mail-io0-f201.google.com with SMTP id c9-v6so2188737ioi.20
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 10:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=X2JpPI5kGP26xRXZeMWDpmQaIBkpSAnb8U+v9v0n2f0=;
        b=LnwC0HpQvr+KjfnBBLzafb5gjuHyRLrTSyjtTuwSU3dI9rit2izNRaCnwrY7uiHzR8
         H4Nn7cfnFzghLTS3p7kDN6b3dE/VWMiW2YP8ri+0PomzoFjIKP/yF6PefzBPdvDc9K7g
         v6KLPq48JaLuTRwI9574uQFI0miqpcCGLWnl9Xjkv8g2ohip+Vs+FcUgzKfknsG5zBcQ
         QFmaB/dhVEgQbyDblnpCb9fduKVbzWctla6ylxMTNxY51zLj3ADFMQYdYKpOV2hWr0J7
         w3hCkcbgSSFZb5HaJoOjDig7wOSCmQP54VWZuYtsO1pHeWDPM5uUgkgbEoRLbYxb8+9V
         jXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=X2JpPI5kGP26xRXZeMWDpmQaIBkpSAnb8U+v9v0n2f0=;
        b=S5YRtMgGJUWXeEbmspyVPG8Bi6biU6wK1ZsFSK8/6Fb/Jv1D4gnNCsGFT3cjXhGVKl
         JMZY1f2ddLnEllLsUELRdbOy/Bw7FGBygRVhPplnJ+BqP7wYBVh1IrJx2q6hwYr4tqdP
         qKvvfvsLyzMO+dAbJjmYQYdnHt62YTuPRTPh9B3lQ1CdDGGwJAj3QOEs4pJC0+539G/Z
         IFbcrdTWOF+9k6d9EjhkJzZn4bfsCu6TKA7OupXsJdPzSm4n4Ke2zTtLjEHGE8Mt+90z
         K6ndSrJQ8Ynbkcg8ID7RuunicV7VCPUhfxGhoqXpR1xS6rU7294wgWdxIwQj/CSNqxum
         qlKQ==
X-Gm-Message-State: APt69E12r1OXUKpf+UX6W05PHS0R65Y1EH7PtVxYp80eaSX7TlwsutdN
        UMGMkmreNvMift3DViKtm7/WxTNEYcHFpRYOHVlg
X-Google-Smtp-Source: ADUXVKLaUCPOSxfiZ9He0WqCPD1KZsGCzJxfM6MOhQNDXFKZhGzk2kRWLii3tOla/C0pdgBmR1nPKYgtPAVboOwBVvxj
MIME-Version: 1.0
X-Received: by 2002:a24:6b8f:: with SMTP id v137-v6mr2709372itc.2.1530122301013;
 Wed, 27 Jun 2018 10:58:21 -0700 (PDT)
Date:   Wed, 27 Jun 2018 10:58:16 -0700
In-Reply-To: <20180626205438.110764-4-bmwill@google.com>
Message-Id: <20180627175816.32436-1-jonathantanmy@google.com>
References: <20180626205438.110764-4-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: Re: [PATCH v5 3/8] upload-pack: test negotiation with changing repository
From:   Jonathan Tan <jonathantanmy@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, gitster@pobox.com,
        sbeller@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> +# If "one-time-sed" exists in $HTTPD_ROOT_PATH, run sed on the HTTP response,
> +# using the contents of "one-time-sed" as the sed command to be run. If the
> +# response was modified as a result, delete "one-time-sed" so that subsequent
> +# HTTP responses are no longer modified.
> +# 

Whitespace error on this line (the line immediately after "are no longer
modified.").
