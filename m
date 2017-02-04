Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21E001F9AF
	for <e@80x24.org>; Sat,  4 Feb 2017 12:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750898AbdBDMhV (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Feb 2017 07:37:21 -0500
Received: from mail-oi0-f49.google.com ([209.85.218.49]:34943 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750808AbdBDMhU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2017 07:37:20 -0500
Received: by mail-oi0-f49.google.com with SMTP id j15so25582878oih.2
        for <git@vger.kernel.org>; Sat, 04 Feb 2017 04:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pXU+++Tjlyvbpwbc3TIbGiNHsGm833RBqyCuWGXfjIU=;
        b=m5W21Yhht4SmSRF1moWD73LkJ8zljkHS0K4eWDkpFQ/B0m+NA7lc/BUL7b/XI+ryl7
         57R3DeGpZqTO6bRN5FCK0YoQCMTLyb0/IMUbzuXRxLQglJr491sGzPupI4ZsVsSwy1NM
         UFrL8kuJ1efnOjLdg0pDhO07ufdRIAf+Io2sepKjcQZ1sTUdKV9sROjPPaZVX9UWeFVu
         XrgiyPwUzoKafxjFKoiZREqS/VOfGFEcTr6LqzA2u3PlJdwAZT06+CMjQDz0w/z9zCin
         fIP0kghwMMQdthwomHregNt8oWQo1RrNgiJr92iwTGG4FmJaE5OgJL4byqoJHCTQ/TSk
         i7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pXU+++Tjlyvbpwbc3TIbGiNHsGm833RBqyCuWGXfjIU=;
        b=GUz5BF5F3DEelWlSXv/32xWia2tkknUM1ErAaTtF4oB1e/OWCWv7DliU1ybWKcFg7v
         /7jPFdyQJ98DIPgCny9+m0s91Ptm6gZ6f0BE/RSxX5na5vB9KDR1YMbN/eyvCl9b5d9C
         NGsHmGUEAKBPCcOfbW+aO20CiPA/JekGEAA0+qkC2BErJsTczLBIdOlSpdmuA1c4U8+l
         mOFagxzi7FBaHwTbunBnXfQGhZ1en8pTcwunFAy7JXQD0bocjOQAPyxqtbKksdCZVjZt
         uc2cyPtLQBSBDparVqJx3MkCwZZ4ZZPpgJOjgCmGI7zzJlSSscu8GLZz6E0psJqlV/vN
         y4Tg==
X-Gm-Message-State: AMke39kK3I+VZK47DuwTHf940RipTfn2YfZ02ISF5SOFlJnwRwm6rIzru23RF33znIjvvi5C9rKxkY1Irzl+PQ==
X-Received: by 10.202.60.67 with SMTP id j64mr1002642oia.124.1486211839942;
 Sat, 04 Feb 2017 04:37:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.1 with HTTP; Sat, 4 Feb 2017 04:36:49 -0800 (PST)
In-Reply-To: <E363F108ABEF45CB99C2C721A90B5EA2@PhilipOakley>
References: <20170203202833.17666-1-jacob.e.keller@intel.com>
 <CACsJy8B2gyw7RQBh6Qfm5HxOyKWted-0ZeDfd2_U3MvWCO1HEA@mail.gmail.com> <E363F108ABEF45CB99C2C721A90B5EA2@PhilipOakley>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 4 Feb 2017 19:36:49 +0700
Message-ID: <CACsJy8Bk=pnyYNr2OxhQCYgxQQtOU=GqXUfgseL1HatB6SQPnQ@mail.gmail.com>
Subject: Re: [PATCH v2] reset: add an example of how to split a commit into two
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 4, 2017 at 7:16 PM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Duy Nguyen" <pclouds@gmail.com>
>>
>> On Sat, Feb 4, 2017 at 3:28 AM, Jacob Keller <jacob.e.keller@intel.com>
>> wrote:
>>>
>>> +------------
>>> +$ git reset HEAD^                           <1>
>>
>>
>> It may be a good idea to add -N here, so that 'add -p' can pick up the
>> new files if they are added in HEAD.
>
>
> When looking at the man page for `reset` [1] it implies that `-N` requires
> `--mixed` also to be given. Is that correct?

Yes. But since --mixed is the default mode, "reset -N" equals "reset --mixed -N"

> Or could the man page be clearer?

If someone makes questions, I guess the answer is yes it should be made clearer.
-- 
Duy
