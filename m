Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02C5C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 00:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234680AbiBYAfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 19:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232278AbiBYAfX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 19:35:23 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A478127578E
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 16:34:52 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EDF0510F687;
        Thu, 24 Feb 2022 19:34:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wx7SKuyIR9cyM4Acl3RwbHFJTSZjYjL2MVCgde
        e7ckQ=; b=CNeA4SgamG+FC3N8d/dweGE/nyuGgd9XXmiRUmUbhy3jcLyfESW/e/
        xsWguWoGlJwUC/Wl3d2r8vosgmTht+tshsP0GLicIGrHKlC0Y0fj/mrRW+HIoWNe
        hmDObYJhsC6o+lMm34VXHNAGblI9xpIEzRvaRXwhlUulAw7m/yk9E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E593610F686;
        Thu, 24 Feb 2022 19:34:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 593BE10F685;
        Thu, 24 Feb 2022 19:34:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH v3 01/10] t5526: introduce test helper to assert on fetches
References: <20220215172318.73533-1-chooglen@google.com>
        <20220224100842.95827-1-chooglen@google.com>
        <20220224100842.95827-2-chooglen@google.com>
Date:   Thu, 24 Feb 2022 16:34:50 -0800
In-Reply-To: <20220224100842.95827-2-chooglen@google.com> (Glen Choo's message
        of "Thu, 24 Feb 2022 18:08:33 +0800")
Message-ID: <xmqqmtifhjh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BE86A032-95D2-11EC-9985-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +verify_fetch_result() {

Style.

	verify_fetch_result () {

> +	ACTUAL_ERR=$1 &&
> +	rm -f expect.err.combined &&
> +	if [ -f expect.err.super ]; then

Style.

	if test -f expect.err.super
	then

