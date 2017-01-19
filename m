Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC7FC20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 20:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754573AbdASUg6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 15:36:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57687 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752433AbdASUg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 15:36:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A704B60E7B;
        Thu, 19 Jan 2017 15:32:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BI9pTWLgHcwoNYMsd20f3pYFgNY=; b=OvdY4I
        773NNliwIiVK2MHl748DYhTGNkdS2K6083VJH3lBQUiCwvMMyeYHMuduCAGWUA6J
        0B+Vjp+SyfllYkqzuJyNt3cfQMPWd5cfFkbvzIJXAmpYmV0lFzrvzmH+NpsUeate
        i36A0LLwMacDGadwNUuScDablw6A64Ea1kwds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kHU2KhdtJKS76/rCRVB8dIqsPC2d65JU
        9EXmMKgzhayo+Qvkd2lr9PiTjqWg2zlzDVz/9mTJUjoRcWINH6NGGmc7bFpTCwgX
        WDVzjDfYfwLv2mOP6Fw9NsjSY9cKsJvt+VZ5uC0yLk101ULjM4gFDWjbG5L3Yk8G
        1FLZ+Yiw40o=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9CF0D60E7A;
        Thu, 19 Jan 2017 15:32:40 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E4E7160E79;
        Thu, 19 Jan 2017 15:32:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Michael Gooch <goochmi@gmail.com>, git@vger.kernel.org
Subject: Re: problem with insider build for windows and git
References: <1bddbd50-86ea-6c38-6ab8-08336de2ba72@gmail.com>
        <alpine.DEB.2.20.1701131300390.3469@virtualbox>
        <alpine.DEB.2.20.1701181738490.3469@virtualbox>
        <xmqq8tq8b4mr.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1701192032330.3469@virtualbox>
Date:   Thu, 19 Jan 2017 12:32:38 -0800
In-Reply-To: <alpine.DEB.2.20.1701192032330.3469@virtualbox> (Johannes
        Schindelin's message of "Thu, 19 Jan 2017 20:54:02 +0100 (CET)")
Message-ID: <xmqqshoezt7d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6BF4E706-DE86-11E6-B701-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> are there any other topic that are already in 'master' that should go to
>> 2.11.x track?
>
> Personally, I would have merged 'nd/config-misc-fixes' into `maint`, I
> guess, and 'jc/abbrev-autoscale-config', and probably also 'jc/latin-1'.

The "almost ready" pushout were merging the ones that have been in
'master' for weeks (including that mingw-isatty topic).  These three
are still on radar, but they were too young and that was the only
reason why they were not included in the batch.

> The 'rj/git-version-gen-do-not-force-abbrev' topic would be another
> candidate for inclusion. The 'ah/grammos' strikes me as obvious `maint`
> material, as well as 'ew/svn-fixes'. 

I am holding back rj/git-version-gen-do-not-force-abbrev from 2.11.x
before 2.12 is released because I am a bit reluctant to tweak the
release infractructure in 'maint', before the same tweak hits
'master' and produces a release.

The second one will involve translators and that is why it is not
marked for back-merging in the draft release notes.

I agree that the svn thing should have been merged to 'maint' in
that batch, but I missed it.

> Having said that, these are the topics that *I* would merge into `maint`
> if I maintained Git. I don't, so this is just my opinion, man [*1*].

Yes, your opinion was exactly what was requested, and you gave one
;-)
