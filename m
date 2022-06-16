Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C92C43334
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 21:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378522AbiFPVeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 17:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379197AbiFPVeM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 17:34:12 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F69612B9
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 14:34:11 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6911B191055;
        Thu, 16 Jun 2022 17:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N9M6r4PyUE4EqXWzzSBBhJmlbmNn25iesofg16
        z14G4=; b=QFEnctGq3q1Z02Fps1J5mq6JLFaW82zghEMf/RuQM22OhK+E1LsnEi
        sQZzfe2nulMBzMDeu2xIclI12N71Fv674MD+e+kj32ekdXxaucddCOA8+MsHeyuM
        WfY9bptPAEzmgHuh3+0IYm7a2MQFrMHAOmmEy1XwR3bQHWlxo6eZE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 621E3191054;
        Thu, 16 Jun 2022 17:34:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA130191053;
        Thu, 16 Jun 2022 17:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 2/5] tests: handle --global directly in
 test_config/test_unconfig
References: <20220616205456.19081-1-jacob.e.keller@intel.com>
        <20220616205456.19081-3-jacob.e.keller@intel.com>
Date:   Thu, 16 Jun 2022 14:34:06 -0700
In-Reply-To: <20220616205456.19081-3-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Thu, 16 Jun 2022 13:54:53 -0700")
Message-ID: <xmqqpmj8qomp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D761704-EDBC-11EC-AF19-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.keller@gmail.com> writes:

> +		--global)
> +			global=yes

			global=--global

> ...
> +	git ${config_dir:+-C "$config_dir"} config ${global:+--global} --unset-all "$1"

	git ${config_dir:+-C "$config_dir"} config $global --unset-all "$1"

The other one can use the same trick to make it more concise.

Thanks.
