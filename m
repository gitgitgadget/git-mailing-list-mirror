Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C655203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 01:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbcHSBPp (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:15:45 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:36999 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754719AbcHSBPm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:15:42 -0400
Received: by mail-it0-f47.google.com with SMTP id f6so13029581ith.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 18:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kIoDqBJHH1uBCDXXAx9a3PTclHutCOpDkuz4wIlakaQ=;
        b=l3GQhPRoBicFdBrJC25aLdhxfVAjtO8obfXLeME+nk6wdYKLPRJvxk/LsSCop21Z1H
         Gxzrt+aCMYbGpW/HkcLJG9ZVKjUZCWAhfOOTBAsJSVQ7XX5A8TXjdgkjZ/Xydl1jm2mt
         dPIS7vTYtBw702kcKIRMLPWoPB5TYksBFTwTocjJwFsECxEEwdiG/qi9CiHfFwfo/tim
         kjuJU2VuzAgO36UGJNUF+B0RN3rbgEg7Q3mztxnQa8f/uRHvjZaMTCNc8BksCRnTseNU
         XWA0ucvsroDTt1kpKHdCzTc4sZIt4NbY2Bt+/nhg/Pd0eSGumvpdd8l4J0io3TovFYlk
         IUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kIoDqBJHH1uBCDXXAx9a3PTclHutCOpDkuz4wIlakaQ=;
        b=bLc5LvZ5Adt5CE9cBBFdJf7u6JUtYUJEl1RFv2P5HzhRE8RpdCYeyW8ghFCxKaCvj0
         plkCOOGfzliqoi1XWurS8rVVoAXCT7Ff5f1klqLQ3eVc+MP9CcvzOH3QRLBgW5rUqi08
         yKGLVJpRy1l37f26Rbw2uBJzMfNc3iu9ijGnCJLe9ZrF2E5LHdPFwOt85cO2C4NPbkWy
         53yXtc96oEy9KtP++O6Cs7H+fxaahudc65w39N67VPvBOzuYqL4g4suj5bA7bT0RwCGZ
         +h5t8WJ/y6HxsJErIrAk6yV9EygFOMA2mFsxi05Q02DXop5yissxqLLwlYvZgaYvivMJ
         gfPQ==
X-Gm-Message-State: AEkoouviAFjQ0H1wg+hYWdsPIcg7HB8CInmN8j608slRbt5qjaitjwAqtDUj4FDb8Sns1YR7rnKheYWIqwrMqA==
X-Received: by 10.36.213.131 with SMTP id a125mr1214698itg.14.1471544983745;
 Thu, 18 Aug 2016 11:29:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.36.253.71 with HTTP; Thu, 18 Aug 2016 11:29:23 -0700 (PDT)
In-Reply-To: <CAGZ79kZeSwteU84-=GZ0cZDCJUf6=VrGzAiNqC_gx7DgTQX-8Q@mail.gmail.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-3-jacob.e.keller@intel.com> <CAGZ79kZeSwteU84-=GZ0cZDCJUf6=VrGzAiNqC_gx7DgTQX-8Q@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 18 Aug 2016 11:29:23 -0700
Message-ID: <CA+P7+xpEDy5xqNp=tFGauE7+N2hnaGgzZKr2neM2p6G6kvchWQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] graph: add support for --line-prefix on all
 graph-aware output
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 18, 2016 at 10:56 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
>> - if (!graph)
>> + if (!graph) {
>> +         graph_show_line_prefix(default_diffopt);
>>           return;
>> + }
>
>> -       if (graph_is_commit_finished(graph))
>> +       if (graph_is_commit_finished(graph)) {
>> +               graph_show_line_prefix(&graph->revs->diffopt);
>>                 return 0;
>> +       }
>
> This seems to be a reoccurring pattern, i.e. we need to add a lot of
> one off instructions before a return. Is it possible to make the call
> earlier instead
> of just before the returns? (or later for that matter) ?
>

Not sure what you mean by this...? Just move the call up above this? I
think that will work, let me give it a try.

Thanks,
Jake

>
> Thanks,
> Stefan
