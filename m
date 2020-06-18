Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBB0C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C90207DD
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 20:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgFRUZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:25:48 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:37428 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbgFRUZr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 16:25:47 -0400
Received: by mail-il1-f195.google.com with SMTP id e11so7211729ilr.4
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 13:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:reply-to:to:message-id:date
         :user-agent:mime-version:content-transfer-encoding:content-language;
        bh=pJllJaDkq5AwGE5+yJl1csvDmdzI5dk2a8IH6m2wJK8=;
        b=aBUYJ0mGv4HFJcSydngFVwzCOgRkIYvKxPzFWnhY1L90i0/wKF4TXjODIpoFOjDn+6
         5W4NkuXZ5AHctkAP6hgRhLJSMz/0Wdssexdjf6f31irJcY9fdhZ8BIBFkthhHIsvjkW4
         ZnPUZzzm2OmfWFaMClwxHOYMgUpU6uXIWx5bGXD5WaAO40eCKH6QcmEu2Jt8lZ8Cio72
         MwhV8oCpGiZrE0D3yapxyDrPUdNEbC/gE+a/k2OP3FSAJ6D5H4iBVYcNDexm3xH/EJXB
         T1cGvtLswdglIGoywfMzcBOcsLBhKzcpZV2tvjTe6eKaTvGVQZ1OHf3p7fYCPAiKHUEE
         taMw==
X-Gm-Message-State: AOAM532OxmdzP7QhdaluKYwWlgwpq2d8Ffs2VvoXr5sF0+XlM7E9TAvu
        PHw+BLebMPUSOUywGU5gMrS0ojMOnEY=
X-Google-Smtp-Source: ABdhPJxbic17l8uOULuJ6dJZeIYSxSvkqzCk3qCXXTULov9lxeXv+VqEXzklj8aLHwhGacpy4Fm6Ow==
X-Received: by 2002:a63:550d:: with SMTP id j13mr258959pgb.139.1592511946474;
        Thu, 18 Jun 2020 13:25:46 -0700 (PDT)
Received: from ?IPv6:2601:647:4902:640:5dd6:323c:6306:86b1? ([2601:647:4902:640:5dd6:323c:6306:86b1])
        by smtp.gmail.com with ESMTPSA id y10sm3246679pgi.54.2020.06.18.13.25.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 13:25:45 -0700 (PDT)
From:   "Paul S. Strauss" <pss@acm.org>
Subject: git config not following include paths by default
Reply-To: pss@acm.org
To:     git@vger.kernel.org
Message-ID: <6aab7843-7ece-5499-c074-a5fa8ef68beb@acm.org>
Date:   Thu, 18 Jun 2020 13:25:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using git version 2.25.1 in a bash shell on Ubuntu 20.04 (focal).

My global git config file has an [include] with path set to additional 
configuration.

"git config --list --show-origin --includes" shows all of my configuration, 
including items from the included file.

"git config --list --show-origin" shows only the items in my main config file. 
Not sure why "--no-includes" is the default, but not a huge deal either way.

What is a big deal is that none of the configuration in my included config file 
is available to me. I have lots of aliases and other settings in the included 
file, but none of them work.

This can't be the expected behavior, can it? If so, then including config files 
is pretty useless.

-- 
Paul S. Strausspss@acm.org

