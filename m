Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E508920437
	for <e@80x24.org>; Thu, 12 Oct 2017 11:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755919AbdJLLOn (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 07:14:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62409 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755540AbdJLLOm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 07:14:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AAA05979B0;
        Thu, 12 Oct 2017 07:14:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0UigmbI4vt8unKSvZWXVC5y44pg=; b=NgVJOo
        ndaUR88dAff4IykUbGWAREaTxcVKopoyhu1Vtc2O/vFc5Pn6mb1H2vN7k+ni9dnj
        4DImzAUKWZDWSw9AVw424UuNfKV/xNRu47RzlZq0L8wQvp5xrT0LGX2RWdbPLTrj
        LmZhtsWdyNrlw5HHDGISj/3MC1ojUO/rR6EB4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Rb491aUAnqeDTMXoAJuuz+DkIUJidlGZ
        ki/ATANY+ZYreU2qnup228EAO8a6ijZwLxNttieFwhk3lOlheZPKjyAEClI28/p3
        1u3G5+4WQ1Hi9zm3JjQIsn8SBPgxTgleOYqmOx4oavBISNHYsvAZC0TuIUjiAL9Q
        9ubzrquDIMM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A2C3D979AE;
        Thu, 12 Oct 2017 07:14:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1E991979AB;
        Thu, 12 Oct 2017 07:14:41 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        git@vger.kernel.org
Subject: Re: [RFC] deprecate git stash save?
References: <20171005200049.GF30301@hank>
        <xmqqmv4x2ngs.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 12 Oct 2017 20:14:40 +0900
In-Reply-To: <xmqqmv4x2ngs.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 12 Oct 2017 09:56:19 +0900")
Message-ID: <xmqqy3ogy5wf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AE88738-AF3E-11E7-B831-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
>> git stash push is the newer interface for creating a stash.  While we
>> are still keeping git stash save around for the time being, it's better
>> to point new users of git stash to the more modern (and more feature
>> rich) interface, instead of teaching them the older version that we
>> might want to phase out in the future.
>
> With devil's advocate hat on, because the primary point of "stash"
> being "clear the desk quickly", I do not necessarily agree that
> "more feature rich" is a plus and something we should nudge newbies
> towards.

I do not particulary view "feature richness" is the primary benefit
of 'push' that makes it shine.  'save' has a quirk in the command
line option syntax, but 'push' corrects it, and that is why we want
to move users towards the latter.

IOW, I do not object to the agenda; it is just I found the
justification used to push the agenda forward was flawed.

Thanks.
