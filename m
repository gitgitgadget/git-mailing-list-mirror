Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A25AB1F461
	for <e@80x24.org>; Wed, 15 May 2019 00:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbfEOAwX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 20:52:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52000 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfEOAwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 20:52:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92F775FC4A;
        Tue, 14 May 2019 20:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sBqwQExGMXfi9zzH7GMjLaEBOoA=; b=tNMj9o
        fa8SwvLkcXCFkbb6ztQ7JbQgkcZaArn3HCKiVOqaZfwrDnDrmjXSfg3ue2of6bna
        uDBTbCv2eY9eoYZ1Avmuysm1Nq4j7EuqCD+xweKPF8jZgXdaTF5y6HU9ZIXda3s8
        hvHQTIdQpmTsO3kAorhQH7RUGue3nV/4/s8go=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=GSy0BD0lrjQkxkqYj6N3XTbk11eqcN1C
        7W+aWRz6ObX1knymRBTK1AZSRaQ0cfxf/M5wCpx9/nqNBr2k22Jr6a3/yPQW5ft4
        Km2K+fcm44KLlrPI7FSmnBirZX5nck49tBpZMA9mYGIrgl45yUajW93jm5GQ6Rja
        jRwd9VXi9TA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B3365FC49;
        Tue, 14 May 2019 20:52:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C07E45FC48;
        Tue, 14 May 2019 20:52:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: try harder to ensure a working jgit
References: <20190514020520.GI3654@pobox.com>
        <20190514021419.GI7458@genre.crustytoothpaste.net>
        <20190514084534.GA9567@sigill.intra.peff.net>
Date:   Wed, 15 May 2019 09:52:17 +0900
In-Reply-To: <20190514084534.GA9567@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 14 May 2019 04:45:34 -0400")
Message-ID: <xmqqzhno8rpa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B153328E-76AB-11E9-91E6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> All that said, I think Todd's patch makes perfect sense even without
> wanting to avoid "type".

Same here.  t/lib-bash.sh seems to use "if type bash" to see if one
is available on $PATH; I've never felt the need to avoid "type".
