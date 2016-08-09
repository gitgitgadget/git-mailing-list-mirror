Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499501F859
	for <e@80x24.org>; Tue,  9 Aug 2016 23:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbcHIXGd (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 19:06:33 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:33838 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932521AbcHIXGc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 19:06:32 -0400
Received: by mail-it0-f65.google.com with SMTP id u186so1938710ita.1
        for <git@vger.kernel.org>; Tue, 09 Aug 2016 16:06:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=tOK7jg/u3KOj/IjB6r9APVP5Hti5ljoZHIoue7fE+oc=;
        b=hRrIb2PLXZElPZ5qvOORnzlXcUAKKkA2DdtamaNg/NQUqWBUvp7Aa8AvboU2cr89OZ
         aVEsWjw1Pxlz9COgIewCfbw9X3z4aOPBHd6kvTQW1AVnLRaJLRlYV/LnrveuzoVrTy/Q
         z5dmwhXOGkHyMshvTS+rV/KAomkvnaLaH1aLOv5dInscZCM2VkJtRiyCE20b657ej5xY
         ya1/mp+8t3lmO9LzA/YRu1kB4Hj1V0QaG3Pr2LTcB/ihdQ2/kMQU4AFY71Q+0UlpCzpo
         vncK6ornVJCMwNOXit+IrVpCclA/ndBX+U8R6KXbOiQw2wdJvmFHh1leZ+8Ki7YEJPcn
         9hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=tOK7jg/u3KOj/IjB6r9APVP5Hti5ljoZHIoue7fE+oc=;
        b=JuzlI/Okdx4HP1b0II8YNNH4NBsQIqWVk12+1/GLlX3O/73U8pNH17ovy1LaZ1WZyR
         aec+wmcs7/CCS1Tev26tuLldPpJgZ145NsJ87kV7Cg5778+b2v38X3EMdDMlIFXYyb1o
         ab3s4HSK9JHK8PUvKcA202L3aJfv8IigYYs6pJx8bcHgqRtWwhVpxxtYhueanIflkQ+Y
         jdC5Hdxmryo7rZmYLRSKhJBq2tML02ZWL5lDieZryxX8Vp6WcZ2h93EaJ+sJItUKW3tE
         hT7eqSOqOS8AKzvtn9yfkhPPE/PvgbWRIMUcfa3tCCJf9UJCyABC0re8AEG/Nonk6jEG
         7Rkw==
X-Gm-Message-State: AEkooutBNpWGV+76LADizUgILRqgN0MlASq0rR5ld0xuJ6UYazhSe1Wf6yeDGKaDndgtIv1oJEB/T69NxCdDOg==
X-Received: by 10.36.54.135 with SMTP id l129mr1845548itl.73.1470783991687;
 Tue, 09 Aug 2016 16:06:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.130.1 with HTTP; Tue, 9 Aug 2016 16:06:31 -0700 (PDT)
In-Reply-To: <xmqqd1lhc05n.fsf@gitster.mtv.corp.google.com>
References: <20160809040811.21408-1-sbeller@google.com> <20160809040811.21408-2-sbeller@google.com>
 <CAPig+cRnDVMBZzKOOS-fW+hNaCHhYRVLM+d_akZcB4H5iyqfKA@mail.gmail.com>
 <xmqqfuqec56x.fsf@gitster.mtv.corp.google.com> <xmqqbn12c55e.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZgEF2FBSLQnOm=v-a+jy=6aWyPBoLC9-QU=g-aUaqj3w@mail.gmail.com> <xmqqd1lhc05n.fsf@gitster.mtv.corp.google.com>
From:	Eric Sunshine <sunshine@sunshineco.com>
Date:	Tue, 9 Aug 2016 19:06:31 -0400
X-Google-Sender-Auth: Ah7W1pXgr-1MRa5H01N21Io0NKc
Message-ID: <CAPig+cR+3KWDK5r5YW-Ew0=0jvkGRM7r1SJA3O_7+SDSNmXmeQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/9] t7408: modernize style
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 9, 2016 at 1:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>> I originally thought that it may be easier to have 2 patches.
>> This first one is very gentle and "obviously correct" as it only changes
>> formatting and drops the directory changes.
>>
>> The second patch goes for renaming ans subtle style issues,
>> combining some tests, so it is more likely to break.
>>
>> After this review, I consider using just one patch and do it all
>> at once to not confuse the readers as otherwise I should reword
>> the commit message with the rationale of doing it in two patches.
>
> FWIW, I would think your split between 1/ and 2/ were very sensible,
> and have a slight preference for keeping them separate.

The review comment about renaming "current" to "actual" was made
without having looked yet at patch 2. Having now seen patch 2, I agree
with Junio that the existing split is preferable.

So, only the review comment about dropping space after '>' remains relevant.
