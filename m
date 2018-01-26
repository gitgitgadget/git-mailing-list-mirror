Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E57811F404
	for <e@80x24.org>; Fri, 26 Jan 2018 14:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752585AbeAZOQl (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 09:16:41 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:40922 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeAZOQk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 09:16:40 -0500
Received: by mail-ot0-f173.google.com with SMTP id x4so514690otg.7
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 06:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yvIQdgnTxqzXjhlzbM9GdkDzRLLxRG/RwjQ4Zq5bXc4=;
        b=YutknCGHusUpAIaPlhnwRGBO/eZcpR5eI9T8CsjLeezFumfh1OJJtQW6shh9Tvg1Ir
         SJ+uGjobt6cLeP0gU9YDYZwDup555nJBSSC3FfCvK2P68fQTt5LP0s/vSUDzEC64y2+v
         bBSIIft+dz34wKN/Ts11y0hLOgMAEetvrnZOZaAmBsdLXRi37Nc2whyDK41MlMoVKo81
         m9B3EC6nwf/51NlUUKox1OHkzihn1QvsqkWg5Jtm+9c7wFZgk4eUDdCi35qNm0a744jd
         pugTwe+EOKEgVc+Ff//317VO9hYSDtKCovQznAPVt2VKRSFIU0OBRfnj8Kv1RsdMuhrp
         dTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yvIQdgnTxqzXjhlzbM9GdkDzRLLxRG/RwjQ4Zq5bXc4=;
        b=GUNNqZpxhadxAExpNV3BSsYVZVNMMTInHheJOsEi196q6KBwXJ4J8vIYqZtZQhzZYA
         yRK24PcEM1+M/WOPhu5x5sHU5rApGOLgaDNPDsB2L3VTSl2DupCxFw/UFfOx6oUONrw5
         Hm0owIbq16GWLNCfIVKvx3RWCgsaOhn/CxWGD1YJzqfckMCwrGVCLcSbaHADeg+pmlz/
         tqrZB4EKtg4i0TYDO7oU76tpgijI/WyN5/sOaPg+yUZoeNer4tTjAiHswwgJynhRgAev
         rDTOZU7D7mJIW38QOlNdmrJTenm/X7pP/tfYa8IRjRaElj6Us6tGyddM7P/o28HufoxE
         E0tg==
X-Gm-Message-State: AKwxytd/v1vbWIzxUkQ/RrZ5ak/C4YtOYt7Zyp6A941jlFGQMULcIMvU
        ITp/RW458cOEhuvf7M5Ds6fhymAfxHSs5QUJVcM=
X-Google-Smtp-Source: AH8x226E/qwxgfric/uZRkzRTeYufPCIW1LNrsf6eBsDghRTraeUpH16RLZkYQ6dz7Jf1rteTPkvjgTPLqDjGBHYtDg=
X-Received: by 10.157.14.65 with SMTP id n1mr14629656otd.337.1516976200234;
 Fri, 26 Jan 2018 06:16:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.144.218 with HTTP; Fri, 26 Jan 2018 06:16:09 -0800 (PST)
In-Reply-To: <37d84775-174f-02fc-159c-0810df458b5a@gmail.com>
References: <20180125140231.65604-1-dstolee@microsoft.com> <20180125140231.65604-4-dstolee@microsoft.com>
 <xmqqinbp8rw3.fsf@gitster.mtv.corp.google.com> <37d84775-174f-02fc-159c-0810df458b5a@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 26 Jan 2018 21:16:09 +0700
Message-ID: <CACsJy8BS3Gi2rZq=JXz+o+g4cOJCg0sKShqSG0p9kFXCjwNtWg@mail.gmail.com>
Subject: Re: [PATCH 03/14] packed-graph: create git-graph builtin
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Stefan Beller <sbeller@google.com>, dstolee@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 26, 2018 at 8:14 PM, Derrick Stolee <stolee@gmail.com> wrote:
> On 1/25/2018 6:01 PM, Junio C Hamano wrote:
>>
>> Derrick Stolee <stolee@gmail.com> writes:
>>
>>> Teach Git the 'graph' builtin that will be used for writing and
>>> reading packed graph files. The current implementation is mostly
>>> empty, except for a check that the core.graph setting is enabled
>>> and a '--pack-dir' option.
>>
>> Just to set my expectation straight.
>>
>> Is it fair to say that in the ideal endgame state, this will be like
>> "git pack-objects" in that end users won't have to know about it,
>> but would serve as a crucial building block that is invoked by other
>> front-end commands that are more familiar to end users (just like
>> pack-objects are used behind the scenes by repack, push, etc.)?
>
>
> That is my hope. Leaving that integration for later, after this feature has
> proven itself.

Then I suggest you use a more specific command name (commit-graph?
packed-graph?) and leave the pretty name "graph" out, it could be used
for some UI-facing thing someday, maybe.
-- 
Duy
