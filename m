Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9927B1FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 10:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932215AbcLGKsU (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 05:48:20 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33205 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932111AbcLGKsS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 05:48:18 -0500
Received: by mail-io0-f196.google.com with SMTP id j92so12869727ioi.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 02:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sOZqMMNYmNmcdVnppof6/vnX3n8DH5M+UqZw1kbqtJw=;
        b=c0zH3f4ltRxxGXU+6jApzV+ekAESwnoafqofdvYwunClzi6dSgavLJMSYJyKQYCJh9
         OBuIsUrz0IsH6N7B/YlxAA79/LQc/niq3lN5BFr7P4B8AvH6wDTF/WX936/oMr0hTrNi
         76sb2XsgeVcgDu+z5gtOGWI1RRFdnP2xe5XtQJTV91i04jGoTu/RflUrvtlU7ORWA6pS
         IpdEADTjAnsKJxK+NSXLLDCeVHdP7fMlr2HLpFAHRM5P0dbihGWRZAfkthfPCRHKJ3x4
         rf6RgidIPcsVr94pj9lQneGq/AlNpBZ8B4V7ocNtMZw1lEGvzmwX/CeJjWno+jTy8Vfw
         aSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sOZqMMNYmNmcdVnppof6/vnX3n8DH5M+UqZw1kbqtJw=;
        b=NnvAGylAyxCtctPi9RIQLmcUouWID/Gv7ZoPctokZTE9acBPtFARETypDnfOecNrEW
         JOwVGshW5mKuiuhgzn6x70EqobgoDjfiv5wiJ9Kbhc/MWfLUTQn8Q39+TaSLkA9rxGtp
         7ZgLZpNkdAGcvL2mrzKYGxWPMzcb79uLx0uaQ4Y4bCCD2/ezIF30gIAnV9GTFUJj3BF5
         sie0t7A7fTjkO+sbuN9qhjls4vMQBsVxStDtZ1o9EGP1ZSBTFIl8Uq/6MZX7m1Y+zJOe
         LNd7Zwqap2hGjF55/4J/whPMdFq9Hec2c1F/IBOnBc3jjlg9fg9k4t27uLg7hrTxlvIh
         EP5w==
X-Gm-Message-State: AKaTC03OCXk1Hzi+mgH1uJmzN4PETBwlfXmv4jnp9SzCLzNLBK7wAny0L81nSgtOJcri0EMPUg6eKx05AEPNNg==
X-Received: by 10.36.159.3 with SMTP id c3mr1548987ite.50.1481107697464; Wed,
 07 Dec 2016 02:48:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 02:47:46 -0800 (PST)
In-Reply-To: <1481061106-117775-10-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-10-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 17:47:46 +0700
Message-ID: <CACsJy8Du5XUzcKpWfSKy8iknF01C-RWCgPeh73W3E0VkPJ9sog@mail.gmail.com>
Subject: Re: [PATCH 09/17] pathspec: always show mnemonic and name in unsupported_magic
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> @@ -426,8 +423,7 @@ void parse_pathspec(struct pathspec *pathspec,
>                         nr_exclude++;
>                 if (item[i].magic & magic_mask)
>                         unsupported_magic(entry,
> -                                         item[i].magic & magic_mask,
> -                                         short_magic);
> +                                         item[i].magic & magic_mask);

Same here. Maybe put both arguments in the same line. It looks a bit
better. (sorry for two mails on the same patch, I'm reading the final
output first before going through individual patches that breaks this
function down)

>
>                 if ((flags & PATHSPEC_SYMLINK_LEADING_PATH) &&
>                     has_symlink_leading_path(item[i].match, item[i].len)) {
-- 
Duy
