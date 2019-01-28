Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFBE41F453
	for <e@80x24.org>; Mon, 28 Jan 2019 18:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfA1SHj (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 13:07:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40254 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfA1SHi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 13:07:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so19148550wrt.7
        for <git@vger.kernel.org>; Mon, 28 Jan 2019 10:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6rUTZQv6tolG3Q1wkKcyYIX8ELsXM8LmsgPwjjR1LEM=;
        b=k7fcm5fNSX4buAXP8sDwBpHI4c2dPG8OIygMlQ7scqzq/tWjazkEDAOsJfUkWme7GR
         bXVc89V8r23HwwU4HcToFVHdhCnmol5eU0HM7McFSjE8ohbcPYfqMvuJbu/J+f1/D/I+
         YXElZniAg1BQwFjXLF44KK2FJvSOIioukAeBNX6Ki3HB4kpNxBSPo5nNiy1oxHhK7xAB
         g0I8dOcqgsGqLmV2WknPhhg0grk+9NCfy5M7ZthGGnNfQseXMFSC+5O7nBpp+WZA5k7u
         HqlsEaP7s3OCMkVYZ1cRFHaa/VHpubtofoGQ+nPztc7oKGM7iSngExy41j+6dpZtPxnd
         ntUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6rUTZQv6tolG3Q1wkKcyYIX8ELsXM8LmsgPwjjR1LEM=;
        b=tYKUZkEHFgjA2QaTg6ztV/CGcCdr6TV+vxFElZ1VLevSNAeBXtxZFbs6t+Qx4Pi6hz
         l9wkQUBjP/jOakD8V46UzwP+9nKPSuaZLdvFqzvpWlzFKtFZeeiC3iOurfkUX4NRtzCv
         rV2FQ0GuMefDfopTMe+Aw85yqohGQrLZ3zhNDkPFpn5LPgZShi8iJ0YMw9vUUIz++Jvu
         QLYq+YYw0B41dpjOw2ghmtjPgzANcPty0fna9pxqDM7t6mijIp/MrGRkDue8VHXcWTsM
         /ax0ygn0HcPkfr8cYkEtmSCCxTmxxgazZ7vGS+dFayqYktfKtT+JbtMl2wjm8oz6vZb0
         bArw==
X-Gm-Message-State: AHQUAuZiZtx7GJBHDEDEkHf9OqhbJMrWAFpl84S3+D+0Dbali8bVpftG
        pXnTj5pczQq3QV6uXSvxjho=
X-Google-Smtp-Source: AHgI3Iahmb5FcrcgS0lXEJ/DTgz28rYrSxigHxu1U7swyu0DvdYJGKOQiIJ9p26EByZ/LKEPHtQvbw==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr7352934wrw.14.1548698856356;
        Mon, 28 Jan 2019 10:07:36 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v4sm189677wme.6.2019.01.28.10.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:07:35 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH 00/14] Trace2 tracing facility
References: <pull.108.git.gitgitgadget@gmail.com>
        <e1bd52e3-1ac5-b08c-d1f6-a7fa63ebf0cf@jeffhostetler.com>
Date:   Mon, 28 Jan 2019 10:07:34 -0800
In-Reply-To: <e1bd52e3-1ac5-b08c-d1f6-a7fa63ebf0cf@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 28 Jan 2019 11:15:29 -0500")
Message-ID: <xmqqpnsgbqqh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 1/22/2019 4:22 PM, Jeff Hostetler via GitGitGadget wrote:
>> This patch series contains a greatly refactored version of my original
>> Trace2 series [1] from August 2018.
>
>
> My Trace2 series "jh/trace2" has a bad interaction with "js/vsts-ci"
> causing some unit tests to fail in "pu".  I'll post a new version
> shortly.

Thanks for a heads-up.
