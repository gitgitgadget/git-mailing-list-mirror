Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	URIBL_RED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AE782018B
	for <e@80x24.org>; Mon, 18 Jul 2016 21:27:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbcGRV11 (ORCPT <rfc822;e@80x24.org>);
	Mon, 18 Jul 2016 17:27:27 -0400
Received: from mail-yw0-f182.google.com ([209.85.161.182]:34044 "EHLO
	mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbcGRV10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jul 2016 17:27:26 -0400
Received: by mail-yw0-f182.google.com with SMTP id i12so170888223ywa.1
        for <git@vger.kernel.org>; Mon, 18 Jul 2016 14:27:26 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=retz83R587goQsMkN1cfsCf8Er9Wq/LkVGPCm/r+wy8=;
        b=J25ynV7HiK+gkG1R/6re701mRmdAu4WuXMGIG8zPQz52JCPUo1LQyzq51m6R/rw6hB
         marUYidOuc2LFgZbQe5Xjfq4/R82ELDqZ/BpALfojuGyyhp9m6FjWLt6snXQ99Qu/ZNT
         /6Ax8LhG8z10u3fWCZzuF7WuyvoSnA8/fYQbtqQShlil0OGO9U86zc5uP1aqORLWzswn
         /gixyPkvFi2rdoQs3cK3zE4qeeT7isQ1ox5ieX0O3HuwafldPIQdCuSBTPrJItUmi+Y2
         KlD9A/PT/O4MQFc2hNAAZc0VJLh/DeHrJoWcXqXCl81bh6Y90CnniuSQs/23RiuMX184
         OyjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=retz83R587goQsMkN1cfsCf8Er9Wq/LkVGPCm/r+wy8=;
        b=O1ttlkwgu/6j9NOrCsgSIkz2b7NA05H453tu6CHBiA5BMIn7wO3zCedbw9Ekpx+IuY
         DLmqnEwcu6PXdINq0m+4AreF87MsZj6Rum95hRSjGa2ga4vOq9zjSBCCkEK9TAJZoudg
         zSlEPO4NaFGSinfSS4pcZ0yOdeeeZ2JqtKAKK80ZMVhDnNMpIAo9d2eRilRwVjJmklO7
         sZsnA72K5EUoVItBGgS2sym1BYrAEJYKa+QUmMp9meKQGiWy6P9zi/QvrRBe5NSzjn7g
         nLvA8duhraN0dw5p09Hn1a7N6uOZrE0xlqPrawpzeJTJI7/cXOpLDKBC1b7wKDR5Zoce
         B5Gw==
X-Gm-Message-State: ALyK8tIRbg3SPPh69A1bORAY3mONzyupCAO6Sp7ztaoJcFwcemmhFHpcSh9JgmjhjagVy+OhBfaSme6pkEMGEQ==
X-Received: by 10.37.51.9 with SMTP id z9mr23831892ybz.151.1468877245573; Mon,
 18 Jul 2016 14:27:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.240.66 with HTTP; Mon, 18 Jul 2016 14:27:06 -0700 (PDT)
In-Reply-To: <20160718211951.GA62657@plume>
References: <20160718064431.GA10819@starla> <20160718130405.GA19751@sigill.intra.peff.net>
 <xmqqshv6ivfk.fsf@gitster.mtv.corp.google.com> <20160718200351.GA61232@plume>
 <xmqqk2giitrn.fsf@gitster.mtv.corp.google.com> <20160718211951.GA62657@plume>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Mon, 18 Jul 2016 14:27:06 -0700
X-Google-Sender-Auth: 5LUCD35Nci7KK3jFRGkhawKw29I
Message-ID: <CAPc5daWnfA7C23Qa07Y-aYwWBebdn33qZMo4Sj+Evm3-fVUDcg@mail.gmail.com>
Subject: Re: [PATCH] test-lib: stricter unzip(1) check
To:	Eric Wong <e@80x24.org>
Cc:	Jeff King <peff@peff.net>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jul 18, 2016 at 2:19 PM, Eric Wong <e@80x24.org> wrote:

> Thanks, but I think the test file is too small.  I tried
> setting up a test to store the text file as binary in the
> zip to check for inadvertant CRLF conversions:
>
>   printf 'text\r\n' >binary && zip -B infozip-binary.zip binary
>
> But zip -B/--binary only works on VM/CMS and MVS...
>
> So I'm inclined to go with Dscho's patch.

OK, I'll wait for the final reroll and queue it near 'next' when it happens.

Thanks.
