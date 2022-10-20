Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BCBEC433FE
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 23:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJTX1E (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 19:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbiJTX1D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 19:27:03 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE41226E60
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 16:27:01 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68C141CC048;
        Thu, 20 Oct 2022 19:27:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=1tJmZhWuS8/s
        Qs6g/7nUsqsp6Wi4t8+VD8Gy9zsqsIo=; b=VPHL3ATQnfFdPPRohTKuVH9+a8/1
        r/+CvpeLELBgq0QsqVW1wfcnb0N8QsHggfPqt6oQstZQ3dNwmH9ZZM5+jrzY7/Oj
        2txm7ASZkFKQ94ydIfdB6PeAV1r3nnj6phgLprQl4rYwNzSg2TDXCpG7+jUS0j8A
        pcO3CnUMOpNIB9E=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53DEB1CC047;
        Thu, 20 Oct 2022 19:27:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6CE881CC046;
        Thu, 20 Oct 2022 19:26:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Mike Hommey <mh@glandium.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Glen Choo <chooglen@google.com>,
        Eric DeCosta <edecosta@mathworks.com>
Subject: Re: [PATCH] Makefile: use sha1collisiondetection by default on OSX
 and Darwin
References: <patch-1.1-1f4e39be97b-20221020T225305Z-avarab@gmail.com>
Date:   Thu, 20 Oct 2022 16:26:56 -0700
In-Reply-To: <patch-1.1-1f4e39be97b-20221020T225305Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 21 Oct
 2022 01:01:20 +0200")
Message-ID: <xmqq4jvyqdof.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B098A698-50CE-11ED-908E-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Junio: I see in the meantime you've queued your own
> https://lore.kernel.org/git/cover-v3-0.9-00000000000-20221020T223946Z-a=
varab@gmail.com/;
> which is currently in "seen".

Yes, as I said, I intend to merge it to 'next' in tomorrow's
pushout, and then fast track all three topics (Peff's "-O0",
Eric/=C3=86var's "use git_SHA_CTX abstraction", and "osx-clan uses
sha1dc") down to 'master'.  As you chose to make this topic hostage
to the other multi-part topic, which is likely to be slowed down and
require rerolls for typofixes and possible bikeshedding, by the time
this topic becomes ready, it is likely that it would already be in
'master' and you'd have to rebase on that.

Isn't this step of much higher importance than the other multi-part
topic?  I do not see why you chose to take it a hostage to the other
one.  Let's all learn to give priorities to produce sufficiently
focused fixes that also sufficiently cover important issues.  Frills
and niceties can come on top later.
