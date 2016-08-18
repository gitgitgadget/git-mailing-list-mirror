Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 84AFB203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754312AbcHSBLB (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:11:01 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:33334 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754037AbcHSBJY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:09:24 -0400
Received: by mail-yb0-f176.google.com with SMTP id r187so11165866ybr.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 18:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0Rt/zzO4GHT8NYKoyeYDyshm7FY+iBsW85Ykq1FCYrM=;
        b=WNIxQUAbfIkhYen2aeaZ+ehgT/vvZSQthRznq/4P0dcFlY6c6S2IbVzuzOZooEVs2e
         UyAlMWHaB8OF5ZVhyHxOtrOuIvUewBmNsuQFUx1RmdRa3NINejZOrXbWtlBdnWoOu0mz
         PWLUg/6z7oKORVjRPMkxnUCSW+IzAqO68PobGP+qjE+d8hYpbbmVTlNVuEaslNa2fXLK
         zvqlVqyX0GbENHkeYwjAzGTXJzZmyIChS12z6MXUCHQoGWRWSsbG2swJVzvFQCk/rknA
         tY3K3q8ZVL7KqvN6AtGCnWgOHJdlBdSrUrmFEo2OlB1X9izE0LrQT0l2tMAf9tZpV+E7
         4kig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0Rt/zzO4GHT8NYKoyeYDyshm7FY+iBsW85Ykq1FCYrM=;
        b=ae67XX6jwauh+72hlxUGdMUT37LytIPMYj77z6YTvMhBK2ezDAgtyJleeZh4/SFrc6
         KvCFzO1kwAgAJwjf+8RTGcOdtLiQvzh7bCGkqbtkGCzmbNyDMtVS0R2TocPqtbOAZ+aB
         jzLzXyX9ob8A/rGjdExJgfgV3Y4pclLQq22oUcOWcv7ivPxbXqaDCgCixHzPKK2ob3gG
         4c6hn9g+TcBGkwJ/l+tJ4G2jPgbVGOt3fibsuoCAEvD8psmStDSlccAsPFU8aHY8qYFv
         iQThmGrJt8YQROIUnA9u5Ul1r2gWGqs9PsKHnpJJCf3KWcNZX0mR84m0zFCjgvyK25B5
         K3vQ==
X-Gm-Message-State: AEkoouudAvYLfu66XtL2cL1fUEqoIkXEkBR7ez7f6YhCnHJLrRJqcfP+tTyvdFuMkm+Tw4RfsjFz3rdGDZo+lw==
X-Received: by 10.37.97.149 with SMTP id v143mr3388623ybb.164.1471554560357;
 Thu, 18 Aug 2016 14:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Thu, 18 Aug 2016 14:08:59 -0700 (PDT)
In-Reply-To: <xmqqbn0p6bvu.fsf@gitster.mtv.corp.google.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-7-jacob.e.keller@intel.com> <CAGZ79kaFfrVwe+JXVJBBZVPn=mTv7F1db8T1ZzXEaMtZKoupQA@mail.gmail.com>
 <CA+P7+xrNzc-+KBdu20QpEcCJ_udYUUk=qQyDi26YoOyCwrPXiQ@mail.gmail.com>
 <CAGZ79kZp+fhB-APx+zSAyYYiLq0pinDZOS1s33a7OjckJOi5=A@mail.gmail.com>
 <CA+P7+xqQ-iaax3rtZbsGb6D4vBbwP7d63Qq4D2_z71V0Z4YCeg@mail.gmail.com> <xmqqbn0p6bvu.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Aug 2016 14:08:59 -0700
Message-ID: <CA+P7+xpQBdr1rzOPazLFhOW8cdk2ePCiqsykGqCmStvt--UMaQ@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] submodule: refactor show_submodule_summary with
 helper function
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>>>> If we were to change those, we could discuss if we want to go with
>>>>> full sentences
>>>>> all the time:
>>>>>
>>>>>     submodule is new
>>>>>     submodule is deleted
>>>>>     submodule is not initialized
>>>>
>>>> I agree, I'll make a new patch that does this as a cleanup prior to
>>>> this re-work.
>>> ...
>> Sorry for being unclear myself, too. I'm keeping it as "not
>> initialized" and updating the description of the patch that changed it
>> from "not checked out" to "not initialized"
>
> Whether it is done inside or outside the scope of this series, the
> other two "is new"/"is deleted" updates look very sensible ones to
> make in the longer run.  I'd further suggest to unify "commits not
> present" and "revision walker failed" into one error class.  From
> the end user's point of view, they aren't very different.

That won't work exactly due to the new way we separate the header
format from the revision walk. I can change the error case though. The
new show_submodule_header will not actually attempt a revision walk at
all and thus won't know to display "revision walker failed" at the
same place as the header fails. However I think almost all of the time
it should succeed if commits are present.

Thanks,
Jake
