Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 946AD20756
	for <e@80x24.org>; Fri, 13 Jan 2017 23:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750747AbdAMX6i (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jan 2017 18:58:38 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60235 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750718AbdAMX6i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jan 2017 18:58:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12BDE5F11A;
        Fri, 13 Jan 2017 18:58:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TNkUpX9V3EwM7nvUnfZITjB/g/c=; b=CMBmbS
        vbFXOnOQRvdY5uMHFzRjij6F5UD1MPHqRSzmzahQU3FT2HCoCQrg2PcyhTeIVsEm
        ytGy314/CFPknheJR/FW7qRdhOMLLhzZgPkBs5NrHG5OQqERkJKjdLb59N/Jzoee
        t2/NRUdbzQbtNOG0EGEctN2gNFmLb4nQ3BwB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j/lc8jIXyp+vSjXUXuePgVAysckuKyJp
        DLsdQ3/l+VdoLREIW48nUrytF9m/ZDt362oZQEYAj6HfJBw+kQPiV3jjxneWFDEj
        28vs868QSrCHZhdKMM4jT/blUY/raY6b73n1BER4IPo5P4JwbEBj5O5DqTtkrBHH
        g2DrNxWYAyc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 09B155F119;
        Fri, 13 Jan 2017 18:58:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 614BE5F118;
        Fri, 13 Jan 2017 18:58:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     bmwill@google.com, judge.packham@gmail.com, olsonse@umich.edu,
        git@vger.kernel.org
Subject: Re: [PATCH] submodule update: run custom update script for initial populating as well
References: <20170113194326.13950-1-sbeller@google.com>
Date:   Fri, 13 Jan 2017 15:58:35 -0800
In-Reply-To: <20170113194326.13950-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 13 Jan 2017 11:43:26 -0800")
Message-ID: <xmqq7f5yeclw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32806CE6-D9EC-11E6-9799-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> +			if test "$update_module" = "merge" ||
> +			   test "$update_module" = "rebase" ||
> +			   test "$update_module" = "none"
> +			then
> +				update_module=checkout
> +			fi

	case "$update_module" in
	merge | rebase | none)
		update_module=checkout ;;
	esac

Shorter and probably easier to update.
