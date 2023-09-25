Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B724CE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 14:48:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjIYOsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbjIYOso (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 10:48:44 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D548B101
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 07:48:37 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A7682048B;
        Mon, 25 Sep 2023 10:48:37 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=22DrcbXnUUkZ7PuoUvtFdqGltuT1BdzwIeJN5Mp
        XFS0=; b=FKnhdwVeawzGDR4poeCZIr2icrvK+Uc6bt7ZnokUYw163ytw2RVTLlI
        xEyEqeoUZUcTqTGJ2XqVoGVXNmPyFbiNglsLCnlBGnoKskPAwDx+BBVp2WOC5RWv
        JZ3iCKOjwX/junazMculN1P9ybbbFpj8f31Zk8GqB0+xsYXXSW5Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5273F2048A;
        Mon, 25 Sep 2023 10:48:37 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [108.15.224.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5651320489;
        Mon, 25 Sep 2023 10:48:32 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Mon, 25 Sep 2023 10:48:29 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>,
        Junio C Hamano <gitster@pobox.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [REGRESSION] uninitialized value $address in git send-email when
 given multiple recipients separated by commas
Message-ID: <ZRGdvRQuj4zllGnm@pobox.com>
References: <ZQ1eGzqfyoeeTBUq@debian.me>
 <20230924033625.GA1492190@coredump.intra.peff.net>
 <ZRE6q8dHPFRIQezX@debian.me>
 <20230925080010.GA1534025@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925080010.GA1534025@coredump.intra.peff.net>
X-Pobox-Relay-ID: 9953858A-5BB2-11EE-9242-A19503B9AAD1-09356542!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Mon, Sep 25, 2023 at 02:45:47PM +0700, Bagas Sanjaya wrote:
>> I think you missed perl version. As stated earlier, I'm on Debian testing
>> with perl v5.36.0. On there, `perl -V` outputs:
> 
> Mine is the same (I'm on Debian unstable, but the version is currently
> the same as the one on testing).
[...]
> Do you have any other send-email related config? Can you show us the
> output of "git config --list"?

From the peanut gallery... could the presence or lack of the
Email::Valid perl module be a factor?

-- 
Todd
