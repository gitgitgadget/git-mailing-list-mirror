Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E63F1FAFB
	for <e@80x24.org>; Wed, 19 Apr 2017 01:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758495AbdDSBDQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 21:03:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60983 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752890AbdDSBDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 21:03:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5440782B09;
        Tue, 18 Apr 2017 21:03:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KbM3z49vi1AOs+3U5vpITXNn8cw=; b=vhtLyS
        mPospkhiqweeCwYdXJZxeXR86mt0afV91+J0REnVnBcMMx6pboUR2YI5k3EZBU8a
        h75L1avvIMMC6yUz5IIIczyZJ+w5HgzbIpPg6DD3rQbKeEdQzNxj7gfSlCPaccaD
        B3cwOdflXiWsUcHV0F3Ebepn8zcSIlX36RgNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HuCmPPOjQ957AYTQBsIvNBvuzJEca5Qp
        BNjWEMkcpXIPkdXXHWBjDmLXx5f0RIyykzSBaKHyIY19r/+FpL4qDpF5KYG2Ab1E
        JKfhnpiyeTi9pO+r8OG4bk2BsIwD7KvVQXvrUyTiHF9td5+rY16swMB3C24Ow9Hh
        4iHpD3Vqjno=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BC5C82B08;
        Tue, 18 Apr 2017 21:03:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD7A882B07;
        Tue, 18 Apr 2017 21:03:07 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, jacob.keller@gmail.com
Subject: Re: [PATCH 3/2] ls-files: only recurse on active submodules
References: <20170413171224.3537-1-jacob.e.keller@intel.com>
        <20170413185707.97746-1-bmwill@google.com>
Date:   Tue, 18 Apr 2017 18:03:06 -0700
In-Reply-To: <20170413185707.97746-1-bmwill@google.com> (Brandon Williams's
        message of "Thu, 13 Apr 2017 11:57:07 -0700")
Message-ID: <xmqqefwpdx9x.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F34360EC-249B-11E7-A93D-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Add in a check to see if a submodule is active before attempting to
> recurse.  This prevents 'ls-files' from trying to operate on a submodule
> which may not exist in the working directory.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---

Sounds like this is something we can demonstrate its effect with a
simple test in t/ directory?
