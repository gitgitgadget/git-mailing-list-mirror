Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 749481F404
	for <e@80x24.org>; Fri, 23 Feb 2018 22:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbeBWWda (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 17:33:30 -0500
Received: from mail-yb0-f170.google.com ([209.85.213.170]:39187 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751607AbeBWWd3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 17:33:29 -0500
Received: by mail-yb0-f170.google.com with SMTP id v8-v6so3434016ybk.6
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 14:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=suQYofdyQbBzumlfUFVCbi/imk6ZoUJFb+6rDOxcAhM=;
        b=kye7Hq5DGsGkDotsfATP7CfCKFX8nU74VcqPPxriZyR8cRR5HP5izi9noR25dnxCfS
         F8M7K+x9ZIBBkLl93xxYkvWpYhArRYxymQsIUaXnDlrqJMhG4EGDAjNJNOKKvFzM0sN+
         XMgxlF0GtysG/7tcnXhlHWX/UcUizlutL2TW9ckA4pYwJyn+jBzVYkAdbN7TsWqY7rsc
         SUsoakMP7MH5lMaNwWjyoa0piUze/AAgNsVjwERYod9xHWiblf2XUds5m8DLgyNaukSv
         pu60WwAYoAoYe9j/7wsjxPNJTGeay7BPYxQQPBd6xpP3E3ZiWYwceGgKFNuekibz/Dlb
         qowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=suQYofdyQbBzumlfUFVCbi/imk6ZoUJFb+6rDOxcAhM=;
        b=JMDJTTPqWxY6Ad7wovWtQxb9keSCqxvUaVlnWUJwxy4LSFXU8W3liyQMEgdnHATuuc
         BDKvZvMA8f34mX8ECD1pW8lZNP4YnogxiYVW1ftJt54uxldoAKFpwbedaBfRSDRRA23D
         22VVqCw0NWK7EaNSx8Mg8uhpbwPwXbmXtWCZWfZ4yj9Eq+U27oVOxMsTDvYMy84R9lbY
         XIT9KMKLAqf0nP7Lmj88xDi6Ve2HigLgQUQKQKG4l6wZnoNl1bYowsP0VrP9/E6dNP0E
         FpH/uucjW1bK+6XGJpJEDPOWoeBgMJXAUJe7m0m7hsADDTggDAIiKX8PSl2EfpIt9j2C
         yMmA==
X-Gm-Message-State: APf1xPDrm7CfABCXgzqS8+HE7YRaaAmZJNhUyV3dalufwpYbQ0tL5WIu
        7ubKD3a6zmsIy3xgbVPIRqkyW0cRX9JsS3+nVNsz4Q==
X-Google-Smtp-Source: AG47ELuDQYGkRLAITQ19ekY5+x5XZFrN0yDgEnKwO9hdfmwvzbUXtqfyuKri+2rpZzN4oajgWHa3ADgsEtNNZ7h8V7U=
X-Received: by 2002:a25:d9d6:: with SMTP id q205-v6mr2204858ybg.515.1519425208346;
 Fri, 23 Feb 2018 14:33:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 14:33:27
 -0800 (PST)
In-Reply-To: <20180222065122.GE133592@aiede.svl.corp.google.com>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-14-sbeller@google.com> <20180222065122.GE133592@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 14:33:27 -0800
Message-ID: <CAGZ79kYozWRw5rtCSN+Fab2x+MDSOSASdY4MZgSykw9cN98qaw@mail.gmail.com>
Subject: Re: [PATCH 13/27] sha1_file: add repository argument to prepare_alt_odb
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> --- a/sha1_file.c
>> +++ b/sha1_file.c
>> @@ -23,6 +23,7 @@
>>  #include "sha1-lookup.h"
>>  #include "bulk-checkin.h"
>>  #include "repository.h"
>> +#include "object-store.h"
>
> Should this #include have been added in an earlier patch, since the
> file both uses and defines prepare_alt_odb, which is declared there?

This is another superflous include, dropped it. Thanks for catching.
