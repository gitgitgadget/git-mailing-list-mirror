Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 05BB01FF32
	for <e@80x24.org>; Thu, 12 Oct 2017 05:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751053AbdJLFFo (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 01:05:44 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52811 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750774AbdJLFFo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 01:05:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7D6A99B4A2;
        Thu, 12 Oct 2017 01:05:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rGDPoE7ZD983dnDAC/InOvPRM/g=; b=u5wnST
        rqsDl8zFNqYGAr2PMkzFNsfwVsCVA3lJI++7Tj0jYAYERfyHZV8XWq0pigj47J29
        HSMcqurvnTsU7Y8i4nkJUUI3RiLSZEcOTXqeziLF440ZUmQRPw+TLakYkeIBWekK
        fAa6IcjTFms/gHeUXWnldVtwRtXgztL+clYnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L5tdClKg9UlituqkraSi9VGNPGXk2oOV
        x54XMG0BdRMxIfGRvLJrEXRYG9rnwo0755LQqSSD4PIK3/gNbAbI4dvdS4MiNBoi
        00hKlvG4jMcIFwTxt16yQhVu4icVXzWHmOfjCrV2nfUChIqWOyOX7JcHfmgN1AJ/
        P6sJYSRCfrk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72ADB9B4A1;
        Thu, 12 Oct 2017 01:05:43 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EFD79B478;
        Thu, 12 Oct 2017 01:05:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] color: downgrade "always" to "auto" only for on-disk configuration
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
        <20171012021007.7441-1-gitster@pobox.com>
        <20171012021007.7441-2-gitster@pobox.com>
        <20171012044724.GD155740@aiede.mtv.corp.google.com>
Date:   Thu, 12 Oct 2017 14:05:35 +0900
In-Reply-To: <20171012044724.GD155740@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Wed, 11 Oct 2017 21:47:24 -0700")
Message-ID: <xmqqa80x0xcw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB9DA0BE-AF0A-11E7-9BC7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Should we document this special case treatment of color.* in -c
> somewhere?  E.g.

Perhaps, although I'd save that until we actually add the new option
to "git" potty, which hasn't happened yet, if I were thinking about
adding some text like that.  Also I'd call that --default-color=always
or something like that, to avoid having to answer: what are the
differences between these two --color thing in the following?

    git --color=foo cmd --color=bar

