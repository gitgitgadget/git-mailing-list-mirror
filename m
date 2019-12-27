Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2280C2D0C3
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A67620740
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 22:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Xl7dPzZ6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbfL0WcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 17:32:18 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53247 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbfL0WcR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 17:32:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E73ACB0BFB;
        Fri, 27 Dec 2019 17:32:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h2HhU78+U63VD8C7VPQGWf9sHjo=; b=Xl7dPz
        Z65A+MbMIFBPE/5pdm47pEbX8kLvVg+eRpc+/xTfPqAuG0cDJIdjPdORnSVFJ4w9
        FuBMTIgmsKSUkAlbyHI4bi9ms0NTuA0q6T5i0Hv6hJ2L78az3IdlJuoT7u0jUUXm
        hNe2tcrISmJ6dbeHCMfbt5tus6wHzMjwqoqHk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Oppttee+zMpID6W4GBctH8+Pz1kT4X/l
        1z0H2n9ag/3kp7d/epCJKs6tv1q7NCbOFW0Q1oOPBKbL1yS+oBlV0LSP3dgnJEgE
        pV1i3oC3u6vnQEyC02oDvZjTg8/uN2gC98JfSuOEMU5C3pZX9T99bYzYFYg9L9fU
        8USJfMT1Jfo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D3F39B0BFA;
        Fri, 27 Dec 2019 17:32:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9C0C3B0BF9;
        Fri, 27 Dec 2019 17:32:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Zoli =?utf-8?Q?Szab=C3=B3?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Zoli =?utf-8?Q?Szab=C3=B3?= <zoli.szabo@gmail.com>
Subject: Re: [PATCH 1/1] git-gui: add possibility to open currently selected file
References: <pull.499.git.1577386915.gitgitgadget@gmail.com>
        <fce80f1b95f83915076640ca0be01aa473744777.1577386915.git.gitgitgadget@gmail.com>
        <20191227193418.36uzeizs37nv7ywb@yadavpratyush.com>
Date:   Fri, 27 Dec 2019 14:32:10 -0800
In-Reply-To: <20191227193418.36uzeizs37nv7ywb@yadavpratyush.com> (Pratyush
        Yadav's message of "Sat, 28 Dec 2019 01:04:18 +0530")
Message-ID: <xmqqy2uxiemt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BA0C03A6-28F8-11EA-968A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

> Have you tested it on Windows? Does 'explorer.exe' do the correct thing? 
>
> Looking at MacOS's 'open' man page, I think it should also work like 
> xdg-open and shouldn't be a problem.
> ...
> Tested on Linux. Works fine. Looking forward to the re-roll.

> Subject: Re: [PATCH 1/1] git-gui: add possibility to open currently selected file

The phrasing on the title is a bit awkward.  "add possibility to do
X" is better spelled "allow doing X", no?
