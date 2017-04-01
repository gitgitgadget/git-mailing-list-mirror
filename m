Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF48320958
	for <e@80x24.org>; Sat,  1 Apr 2017 17:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbdDARig (ORCPT <rfc822;e@80x24.org>);
        Sat, 1 Apr 2017 13:38:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64520 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751661AbdDARif (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Apr 2017 13:38:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 92DD28B233;
        Sat,  1 Apr 2017 13:38:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F6H6bO+EDuel/GPXQTtBVKfM03w=; b=auJY8h
        0cq0NvedMPudfnGDW3+8k0iILD5j/r4ANNCnvL/7dCUaTb+J9HcAZxi1ZPMxm7Q8
        s4w0laWOZLKwSqCB+1CE7zJhrREd7REXQF6RAaLvd4ZeMVfLiOohPCw/PWE7GeUC
        8wnRZRTzBb3yNLqtAx/67HLnnDXYPGCt6sKRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hWHU+sW52zm801DQuIYCsJsZF4MMMcDp
        wbvvczt+JDdG2C2p3i09NtPu/qLeBCP4h622QtlavuKC2H7JBamz9ZALzqnIuQsM
        dfO8DguvO3ACO78ScjQN/6OqKfILuvRGWAfjLDhVt41nLoNDT6pP1o2xcAJk556J
        xFORrPATWgs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8ADCB8B231;
        Sat,  1 Apr 2017 13:38:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A2668B230;
        Sat,  1 Apr 2017 13:38:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael J Gruber <git@grubix.eu>,
        Stefan Beller <sbeller@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] Localise error headers
References: <cover.1483354746.git.git@drmicha.warpmail.net>
        <20170104070514.pxdthvilw66ierfz@sigill.intra.peff.net>
        <8d0966d0-1ef1-3d1e-95f5-6e6c1ad50536@drmicha.warpmail.net>
        <20170110090418.4egk4oflblshmjon@sigill.intra.peff.net>
        <CAGZ79kYVc0YQ4okrTHGiYQzPqfiVAm_f7orXdkhwgf5kMPXj-w@mail.gmail.com>
        <20170111113725.avl3wetwrfezdni2@sigill.intra.peff.net>
        <xmqq1sw9piz5.fsf@gitster.mtv.corp.google.com>
        <20170121142048.ygbwc65un4whhtwn@sigill.intra.peff.net>
        <76f61fea-3d24-ec55-0cbc-64ee3d030dcf@grubix.eu>
        <20170401081256.fupby6oo5yf7wqdz@sigill.intra.peff.net>
Date:   Sat, 01 Apr 2017 10:38:30 -0700
In-Reply-To: <20170401081256.fupby6oo5yf7wqdz@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 1 Apr 2017 04:12:56 -0400")
Message-ID: <xmqq1stcvxih.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06A02154-1702-11E7-96C0-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Mar 30, 2017 at 05:18:59PM +0200, Michael J Gruber wrote:
>
>> I read back the whole thread, and I'm still not sure if there's
>> consensus and how to go forward. Should we let the topic die? I don't
>> care too much personally, I just thought the mixed tranlations look
>> "unprofessional".
>
> I don't have a strong preference either way. I also don't care
> personally about the output (as I do not localize at all). My main
> concern was keeping the code simple for developers. But if consistent
> translation is important for people in other languages, I'm OK with
> whatever we need to do.

 (0) I do not mind the status quo, and I do not mind telling an end
     user who comes here with a translated message from die() to try
     running it again in C locale, either.

 (1) I do not think messages (including prefix) from die(),
     warning(), and error() are sacred, even when they are given by
     plumbing commands.  If the list concensus is that we want to
     see all translated in the ideal endgame, I think it is OK not
     to special case the plumbing.

 (2) I found your

         vreportf(_("fatal: "), err, params);

     a reasonable approach, if the we all agree with (1) as our
     goal, and want a way to gradually get us closer to the
     "everything translated" endgame.

I do not know what is professional and what is not in this context,
though ;-).

Michael, thanks for pinging the thread.
