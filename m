Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA9401F462
	for <e@80x24.org>; Wed, 12 Jun 2019 18:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbfFLSAn (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jun 2019 14:00:43 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54455 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728965AbfFLSAn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jun 2019 14:00:43 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F0C146FDA5;
        Wed, 12 Jun 2019 14:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EPnUts4klNtoTf59AwqVKW2OJn0=; b=x3UJx+
        hlcFl41Cz6Ldd1VF5055vymruELoMCaPQxTXRS5fPm2+6qvDNhaaPkc5cNvGIILd
        wepbELgo+tPtPLfCeQeVBXQ+6SFFik2+I4y37qQo3/DDT7e69QLMu47DqNuCIVXg
        4438ZgLHRK302Z0NeGrIGz4vFHV5q6jpJsZeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=R79WWmcTAq0ieTOqDSJEUALcTzHBOtTn
        tR4QCnV+arJq2XENROrud/NVOjMYSZqhGTng22EX8/sDGpJTsmShZPlSSYfbFz4B
        DkgM6M0cNWQdDEB4i9mfIv994QPUhN7VSo0FNNBN/ScbTshBZHydOxJ5ZaXxomEo
        /miPz8w4FUs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E8D746FDA4;
        Wed, 12 Jun 2019 14:00:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 0B69C6FDA3;
        Wed, 12 Jun 2019 14:00:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com
Subject: Re: [RFC PATCH 1/3] trace2: correct trace2 field name documentation
References: <cover.1560295286.git.steadmon@google.com>
        <8bcd72a762f0fd349f8bf7d0b134cc7033ae6f00.1560295286.git.steadmon@google.com>
Date:   Wed, 12 Jun 2019 11:00:34 -0700
In-Reply-To: <8bcd72a762f0fd349f8bf7d0b134cc7033ae6f00.1560295286.git.steadmon@google.com>
        (Josh Steadmon's message of "Tue, 11 Jun 2019 16:31:35 -0700")
Message-ID: <xmqqwohqiszh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FB53050C-8D3B-11E9-AEF1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> Correct the api-trace2 documentation, which lists "signal" as an
> expected field for the signal event type, but which actually outputs
> "signo" as the field name.


Nice.  Is this one of the findings made by your validation, by the way?

>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/technical/api-trace2.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
> index 23c3cc7a37..fd1e628944 100644
> --- a/Documentation/technical/api-trace2.txt
> +++ b/Documentation/technical/api-trace2.txt
> @@ -668,7 +668,7 @@ completed.)
>  	"event":"signal",
>  	...
>  	"t_abs":0.001227,  # elapsed time in seconds
> -	"signal":13        # SIGTERM, SIGINT, etc.
> +	"signo":13         # SIGTERM, SIGINT, etc.
>  }
>  ------------
