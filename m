Return-Path: <SRS0=Te6D=5Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEABC2BA19
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13ED2074F
	for <git@archiver.kernel.org>; Thu,  9 Apr 2020 22:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jGIuNkaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgDIWrZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Apr 2020 18:47:25 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52668 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgDIWrZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Apr 2020 18:47:25 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A92FC2A36;
        Thu,  9 Apr 2020 18:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zD6Iz0Hp3szL8D6VnwiDFUDtdQQ=; b=jGIuNk
        aOrlDIY34qkPDiT0zRP7oaKGlO+7EHHDIBOIAd7S//XGxW/hWnjxZDhbMBM0fMVj
        E/OL9DqGR9vJl7duW5njCu9swuseRLPtXzLRSKZq6yToxJXFqF9GvUI+ey1qpAD6
        4Nst3caxqtbLWU9Mk65rD+SwUX5bk2PLTKB6I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lUx2JmDmjZVICyl3d8pHNgbCyRII/v93
        QHgbQWhZTzVsZu6iRKehB/XhapSue48S/+Exh2aWYUBR5cikQLDyu66wrqacsbpY
        pe7gNhEbiBZApYb2OF2IWsjpwJ3R8dvQAtGYjvblPc1P74Y7iMeWggBxn9R0ewG1
        s/aD3rzSmNw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 52B4BC2A35;
        Thu,  9 Apr 2020 18:47:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 89DD9C2A34;
        Thu,  9 Apr 2020 18:47:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?=C3=89rico?= Rolim <erico.erc@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] segmentation fault in git-diff
References: <CAFDeuWO+2JEGudtnHZvSsSUOVRR83U9ziLEjSoDyMWxYhvDMKg@mail.gmail.com>
        <xmqqh7xsmg7j.fsf@gitster.c.googlers.com>
Date:   Thu, 09 Apr 2020 15:47:19 -0700
In-Reply-To: <xmqqh7xsmg7j.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 09 Apr 2020 15:45:04 -0700")
Message-ID: <xmqqd08gmg3s.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12C48506-7AB4-11EA-B5D9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This is 'next' running for me:

Scratch all that---sorry, but I did see the note about trailing
slash, but somehow managed to forget adding it when I tried it.
