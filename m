Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F98B2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 22:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751712AbdBOWuW (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 17:50:22 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35464 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbdBOWuV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 17:50:21 -0500
Received: by mail-pg0-f68.google.com with SMTP id 204so57495pge.2
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 14:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=a31HpM6JO6m2Ji6zC6/cZA/RQtNKNxRxzdKiU1PZx58=;
        b=di7Ls0MtVSfebRKS6oZzf7+wn4/jQtTs6LQOXrlbJmcwAOvt03Gmk+/C7X1uTmHixb
         nTLP9ezY5z7rpM58B26rBxI/KPa+zk5nRGFRyJ2Vpw0dVc93ouOS6CKeBzkBKtu/2Dnr
         ez7OpG1/E+/Y+jjzQBDT9c/isGFL1wHsv8JMSjfAWetZ4Zo2p1n2yopiHJzZg6ITCbFl
         OCBPBMRO+Sybso6wR4BqyBp07Vp8aJIFESa4K7NNsOmsj61CQAH0OUJA7XWjwXUTYO/5
         zbSsXmcHB7nQVZs/zzW6dzbKOgWHto3qrSETIZ3/jkwi8t+2OqRIe8Q/O80lR8Eorpu2
         EqXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=a31HpM6JO6m2Ji6zC6/cZA/RQtNKNxRxzdKiU1PZx58=;
        b=mWU+RIV+tInWNWGfK/S8x9Tz0OFgEJIe9L221YSZGl/gryFoPYMFYMEaiWWSro12r1
         /Nq/+GBt1opNW2q3pvMKiD4vjC/DytBaz1Gx/fPTKZTNg6kfivi1UegGMvDaF6MSooa3
         FZqo8mcm4D58ccWGsJa+4R2nBFKPXTZTH/LTgYZI3lwiTfMwJ4LG6Qdncp4EWkWnlbvn
         ErEv9FRNOQFKdAs3BRwRacY1zzHd2Yo6PNgtsOVZL0ekcdkyxJHIlP2HULfzyB6gUocQ
         i1kPKili8uW6Cj/1PGflfnCeco784yIBpOhQ2FkkvC5jlc24ybg5KEMFs/aEEq5UNs5d
         tthA==
X-Gm-Message-State: AMke39n89SBg5/IzmA//5oZi7/Om6Rw38w8w83R+fK0xnJKLtmMFaOXn+rakEyXZLDRK8A==
X-Received: by 10.84.211.137 with SMTP id c9mr46026248pli.8.1487199020483;
        Wed, 15 Feb 2017 14:50:20 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id o66sm9311002pfa.119.2017.02.15.14.50.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 14:50:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?J=C3=A1chym_Barv=C3=ADnek?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: Confusing git messages when disk is full.
References: <CABpqov=FE-h_2s=O9fkSjFjgFXSy6hDwc2fu5ijiVvkaLx9f_Q@mail.gmail.com>
        <20170215213221.lnraiktneokpk3mg@sigill.intra.peff.net>
        <xmqqk28r2kk4.fsf@gitster.mtv.corp.google.com>
        <20170215215151.a5chtxyjhbe3og4p@sigill.intra.peff.net>
        <xmqq7f4r2io5.fsf@gitster.mtv.corp.google.com>
        <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net>
Date:   Wed, 15 Feb 2017 14:50:19 -0800
In-Reply-To: <20170215223246.mkaz22yrovnscnne@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 15 Feb 2017 17:32:46 -0500")
Message-ID: <xmqq37ff2hn8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> Good catch. I think we use a nasty bitwise-OR elsewhere to do that.
> Ah, here it is, in tempfile.c:
>
>                 /*
>                  * Note: no short-circuiting here; we want to fclose()
>                  * in any case!
>                  */
>                 err = ferror(fp) | fclose(fp);
>
> That works, but the fact that we need a comment is a good sign that it's
> kind of gross. It's too bad stdio does not specify the return of fclose
> to report an error in the close _or_ any previous error. I guess we
> could wrap it with our own function.

Sure.  I am happy to add something like this:

	/*
	 * closes a FILE *, returns 0 if closing and all the
	 * previous stdio operations on fp were successful,
	 * otherwise non-zero.
	 */
	int xfclose(FILE *fp)
	{
		return ferror(fp) | fclose(fp);
	}

I do not think we should try to do anything fancier to allow the
caller to tell ferror() and fclose() apart, as such a caller would
then need to do

	switch (xfclose(fp)) {
	case 0: /* happy */ break;
	case XFCLOSE_CLOSE: do "close failed" thing; break;
	case XFCLOSE_ERROR: do "other things failed" thing; break;
	}

and at that point, "other things failed" code would not have much to
work with to do more detailed diagnosis anyway (the errno is likely
not trustable), and it is not too much to write

	if (ferror(fp))
		do "saw some failure before" thing;
	if (fclose(fp))
		do "close failed" thing;

instead.
        
