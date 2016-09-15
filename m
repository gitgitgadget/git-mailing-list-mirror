Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 376642070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753259AbcIOS3H (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:29:07 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53539 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753295AbcIOS3F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:29:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FD233DF16;
        Thu, 15 Sep 2016 14:29:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Wtz9fbAdg/Fl1Fk+cVbNMvGB6qs=; b=rV6Z0v
        n4lX0/FX6pXFRc2BJDkRqMZ0H4JvRi30XYXkYZR/AV99p2dmNW+osszPKHqMFAAv
        1Fhd4y2cFrveVEBvKESai1NCAOEsyzZBV3zl0EXZEZzC4o4Ujwu7LhpiyiVL95TP
        gfQYXV3TKEdHF/hva0kW/7LlZDzxCcMArXV7o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iDgWcXB6socg+quHkLhDR2MlnLkHe0K0
        kUQpDEIz/V6qC2BhtloqxLTOoRzLk+WRn4EbyQ0/AQME6tYvdFKiPOcNVOvT4mVM
        g6y8xtcgfvEvtK9sH9vu68yPbFSvOqfmyvim+Z5eYqoQZeT9OtczzhOloMyfRvB6
        YqI6+rVyWC0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 695F93DF15;
        Thu, 15 Sep 2016 14:29:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C42AF3DF13;
        Thu, 15 Sep 2016 14:29:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yaroslav Halchenko <yoh@onerussian.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [wishlist?] make submodule commands robust to having non-submodule Subprojects
References: <20160915130233.GC9833@onerussian.com>
        <CAGZ79kZLdsKcf0t=dDB24VVe+V=uqQCW_VNQwSJ638m5Keu2nQ@mail.gmail.com>
        <xmqqwpidniry.fsf@gitster.mtv.corp.google.com>
        <20160915181254.GN9830@onerussian.com>
Date:   Thu, 15 Sep 2016 11:29:00 -0700
In-Reply-To: <20160915181254.GN9830@onerussian.com> (Yaroslav Halchenko's
        message of "Thu, 15 Sep 2016 14:12:54 -0400")
Message-ID: <xmqqoa3pnhjn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 46F24DE4-7B72-11E6-8929-2D857A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yaroslav Halchenko <yoh@onerussian.com> writes:

> do you foresee any unpleasant side-effects from above manual editing
> .gitmodules/submodule update --init ?

I do not think so; you essentially did what a canned command we
should have had should have done by hand because of a lack of such a
feature.
