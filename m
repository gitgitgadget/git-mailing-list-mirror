Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 412C11F406
	for <e@80x24.org>; Sun, 13 May 2018 19:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751518AbeEMTLr (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 15:11:47 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:39254 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEMTLq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 15:11:46 -0400
Received: by mail-ua0-f177.google.com with SMTP id v17-v6so6921742uak.6
        for <git@vger.kernel.org>; Sun, 13 May 2018 12:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QS01j9YWxwlKe0fXfYnFLCoU1uRhty6Sz+5oM8bBl4s=;
        b=ebmHNSIT/HWNbU0LDEgA7xv4P4/Y7na3/6iPFaU+KPdPEytzd+E9NIf8SdqiZDiBeu
         Qs3kLLU+8KovnLS6I/kMzafvw44yBanjmDDRJ8kN6aa9NiBGXHb/h6yHqaRkRdNGJ839
         SRwdBPUI3/ds/m5lWeeGCe3AdAen8P2MjCTZzQMUmKnMrIM62VT0rVI/cD4ZvWHXMwph
         WN14iobPJ7HSAjHFXzN1pRd4VEsMTMHtUFgV5W9/Vew8/JScZ7xcGSOT3UGmEDW8vzgE
         Su6PlyUsNOImINx8nMVas5HBbbyYnPJ5Yu06TapPV1g51TjsPzRfUVS5pMJPN7w/yKWd
         +Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QS01j9YWxwlKe0fXfYnFLCoU1uRhty6Sz+5oM8bBl4s=;
        b=DaNTgm1hu+BPF9x31jbh1NUS33dI2pRYOLDCSeOkufHZnX7RZbP6DjyBRPlO0T/Tam
         WwaQfNMQPenDMgyXVBeLlTeyVtCFXVZVuPUwjhl6f5n9fAqoc/pffbZhJ7I5NlTy3BLR
         px5PHmZMj2TrV58yGT7JFhPstI6xNrLTywVutP+63zQVaKHC+3W5LI3tKobUedos/aiX
         JInoizLO7xbhgW7UXaPPpLXwdDFIAzmKlJab70BwBe2fj4v5AldXbkBBJ00qJJRYFngo
         2UJm498GOvxc8QCAgQNG03izB7UP0tB/iid9A2zPztePBAPa+rAnB8B9X92k18OvJof/
         tl0g==
X-Gm-Message-State: ALKqPwe8UfxfWDwgjpTA8Gv3mHlvSCMHwIaxxuNnpzn35uG6zf113H6/
        TxuI35PoqVbhZQfFcHyK0Q==
X-Google-Smtp-Source: AB8JxZoNR91pqr5aEgu6UqZ7n5U+nBHnN92LU1zw7i1Dh7gl4BkHsweDuPqw5IvhzIl5zZdNZXoVFA==
X-Received: by 2002:ab0:47c6:: with SMTP id w6-v6mr9154890uac.186.1526238704394;
        Sun, 13 May 2018 12:11:44 -0700 (PDT)
Received: from [192.168.1.16] (ip177-101-15-186.ct.co.cr. [186.15.101.177])
        by smtp.gmail.com with ESMTPSA id q74-v6sm1468221vke.49.2018.05.13.12.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 May 2018 12:11:43 -0700 (PDT)
Subject: Re: Re: [PATCH 1/3] checkout.c: add strict usage of -- before
 file_path
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <Matthieu.Moy@imag.fr>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
References: <1526178214-30956-1-git-send-email-danniercl@gmail.com>
 <CACsJy8DZ1QvjO+JdbB76TOLtB2wp4Ya+CgsTyD1oz2Y+ZdKdYQ@mail.gmail.com>
From:   Dannier Castro L <danniercl@gmail.com>
Message-ID: <775fe020-be92-f65c-5a67-e83e6bf4777f@gmail.com>
Date:   Sun, 13 May 2018 13:11:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DZ1QvjO+JdbB76TOLtB2wp4Ya+CgsTyD1oz2Y+ZdKdYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/05/2018 00:03, Duy Nguyen wrote:

> On Sun, May 13, 2018 at 4:23 AM, Dannier Castro L <danniercl@gmail.com> wrote:
>> For GIT new users, this complicated versatility of <checkout> could
>> be very confused, also considering that actually the flag '--' is
>> completely useless (added or not, there is not any difference for
>> this command), when the same program messages promote the use of
>> this flag.
> I would like an option to revert back to current behavior. I'm not a
> new user. I know what I'm doing. Please don't make me type more.
>
> And '--" is not completely useless. If you have <file> and <branch>
> with the same name, you have to give "--" to to tell git what the
> first argument means.

Sure Duy, you're right, probably "completely useless" is not the correct
definition, even according with the code I didn't find another useful
case that is not file and branch with the same name. The program is able
to know the type using only the name, turning "--" into an extra flag in
most of cases.

I think this solution could please you more: By default the configuration
is the current, but the user has the chance to set this, for example:

git config --global flag.strictdashdash true

Thank you so much for the spent time reviewing the patch, this is my
first one in this repository.

-Dannier CL

