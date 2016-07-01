Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DFBB72018A
	for <e@80x24.org>; Fri,  1 Jul 2016 22:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752123AbcGAWUi (ORCPT <rfc822;e@80x24.org>);
	Fri, 1 Jul 2016 18:20:38 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35966 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751128AbcGAWUh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2016 18:20:37 -0400
Received: by mail-qk0-f171.google.com with SMTP id j2so170824345qkf.3
        for <git@vger.kernel.org>; Fri, 01 Jul 2016 15:20:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=x/scAo1wPuR8+jn5YuLC+0Zi7YvorJ9Kj7ZVEAcq8xs=;
        b=Wz1nCM+RSN8Ju1Qn4/UHST7nwrPq83K09CnVL3mjCcSh+P5gKgtd+G6UDCoci4C05W
         Fjm0+MtIqhOb/TBsqy8Yx0p+KU0nwez1X/9975C64lCo48a4YCvPHKI/En/PpVuQa+V5
         QipUn36GYeNR8HZvg/Nhd+CRIDmoaw3+aAUEtjP+BMXI0BfjVZLEEwSEnr79QhiyqIbO
         //mYPvixrpMtiysmfGdVdkrUxXibuxp9w++h/EVt+e5TG7tlIA3W2K03g5s0Dc+XaGzx
         R2ZkOzSdNpoFLSl7OHR8drNE4yKMCZvU5Id4gByJJTa3iu1jTHIutSnWvPfpejAdFdwg
         P8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=x/scAo1wPuR8+jn5YuLC+0Zi7YvorJ9Kj7ZVEAcq8xs=;
        b=WZJWAiKCFffQWB47kXKbO6b//sdpV3OW5vjhvLM3PMJroKGOCPgtg4tRkSBcjPfsI/
         itXx8kvb1t5nfOlOBrUfvwpHWKP1k7Nq6Dk9++P2d7Y/SKl6wRld+otZGr1Hy2B0xRmf
         TI7jhZv9/9gS7nwtsXYPWtbFW9xJLq/hwRuaq5PBD4PglGKPbUJENsX5PSX6WviFMPzS
         t9DEVV5iFJMNMSKNf2RvsRviz9T5Zt2Zd8NCKXgFbeWIJLdafbxlsTP0res26dQb2ht4
         x0WjjnZ9/5AY6rWVZjifcdoFAf+rnHdJGCoQ3+/afwEISfKz6a3VtudpiW2NxStW8aG8
         OkfQ==
X-Gm-Message-State: ALyK8tKAjs1FQQ3x0TOftE2W6FtXqodRLI9ukSD1DQHcvyE+Aq+jSk6E5xuqbYzntF19ne0yUTkdcLzzI42qtw==
X-Received: by 10.13.215.6 with SMTP id z6mr320643ywd.275.1467411300022; Fri,
 01 Jul 2016 15:15:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.251.71 with HTTP; Fri, 1 Jul 2016 15:14:40 -0700 (PDT)
In-Reply-To: <38FAE374CD2D44EC9C86167F98953271@PhilipOakley>
References: <20160625164654.5192-1-philipoakley@iee.org> <20160630202509.4472-1-philipoakley@iee.org>
 <20160630202509.4472-5-philipoakley@iee.org> <xmqqk2h5vz2m.fsf@gitster.mtv.corp.google.com>
 <38FAE374CD2D44EC9C86167F98953271@PhilipOakley>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 1 Jul 2016 15:14:40 -0700
X-Google-Sender-Auth: 06bzrOM3_PGmoeeOXF4sPwwrLq8
Message-ID: <CAPc5daW_Kf8UG2zm4vBS9f4tN+bXusdZQkcwnssNs+gdk8J75w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] doc: clarify that `^r1` will exclude `r1` itself
To:	Philip Oakley <philipoakley@iee.org>
Cc:	GitList <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 1, 2016 at 3:08 PM, Philip Oakley <philipoakley@iee.org> wrote:
>>>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>  To exclude commits reachable from a commit, a prefix '{caret}'
>>>  notation is used.  E.g. '{caret}r1 r2' means commits reachable
>>> -from 'r2' but exclude the ones reachable from 'r1'.
>>> +from 'r2' but exclude 'r1' and those reachable from 'r1'.
>>
>> Well, if you have to spell that out, you'd want to spell out r2 side
>> too, no?  That is,
>
> The clarification wasn't about what "reachable" means but about inclusivity,
> such as whether 0..4 would give 0,1,2,3,4 or would be 'off by one' and only
> give 1,2,3,4. And in this case it's the latter.

Well, you have the same inclusivity issue on the opposite end, no? Is 0..4
a range with 0,1,2,3,4? 0,1,2,3? 1,2,3,4? or 1,2,3?

> Describing 'reachability' is a whole different kettle of fish, as you
> highlight below, and would be separate from this patch.

I am not sure I agree. It all is about "is the endpoint included or not?".
