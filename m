Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6753D1F424
	for <e@80x24.org>; Mon, 23 Apr 2018 12:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755285AbeDWM5b (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 08:57:31 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:45078 "EHLO
        mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755161AbeDWM50 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 08:57:26 -0400
Received: by mail-qk0-f173.google.com with SMTP id c136so15966163qkb.12
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 05:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nAN4ikKM+g9CvyPJg2YUHAYOyi7v2XDtDzmkiA8JwVs=;
        b=uIdnKB0ONMfZlok3nFh9LB4YhlmQMjh2lzejbeSXLbLegyVqtgS73a3oB2m/7tLtT9
         uZ5RrRopoPA9PB8c+LrCiKaHB2WRQR3ilUegtp+M4KXvDeebYmshUQY58kMFo//G6sdO
         np9dZzGhVwkO7SBlhRhHyO6acdY0DvxbHanYgg+FGUErjYOnaGG9q9JRo69BaqxWRl93
         uXOcuDrgQr3QcHZK5Hk48l81t6HsSOWH6JZdIFyOz03kE5rZwmKpWDcfqufuysHl8KtP
         S7VYd5DYkvBt6E47ouPdnCSce31IikQMJKw8Dz6yj9Q26wLXLiP4Tu23Pvt6QlvEsOXF
         JdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nAN4ikKM+g9CvyPJg2YUHAYOyi7v2XDtDzmkiA8JwVs=;
        b=a7kcKYdEM0f6GrSifGbRXknAoG7peUwa7AOJYPemF0O61fpZoEALjN/q1n/7+tJykx
         4qdSmlU0RcYqb0NipuMqRnHQ+eEBIVbOWlc9eskcScR6qjmRXVdLotAekty8mL0/cIs3
         zIDd4W4/CSWZNeCmMFIgPmFHijfkgZcWf4i4uRTxZqaYPbzlQxLOn43WAvOcbwtLH9oB
         n8I4e3bSDSVojWdtuLrFVBV7bSrulfntrqNOQqjjfeVHhBMHz2hqi7CMsfwyz7ee2pJc
         m4J7loqZ/lq62/1JtBhe6hX2hiHC+02mVvWCCaE6uEhVQHuEiIQTd+yRIJTyPYPar7FM
         dmAQ==
X-Gm-Message-State: ALQs6tD8emc2sPTO3PcYIE7uQ6afZku8Z05gBqeFxbFhRKp8Dz3raZXS
        WUHd2NxZ3udU1eiUgcuBSak=
X-Google-Smtp-Source: AB8JxZpwZ3ndcyl1OKpWLg0Pf+E/oXHAOgXDajTyJKnTFU2T6KlYzkstAnHbkSdMAmB9noemusgRqg==
X-Received: by 10.55.31.132 with SMTP id n4mr21334279qkh.375.1524488245538;
        Mon, 23 Apr 2018 05:57:25 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id z23-v6sm9714554qto.13.2018.04.23.05.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 05:57:24 -0700 (PDT)
Subject: Re: [PATCH v1 1/2] merge: Add merge.renames config setting
To:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180420133632.17580-2-benpeart@microsoft.com>
 <CABPp-BFANBs=tOhS5BFfTMkdQsNYbUDExWK8QB0V=qD9YwZyWw@mail.gmail.com>
 <CABPp-BEhvLVTL3+0scUucAp9ZMBiiT_0VG3eeKm9qRnHG=y+tw@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <82d8c76d-b8fa-4b72-5ebd-25b650f89980@gmail.com>
Date:   Mon, 23 Apr 2018 08:57:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BEhvLVTL3+0scUucAp9ZMBiiT_0VG3eeKm9qRnHG=y+tw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/20/2018 1:26 PM, Elijah Newren wrote:
> On Fri, Apr 20, 2018 at 10:02 AM, Elijah Newren <newren@gmail.com> wrote:
>> On Fri, Apr 20, 2018 at 6:36 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>>> --- a/Documentation/merge-config.txt
>>> +++ b/Documentation/merge-config.txt
>>> @@ -37,6 +37,11 @@ merge.renameLimit::
>>>          during a merge; if not specified, defaults to the value of
>>>          diff.renameLimit.
>>>
>>> +merge.renames::
>>> +       Whether and how Git detects renames.  If set to "false",
>>> +       rename detection is disabled. If set to "true", basic rename
>>> +       detection is enabled. This is the default.
>>
>> One can already control o->detect_rename via the -Xno-renames and
>> -Xfind-renames options.  I think the documentation should mention that
>> "false" is the same as passing -Xno-renames, and "true" is the same as
>> passing -Xfind-renames.  However, find-renames does take similarity
>> threshold as a parameter, so there's a question whether this option
>> should provide some way to do the same.  I'm not sure the answer to
>> that; it may be that we'd want a separate config option for that, and
>> we can wait to add it until someone actually wants it.
> 
> I just realized another issue, though it also affects -Xno-renames.
> Even if rename detection is turned off for the merge, it is
> unconditionally turned on for the diffstat.  In builtin/merge.c,
> function finish(), there is the code:
> 
>      if (new_head && show_diffstat) {
>          ...
>          opts.detect_rename = DIFF_DETECT_RENAME;
> 
> It seems that this option should affect that line as well.  (Do you
> have diffstat turned off by chance?  If not, you may be able to
> improve your performance even more...)
> 

Seems reasonable to me.  I'll update the patch to do that.
