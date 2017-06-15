Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0B4520401
	for <e@80x24.org>; Thu, 15 Jun 2017 22:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751812AbdFOWAf (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 18:00:35 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36236 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdFOWAf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 18:00:35 -0400
Received: by mail-pf0-f179.google.com with SMTP id x63so13255606pff.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 15:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6omjIYBj4myKNMvSxw+YB9fpWWN3t8rOI7N2h3Q0KuY=;
        b=o4SIfdg5w5Cdt3wtUfXBiGwNoSfiiSqmsFb+KkWYNYRfiUVUhCDIgvl/29o0Y4d4Jp
         rQg7CyHDvx5MAZ1gPFt0dEYAe7B4F5wCgUfSk6iXZiV4nQljNFA16EjCzKnxPoUv2I1n
         Mn9emi2bv7W3LIkcVARs3tcNzo5Z0924rQ0lGPFOSZ34mOo9Ci/2/VVtSeXrCSIcHkgf
         ygLjoz+of74rMxmGOI+4meMTX5GLms3GR2JbwT/PSA1unS3CEcCVnW6cHkoQPTMdOTPs
         HuVF+J1mYHqik2mk5vclRlTRxGtZ+9gkueuN0/53QADCE8e98hVCj43Q/IdkaCfF8cGc
         oJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6omjIYBj4myKNMvSxw+YB9fpWWN3t8rOI7N2h3Q0KuY=;
        b=eGnIRWTtf+ASNTqn/bVwTOHOzx8sUJmB7/m0gxizwkI7hE1UrbVrs9+t+2uU/PISzl
         Ps9ezsHhZrD6ySryTpQ6DR+2JqqbHlUOnmCom1X4WMa1dV/2CaTGKoQG8yp/jZeUnACH
         CfYciHMPnPbk5U0bkhAuRkGgyAJ/n9sjLjRkaRAxvyUVlu/mdkzjHaqhOo6YzPiaUzhX
         DDj6jBhK7PQfYHg0iObDcKdifa2cmwr2WGH2tWemEZQfanZKW2KOOy6ebi43iuXM9yht
         20DuSbH7NmsH3kchZZJ/fZZV1BFCkpRvrAEYK0PDPaJ7vUaKGL2dAM/OXwl09Gkj1S2X
         sNqA==
X-Gm-Message-State: AKS2vOxOK7yra+5xRDJwhrawoiI3qkyJoLjpVWgql7WVlKBKonuYJxmi
        UFYqfQhD/PfNQQ==
X-Received: by 10.98.163.25 with SMTP id s25mr7442593pfe.217.1497564034116;
        Thu, 15 Jun 2017 15:00:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id s9sm477627pfe.21.2017.06.15.15.00.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 15:00:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v3 0/2] Add a FREE_AND_NULL() wrapper macro
References: <CACBZZX7S9A=mPSgqtmVyZbLdR3GVH+ux3tGN1QXBMEzbg8Ffog@mail.gmail.com>
        <20170615210700.16310-1-avarab@gmail.com>
Date:   Thu, 15 Jun 2017 15:00:32 -0700
In-Reply-To: <20170615210700.16310-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 15 Jun 2017 21:06:58 +0000")
Message-ID: <xmqqa858zzb3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> On Thu, Jun 15 2017, Ævar Arnfjörð Bjarmason jotted:
>> I'll change it to FREE_AND_NULL and submit my patch as-is, my reading
>> of the rest of this thread is that making it a function instead of a
>> macro would be interesting, but has its own caveats that are likely
>> better considered as part of its own series, whereas this just changes
>> existing code to its macro-expanded functional equivalent.
>
> Here's v3 with that change. Nothing but the macro name (and comments,
> commit messages etc. referring to it) have changed.
>
> Ævar Arnfjörð Bjarmason (2):
>   git-compat-util: add a FREE_AND_NULL() wrapper around free(ptr); ptr =
>     NULL
>   *.[ch] refactoring: make use of the FREE_AND_NULL() macro

Thanks.

Perhaps somebody wants to do a follow-up patch on top of these two
patches to add .cocci rule e.g.

	@@
	type T;
	T *ptr;
	@@
	- free(ptr);
	- ptr = NULL;
	+ FREE_AND_NULL(ptr);

so that we can periodically sweep new candidates, to which this
macro can be applied?
