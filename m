Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4CF1F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 16:08:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbfJGQIT (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 12:08:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40915 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfJGQIT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 12:08:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id b24so59916wmj.5
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 09:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aZwIRgadf4jV2/rIn6Xvu6S60BefXmzaW/IHOwLmfjY=;
        b=QqI30E3soSNzBbSme88HsvGurjKu5U1OFl1YYWu1fXDCZ1sctXD3rCR4mANcmU0uk2
         QP5vIAcIuIriTZIXokYmMS4+IHMEzuAlkPADjB06xAtQ4H9+0wz0AQznc+ITFWzsGesS
         cLfcIPZ570fx9wtkrMWfY3GUveMI+76o16s0jP/jFsB7exljKJAehIJItkuYyhS3YIXA
         oQU2T9hHrCCv3ynUixYrJRXmx/ctjhjLmXePgjADosV+WM+QynlOuNCnY+ai3JbI2icX
         FKG6bHvvi6MEssC9v/uq04iJtcRwDMSvzxyJBvxjAIJW5uJbrs4SN6CP1yxmBtPU/dnm
         a+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aZwIRgadf4jV2/rIn6Xvu6S60BefXmzaW/IHOwLmfjY=;
        b=YERIHTYH7egDaGCwaJCaR2MHVWbofshGKDPtk1Pq3gZq/xGtA1ChpXkTpgX0CZIdMb
         LL7qjtF3alBz5ey3eV6DJSPHjroAy5+HpuYKVUP13ADvfITxoCV+xvZU91tP1MX63cAw
         WtP0Fnyttz45ygpyXNfk59sRAancFdqzuRSouMfmrRaXXKUpo54zZkoZF+tMpHQx4HEJ
         gt+eFcJJrv6DXJTcdTEObxQFhycKS8cO3+ZMiIsiZAed/C4Gk7eRQg535ARr86ePsr4u
         xhX9JbrC3Ni7MHS+s4MMsF3nairIHo/5bJ7VWKlTAxR6ej0rT3sZZYiljsDBVSVarSZ0
         ioLA==
X-Gm-Message-State: APjAAAW/jnj8uFTYVDmYm1O1IA4p3DwgFRQLNYPIkI7+zSyI5E9CeNJH
        s9x0Kb4ixfdO8Xw9ubjKz38=
X-Google-Smtp-Source: APXvYqyf3w2N4QEmJNQgBr1yfHRXY2Egst05c5fj50BiKo87EzttAOBCUKAwwmS+t2OZcMjjvuSheg==
X-Received: by 2002:a05:600c:2293:: with SMTP id 19mr70401wmf.26.1570464497566;
        Mon, 07 Oct 2019 09:08:17 -0700 (PDT)
Received: from localhost ([95.149.189.152])
        by smtp.gmail.com with ESMTPSA id r7sm2325883wrt.28.2019.10.07.09.08.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Oct 2019 09:08:16 -0700 (PDT)
Date:   Mon, 7 Oct 2019 17:08:16 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in our
 Azure Pipeline
Message-ID: <20191007160816.GB74671@cat>
References: <pull.288.v2.git.gitgitgadget@gmail.com>
 <pull.288.v3.git.gitgitgadget@gmail.com>
 <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
 <xmqq5zl15q1c.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5zl15q1c.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07, Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Date:   Fri, 04 Oct 2019 08:09:25 -0700 (PDT)
> > 	[...]
> > 	X-Google-Original-Date: Fri, 04 Oct 2019 15:09:10 GMT
> > 	[...]
> >
> > I am fairly certain that the latter is the actual `Date:` line sent to
> > GMail, and GMail just decides that it will not respect it.
> 
> If the submitting program said "Fri, 04 Oct 2019 15:09:10 +0000
> (GMT)" instead of "Fri, 04 Oct 2019 15:09:10 GMT", that would match
> the format the MTA produced itself, I guess.  I am kind-of surprised
> if the problem is the use of the obs-zone format (RFC 2822 page 31),
> but anything is possible with GMail X-<.

Yeah, the obs-zone format did seem to be the problem.  I just dug up
the previous thread we had about this, where I confirmed that +0000 as
the timezone worked just fine in my setup through GMail [*1*].  Note
sure if the (GMT) would cause any problems, but I'd agree with
avoiding it as you mention below to make sure GMail doesn't do
anything funny with it.

*1*: https://public-inbox.org/git/20190318214842.GA32487@hank.intra.tgummerer.com/

> How does send-email write that date header?  Matching that would be
> probably the most appropriate, if possible, given that GGG was
> written for send-email refugees, I guess ;-)
> 
> Here is what its format_2822_time sub does, so +0000 without any
> textual zone name, it is.
> 
> 	return sprintf("%s, %2d %s %d %02d:%02d:%02d %s%02d%02d",
> 		       qw(Sun Mon Tue Wed Thu Fri Sat)[$localtm[6]],
> 		       $localtm[3],
> 		       qw(Jan Feb Mar Apr May Jun
> 			  Jul Aug Sep Oct Nov Dec)[$localtm[4]],
> 		       $localtm[5]+1900,
> 		       $localtm[2],
> 		       $localtm[1],
> 		       $localtm[0],
> 		       ($offset >= 0) ? '+' : '-',
> 		       abs($offhour),
> 		       $offmin,
> 		       );
> 
> 
