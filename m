Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F0811F461
	for <e@80x24.org>; Thu,  5 Sep 2019 19:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390294AbfIET4K (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 15:56:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54038 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733174AbfIET4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 15:56:10 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E143A2A083;
        Thu,  5 Sep 2019 15:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i0a1kpij6ts85ra6yLK7XSW89Js=; b=ORk2t6
        xBEanG5OMahhlOFT2Ml4K5BBGExyO5U/DCWTxVpJTK7lUCBjoxIyyZajpiA4fne1
        g3k4Tk44Vpa7sGsZyHJIWFq6wdV66F6oAySoF0Y9p7MjBxdK96Ce58UjfHd18pEL
        pht8AB9k8GaUSLau3YiylXuMqUsYUzifid7B4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KOM6RXQ1csj41CIyTjRTUiVEg89azy2u
        Wz0W0zcMwfs5fZqSPjOoN4jngFOuVX+Xsyn1yZ+FUhA69qJMdKbVqqvTnqci2PYF
        YfI7m5kxcpqft/I3KdWpEi6A6SaExdt/ll7k316F6EwpiJNEyIPE+4FJP1YuxXAM
        8ULpcWe8MRg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D87042A082;
        Thu,  5 Sep 2019 15:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4746A2A081;
        Thu,  5 Sep 2019 15:56:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 00/13] format-patch: clean up tests and documentation
References: <cover.1566635008.git.liu.denton@gmail.com>
        <cover.1566878373.git.liu.denton@gmail.com>
        <20190904112105.GA27933@archbookpro.localdomain>
Date:   Thu, 05 Sep 2019 12:56:06 -0700
In-Reply-To: <20190904112105.GA27933@archbookpro.localdomain> (Denton Liu's
        message of "Wed, 4 Sep 2019 04:21:05 -0700")
Message-ID: <xmqqef0uplex.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33303346-D017-11E9-B092-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> I see that "dl/format-patch-doc-test-cleanup" currently has the comment
> "Expecting a reroll." This should be the reroll that you're expecting ;)
>
> Also, since there haven't been any comments on the topic in a while, I
> propose that it should be ready for inclusion.

I may be the only person who had issues applying that series from
the list, with mixtures of iso-8859-1 and utf-8 causing troubles,
but if I am not alone, I suspect that the reason why nobody gave a
comment is because the patches did not even apply so there is
nothing to base their comments on.

I wiggled them and compared the result.  The range diff against what
has been queued seems a bit different from what you gave below
(e.g. I see log message got modified on patch #2 and the dropping of
the comma made it harder to read), but the endpoint diff looks not
too bad (IOW, the alloted time for the topic ran out before I
started looking at each individual patches in more depth).



