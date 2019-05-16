Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 005FC1F461
	for <e@80x24.org>; Thu, 16 May 2019 01:56:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfEPB4a (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 21:56:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61946 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbfEPB43 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 21:56:29 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E0BF514603D;
        Wed, 15 May 2019 21:56:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FYZCi7DYs3rRwneIfXcDGDV9G08=; b=ZL/1iK
        7F0IDt2o4LXROQccNm+OdKXUQ6EIaKfhXM96GIp+Pu/mzYmlF35Emfd8V+Qfp6Ml
        AbHaOu+etys5bh+ZaZ9i/PiBNYk/55cJnmC2WxuiZ4XmNTe8yGVrYt9V2PTCUa91
        DnSqaVOjOhyj15ajpCT3oP9MZ5ZzFLoyvYZp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=d16EAC6kCDDNeo28peZ0W+Strr+KcGfC
        XlsBzi8SqVaY6TB4dZKACEcqJnoqUfvxtJ/G39bqv3YfWkKLKtJi1AqCV37iKtrr
        kHVyulbkKcGTh7X7erIt5r40OWu+FZPnTMHSnWCn1KKnT9t1mfaRenc47kGF+PjR
        vpA7/1bCBe0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D672F14603C;
        Wed, 15 May 2019 21:56:27 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4816114603B;
        Wed, 15 May 2019 21:56:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/2] Doc: git.txt: remove backticks from link and add git-scm.com/docs
References: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
        <20190515224709.2936-1-philipoakley@iee.org>
        <20190515224709.2936-3-philipoakley@iee.org>
Date:   Thu, 16 May 2019 10:56:26 +0900
In-Reply-To: <20190515224709.2936-3-philipoakley@iee.org> (Philip Oakley's
        message of "Wed, 15 May 2019 23:47:09 +0100")
Message-ID: <xmqqbm035fhx.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D10901DA-777D-11E9-9102-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> While checking the html formatted git(1) manual page, it was noted
> that the link to https://git.github.io/htmldocs/git.html was formatted
> as code. Remove the backticks.

Good.  I just ran

	$ git grep '`https*://' Documentation/

to see if any hits I see are for the real URL the user may want to
click on.  There are some that are pointing at real sites, but I do
not think users would want to clickon  many of them while reading the
documentation.

Except perhaps for these to see what's there:

Documentation/git-archimport.txt:	Attempt to auto-register archives at `http://mirrors.sourcecontrol.net`
Documentation/git-cvsimport.txt:* cvs2git (part of cvs2svn), `http://subversion.apache.org/`

