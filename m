Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 873FC202C1
	for <e@80x24.org>; Tue, 14 Mar 2017 10:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750797AbdCNKIJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 06:08:09 -0400
Received: from gateway-a.fh-trier.de ([143.93.54.181]:46508 "EHLO
        gateway-a.fh-trier.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750770AbdCNKIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 06:08:09 -0400
X-Virus-Scanned: by Amavisd-new + McAfee uvscan + ClamAV [Rechenzentrum
        Hochschule Trier (RZ/HT)]
Received: from localhost (ip5f5bdecf.dynamic.kabel-deutschland.de [95.91.222.207])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: politza)
        by gateway-a.fh-trier.de (Postfix) with ESMTPSA id 4A6AF179AC63;
        Tue, 14 Mar 2017 11:07:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=simple/simple; d=hochschule-trier.de;
        s=default; t=1489486074; bh=J8jCWtgPaFKXtqisTabE9AxcDLI=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
         MIME-Version:Content-Type;
        b=XB9kpot6fjPZ29AO0IUTg03fMPKysB+7zmHbfOJIF4qnTvdssFxuA0M6rae1PnrDs
         ihROlPRXTCuHR+1segDAEIR1sB0q+TV0tFEEc0Af4nXpDbeaqoPXRxP1beN7rLwRIv
         eWe1gxnnxkvAVYvxNMgO/f1RetDEH7Od6GjSBEOA=
From:   Andreas Politz <politza@hochschule-trier.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: git checkout exit value and post-commit hooks
References: <87y3w8k4ac.fsf@luca>
        <xmqqshmgjt2j.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 14 Mar 2017 11:07:53 +0100
In-Reply-To: <xmqqshmgjt2j.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Mon, 13 Mar 2017 23:00:52 -0700")
Message-ID: <87tw6w9nnq.fsf@luca>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Andreas Politz <politza@hochschule-trier.de> writes:
>
>> the exit value of a `git checkout' seems to depend on the exit values of
>> the hooks it runs. This breaks for example `git bisect', as seen in the
>> following example.
>
> I am a bit puzzled why you have "checkout" and "post-commit" on the
> title, though.  Does checkout call a hook for "commit"?

No, just a typo.

> Any script that calls "git checkout" and sees it fail should not
> blindly continue its usual processing; if "git bisect" notices an
> error from "git checkout" it internally runs and stops, it is doing
> the right thing.

So its by designed, I should have guessed as much.

I'm sorry, I never used git-hooks before and spend an hour trying to
figure out, why I can't reset the bisect operation, while the error
message (something to the effect of "Unable to checkout master" seemed
ridiculous.

-ap
