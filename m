Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0689F1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 17:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbeHDTUZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 15:20:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41844 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHDTUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 15:20:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id j5-v6so8314864wrr.8
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 10:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+Mk2iSvIVhIeJsEd2Wqzny0TM83uPuHP4iSoyvwK4/c=;
        b=P9u4kudgM8QfN2ND0HMB956hSyXEMy2+ZL0RoMn7mE+1cprv5ybTuHUqlsDzZ8mGHw
         4TO5AAr3gJRppa5BOiTI5yzyeNfiURKOy8WLTIqmXsXFM+t/DDA8cWe0P6Fhuhh41Epa
         DtzrU07119VRH7VxEcbcFwylkRDcsB6RQp6KM/WsG9bJlcR10Dr3kqedFDDYMG8q+0rX
         IWehKWh2/QZeNgrmdz7E7ekj9lfLSLRtRcHubqB9nx2VuEHyjxxI7KB5E9ZelC2LJbFd
         sq/KEKxCSpXkSc5LsJeIBLy9trbcw6yQyYb8XIdPTgP/mf6IILDdaSIZCeZZSIoVa93P
         iOQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+Mk2iSvIVhIeJsEd2Wqzny0TM83uPuHP4iSoyvwK4/c=;
        b=RsBCHtY9iswzbU6d5EQpwM46igzEOAqxnMcIwJ3gQrF50eXCAygvErOueOSrQRpvSV
         YkTr4m2nCY7vFHcljy0+5TsnAnMqJETgOMzLPcIyJ95tn5UISn0X4x16k1Xs7tVoR/Wx
         TdytVxG9BHsLFqOU6rJV+rtu7B5VtjpkFcCLbXHe+jOMC/+D2ZQemlKinlp33/FO3+DA
         FRbu/TC67b4npUxVQfxK3O9YN9jQWUnd1HJnXwEAOCNzPY6vZvqlAkQTbNpRgWzQkQAs
         vnFgEf/mQLYKXuMtiJzWsUjSU2FFyyGlggxiFiRnZ+rW2KR18+MsOR0m7DESzedhysMH
         oXFQ==
X-Gm-Message-State: AOUpUlG/uLA8xAeEaQyqqWI0pReDFdT0zlp19KTOeDWtlEI41D2Yhy0c
        KNB8crFSx3BJCWfjzFommqM=
X-Google-Smtp-Source: AAOMgpf//ZkCFYJvvLGhc2SnQzcXwi4lwVVliCs23R+g2/8WRMKemsK+SaIJ0wo9ASkyQATxIHGoAg==
X-Received: by 2002:adf:b2f4:: with SMTP id g107-v6mr5687430wrd.53.1533403143447;
        Sat, 04 Aug 2018 10:19:03 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id s16-v6sm5334003wrq.20.2018.08.04.10.19.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 10:19:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        git-packagers@googlegroups.com,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Makefile: enable DEVELOPER by default
References: <20180804020009.224582-1-sbeller@google.com>
        <20180804020255.225573-1-sbeller@google.com>
        <20180804060928.GB55869@aiede.svl.corp.google.com>
        <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
Date:   Sat, 04 Aug 2018 10:19:02 -0700
In-Reply-To: <CACsJy8DxSDLD7B8Z+GBFOuU7d7VQ4-M=BP=wptra5rBiZGspSQ@mail.gmail.com>
        (Duy Nguyen's message of "Sat, 4 Aug 2018 08:38:14 +0200")
Message-ID: <xmqqo9eirqwp.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Aug 4, 2018 at 8:11 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>> My main concern is not about them but about other
>> people building from source in order to run (instead of to develop)
>> Git, and by extension, the people they go to for help when it doesn't
>> work.  I have lots of bitter experience of -Werror being a support
>> headache and leading to bad workarounds when someone upgrades their
>> compiler and the build starts failing due to a new warning it has
>> introduced.
>
> Even old compilers can also throw some silly, false positive warnings
> (which now turn into errors) because they are not as smart as new
> ones.

I agree with both of the above.  I do not think the pros-and-cons
are in favor of forcing the developer bit to everybody, even though
I am sympathetic to the desire to see people throw fewer bad changes
that waste review bandwidth by not compiling or passing its own
tests at us.

