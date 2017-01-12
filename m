Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A9421FEB3
	for <e@80x24.org>; Thu, 12 Jan 2017 22:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbdALWCw (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jan 2017 17:02:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58125 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750934AbdALWCv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jan 2017 17:02:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C9D35E399;
        Thu, 12 Jan 2017 17:02:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dZ1OWYQtc8jqPOP2LSju6nNl5VA=; b=s5PXqV
        5UrQYFCHcfuK+6hUMhTjKNQXK0oho05xwaV1hwz0EEnw4sN/5ljI0cqjWaFhZcGc
        sQz14upVuQOaC2SL+3p+QNf2z9ttHEo1yowTZ98nbt3r6uMuIl3XaCcCgrA16tMT
        k6QodwAzbOrT7JnOW+IrP0OlLxIsYkGF4wF4Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lBqIrcZODpY16nUkqN9Y431+I93Vixu+
        IrFrv4oZ3qfTlgp1CxIir/RZo+6+yqHs0M8MlC1XtFRyRCgXOREnfAg/QKl3LJQ7
        xj4FmEHmU0Ft06bzVxLV2NNdpM810y3FLhemVgmoNzElXD2KtS3yrp8mZfHOxhUG
        JMQP/lgv4TU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 640765E397;
        Thu, 12 Jan 2017 17:02:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC5405E396;
        Thu, 12 Jan 2017 17:02:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jacob Keller <jacob.e.keller@intel.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/5] describe: teach describe negative pattern matches
References: <20170112001721.2534-1-jacob.e.keller@intel.com>
        <20170112001721.2534-6-jacob.e.keller@intel.com>
        <alpine.DEB.2.20.1701121041450.3469@virtualbox>
Date:   Thu, 12 Jan 2017 14:02:48 -0800
In-Reply-To: <alpine.DEB.2.20.1701121041450.3469@virtualbox> (Johannes
        Schindelin's message of "Thu, 12 Jan 2017 10:42:44 +0100 (CET)")
Message-ID: <xmqqlgughr7b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DB9D06B6-D912-11E6-903B-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Jake,
>
> On Wed, 11 Jan 2017, Jacob Keller wrote:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>> 
>> Teach git-describe the `--discard` option which will allow specifying
>> a glob pattern of tags to ignore.
>
> IMHO "discard" is the wrong word, it almost sounds as if the matching tags
> would be *deleted*.
>
> Maybe `--exclude` or `--unmatch` instead?

Yeah, as j6t mentions, I think --exclude would be a good choice.
