Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8602C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 23:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbiADXRF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 18:17:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59018 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiADXRE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 18:17:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 195631160F1;
        Tue,  4 Jan 2022 18:17:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TTAY6T3WpuW6HqXkuW8LwpPlyC68H+dk3CFTjg
        1lfoo=; b=RvJ3YCN6keNJZFw2T5NIhroJ9N8Dz9M7kIw7oaBs1esTmGKJV2uxK1
        3gHQsbRY4T6BDo7EShB9xumugOWfF/1260pXme4wdv5HK4FHiss/iMsTmTNEoz8V
        g9a4GaHyD3MRtNoIqveJ42aIQJpbwqklmZd9OYEKENA9mJ/UPmc+I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BD5B1160F0;
        Tue,  4 Jan 2022 18:17:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9F691160EF;
        Tue,  4 Jan 2022 18:17:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v2 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
        <20220104015555.3387101-2-sandals@crustytoothpaste.net>
        <xmqqsfu3b4gw.fsf@gitster.g>
        <YdTQodIhZ9273nJE@camp.crustytoothpaste.net>
Date:   Tue, 04 Jan 2022 15:17:01 -0800
In-Reply-To: <YdTQodIhZ9273nJE@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Tue, 4 Jan 2022 22:56:33 +0000")
Message-ID: <xmqq35m39jma.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6CCBA8E6-6DB4-11EC-A68C-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> There's an important additional difference here.  On real BSD systems,
> the prototypes for this family of functions live in <stdlib.h>.

Ah, I missed that one.  So "C side does not care between
HAVE_ARC4RANDOM_LIBBSD and HAVE_ARC4RANDOM" is not true.  We do
care and the patch as posted is fine.

Thanks.
