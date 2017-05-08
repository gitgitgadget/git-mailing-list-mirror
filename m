Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C9531FC44
	for <e@80x24.org>; Mon,  8 May 2017 21:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751089AbdEHV1f (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 May 2017 17:27:35 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36073 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750839AbdEHV1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2017 17:27:34 -0400
Received: by mail-it0-f66.google.com with SMTP id x188so8635915itb.3
        for <git@vger.kernel.org>; Mon, 08 May 2017 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VYqXXtWfLXk0qYYtPx67pBiuvrnwhU0iac2znCIpjpo=;
        b=s+XhHqgfg3G0e2UHuHnrDTA0iJqntjrf/IBOZ0+apoge08pGBuWlIoiJDBNL1nIGbq
         60YL5KCS2X7y4L2PeX0QF7L04sZNMkdN5oqoPw07dG97BhXcwX6rlXwvSQfwNRdWWF8y
         MEdX2yxcI2t7D+l2KXIXQhQGDYsEzaYRPob1MCtZClK84RLEl5NubnVK3p6ski+Fad42
         sZlIhZgmCTrl3qOumfJbxGz3QWLZ6wG5jZ7ZW/L3gqiaaMZabs30T1PtFUA0dyk17BJk
         GZnySCWbsijV0Ilh+FeEXetIfYHOKsusKhcDvdrMdazR80HuAH/SM1GoUzRULCn9ASU2
         tA9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VYqXXtWfLXk0qYYtPx67pBiuvrnwhU0iac2znCIpjpo=;
        b=RNVlaaMhTpUxpTUtAj7ChwuDH+EwK1a6J5uHjsURw98P8jOU1CUzxNGmY6kGewNCKX
         oRWwW98qs5XyBlfsvvLD1O9ieRm5jwlR6OTySJbmrJrTxqbF28buARwXutagwDRGfOMQ
         w9wmdLDaiY5e45fDd3YzbzBeRQs2Y+AOLLl8t+gNQf+VQdcGMOYKCC15aPIY5qs6PqXL
         KWkZwbGYz7++D6vsspMfhp46CRIk/5Ph1uUYRpuj4iETzzrn9+Uc9u0hWbfW0nDeZLjs
         7UsMVmouA7rU3s0CJvJQPtEDPMvZGe3raLbu6d3dPop4yFSBFp91ltPIINsY0zkFrCqP
         oyag==
X-Gm-Message-State: AN3rC/5S05i7hfYJgXWgeda+sZBAAZpnj30lPuOIiSH96Rs+Sn2cgM1n
        wO6dtW7/CO9hww==
X-Received: by 10.36.111.205 with SMTP id x196mr23325339itb.117.1494278853760;
        Mon, 08 May 2017 14:27:33 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id y96sm5141143ita.9.2017.05.08.14.27.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 May 2017 14:27:33 -0700 (PDT)
Message-ID: <1494278850.32697.4.camel@gmail.com>
Subject: Re: [PATCH v3 0/6] rebase -i: add config to abbreviate command-names
From:   Liam Beguin <liambeguin@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, peff@peff.net
Date:   Mon, 08 May 2017 17:27:30 -0400
In-Reply-To: <xmqqo9v4chv4.fsf@gitster.mtv.corp.google.com>
References: <20170502040048.9065-1-liambeguin@gmail.com>
         <alpine.DEB.2.20.1705021741580.3480@virtualbox>
         <1493769381.29673.39.camel@gmail.com>
         <alpine.DEB.2.20.1705031315460.3480@virtualbox>
         <xmqqwp9x9prp.fsf@gitster.mtv.corp.google.com>
         <1494177195.32697.2.camel@gmail.com>
         <xmqqo9v4chv4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 2017-05-08 at 09:27 +0900, Junio C Hamano wrote:
> Liam Beguin <liambeguin@gmail.com> writes:
> 
> > Sorry for the delay, I don't mind switching to C but it would probably
> > be easier to see if the scripted version gets approved first.
> > If it does, I could then get started on the C implementation.
> > If you prefer I could also forget about the scripted version, make a C
> > implementation work and see if that gets approved.
> 
> I am not sure what "approved" would mean in the context of this
> project, though ;-) Your patch to the scripted version would
> certainly not be in the upcoming release.  If you define the
> "approval" as "it is queued to my tree somewhere", the patch would
> start its life like everybody else by getting merged to the 'pu'
> branch, where there already is a topic that removes the code you
> patch your enhancement into.
> 

By "approved", I guess I meant the list reaches an agreement. 

> The list _can_ agree that it is a good idea to have an option to
> populate the todo list with shortened insn words from the beginning
> (instead of merely accepting a short-hand while executing), which is
> what your patch wants to do, without actually having the updated
> scripted "rebase -i" merged in any of the integration branches in my
> tree.  If you meant by "approval" to have such a list concensus, I
> think you may already have one.  I personally do not think it is a
> great idea but I do not think it is a horrible one, either.  As long
> as it is an opt-in feature that many people find useful (which may
> be the case already, judging from the list traffic), I do not mind
> ;-)
> 

Ok, based on this, I'll send a new series based on the 'pu' branch.

Thanks again, 
Liam
