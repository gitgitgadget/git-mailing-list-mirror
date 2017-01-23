Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E840F20A17
	for <e@80x24.org>; Mon, 23 Jan 2017 18:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751272AbdAWSPP (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 13:15:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60733 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751124AbdAWSPP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 13:15:15 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9C7CB610E1;
        Mon, 23 Jan 2017 13:15:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=18cDeC/XaQknfzoPSECX0LTI6Pg=; b=NlYr3V
        DfKu11+6bTcFCYzpott0zGWwef/GzQGejp832ApfBwT9XTDHcQu8rx+3e+l5mHsj
        pno7OwvgArUvzPKdC8c9FhkAoAyeG4T1zT+lYQTk7gEF7IGNFQ5hlu2MU70yw+5f
        gwMPT8MlhVNgGY2eOJdhwnpLd07nrzpkpD8s4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K5run5xXAf9wIlGLnFeL31pL2lI47uCd
        d7CSWY4XPDLXsY+hW4UBJVb51J9gKAnczZWgdCDkJ8B98DW1dgktBDMnjvKJAug2
        dkDgoPMmAS/blWNkEWgGFc8XDseeexn3MiIabQCxRGDgvum9c22CM88wxTZhR4j7
        4msEbplFneQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93084610E0;
        Mon, 23 Jan 2017 13:15:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E636D610DF;
        Mon, 23 Jan 2017 13:15:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] Option to allow cherry-pick to skip empty commits
References: <20170121131629.16326-1-giuseppe.bilotta@gmail.com>
        <xmqqpojeu14h.fsf@gitster.mtv.corp.google.com>
        <CAOxFTczut_CGGxmbrVFzhn_o4=StTOY6N1mEAw75Ro2Q4tzWgQ@mail.gmail.com>
Date:   Mon, 23 Jan 2017 10:15:12 -0800
In-Reply-To: <CAOxFTczut_CGGxmbrVFzhn_o4=StTOY6N1mEAw75Ro2Q4tzWgQ@mail.gmail.com>
        (Giuseppe Bilotta's message of "Mon, 23 Jan 2017 11:18:37 +0100")
Message-ID: <xmqqd1fdtzgv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E29C7BDA-E197-11E6-9AF7-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> By the way, I noticed going over the code that the -allow options are
> not stored, so that in case of interruption they will be reset, is
> this intentional or a bug?

I do not know offhand, but given the history of the two commands, I
would guess it was a bug simply overlooked when people bolted "a
series of commits" mode onto these commands that originally worked
only on a single commit.
