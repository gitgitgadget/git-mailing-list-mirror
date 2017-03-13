Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F023D20373
	for <e@80x24.org>; Mon, 13 Mar 2017 21:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdCMVjb (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 17:39:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56218 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751047AbdCMVj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 17:39:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8101083515;
        Mon, 13 Mar 2017 17:39:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z/I63PtHJ5CrbMSVeqfNdtzuUQM=; b=FhEcY2
        CDXdxNXW+Vr/bfxfIttUxkDfFDXv2X+5ZjOmpjYY3tV1W3gNIw/LP2YzfURr2r7y
        kQVRrpDKafB7mY5uSZaZj7BJ6+sQK6YLGJ5jgkNpBgY3ByL4iZi/XsNCBQI+FM8j
        sKRUX1NfvkaMSHsnjd/HLX/U7bvMs9JIqHV4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EG2UnuqbCIF61PC386vtyPOz8LkQlfgf
        hTDk70dT/g/rb53oMnxclH/QIucTwJxtMHscnTzGXd6/VQ4PswOZXtpi094chYGh
        LkpBAhUJbcaobKzfkXQTJTUnLc5sN/VsxEN19eiV1iOkFg/D9qKmD8uTfVCpAvv7
        LpSIf1asciM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AB2083514;
        Mon, 13 Mar 2017 17:39:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D048983512;
        Mon, 13 Mar 2017 17:39:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <lehmacdj@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [GSoC][PATCH v2 1/2] path.c: add xdg_cache_home
References: <20170313172232.96678-4-lehmacdj@gmail.com>
        <20170313204355.56559-1-lehmacdj@gmail.com>
Date:   Mon, 13 Mar 2017 14:39:26 -0700
In-Reply-To: <20170313204355.56559-1-lehmacdj@gmail.com> (Devin Lehmacher's
        message of "Mon, 13 Mar 2017 16:43:54 -0400")
Message-ID: <xmqqefy0rh4h.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88BFD764-0835-11E7-8EAD-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <lehmacdj@gmail.com> writes:

> We already have xdg_config_home to format paths relative to
> XDG_CONFIG_HOME. Let's provide a similar function xdg_cache_home to do
> the same for paths relative to XDG_CACHE_HOME.

Nicely explained.

> +/**
> + * Return a newly allocated string with the evaluation of
> + * "$XDG_CACHE_HOME/git/$filename" if $XDG_CONFIG_HOME is non-empty, otherwise
> + * "$HOME/.config/git/$filename". Return NULL upon error.

s|CONFIG|CACHE| and s|.config|.cache| are needed, methinks.

Will fix while queuing, so no need to resend only to fix this typo.
