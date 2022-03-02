Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031D2C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:01:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbiCCABz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiCCABy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:01:54 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CCC3EA9D
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:01:08 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AE838182410;
        Wed,  2 Mar 2022 18:23:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/KEcMs32YaRz
        Ogk9E6BZ+ZZ0m9WIgBtJf9Y/WHPg5wA=; b=xmGqch7BQvt4of3itD+f0O/Oqccl
        WsuWazlNl792gZsjcBb0yks+0rdUDdquAOXpWfadLyOknrJVn5Dx9APCJ7IYxNt/
        /nN6ab15VbSJCM7KOSuR7utw2oykuIzkwxuwnzlGa6Kd6Rd1azKmRH6g8V1SoCBz
        Q+30wvFcG29lHDg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A756418240E;
        Wed,  2 Mar 2022 18:23:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2677518240D;
        Wed,  2 Mar 2022 18:23:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 00/15] tests: don't ignore "git" exit codes
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
Date:   Wed, 02 Mar 2022 15:23:22 -0800
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 2 Mar
 2022 18:27:09
        +0100")
Message-ID: <xmqqy21sey6t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C10899EE-9A7F-11EC-A0A6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This series fixes issues where we ignored the exit code of "git" due
> to it being on the LHS of a pipe, or because we interpolated its
> output with $() in a "test" construct, or had missing &&- chains in
> helper functions etc.

Thanks.  I've looked at all the steps, left some comments, and it
was a pleasant read overall.  Writing and reviewing all these
changes, both of us must have too much time on our hands ;-)

Will queue.
