Return-Path: <SRS0=iF2w=72=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F77C433DF
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 16:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50645207BC
	for <git@archiver.kernel.org>; Sat, 13 Jun 2020 16:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yEyzYyvw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgFMQoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Jun 2020 12:44:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65033 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgFMQod (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jun 2020 12:44:33 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 56DF465EBF;
        Sat, 13 Jun 2020 12:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ryHKNvDAcKJ5MfbkT3QwWdKysPc=; b=yEyzYy
        vwm7x8/zt05ZhLaa7h+KrwaIw3ghE9tVG7OghEB65P2s/1rw4acTuZe1jnQ/cNkg
        cpp0DuQBhycYqOPx6qJDzs1Yd78ZNjnTc51BI/5SPZjCl440soza/L+xk8M6Oh9B
        OJfIqyq37P7DTkC/KWJul5Ny1RdFHm39RXIAI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R688USyQlpkY/DaQkeM9XpY16wYsimhZ
        oKSyF9QULrOxgakX+MGz16GaIC8+2+IRezggV5hS7Nmvh6OBNkThynOmH/GL4D4n
        UD8Tfl3b1zxTaWP62ONrECtdmOaMl9hB8ksEhMJJOsU3+NMMvHrlWR/JmGQvvWH+
        EFBdMBO8hw0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BC1665EBE;
        Sat, 13 Jun 2020 12:44:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A883D65EBD;
        Sat, 13 Jun 2020 12:44:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     "Curtin\, Eric" <Eric.Curtin@dell.com>,
        Christian Couder <christian.couder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "Geary\, Niall" <Niall.Geary@dell.com>,
        "rowlands\, scott" <Scott.Rowlands@dell.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Collaborative conflict resolution feature request
References: <BY5PR19MB3400EB9AD87DFE612AFD5CC390810@BY5PR19MB3400.namprd19.prod.outlook.com>
        <CAP8UFD3m9ANt6UOyOoMDy2haTJjhzL5ctFiki46ktgH3RLPqjA@mail.gmail.com>
        <BY5PR19MB3400AE170C9F5FF501D27B18909E0@BY5PR19MB3400.namprd19.prod.outlook.com>
        <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email>
Date:   Sat, 13 Jun 2020 09:44:30 -0700
In-Reply-To: <432b9e0b-eedf-6d39-ebc0-0416f8574afc@iee.email> (Philip Oakley's
        message of "Sat, 13 Jun 2020 14:14:32 +0100")
Message-ID: <xmqqmu56zzip.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 272B29FA-AD95-11EA-A023-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Maybe have a parallel 'merge' branch that is used (say weekly) to do
> trial merges and will essentially record the conflict resolutions while
> they are fresh in folks memories. That branch is distinct from, either
> of the two main branches, but will act as a filter and a hand rail to
> highlight future difficulties."

An aside that probably would not directly help Eric, but I know the
above workflow helps reasonably well.  The 'pu' branch is rebuilt
not on top of 'next', but is rebuilt with all topics (including
those already in 'next') in flight directly on top of 'master',
which serves as a way to anticipate conflicts that will require
resolution in the future before the topics can enter 'next' branch.
And these resolutions are ...

> Also look at 'rerere'.

... remembered in the rerere database (and even trickier ones that
rerere cannot handle are recorded in the merge-fix commits, but that
is a separate story).  When topics are ready to be merged to 'next'
and to 'master', the correct resolutions are likely to be known and
the result tested in 'pu' and 'next', respectively, for some time
already.
