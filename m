Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FEF31F4F8
	for <e@80x24.org>; Thu, 20 Oct 2016 17:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753804AbcJTRum (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Oct 2016 13:50:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63385 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752106AbcJTRul (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2016 13:50:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9ED1547E8F;
        Thu, 20 Oct 2016 13:50:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Bu4N0vz6T8VhyjxtU4tfvXdA7Dw=; b=u7bJIe
        Bx/Kf+MtszGKKAgQGzXdlrNWYWY/Alh+HzDio36hAwYgHYr4OxDwawWpcNH8agCJ
        NrEAfXsugTwozxSmIZiJDMWwpW8e+HW/2R+q4yM1BdRAGucnPqMrbn3XJrqJcG7Y
        QtmCeW9YTcPd5LVPlR5LFU93EiBC/wFpPYCS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X4RK879YaH2zDuEbWep8szHmFFVcoTnB
        lJ6YzTZsZKrAz68kvFBA2MTpChHOMDbbr3PpF+oNyV7zJYo1gQylezOvzdTz4KPj
        0v8q/mztNsqql7mgti/HzM3WnG+e9XFhRlfeW6J1gGnd0pmKPZd7anuxXkF1Wdxz
        Wp1NYSzXnNk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95D5947E8E;
        Thu, 20 Oct 2016 13:50:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 17C1347E8D;
        Thu, 20 Oct 2016 13:50:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: Fwd: New Defects reported by Coverity Scan for git
References: <580893d5a4736_4ed37b53181837@ss1435.mail>
        <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
Date:   Thu, 20 Oct 2016 10:50:37 -0700
In-Reply-To: <CAGZ79kabVPhp0_z-e_4jJOFq+jzSE2SsgmFuY-2RUgrEviGKyA@mail.gmail.com>
        (Stefan Beller's message of "Thu, 20 Oct 2016 10:05:38 -0700")
Message-ID: <xmqqshrqhpua.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B64A7130-96ED-11E6-B28E-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Not sure what triggered the new finding of coverity as seen below as the
> parse_commit() was not touched. Junios series regarding the merge base
> optimization touches a bit of code nearby though.
>
> Do we want to replace the unchecked places of parse_commit with
> parse_commit_or_die ?

The reason parse_commit() would fail at this point would be because
the repository is corrupt, I do not think it would hurt to do such a
change.  

I agree that it is curious why it shows up as a "new defect",
though.

By the way, do you know who is managing the service on our end
(e.g. approving new people to be "defect viewer")?  The site seems
to think I have the power to manage others' subscription, which I do
not think I have (I do not go to the site myself).  As it spewed
quite a many false positives into my mailbox in the past, I do not
pay very close attention to these reports these days, but I still
read the e-mailed reports every once in a while.

Thanks.
