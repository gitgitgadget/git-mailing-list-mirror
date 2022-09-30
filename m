Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434B3C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbiI3VcA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 17:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232077AbiI3Vb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 17:31:57 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00168197F3F
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 14:31:56 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0F5401BEB02;
        Fri, 30 Sep 2022 17:31:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=UhUjPYwCXUCu
        CwAkyMb4D2+xb3Sxs5EOJGWwSKzlTEw=; b=UmVpw5XI08z241mQBseWReejneLj
        lq1sfNVBN+Y2IHigN5ntrB/85jppbdgDlw+xqYapmuotSOUpoO+RE+UJ2ohxeRnC
        Ai8cHrCGpFP4uymZDUsQQc2WuY0GRrUrwkg3Shyrzw8K/dVo8VhcZ8LRb7skL37N
        WIkJl/UBw88f0hk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0763B1BEB01;
        Fri, 30 Sep 2022 17:31:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3F5611BEB00;
        Fri, 30 Sep 2022 17:31:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 08/36] built-ins: consistently add "\n" between
 "usage" and options
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
        <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
        <patch-v3-08.36-e9924890620-20220930T180415Z-avarab@gmail.com>
Date:   Fri, 30 Sep 2022 14:31:52 -0700
In-Reply-To: <patch-v3-08.36-e9924890620-20220930T180415Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 30 Sep
 2022 20:07:31
        +0200")
Message-ID: <xmqqwn9k8s6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4D1DD218-4107-11ED-8B1B-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change commands in the "diff" family and "rev-list" to separate the
> usage information and option listing with an empty line.

This makes the result more in line with what parse-options API gives
via the usage_with_options() call, I would presume.

That's a welcome change.

