Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E99D12095E
	for <e@80x24.org>; Sat, 18 Mar 2017 17:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751680AbdCRRA4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 13:00:56 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54974 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751444AbdCRRAz (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 13:00:55 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B470682B4B;
        Sat, 18 Mar 2017 13:00:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vhQHUWiJd0g4xlSKGpqNIovFfK8=; b=OJKxDR
        3llUmaFiD1tQek+2Xbd0eDDd8VW2qYw5ozTU6i2O6jI3TCq62cPemNwS6N1lZN6b
        +Bpf6iYrWjfKk9t54dpyWMyNcEAOAxXl4J/iu03OvCA+Jb7AwAWf49d5DbZS6CjG
        BNtLW7o3oBsieI1Tsu19XkM1zLr4aPu5Gbilw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=T2SdVCOc3zjwHBLwviddhJACapKEaOZz
        wTI0H8FV7kix3pz9DIpYHWCDWPT6220z9PeyyuWtzfQ5kqsXFjDbt8U8HPh6P0kF
        4FGGNNZgXhrTsH+vKbf3xdyofx4UCmXXNb+AV10kIQWeiVJmhm/TQeMKC41jiZ61
        GGloF2bZAgE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ABE6F82B48;
        Sat, 18 Mar 2017 13:00:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18ECF82B47;
        Sat, 18 Mar 2017 13:00:53 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH v5 00/10] decoupling url and submodule interest
References: <20170316222952.53801-1-bmwill@google.com>
        <20170317223805.95271-1-bmwill@google.com>
Date:   Sat, 18 Mar 2017 10:00:51 -0700
In-Reply-To: <20170317223805.95271-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 17 Mar 2017 15:37:55 -0700")
Message-ID: <xmqqwpbm4j0c.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 720C0FC2-0BFC-11E7-AEE3-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Changes in v5:
>   * Add "NEEDSWORK" comments to indicate where attention is needed once
>     per-worktree config is a reality
>   * --no-recurse now works by clearing the string list of paths.
>   * module_list_active() now does post-processing instead of duplicating code.
>
> Brandon Williams (10):
>   submodule--helper: add is-active subcommand
>   submodule status: use submodule--helper is-active
>   submodule sync: skip work for inactive submodules
>   submodule sync: use submodule--helper is-active
>   submodule--helper clone: check for configured submodules using helper
>   submodule: decouple url and submodule interest
>   submodule init: initialize active submodules
>   clone: teach --recurse-submodules to optionally take a pathspec
>   submodule--helper init: set submodule.<name>.active
>   submodule add: respect submodule.active and submodule.<name>.active

Replaced what has been queued with this and read it over
again. Looked sensible.

Thanks.
