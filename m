Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA1B720A10
	for <e@80x24.org>; Fri, 29 Sep 2017 02:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751058AbdI2CoW (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 22:44:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750891AbdI2CoV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 22:44:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4BF1AEA88;
        Thu, 28 Sep 2017 22:44:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=huo4oraxH2/OTjq5zj1m4q6YS38=; b=O8gcpT
        k7nKoibXi3SNRMMKoKq5BPs0yX9iICcOURtbvmmzvFOqSmmpeTJWmbPCS/h4+JPN
        987eJ7IiGOOEv1jPS+PZn7aFDZ8ZAULGCNvA4LpjlxlXyW4Y1iNAUR/pZl+iPypZ
        BE7/uqQHkn6WCML/3Ft1GNf0WSm5MRJtMplTA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=w1ZS+CIz2ZGNpPbLKoOFkzF9Nv95mVj9
        MqG2bIe5yoSIP3SZfGDRG5ISuK5zriyD43T0wVIhSAIr3bueTBK88ekP57wXYI8o
        /oWfJIN2lkZ9dl5qC8FEstynVr14iZTW38ZkfnTefWPLwJYi3wWmX5YBU6wsMpQP
        IRukbIRjJoU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BAA94AEA87;
        Thu, 28 Sep 2017 22:44:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 31BC6AEA86;
        Thu, 28 Sep 2017 22:44:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Eric Rannaud <e@nanocritical.com>, git@vger.kernel.org,
        jeremy.serror@gmail.com, "Shawn O . Pearce" <spearce@spearce.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH 1/1] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
References: <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
        <5b6001e7db3c57fdd9e6354ed4294e2192524061.1506574951.git.e@nanocritical.com>
        <20170928125916.GB9439@dinwoodie.org>
Date:   Fri, 29 Sep 2017 11:44:19 +0900
In-Reply-To: <20170928125916.GB9439@dinwoodie.org> (Adam Dinwoodie's message
        of "Thu, 28 Sep 2017 13:59:16 +0100")
Message-ID: <xmqq3776z0jg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18155250-A4C0-11E7-A3F2-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

>> Also adding the necessary PIPE prereq, as pointed out by Ramsay Jones.
>
> Cygwin doesn't have the PIPE prereq; I've just confirmed that the
> previous version of this patch has t9300 failing on Cygwin, but this
> version passes.

Thanks for a report.  So the patch should be good to go, it seems to
me.

Eric, thanks again for working on this one.
