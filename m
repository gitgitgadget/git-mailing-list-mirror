Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250BFC1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD1672072D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RiY2abiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCVXBy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:01:54 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54123 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgCVXBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 19:01:54 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 887F0D6D91;
        Sun, 22 Mar 2020 19:01:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EipFe5m1NuMCo9W/+aHTyjApa90=; b=RiY2ab
        ivXR27UevAiBSVSFB1WBvCtOl7okRR6vIg8Mo+Xc/qTLnTjtUFBjkT1/aYt4LnLx
        0AJKTZ9BB/1R4tKPxN/FJ5coJur8YI4EgTNu8gk1Sxg5N6I71WM6SAQf5vk8WI9f
        yTuIsdvb3vjSkWpHaUCw5hJe6w6FHU+SwHqdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZrKUb8eLmPlNSFbWsKoDdG/TPwcN8R6I
        qmQGvmFLZam5ueWTHlMpQVKaTk/7yM3KKX7Kw9HrCvORDCfElaY3/ABdVKqDtvN8
        2J2kLAY0hXgHv78D6AkAYpDE7U4x58QBFdyW/oVA0GajVQBwwdEP0zn4PgSysqym
        6pogYnrJ0IE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7FEF4D6D90;
        Sun, 22 Mar 2020 19:01:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C427AD6D8E;
        Sun, 22 Mar 2020 19:01:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git <git@vger.kernel.org>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Subject: Re: [PATCH v3 4/5] doc: be more precise on (fetch|push).recurseSubmodules
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com>
        <20200320213729.571924-5-damien.olivier.robert+git@gmail.com>
        <260F83FF-484B-438A-B70A-8348A5267877@gmail.com>
Date:   Sun, 22 Mar 2020 16:01:48 -0700
In-Reply-To: <260F83FF-484B-438A-B70A-8348A5267877@gmail.com> (Philippe
        Blain's message of "Sun, 22 Mar 2020 18:37:37 -0400")
Message-ID: <xmqq4kug804j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1CD7B058-6C91-11EA-999D-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>> -	This option can be either set to a boolean value or to 'on-demand'.
>> +	This option can be set either to a boolean value or to 'on-demand'.
>> 	Setting it to a boolean changes the behavior of fetch and pull to
>
> I think in the context of patch 5 maybe it would be good to be
> careful here, and state that this only affects the underlying
> "fetch" in "pull", and not the whole pull ?

Meaning that sub(sub)*modules are fetched but the merge is done only
for the top-level superproject?  I guess it does not hurt to spell
it out.  Good suggestion.

>> +	If not set, 'on-demand' is used by default, unless
>> +	'submodule.recurse' is set.
>
> I know Junio seems to think otherwise, but to me it would be
> clearer if this would be clearly spelled out:
>
> Defaults to 'on-demand', or to the value of 'submodule.recurse' if set.

Well, between the above two, I'd actually have slight preference to
yours, but they both look clear enough to almost the same degree, at
least to me.

Thanks.

