Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62B47208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 21:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbdHJVUL (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 17:20:11 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56226 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752882AbdHJVUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 17:20:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 408169F511;
        Thu, 10 Aug 2017 17:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=pbAFXy5M8paiBNyJJUtNYQvIikI=; b=QjvUZ3
        4hBmsbWyUA507S6CX5e8XzpSm7ZaIUJmZDjXCMF2hmgzi28veLNqwsx9nM7chsDT
        hkbyHqWZTpKkiSHWpiZCnUemk87sLIFteZhewlcQERPEtaxall3FCEGse69l5EEy
        mcFxwuvjSnM6a9D0SncGyXtdzcBjhP7RoRiCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JywGQ5z98xN1nRcszpv0vQPPFBtufP8t
        6skEwTS3FJHnInqa9tpKZaVqDJ0w0HwFHvxxx7kJnNFdNs5IXATOZLdB7MGPRBSB
        xrgVtm7y2cTOGivqEg7pa5Exhw2MsNg4YKFH5WFUV8g1sAJSZwjqK//7mGF1CDk3
        45i2K1fUxmE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C7DE89F50D;
        Thu, 10 Aug 2017 17:20:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 205AD9F50A;
        Thu, 10 Aug 2017 17:20:00 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v2 00/25] Move exported packfile funcs to its own file
References: <cover.1502220307.git.jonathantanmy@google.com>
        <cover.1502241234.git.jonathantanmy@google.com>
Date:   Thu, 10 Aug 2017 14:19:59 -0700
In-Reply-To: <cover.1502241234.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Tue, 8 Aug 2017 18:22:32 -0700")
Message-ID: <xmqq7eyb2k8w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB4BB2CE-7E11-11E7-BE06-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Here is the complete patch set. I have only moved the exported functions
> that operate with packfiles and their static helpers - for example,
> static functions like freshen_packed_object() that are used only by
> non-pack-specific functions are not moved.

This will interfere with smaller changes and fixes we want to have
early in the 'master' branch, so while I think it is a good idea to
do something like this in the longer term, I'd have to ask you to
either hold on or rebase this on them (you'll know what else you are
conflicting with when you try to merge this to 'pu' yourself).

Thanks.
