Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F7C21F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:53:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732399AbeGLUET (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 16:04:19 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:50213 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732204AbeGLUET (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 16:04:19 -0400
Received: by mail-wm0-f52.google.com with SMTP id v25-v6so6730498wmc.0
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=v6JD0xD25AT98hBkt3/izPKyxVlEEnam4BQaqKS4Fx0=;
        b=LV06SGjzR2owFhQxncquhYWZ3uho+t242LOa3HT1ifd3r5xmXThqbGAAr/TopY7Qld
         /u8BbDHDrrFhq/ohAEwZJ+OBoEQSIMAY0Ue+dqQAo7GS79FOnKXNrCjHG0SUsJLgiSLp
         E4rS9EFg3t4Yk6ZmETYJJfkIYqThjtLaT1hH5lDTVRVyBIdYqEZXVq1Cp7/OmdEPoKdK
         6p0aokuZaUe71juC0oLZrjUyHEjeb0Q6rt+AIx9VyVbVrBL2IkmaUBa306MYfMcCn14i
         Nrl+dgHmeZ696BYwCESFXrClt4XuhDtasgHXxtvUPZYoccHyNKpslMkOKJiikB3yrVbf
         8WHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=v6JD0xD25AT98hBkt3/izPKyxVlEEnam4BQaqKS4Fx0=;
        b=tGRQm2OxZslepeJ9Vkfkdb8lWbp/+Wfdz8szdqmcrqrszpuA99brh7oFKUQxYKMypB
         4nH7jxmAbEIll6utrMF7jdGPn7rTGdnqHzCJdZACXmsk7EHBQXGVVjbJ67QLGZ8eYxt1
         2YGtAsg05x0P8T03iTqM7z0Co8mR1K6BpPQJLLj3wARekBWQ1FpZK1iZ9VnO77pOQjsn
         TMdxc1wNeWQlIFlHEsrArLGOK0n2y0XKW7w1Lk39fIfCb7FsTOhXl3kyxfZdYzvMO1qy
         09ez+sMU1LwUFXshatUE9qZus0FR5CJeZHo1u8sMy9OT3XSOzwq+lZj+qi9VT5Dycq6I
         J3Cw==
X-Gm-Message-State: AOUpUlFsGTOpWyDxkLpYs1CFvWH4OWbknTb4l3uUlfmXYEVMOseHC0Gp
        SokYjEn/4+HriMKAROb0IEg=
X-Google-Smtp-Source: AAOMgpeixBiFvStSe1kvhCPtaJaOSWDaX8YnybrxGG1bvY3t9iJ+dj6LFbWwlhOA50wZkbSHor2b0Q==
X-Received: by 2002:a1c:ae8d:: with SMTP id x135-v6mr2146260wme.20.1531425194289;
        Thu, 12 Jul 2018 12:53:14 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id r14-v6sm30555541wrl.4.2018.07.12.12.53.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 12 Jul 2018 12:53:13 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sbeller\@google.com" <sbeller@google.com>,
        "johannes.schindelin\@gmx.de" <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3] handle lower case drive letters on Windows
References: <20180711175420.16940-1-benpeart@microsoft.com>
        <20180712154419.18100-1-benpeart@microsoft.com>
        <xmqqr2k8w9n2.fsf@gitster-ct.c.googlers.com>
        <BL0PR2101MB1012EDB64112A8805A2C3D82F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
Date:   Thu, 12 Jul 2018 12:53:13 -0700
In-Reply-To: <BL0PR2101MB1012EDB64112A8805A2C3D82F4590@BL0PR2101MB1012.namprd21.prod.outlook.com>
        (Ben Peart's message of "Thu, 12 Jul 2018 19:23:23 +0000")
Message-ID: <xmqqmuuww7rq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <Ben.Peart@microsoft.com> writes:

>> -----Original Message-----
>> From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
>> Sent: Thursday, July 12, 2018 3:13 PM
>> To: Ben Peart <Ben.Peart@microsoft.com>
>> Cc: git@vger.kernel.org; sbeller@google.com; johannes.schindelin@gmx.de
>> Subject: Re: [PATCH v3] handle lower case drive letters on Windows
>> 
>> Ben Peart <Ben.Peart@microsoft.com> writes:
>> 
>> > On Windows, if a tool calls SetCurrentDirectory with a lower case drive
>> > letter, the subsequent call to GetCurrentDirectory will return the same
>> > lower case drive letter. Powershell, for example, does not normalize the
>> > path. If that happens, test-drop-caches will error out as it does not
>> > correctly to handle lower case drive letters.
>> >
>> > Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
>> > Signed-off-by: Ben Peart <Ben.Peart@microsoft.com>
>> > ---
>> 
>> Thanks.  Will replace, even though showing the whole Buffer (I am
>> guessing it is the equivalent of result from getcwd(3) call) and
>> complaining about drive "letter" feels a bit strange ;-)
>> 
>
> Thanks.  I thought it was strange as well until I realized you only see the
> error message if there _isn't_ a valid drive letter so seeing the entire
> path makes sense as it will likely be something like "\\server\volume\directory"

Yup, that is why I thought Dscho meant to say something like

	"'%s': path without valid drive prefix"

in my response ;-)

