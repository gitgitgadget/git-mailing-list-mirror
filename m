Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C184D1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 06:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408528AbfJXGGp (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Oct 2019 02:06:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63231 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404173AbfJXGGo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Oct 2019 02:06:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 29E7B8CE0C;
        Thu, 24 Oct 2019 02:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HrASTccETf986xbsFrGjWt4F3AQ=; b=JZ9n1Q
        L+rC1aoyfVXNw03BebPks7g4vTPfsQYCmnpAQphWeamV8OEeR/EIvISruvZOGXTB
        +tNVcVzfDEswE+/hdieM5j8HnmwdwGU8voZApc9DDGCDcMuofZ45EIyWf5axU/Ea
        Nd34PXpZYHigpqDOBDd2/B8g5v6naBhwpwedI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k08QgHIIw1DeXeVVN7S68fcCZrSPaCBg
        ckZda8xQRu3c7JZiJJW7+dv/zvOcGDA1lQq6Q1yE9XRlDO8p2lh1kMDec4RJHRhe
        Pm5Zmvs7fbUomy5wkS/MOueiW4Ygm44PXjeI1xkMCMSCmVRSBw/P+Ju3zTy6WKiO
        r/0It0fWnig=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 236668CE0B;
        Thu, 24 Oct 2019 02:06:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EF36A8CE0A;
        Thu, 24 Oct 2019 02:06:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 10/23] fsck_describe_object(): build on our get_object_name() primitive
References: <20191018044103.GA17625@sigill.intra.peff.net>
        <20191018045638.GJ17879@sigill.intra.peff.net>
Date:   Thu, 24 Oct 2019 15:06:37 +0900
In-Reply-To: <20191018045638.GJ17879@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Oct 2019 00:56:38 -0400")
Message-ID: <xmqq4kzyfziq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71CBEEDC-F624-11E9-892C-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This isolates the implementation detail of using the decoration code to
> our put/get functions.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> Arguably this could be squashed into the previous commit. By not doing
> so, it made describe_object() more of a pure code movement.

Indeed it did.
