Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B75E2047F
	for <e@80x24.org>; Sat, 29 Jul 2017 16:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbdG2QK1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 12:10:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58973 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752599AbdG2QK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 12:10:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B120FA5117;
        Sat, 29 Jul 2017 12:10:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XN0xgCGewvEFHJ3TR4pltaalL1M=; b=Dhkwot
        x0il7ruacImGLM5OMKMcoxWgdSCrZGT51PkXWgXyr8F6sLekKgolILc/+Sa9sLaO
        LLajrNBVtw62YCHx0l0j5QukY3tNrjHSI8L+Jx7uwM1rDPms3EyBEMMUsDYXEdEr
        eqaLvB6joNZGZW1lkjIaS95GaQad63Pzzu7/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HksBXCA4bSQmigODWIq5t7yuY+Lfh+V+
        DJrkcNhLNRm814I3ugeW+DPwGnUpyyzsRnyp4zfmomH88hU8kl0AbT90XUDlB3ZJ
        dLmOv+0/cpuPxA+xZwVqTA1bNk3s4iY7bTW8ijn9Xu9We2SxtX2LHRu9UyRy3WRm
        S68vFXucOTQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A7C13A5115;
        Sat, 29 Jul 2017 12:10:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 15B64A5114;
        Sat, 29 Jul 2017 12:10:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] setup: update error message to be more meaningful
References: <0102015d7ae53b0a-a6505296-9257-4b0d-84d6-2152e17eb070-000000@eu-west-1.amazonses.com>
        <20170725212110.GG13924@aiede.mtv.corp.google.com>
        <xmqqlgnbq7sc.fsf@gitster.mtv.corp.google.com>
        <1501296270.2112.2.camel@gmail.com>
        <xmqqefszlx0e.fsf@gitster.mtv.corp.google.com>
        <1501330390.2001.1.camel@gmail.com>
Date:   Sat, 29 Jul 2017 09:10:16 -0700
In-Reply-To: <1501330390.2001.1.camel@gmail.com> (Kaartic Sivaraam's message
        of "Sat, 29 Jul 2017 17:43:10 +0530")
Message-ID: <xmqqy3r7jkbb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 69FB2EAA-7478-11E7-9041-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Fri, 2017-07-28 at 20:53 -0700, Junio C Hamano wrote:
>> Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:
>> 
>> > Though the message seems to be most fitting one, I'm a little reluctant
>> > to use it as it "might" create a wrong picture on the minds of the user
>> > making them think this would be the case in other cases too, which we
>> > know is not true. For example,
>> > 
>> > 
>> >     git log -p --full-diff master --stat
>> > 
>> >     git commit -v Makefile --amend
>> 
>> These are accepted not by design but by accident.  
>> 
>> I do not think we even document that you are allowed to do these in
>> "log" and "commit" manual pages, and we should discourage them (I do
>> not even mind eventually removing these with the usual deprecation
>> dance, but I do not think it is worth the noise).
>> 
> That's interesting. In that case, I'll go with the suggested statement,
> happily!

It is not interesting at all.  It actually is disturbing that you
had the notion that these are "valid" command lines.

We perhaps need to somehow make sure new users won't be led to the
misunderstanding.  Improving our documentation is a good first step.
We might want to have a group of volunteers who actively monitor the
internets (e.g. stackoverflow and other places like that) and
correct people who spread the same misunderstanding when they do.


