Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 637C71F935
	for <e@80x24.org>; Wed, 21 Sep 2016 22:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933863AbcIUW2i (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 18:28:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56519 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933101AbcIUW2h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 18:28:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 43178402DA;
        Wed, 21 Sep 2016 18:28:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=g+uBp/nnBEKmitMD80wJNN9XXRI=; b=vYnPvS
        LnHtis0YiTzVIYbd0GrWGYRrc6sWjQY3WL9AQCCPW4i4b4H8j4dqUpfBECov2SzW
        5R+UVWy+vqpOAIFdhP7yIyKNB+fRyDIq/kg8c5tLBC4IHMsGbp5poK0EprLL9d0O
        do8uFHc8mm5rhZ5NZsM1ANX4lbq2E8HDTV0vA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iDmGJ0uRY2AR83fEr6OhdNYzIKpFvJ6e
        R5hPOIFk5+HGKlOJ2od10IZy3JGJNavR8fUDb8jI6M8cTUJ1vcZMZxMd8VAKsQiY
        v6kMIAmlrTLJkX80DlxcRGC2RnfFRoAEQfn88EwjZvmHpDnZ2DHr5AiEHzEU/NZu
        2zii0eomOxc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ADC0402D9;
        Wed, 21 Sep 2016 18:28:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ACB9C402D7;
        Wed, 21 Sep 2016 18:28:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] ls-files: adding support for submodules
References: <1474495472-94190-1-git-send-email-bmwill@google.com>
        <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
Date:   Wed, 21 Sep 2016 15:28:33 -0700
In-Reply-To: <CAKoko1q7Mb6_cnaA1ecZJ2y1PWUrW4RSu6RiviyN91JV5-QR5g@mail.gmail.com>
        (Brandon Williams's message of "Wed, 21 Sep 2016 15:08:03 -0700")
Message-ID: <xmqq1t0c7ur2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BC588576-804A-11E6-A771-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> This is another version of the first ls-files patch i sent out in
> order.  In this version I fixed the option
>  name to be '--submodule-prefix'.

I understand that many internal changes in your work environment are
titled like "DOing X", but our convention around here is to label
them "DO X", as if you are giving an order to somebody else, either
telling the codebase "to be like so", or telling the patch-monkey
maintainer "to make it so".  So I'd suggest retitling it to

	ls-files: optionally recurse into submodules

or something like that.  It is an added advantage of being a lot
more descriptive than "adding support", which does not say what kind
of support it is adding.
