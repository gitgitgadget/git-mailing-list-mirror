Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F18141F461
	for <e@80x24.org>; Thu,  5 Sep 2019 21:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbfIEVk3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 17:40:29 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40203 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfIEVk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 17:40:28 -0400
Received: by mail-pf1-f195.google.com with SMTP id x127so2766389pfb.7
        for <git@vger.kernel.org>; Thu, 05 Sep 2019 14:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B5J8L96YiWXVkPWrVNGbztCdGPe1bRDZ80Yzho6QwKo=;
        b=i8Dt0z59MPH52Q0yYC6OxLYPjWaral1NtH525JlmvbKnwTxV7mtGP6aqX0SyprsMEA
         w13mDV95eLxQ7GUeC4+xZxPXTjKoMx9dWrIVI6JFS4qhpLhY5hmzqGqGA/4jZL1qq3B2
         X+Oad/9mSHBsmRY0DMdbsJg9572a9MgL0BRaLWDDKCt5/w9wux4dHhD4+EaPE5ZnraWX
         HBbfozZjsiQ+vRCWy+S99Sce2oAOhaD55EO5IiKdqy6TsGrzdJIkGwe0amRprtcEtKG2
         eZB32PMmn9MssZh6AygfhcsPKwmSlQTGLNKpLlz03mF0aERSoSHqZYM58s0xIbh9b+ZF
         FDZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B5J8L96YiWXVkPWrVNGbztCdGPe1bRDZ80Yzho6QwKo=;
        b=R+cQo0MobAPRc6HF47kGuG1Xa5/x3J2CI4gRsWkVKcFkfaLPratbLnbzpLcFCiDqDV
         8OnXSGurptRVdFsvyc8xBZtxDWoobJyh+kYCztmkioW/8rR5uft9udrI97b04N4OdrLv
         m64V9sLULf4rbjSijg5mQ035aXM/hW0xO3dcEPXK9xxV3uJwoPQRjlc3mKnAmkP+rpLI
         Jqbe/ImohD382KdnyER8yh3KTuhraSiyGJWvUnNAlm/bIU9IgOHe8Sp4lqM+O/wppC5O
         T0IpTS+q3ByuZ7lFIfPJRBIvZ3G6OAbeMlzKaG2d/n9WiqXZuwBA/TUD1UOhguha5aXL
         287A==
X-Gm-Message-State: APjAAAVXAZTxSRG8QvEZL1pOvZrNF7ih91AT1d8NMSEwdx9nHETlYTjJ
        oJbVjrVoBysGOv+fKju3SDQ=
X-Google-Smtp-Source: APXvYqzZ3HmlYM1AwXmHoxLUmpBY8LDlQ6Ywga3y9lO8mc9qS5WMZuM3mpAiAbixXm6DTznGmVbVhA==
X-Received: by 2002:a62:e10a:: with SMTP id q10mr6539947pfh.236.1567719628134;
        Thu, 05 Sep 2019 14:40:28 -0700 (PDT)
Received: from dentonliu-ltm.internal.salesforce.com ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id s5sm3306384pfm.97.2019.09.05.14.40.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 14:40:27 -0700 (PDT)
Date:   Thu, 5 Sep 2019 14:40:25 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 00/13] format-patch: clean up tests and documentation
Message-ID: <20190905213933.GA62578@dentonliu-ltm.internal.salesforce.com>
References: <cover.1566635008.git.liu.denton@gmail.com>
 <cover.1566878373.git.liu.denton@gmail.com>
 <20190904112105.GA27933@archbookpro.localdomain>
 <xmqqef0uplex.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef0uplex.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 05, 2019 at 12:56:06PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > Hi Junio,
> >
> > I see that "dl/format-patch-doc-test-cleanup" currently has the comment
> > "Expecting a reroll." This should be the reroll that you're expecting ;)
> >
> > Also, since there haven't been any comments on the topic in a while, I
> > propose that it should be ready for inclusion.
> 
> I may be the only person who had issues applying that series from
> the list, with mixtures of iso-8859-1 and utf-8 causing troubles,
> but if I am not alone, I suspect that the reason why nobody gave a
> comment is because the patches did not even apply so there is
> nothing to base their comments on.

Which patches weren't applying properly? I managed to apply both the
patchset I had locally and a fresh one I downloaded from public-inbox
and both applied cleanly.

> 
> I wiggled them and compared the result.  The range diff against what
> has been queued seems a bit different from what you gave below
> (e.g. I see log message got modified on patch #2 and the dropping of
> the comma made it harder to read), but the endpoint diff looks not
> too bad (IOW, the alloted time for the topic ran out before I
> started looking at each individual patches in more depth).

Hmmm, I don't think my workflow uses your topic branches properly. I've
been range-diffing against the previously submitted patchsets but it
seems like you expect a range-diff against the actual topic branch.

What should the ideal workflow be? I've been avoiding working directly
from the topic branch since that would require me to manually remove
your SOB line whenever I generate new patchsets. I guess I could
manually remove your SOB line from each patch manually. I dunno. Any
ideas?

Thanks,

Denton
