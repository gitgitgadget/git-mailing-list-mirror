Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DB4C4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51C2A23BF0
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391222AbgLKGAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 01:00:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59983 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395444AbgLKGAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 01:00:01 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 418F48B3E7;
        Fri, 11 Dec 2020 00:59:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=s6iCOwibXzboCRo0s5tegmmGzQg=; b=Yr36u5tsGkbVagFKNkEf
        MPV278h2WcvisVu3MnIPqv1mqvsGGvqBdtwJxTq5gvzuXhN0U4JMaJmYwNQz1kDN
        fxrpC4VoYKbvav9/LSTOegAN0h+AewhJDfOZ/IOtC4TGkK4a2yivcIUvOA5jfX9F
        8OlOxshssnW9Knb3+N3PIhw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=TMsKrlmnwVhjyAHbuiNs87t0+Us1gs4ZXncucQ3Di8Xd/m
        c9Vyr8RVRMEYAYaFQGJITRR+tt1MZ7n6wharksYkf6RtnmkU6hfFbNryLK0xhduW
        wLtZ8BYrunn18NxP33oQE5Hoc2YBzJoro1Ju4aKA+QeXzqFbZOoWVvTHUuzeQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 28A038B3E6;
        Fri, 11 Dec 2020 00:59:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AB358B3E5;
        Fri, 11 Dec 2020 00:59:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git <git@vger.kernel.org>
Subject: Re: fc/pull-merge-rebase, was Re: What's cooking in git.git (Dec
 2020, #01; Tue, 8)
References: <xmqqpn3j4ved.fsf@gitster.c.googlers.com>
        <nycvar.QRO.7.76.6.2012091502000.25979@tvgsbejvaqbjf.bet>
        <CAMP44s1dRKPtVr9Oazg_JR2WWMhNC_2rx7G4k3qME5FM4L4xTA@mail.gmail.com>
Date:   Thu, 10 Dec 2020 21:59:18 -0800
Message-ID: <xmqqzh2knart.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01C0479E-3B76-11EB-94FB-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The commit is prefixed with "future:" it's not meant to be applied
> today, but months after the previous patch, perhaps even in Git 3.0.

And when it is applied in the future, it would break tests because
they are not adjusted for the change in behaviour.  So "today" is
not the meaningful part of the above statement.  It is not meant to
be applied ever, as it is known to break the test suite.  It is
offerred merely as an illustration of a WIP, a preview of what to
come.

You may have meant it as such, but (1) we never use "future:" to
mean such a thing in this project, and (2) nowhere else in that
commit it says the patch is not to be applied.

So your "this is not a real patch to be applied" failed to
communicate.  Let's try harder to avoid such miscommunication next
time.

Thanks.
