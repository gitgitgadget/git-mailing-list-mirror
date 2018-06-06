Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BC381F403
	for <e@80x24.org>; Wed,  6 Jun 2018 02:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752680AbeFFCML (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 22:12:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45223 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeFFCMK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 22:12:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id o12-v6so4439208wrm.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 19:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Frgx/dksVWq+Qz25HT0Wvbiw1fu2CaQicpYb9X7vXGs=;
        b=Xlq01A9pbKv4fCVeIlBOBOYFJ49kQ8U1acYDlchBSZo1OEMOPIvZ2kRWnleNQKE/fa
         Dkb1x5D7gLirq+C6YtYmxf8tW2Tbx3u22Ate9RcPn2uApjRHm774EJfCxt8x9X81AliV
         S/K0CNocmssVxa0wn+RjTd5JeIRhLKAK99mKtnvDcQoTVVyfzBZGgtkVBE/8dQarjyvs
         5hltFWRlPvneFQ1hvjA7MdOhoD2DB9XrUFseoaNGOHLdJLU2lMb99JK2xYVD2ZNW6niI
         Wuvas8gprF15KEbuisPOlX7Ii+tMPc7VwXpgRcpjIJJuQ+oj6Np+YIZG/Fn/PsIhpiIa
         W80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Frgx/dksVWq+Qz25HT0Wvbiw1fu2CaQicpYb9X7vXGs=;
        b=A9hOlvzmhJet6rOPeE2HO/r/ipIqUjg2DqK94giNvs5Euqt1BwVrmJckTYnogK8jvV
         1P5Qn/EP2lNdkjeCtdoxzCTaawh7PPJnqaz7li1ajNCfJ4wGmNrwai9ZKeDpbRz6S22U
         GXucrUVmNCIiaKEMFVbrwA8FJNrqIjVTG++1O+UYyvXcJ2YwQC4hP9WEn4NaZ3ufxScj
         kT5TTVAWm0X2DJ0kVQ/Z5VeQIuPf+/q2NDhBMFeSyascWS+reZwCutoCOld8kZIDk8V4
         cbYw9LD3pFRJLCv44eu5G18V6atljpW0iROuIKMV/+DyfQc9F2eDviNvUp4CZC7EGbWy
         ihUg==
X-Gm-Message-State: APt69E3Xgm87NH8OrTCuZW98eE56voa9i/atIg6xjWUK4pgEkMtTcfxg
        /xEVMFYZj4VQOGyvvuos+ecNV/AGvyr38mypwi6LQg==
X-Google-Smtp-Source: ADUXVKKIisnXbOBb6UZTLNngRMEJuoZ9o8WOirD174DSVH5d1ScUrMxCYrSVsAML+iHxBcqWkhgHYpuRairn6Q/6Cj0=
X-Received: by 2002:adf:fb92:: with SMTP id a18-v6mr642035wrr.278.1528251129021;
 Tue, 05 Jun 2018 19:12:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:e90d:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 19:12:08 -0700 (PDT)
In-Reply-To: <20180605233504.GG9266@aiede.svl.corp.google.com>
References: <cover.1527894919.git.jonathantanmy@google.com>
 <8bda254e73fb00ff8448031002c7619bbe1dc285.1527894919.git.jonathantanmy@google.com>
 <20180605233504.GG9266@aiede.svl.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 5 Jun 2018 19:12:08 -0700
Message-ID: <CAGf8dgL2i2R50aRM9OoKGmVgS6XOSY+rD3F=RV8qd=Ozh=ONUA@mail.gmail.com>
Subject: Re: [PATCH 4/6] fetch-pack: make negotiation-related vars local
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 4:35 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jonathan Tan wrote:
>
>> Reduce the number of global variables by making the priority queue and
>> the count of non-common commits in it local, passing them as a struct to
>> various functions where necessary.
>
> \o/
>
>> This also helps in the case that fetch_pack() is invoked twice in the
>> same process (when tag following is required when using a transport that
>> does not support tag following), in that different priority queues will
>> now be used in each invocation, instead of reusing the possibly
>> non-empty one.
>>
>> The struct containing these variables is named "data" to ease review of
>> a subsequent patch in this series - in that patch, this struct
>> definition and several functions will be moved to a negotiation-specific
>> file, and this allows the move to be verbatim.
>
> Hm.  Is the idea that 'struct data' gets stored in the opaque 'data'
> member of the fetch_negotiator?

Yes.

> 'struct data' is a quite vague type name --- it's almost equivalent to
> 'void' (which I suppose is the idea).  How about something like
> 'struct negotiation_data' or 'fetch_negotiator_data' in this patch?
> That way this last paragraph of the commit message wouldn't be needed.

I wanted to make it easier to review the subsequent patch, in that
entire functions, including the signature, can be moved verbatim. If
the project prefers that I don't do that, let me know.

> [...]
>> --- a/fetch-pack.c
>> +++ b/fetch-pack.c
>> @@ -50,8 +50,12 @@ static int marked;
>>   */
>>  #define MAX_IN_VAIN 256
>>
>> -static struct prio_queue rev_list = { compare_commits_by_commit_date };
>> -static int non_common_revs, multi_ack, use_sideband;
>> +struct data {
>> +     struct prio_queue rev_list;
>> +     int non_common_revs;
>> +};
>
> How does this struct get used?  What does it represent?  A comment
> might help.

I'll add a comment.
