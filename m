Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F40C820372
	for <e@80x24.org>; Fri, 13 Oct 2017 01:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753471AbdJMBjf (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 21:39:35 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54295 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753327AbdJMBje (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 21:39:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B076A79C1;
        Thu, 12 Oct 2017 21:39:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=Z2cIsq90WyRKj0EJlV3VLSX+5qY=; b=sU1g7KhoKHxL2iiKfjsg
        dcVvoOEwR9lyIH4ufNuqRhEbKW6aoxQED7lkCKn13QTIiByr6JjPBZsN0OMYkhIR
        JBwbW7cB5qmbiP9XgmYtY1SHkP9HygJ9I/gzBhhHP+laW/wexgKpaZ1hmJEAefjQ
        oxd+c6H6E075CA/gBQpSYJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=VyhXbCW9n/2gaY1UYedqi/clmWiQ/2O456Xl17jz6yUqZJ
        WCkKLHSWWzniYWgdzpO6T/groWDkcC6GRkStio4bm5nx5mm5zvZjJZTSXNDEq+1A
        lLiMVutLP+DnGVfQSCkd0l5U1EyuXY7yRP2NH31DadzSBRRuw6LR4kT5lfvis=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12CD1A79C0;
        Thu, 12 Oct 2017 21:39:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60002A79BF;
        Thu, 12 Oct 2017 21:39:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Marius Paliga <marius.paliga@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>, thais.dinizbraz@gmail.com
Subject: Re: Enhancement request: git-push: Allow (configurable) default push-option
References: <CAK7vU=0ztEwMPsGO4Cd1A5JEnxmwkF57QPKjjvjD8rBUB79dRA@mail.gmail.com>
        <CAGZ79kaBJnXW=rSiKuHpds79mXVL0Aoo+PBa0a5V-C_bop=Kbg@mail.gmail.com>
        <CAK7vU=3whGsx4L4KACSC+XDWQEbUWuZZZqTsW2R=CbF8d7rkuQ@mail.gmail.com>
        <CAK7vU=22W9mYdSnw_LP2uWYyKZuTzF0JgTVWCX+nMhUnLjQ_Cw@mail.gmail.com>
        <xmqqh8v5ls8i.fsf@gitster.mtv.corp.google.com>
        <CAK7vU=0wbGsFCXmwmCc-XX9K07UF_OZ7tFa4_GVb-H7fxakssg@mail.gmail.com>
        <CAK7vU=0A_nf2bAgV6dQyiesLJ3HHs5guyfNSNTwzYzgS2+YeWg@mail.gmail.com>
        <CAGZ79kZEQ9WeJdTu83PxC7KSfvQAE3aX4D0M-vRth8P5O2TrVA@mail.gmail.com>
Date:   Fri, 13 Oct 2017 10:39:32 +0900
Message-ID: <xmqqh8v3x1uz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5D2602CA-AFB7-11E7-B322-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Junio,
> do we have variables that behave similarly to this?

If you scan Documentation/config.txt, you'll find http.extraHeader
as an example' but I do not recall offhand if that was the original
that introduced the convention, or it merely followed precedence set
by other variables.

