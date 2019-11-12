Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02171F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 11:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfKLLc3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 06:32:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37281 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbfKLLc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 06:32:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id b17so2572053wmj.2
        for <git@vger.kernel.org>; Tue, 12 Nov 2019 03:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZbxiwWHos4W3ilHXCVMfj+RaghSH42OkBLidHqXb4Lo=;
        b=gbT+FuOw4ZuYRRzqMwb5WmaDllX7rP8E6Rz9U6AWWEskXFwy1wJYo0Lsk8IGcG/vYJ
         HfIfNAhrtaBUtMFU6fYM5AnW/wvvudDDNb1qC37nnKwi9YMHlsz/O9UxyoFsCfaYKSZw
         wGvhdNPmds6+IdhN5iGpbMygikA1F64yXACnXO7LwJVoZXpyvsspc6rKFlsGsomtQxmM
         UX7jOfv34YAIIjEVcLxp3fYK4igrEgUS1Q+/lRhEdsicErQe2JUtazqM6nxK16vVdiN3
         hF4EXLlVWzwz6I7SO9rfMQvBftoQRdHSIPEn5jH+IJAf5DoXcaXLl1y+sutsK1Md36Pc
         iMYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZbxiwWHos4W3ilHXCVMfj+RaghSH42OkBLidHqXb4Lo=;
        b=Kcm+H6rA1CTgz4uiXE6oXxV0M/kxVp2Sfd7PYAbdSN6080+4nMsRcItNEczhZbeOlt
         wS860ar4UTVdwxFpsh940w8wntcwDcAF8XdceLMwggrpUkO7CZRg338+bTiEKQ+w+eBm
         HDjtVIhk4ogkFRZUEgSPJtN16NVthwOaJDg98HZVp/MMlPyHAMH+knv8Te/fei5TKjGM
         +slj27jLp27CVp7a94AZzfkH01AqA4OnUeqJEk5LL/pV7E4fOW1tfCKRiQ4KYAKSOLpN
         W2yxvTfjxXMl0QRfHylHlzfQzlcqF3XQtI5YKDZumnNeDlbWofYhVIF4hBntzfXjgCL0
         3yMw==
X-Gm-Message-State: APjAAAWYbhD1czEjsoSG+LgGRYWDIa8w0yKGbPXeRUHXwaFgcEuGZ9/h
        xeCnPKdViWP1bxxvzGQ8Iws=
X-Google-Smtp-Source: APXvYqzr+NlCg1p3xsICFRcTHJ7F4vjWRnmmufOp3sp3qHZs3FKUrfLuDGK9P5/76ukqqOWJiyh05w==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr3539780wmo.7.1573558346639;
        Tue, 12 Nov 2019 03:32:26 -0800 (PST)
Received: from szeder.dev (x4d0c65ae.dyn.telefonica.de. [77.12.101.174])
        by smtp.gmail.com with ESMTPSA id i71sm40350872wri.68.2019.11.12.03.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 03:32:25 -0800 (PST)
Date:   Tue, 12 Nov 2019 12:32:23 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Kevin Willford via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Kevin Willford <Kevin.Willford@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH 1/1] fsmonitor: fix watchman integration
Message-ID: <20191112113223.GO4348@szeder.dev>
References: <pull.444.git.1572889841.gitgitgadget@gmail.com>
 <52eaf20f405b53743e27935dfe89f62e6f824a33.1572889841.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <52eaf20f405b53743e27935dfe89f62e6f824a33.1572889841.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 04, 2019 at 05:50:41PM +0000, Kevin Willford via GitGitGadget wrote:
> When running Git commands quickly -- such as in a shell script or the
> test suite -- the Git commands frequently complete and start again
> during the same second. The example fsmonitor hooks to integrate with
> Watchman truncate the nanosecond times to seconds. In principle, this is
> fine, as Watchman claims to use inclusive comparisons [1]. The result
> should only be an over-representation of the changed paths since the
> last Git command.

> [1] https://github.com/facebook/watchman/blob/master/query/since.cpp#L35-L39

Nit: please refer to the specific blob in this link.  The file's
content in 'master' might change in time, and then the highlight will
point to different lines.  Worse, the file might be renamed, and then
we'll get a broken link.

