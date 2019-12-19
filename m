Return-Path: <SRS0=FxFb=2J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B36C43603
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFB8C20716
	for <git@archiver.kernel.org>; Thu, 19 Dec 2019 17:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="izBeTq6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfLSR4S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Dec 2019 12:56:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62891 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726797AbfLSR4R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Dec 2019 12:56:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 734EA25B28;
        Thu, 19 Dec 2019 12:56:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=nvB+pZQPKXm+U1FWS2QQL7/C12Q=; b=izBeTq
        6VR3XW8tGgEtCmKbo/vw6NLW/nVX563ddFTkLE1wgqfYEFj8vWcKo81wEu9Ib8sm
        YDtH5TBF/sBJS1rOpCLZpxhtrxd5rlV1BDseTh3v+lO9JlMxj5WRnTkgALiG/xN2
        HQoZ3a2+F+UZyW+VHH0GO3dKO7dZB1uYjVlfI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uBODYK1V6BOsEQiSiqNNVYQOgaUdu/4J
        TseJ7p7YO94WihO/k4aJ/ieDQ1jGf0lEsN3Mx1A9JMjy1BDBtN8ajzwNYwO32AlP
        Au+hFR/LMcA+6yGsW3L8MXvWOYZU2J4SVRIYG1XKAbCITMeHSWhjp5PrtheRfGD8
        fJYuNr1Jc64=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C14E25B27;
        Thu, 19 Dec 2019 12:56:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CA68925B26;
        Thu, 19 Dec 2019 12:56:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <mattr94@gmail.com>
Cc:     "'Philip Oakley'" <philipoakley@iee.email>,
        "'Matthew Rogers via GitGitGadget'" <gitgitgadget@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH 1/1] config: allow user to know scope of config options
References: <pull.478.git.1576631464.gitgitgadget@gmail.com>
        <ec699bb3e64c74e6e87a20bbb5efac12a13cb077.1576631464.git.gitgitgadget@gmail.com>
        <9a91caa0-72c3-3a38-3eb7-55a43537762e@iee.email>
        <03b001d5b601$09b950e0$1d2bf2a0$@gmail.com>
Date:   Thu, 19 Dec 2019 09:56:13 -0800
In-Reply-To: <03b001d5b601$09b950e0$1d2bf2a0$@gmail.com> (mattr's message of
        "Wed, 18 Dec 2019 19:12:44 -0500")
Message-ID: <xmqqtv5wb3nm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9843D00-2288-11EA-9ED7-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<mattr94@gmail.com> writes:

>>These are correct changes, but is unrelated noise in the context of
>>the theme of the patch, no?
>
> I think that's the case, would the recommended course of action be to
> move these changes into its own commit? 
>

Yup, and it generally is a good idea to make such a clean-up patch
either early in the series, or as a standalone patch (with a note
under three-dash lines that another topic is coming on top of the
cleanup), because it would be much less likely to introduce new bugs
and can be merged quicly to 'next' and then to 'master' to serve as
a base to build your other changes on top.

