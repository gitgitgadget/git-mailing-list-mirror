Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E511F404
	for <e@80x24.org>; Thu, 25 Jan 2018 22:18:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751404AbeAYWSM (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 17:18:12 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:38680 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeAYWSL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 17:18:11 -0500
Received: by mail-yw0-f194.google.com with SMTP id m84so3558946ywd.5
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 14:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=btQBSuPVnJPg/A3qt6byiRiaakxWAVm6muu6DlMo7Q8=;
        b=Geb49hK4wXVrGeTGsY/T/Hngdv+/BHZxlc8lZD3Pli9XBJxVRcskvWe/8qQR7fxVYY
         Qb/1tXe3ENZ0lR69xbXeQGpkLy23N8N8J2hmAzfqwF8emufPNDXCokWNAKFnMSbv+/1X
         pbE/9fYW5ju2MIzsbrslQlP5TG+iE+J1+UvXEA7M3yXmPu4rwi9FMupQwA0a9IWedQyS
         yV/0UpszAJzCy1JIYTR0/2gh6CRlLY7aCyWzvXBYkXG9FSTttAJlBjJTqxZuLZHRJ67A
         0RyJX7i0zpaVmp6GWy0tCLW6FDSoGcwB9NenN/12LR2yCg10a7qD4G7YpZo7vD1Tnq4t
         hBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=btQBSuPVnJPg/A3qt6byiRiaakxWAVm6muu6DlMo7Q8=;
        b=Te18CH+f/Osutpvdw4+OvxEhiYaB4BmulcguXrjVzCpicpnKpFkDTWjoVm0tHttQPj
         2vCsa+ORWNZNbN0zMc0PuAGlGPdWEdRzSO5RqeclZvgrNDprx2bSnEhmv8JAcAg6SVWm
         i885LF+mk/xOGpcZD2D8hi1xb9B+ySpIpIOMsqHZ2U0aOfEQJcU6xbN8IBoeLqEAKElx
         mXNeaTITAFVwkXvGbNUgY85bCJ2MwFl0VUFRc0X/EEq+sRBtoG6I5RyMlnr9vsm2SI32
         DV49nQGvTfWA9+vM8LY9OgMzZGEAYkaP6QCYqjthIHtODM4J9uXwjJHjj4MpbfRMG3XU
         8fHg==
X-Gm-Message-State: AKwxytdPKvyc8ikBnEMmHb6nJfOKTxeORXa6MB/3PoCcpR0ldtP3kKFM
        140wfzbBBLXk+j//LnmdDBip3sobEum9IuYZUpzdYw==
X-Google-Smtp-Source: AH8x227qrMUNHkZzf+eazBHXr1WwMEBzexEljleCXOESitwSie0SVdW+p9QzGd3nfCi3nvtEzgac12Kc9qcnUnk0Z8c=
X-Received: by 10.13.220.3 with SMTP id f3mr9609125ywe.288.1516918690471; Thu,
 25 Jan 2018 14:18:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.210.209 with HTTP; Thu, 25 Jan 2018 14:18:09 -0800 (PST)
In-Reply-To: <xmqqr2qd8ug8.fsf@gitster.mtv.corp.google.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-5-dstolee@microsoft.com>
 <xmqqr2qd8ug8.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 25 Jan 2018 14:18:09 -0800
Message-ID: <CAGZ79kZkhCmmF9hPRaf7RygDuWJd3edMDiAki8CDTJw3xG6BCg@mail.gmail.com>
Subject: Re: [PATCH 04/14] packed-graph: add format document
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 25, 2018 at 2:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> Add document specifying the binary format for packed graphs. This
>> format allows for:
>>
>> * New versions.
>> * New hash functions and hash lengths.
>> * Optional extensions.
>>
>> Basic header information is followed by a binary table of contents
>> into "chunks" that include:
>>
>> * An ordered list of commit object IDs.
>> * A 256-entry fanout into that list of OIDs.
>> * A list of metadata for the commits.
>> * A list of "large edges" to enable octopus merges.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>  Documentation/technical/graph-format.txt | 88 ++++++++++++++++++++++++++++++++
>>  1 file changed, 88 insertions(+)
>>  create mode 100644 Documentation/technical/graph-format.txt
>>
>> diff --git a/Documentation/technical/graph-format.txt b/Documentation/technical/graph-format.txt
>> new file mode 100644
>> index 0000000000..a15e1036d7
>> --- /dev/null
>> +++ b/Documentation/technical/graph-format.txt
>> @@ -0,0 +1,88 @@
>> +Git commit graph format
>> +=======================
>
> Good that this is not saying "graph format" but is explicit that it
> is about "commit".  Do the same for the previous steps.  Especially,
> builtin/graph.c that does not have much to do with graph.c is not a
> good way forward ;-)
>
> I do like the fact that later parents of octopus merges are moved
> out of way to make the majority of records fixed length, but I am
> not sure if the "up to two parents are recorded in line" is truly
> the best arrangement.  Aren't majority of commits single-parent,
> thereby wasting 4 bytes almost always?

git.git has ~37k non-merge commits and ~12k merge commits,
(35 of them have 3 or more parents).

So 75% would waste the 4 bytes of the second parent.

However the first parent is still there, so any operation that only needs
the first parent (git bisect --first-parent?) would still be fast.
Not sure if that is common.

The downside of just having one parent or pointer into the edge list
would be to penalize 25% of the commit lookups with an indirection
compared to ~0% (the 35 octopus'). I'd rather want to optimize for
speed than disk size? (4 bytes for 37k is 145kB for git.git, which I
find is not a lot).
