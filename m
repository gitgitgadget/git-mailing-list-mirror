Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EDA520282
	for <e@80x24.org>; Fri, 23 Jun 2017 18:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754781AbdFWSof (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 14:44:35 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36130 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754327AbdFWSoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 14:44:34 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so24449233pgb.3
        for <git@vger.kernel.org>; Fri, 23 Jun 2017 11:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=sk+TlJb6Sx+YwT99V4BnsGnq/GMakUf+jVImx6/Y9Zs=;
        b=D873iVODWZ22T7b6f6bPB5aO8gGxK7Z9ndw7kqCdQMBg2QkqZZGXzLTKgIZjJtyglE
         C8e0UQPPyN2W0vE59rAgyTJcbJINWClQxDXwKCqY2qIekYGnNNY6dGeJPfvmnuZs6hdg
         DamAj6/A1yAfaXI6psDkSBdVjz1yBxNov/gKjcnoJ9GHJg+MGyH3/0W1lxvPOGtIP2QG
         CyxnXkg19Dyq0dpUNBzqX1nlhoSnruznaO7a+dUT8bV4FFAMcuuVnNUi33KTBfT7qpda
         7FHzFVaYvAGOyHoVhOre/IKIsYWrSl3+vuZBsORjc11quQcAuFH/tPevtdNxeKWTl+uy
         EfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=sk+TlJb6Sx+YwT99V4BnsGnq/GMakUf+jVImx6/Y9Zs=;
        b=PdXJ+DiT3nL1zNVxf/yGIEh7D6KePZBgeSbbasS+pwziTMdAxGo4CTbcR67Pk7ntp3
         pyviYYCuKbIwgLGHWEJmb83nptPmvm7tZnRVmxYp4N5dcE3EnGbTBNr3bBpQWjPqCYD8
         JQoSgMSjSW/DMihkPnbzptwD6KR/ntxc18/MXAT89asySRoKtyoniFgzCCyTWraeYvbZ
         9n/hl6Nxx7R9MHNkJ6AwlAd7VoTPhXq/P3jyFpgZQGkagGfRQoOeFxLVkYnNNQIiCk4X
         9q6f0b9Y6RXuIGc3CiCFZRbqbol4ruH7+K3z4elOnvCvOmaZijBMAqgAZW99IRraBaVw
         P5nQ==
X-Gm-Message-State: AKS2vOyywoDJ9xs1MiYH5QeSM6Yw5lJFN1lJeVnr7vDxske6tieC7mj5
        vSaBFhOA2WoE0g==
X-Received: by 10.84.128.67 with SMTP id 61mr10907651pla.246.1498243474088;
        Fri, 23 Jun 2017 11:44:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4cd0:d6d2:1e09:4052])
        by smtp.gmail.com with ESMTPSA id f8sm11746748pfc.14.2017.06.23.11.44.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 23 Jun 2017 11:44:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Simon Ruderich <simon@ruderich.org>,
        Patrick Lehmann <Patrick.Lehmann@plc2.de>,
        Jessie Hernandez <git@jessiehernandez.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: your mail
References: <7c277ac1cfb40b9b362d468a94dfb4fe.squirrel@mail.jessiehernandez.com>
        <20170622124803.45sduodpfbwuuq52@ruderich.org>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102A3D5@SBS2011.opfingen.plc2.de>
        <20170622134708.fcc4zxakga6p255x@ruderich.org>
        <0092CDD27C5F9D418B0F3E9B5D05BE080102A423@SBS2011.opfingen.plc2.de>
        <20170622204628.eintlap4uchlncub@ruderich.org>
        <xmqq8tkjiu3d.fsf@gitster.mtv.corp.google.com>
        <878tkjk7m7.fsf@gmail.com>
        <20170622232156.vptuoafdtglokujw@sigill.intra.peff.net>
        <xmqqshirffay.fsf@gitster.mtv.corp.google.com>
        <20170623165347.s6byszwdps34ntzv@sigill.intra.peff.net>
Date:   Fri, 23 Jun 2017 11:44:32 -0700
In-Reply-To: <20170623165347.s6byszwdps34ntzv@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 23 Jun 2017 12:53:48 -0400")
Message-ID: <xmqqvanmee7j.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Jun 22, 2017 at 10:23:17PM -0700, Junio C Hamano wrote:
>
>> Otoh, "community" page does not encourage subscription as a way to
>> ensure you'll see follow-up discussion, which may be a good thing to
>> add.
>> 
>> A tangent I just found funny is this paragraph on the "community"
>> page:
>> 
>>     The archive can be found on public-inbox. Click here to
>>     subscribe.
>> 
>> Of course clicking does not take you to a subscription page for
>> public-inbox, even though the two sentences appear to be related.
>> 
>> Perhaps swap the order of the two, like so, with a bit richer
>> explanation taken from Ævar's version:
>> 
>> 	... disable HTML in your outgoing messages.
>> 
>> 	By subscribing (click here), you can make sure you're not
>> 	missing follow-up discussion and also learn from other
>> 	development in the community.  The list archive can be found
>> 	on public-inbox.
>
> Yeah, I think that's a good suggestion. Do you want to phrase it in the
> form of a patch? :)

OK. Letme try.
