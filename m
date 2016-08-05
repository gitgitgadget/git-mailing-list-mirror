Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20B522018E
	for <e@80x24.org>; Fri,  5 Aug 2016 21:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1949023AbcHEVYG (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 17:24:06 -0400
Received: from mail-yb0-f196.google.com ([209.85.213.196]:33548 "EHLO
	mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S3000976AbcHEVYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 17:24:03 -0400
Received: by mail-yb0-f196.google.com with SMTP id e125so1620502ybc.0
        for <git@vger.kernel.org>; Fri, 05 Aug 2016 14:24:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=VNTFAnv3EbMILaqCuE0PC+Y/hhXPS6S/OnllsK3PpKc=;
        b=HRpZoBGyGHZvBKkOz5pQUmwtNMMoBcWzWYVLd952HjjBrMbi59qGowV7C3bMcXUMNC
         NH9ZUarPHnu40E1VRPTqYDfTXtu6QcasySG4lJ45HbyZblz0pfM15CIxIGZlYnsePUPo
         4rCCv5AqM1eOtpcrgMiUtcPGqMIT6xnbLhiC2Es6OKdFu0/LVxXaf4YFwayeS2md9vvV
         aXKtjffEqsOYmR27slu74BoU/r4BqEb/KlIcffL/OJDi+VqsiOr0NsYNxEGLmEbZBseO
         3uobzvA9ahFt9nvcoBXoAH14kynFmENYiCnfOBprR/Acz53Z03NODhjjh46ajGgpwZcD
         M9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=VNTFAnv3EbMILaqCuE0PC+Y/hhXPS6S/OnllsK3PpKc=;
        b=S0ro+iEeqb30gQiWHlk8+OQXbmwsk0EV/WRH5YS1oVL1Ie4UF/1EvxCy4fMIrmSd+x
         8X95kjNgu9RVs8DZQngJNqdTVCDXQLKDD+1Zav5njcC6d0luKZlfUOFhfyPGb01/PWm/
         +fNbG2BrjZx7XmtXewGoPr4KgJ2GhCf3onDGwBMnBuDBLWzmaI/XW3JlKSf4VUdGtYKy
         I29lOtwGVwy2wDQ8MSOumD1fGmpCxpRyDfoCj188pNxdhG8isWqBdtnl7AtmB9gudueU
         1Ox4k0OpUwAoSKD2osytJsAmJllbTYdNEdWreLG3+0cwh2aihTKjlNszC+lKiYa79Ky/
         s9kQ==
X-Gm-Message-State: AEkoouuPHL1jrUucsty/pooSuxumsR95RbilXOpC/vePzf0wJPEaZlyQbwhaEjQh0ceGaqWBrmu7m5cs34eGzQ==
X-Received: by 10.37.66.147 with SMTP id p141mr27288997yba.28.1470432242623;
 Fri, 05 Aug 2016 14:24:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Fri, 5 Aug 2016 14:23:42 -0700 (PDT)
In-Reply-To: <10752620.2J2dEZLIGc@mfick1-lnx>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <20160804234920.GA27250@redhat.com> <xmqqy44bxm0h.fsf@gitster.mtv.corp.google.com>
 <10752620.2J2dEZLIGc@mfick1-lnx>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Fri, 5 Aug 2016 14:23:42 -0700
X-Google-Sender-Auth: jErNsnRv6pqK-3T-5Po7N-jDpmY
Message-ID: <CAPc5daV51cwPs-8uc_SYLaod7RB7aDGYbjt-x-JsY1qNL81QRA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Martin Fick <mfick@codeaurora.org>
Cc:	"Michael S. Tsirkin" <mst@redhat.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>, repo-discuss@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 5, 2016 at 2:20 PM, Martin Fick <mfick@codeaurora.org> wrote:
> On Friday, August 05, 2016 08:39:58 AM you wrote:
>>  * A new topic, when you merge it to the "lit" branch, you
>> describe the cover as the merge commit message.
>>
>>  * When you updated an existing topic, you tell a tool
>> like "rebase -i -p" to recreate "lit" branch on top of
>> the mainline.  This would give you an opportunity to
>> update the cover.
>
> This is a neat idea.  How would this work if there is no
> merge commit (mainline hasn't moved)?

Sorry, I do not understand your question. You always
merge into your own "lit", which is based on (some)
version of the mainline. If a topic builds on top of the
mainline, you "merge --no-ff" it into "lit". Because no
merges on "lit" will be part of the future mainline anyway,
even the project frowns upon a "no-ff" merge, that will
not be a problem.
