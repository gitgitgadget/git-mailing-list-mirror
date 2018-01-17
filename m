Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4081F406
	for <e@80x24.org>; Wed, 17 Jan 2018 18:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753795AbeAQSUW (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Jan 2018 13:20:22 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63917 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752654AbeAQSUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Jan 2018 13:20:21 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A999BCC89;
        Wed, 17 Jan 2018 13:20:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5fMRpRT3DukmYURqBHIp8JcJJVw=; b=YhKpW/
        PWrt8vviiXXywGeURCSAUQa2+iseKcoQNH8/Gkh85rAvotGCm31MvqdELLg3L91d
        7X3YciUFnLoi4u4JsAJBsf9j5KDruhbPGn/ChEelXbDKYUHZY32hfint2CdtMpgw
        vopM7oLVEu+QRWgNREnlRD3+RhWofi7pfvoTQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XCHCXu+trYxXzgC/30oNj1ZRP377ujGd
        N77swFhDCm5mAbySHrnFiOCm2SxUmk6eBJZ7cwvtBtGgn6jHlKmFMUnwRbetIioD
        6YeBhZPGye/BlZZkFGMQbNTkRFa+INKQdP6LvC8Dy579IUy4DnQBJjBqAiQiiSNh
        ilw04MgNBzU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 51260BCC88;
        Wed, 17 Jan 2018 13:20:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B0378BCC87;
        Wed, 17 Jan 2018 13:20:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Keith Smiley <k@keith.so>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Todd Zullinger <tmz@pobox.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Daudt <me@ikke.info>
Subject: Re: [PATCH] Add shell completion for git remote rm
References: <20171229135240.GQ3693@zaya.teonanacatl.net>
        <20171229224825.31062-1-szeder.dev@gmail.com>
        <87y3ll6s0e.fsf@evledraar.gmail.com>
        <20171230005222.GT3693@zaya.teonanacatl.net>
        <87vago76i8.fsf@evledraar.gmail.com>
        <xmqq373miw4r.fsf@gitster.mtv.corp.google.com>
        <1516052626.2870893.1236353440.65CA651A@webmail.messagingengine.com>
        <CACsJy8Dzv3qPc1dB1rdvYL+CvEp+hY8ddoBrbCiP5KnqikzyLw@mail.gmail.com>
        <xmqqh8rlvdgh.fsf@gitster.mtv.corp.google.com>
        <20180117004419.GA14263@duynguyen.dek-tpc.internal>
Date:   Wed, 17 Jan 2018 10:20:16 -0800
In-Reply-To: <20180117004419.GA14263@duynguyen.dek-tpc.internal> (Duy Nguyen's
        message of "Wed, 17 Jan 2018 07:44:19 +0700")
Message-ID: <xmqqshb4s5y7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12038CAC-FBB3-11E7-9D33-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Looks good. If we want to be more careful, we can follow up with
> something even more annoying like this before removing 'rm'
>
> -- 8< --
> diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
> index 577b969c1b..0a544703e6 100644
> --- a/Documentation/git-remote.txt
> +++ b/Documentation/git-remote.txt
> @@ -90,7 +90,6 @@ In case <old> and <new> are the same, and <old> is a file under
>  the configuration file format.
>  
>  'remove'::
> -'rm'::
>  
>  Remove the remote named <name>. All remote-tracking branches and
>  configuration settings for the remote are removed.
> diff --git a/builtin/remote.c b/builtin/remote.c
> index d95bf904c3..774ef6931e 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -1609,7 +1609,10 @@ int cmd_remote(int argc, const char **argv, const char *prefix)
>  		result = add(argc, argv);
>  	else if (!strcmp(argv[0], "rename"))
>  		result = mv(argc, argv);
> -	else if (!strcmp(argv[0], "rm") || !strcmp(argv[0], "remove"))
> +	else if (!strcmp(argv[0], "rm")) {
> +		warning(_("'rm' is a deprecated synonym. Use 'remove' instead."));
> +		result = rm(argc, argv);
> +	} else if (!strcmp(argv[0], "remove"))
>  		result = rm(argc, argv);
>  	else if (!strcmp(argv[0], "set-head"))
>  		result = set_head(argc, argv);
> -- 8< --

Yes, this is a sensible way to properly deprecate it further before
removal.
