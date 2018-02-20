Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2C91F404
	for <e@80x24.org>; Tue, 20 Feb 2018 19:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751810AbeBTTG2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Feb 2018 14:06:28 -0500
Received: from mail-yb0-f175.google.com ([209.85.213.175]:45180 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751447AbeBTTG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Feb 2018 14:06:27 -0500
Received: by mail-yb0-f175.google.com with SMTP id y190-v6so2437625yba.12
        for <git@vger.kernel.org>; Tue, 20 Feb 2018 11:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ES0gPwA4C9znH4KcSrwHNISCt8rFU1W2Wmh+Qlh67Bc=;
        b=fWdE8HAXB4KbyRwjixnxmINbwlZHDD6WzQfYRmjagV3iVXTc7oGg/Cqps9D2/Iapr6
         EgVNhcIqGwGfoXj67JqLZMKBeSXjHYiSqx0ojo9SQtQWUUKcwh6qH5e4DcJTF1ow+/Gy
         6VP8QYwPnTYrkCMLkm/WXmfJfqouKvye37pgoqtpfF+O1HgP0i2VQBjQiL/J+cZ+zAPQ
         Srk8HJrC7/w79884wBXxGqYBFdXwTXTjIyDZ1Ufod2KftOilWEYq2vgdzG6FRdKe1orh
         4XeYHbPhfI/dEFDlm12LoB7K7QoTu2TVORnoe6tD2CL0A4TLqD+6eWFVVC7cIFvY05ZJ
         yqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ES0gPwA4C9znH4KcSrwHNISCt8rFU1W2Wmh+Qlh67Bc=;
        b=KBCc4vghp6KOoFRBC2RZtqs+AsZE8DMje0FDQDDWL8C0JXHRshR+P7+h/njRHO4xHV
         M2WJCczyZ/BrY3xetSrpxyiSRn0NJgOqyeQkhB1XEleZK8WxhYaZhEgYURfJArcb0M0/
         AzAbQvN9wygvbyo743BAgYpvMQOOEesZepR/JVKZOan5u9b9TqiPZ2T/tqOdJnidNkQE
         B6dWUc+3qb4jG1A1CkkjePaMelesJoQRKIuEcNXuximRUW7joFyc7N3UXZ3ABdF6ek2K
         uihzSWh2O3L25iW9LhrJgCcVdRtn9RxQRYwQDFUsKFl13dvcp/EJ+yg85K5kzrQQOAXx
         L/RA==
X-Gm-Message-State: APf1xPCq18O2Mj7am+2PypyuLoVcFkAtIXy3lmrszKaYpX9Iuk2XwiO6
        eU0gIJZ+sXv6hAExz78Ve4ZV4Nz8mm9sgmS8o7i18g==
X-Google-Smtp-Source: AH8x224THe7ADUHjLoZPdxYWEy76yV2ijjT+4sFh/95wi9k2s2fnWod58yy273IIkljcrGclJ2nFSG8Wop5qzVaSzv4=
X-Received: by 2002:a25:6b0e:: with SMTP id g14-v6mr608296ybc.292.1519153586216;
 Tue, 20 Feb 2018 11:06:26 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Tue, 20 Feb 2018 11:06:25
 -0800 (PST)
In-Reply-To: <xmqq371v4h6u.fsf@gitster-ct.c.googlers.com>
References: <xmqqlgfu7zn5.fsf@gitster-ct.c.googlers.com> <20180216174626.24677-1-sbeller@google.com>
 <20180216223404.GD216564@aiede.svl.corp.google.com> <xmqq371v4h6u.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 20 Feb 2018 11:06:25 -0800
Message-ID: <CAGZ79kaUYYqtaJ-S6WaQ9NmXDnf6_wY_fRCSxLR8=Do1qSLMug@mail.gmail.com>
Subject: Re: [PATCHv2 00/16] Moving global state into the repository object
 (part 1)
To:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 20, 2018 at 11:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> For what it's worth, I think I prefer v1.  I put some comments on why
>> on patch 0 of v1 and would be interested in your thoughts on them
>> (e.g. as a reply to that).  I also think that even if we want to
>> switch to a style that passes around object_store separately from
>> repository, it is easier to do the migration in two steps: first get
>> rid of hidden dependencies on the_repository, then do the (simpler)
>> automatic migration from
>>
>>  f(the_repository)
>>
>> to
>>
>>  f(the_repository->object_store)
>>
>> *afterwards*.
>>
>> Thoughts?
>
> Are we envisioning the future in which one repository has more than
> one object-store (I am counting an object store and its alternates
> that are pointed by its $GIT_OBJECT_DIRECTORY/info/alternates as a
> single logical "object store")?  If not, doing f(the_repository)
> migration, stopping there without f(the_repository->object_store)
> may perfectly be adequate, I would think.
>

I do not envision that, maybe Christian Couder does?
The partial clone world would be happy with just one object store
per repo, I would think.

The step to take an object store would just add expressiveness
to the code, which may help in understanding what part of the code is
related to what other part of the code, so it may be a readability gain
on its own?
