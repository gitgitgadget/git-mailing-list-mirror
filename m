Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 854212047F
	for <e@80x24.org>; Tue, 19 Sep 2017 18:52:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750973AbdISSwG (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 14:52:06 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:43603 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750892AbdISSwF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 14:52:05 -0400
Received: by mail-lf0-f49.google.com with SMTP id c80so560661lfh.0
        for <git@vger.kernel.org>; Tue, 19 Sep 2017 11:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kX15ymashSnJjnZCrQ3Wo9+1iBYH1BROJBWsDsDA818=;
        b=TZ0ayy138vmjkGV4jpyB3yV2gVDxYrXWlXv0bF3iPZG7V9qHBJAB6XFWhrSthUd/9E
         aWeCgx+qQull43oHekkR4sV9l06cAbQwaAHpq+/lFP+qFkb2oQ7h3rsFsAnLeiyphyLP
         9Tx49dn046PTrjzZvsC2mDwqnhK0E9TOAW6v9opE4k9UJfWsJUnunmUt1wRriJp8Jcw8
         DIQSRRfIWqLc2rKmakdii2t4wnBWiaXSDmGV+0W0UkLCUCW3e6vDSbt1suUyvgwnLJcC
         Ymkeu2an5Y/pwbQRNLEwmczIEvHHeBSIM6UtnTF1VaSeFxmiW8eY5TYwms7dUo8fWeTl
         8U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kX15ymashSnJjnZCrQ3Wo9+1iBYH1BROJBWsDsDA818=;
        b=nJdpboEx1+pGX3QBpW5wRr2EuNtymY1rOjyacOOkGthuIsc9OAILiYUswpptZCAiXd
         VKuzdvRtPTOp5gEn9fbhc47jRm6Bv3XTN43rM8yr1siTZ2G+0P5t9+pP25cowfbzJqfA
         uDVLD6TvBE4r34VPCTz20dG+zt/SYaV1cFvgRdX9OYGcWM7dJriNUeNnEcoqu2mnfeIj
         EXETYl2mGOIxjaMtGbE1iIscLmrroDflpr2JGrx5n62FMk4bv8tBHuV0tM/xwDJmm3+r
         8/Sn2i98zpSrub/SQGF6+y4/As8ExCPuy6WgvDb5KaU39k40zmYvejKSjhL/KjHbi3Wo
         x6ig==
X-Gm-Message-State: AHPjjUhKeYlhV+3/RpqOaxi7eejpz9/+GLxOB9WgA+CEap2oWch6Ly8K
        o6nbP5Fb1rNEzy2gNASR1oY=
X-Google-Smtp-Source: AOwi7QBLznoFBJVmxSrjDHJ8tGReXM/IBec2328OX93iw/+D0JOqEZcSEWs2B8UBJnlfj2TAYsM5RQ==
X-Received: by 10.46.19.26 with SMTP id 26mr1136671ljt.20.1505847123669;
        Tue, 19 Sep 2017 11:52:03 -0700 (PDT)
Received: from localhost.localdomain (114.138.16.62.customer.cdi.no. [62.16.138.114])
        by smtp.gmail.com with ESMTPSA id c26sm1986ljb.12.2017.09.19.11.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Sep 2017 11:52:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, oystwa@gmail.com
Subject: Re: [PATCH] rev-parse: rev-parse: add --is-shallow-repository
Date:   Tue, 19 Sep 2017 20:51:56 +0200
Message-Id: <20170919185156.4285-1-oystwa@gmail.com>
X-Mailer: git-send-email 2.11.0.485.g4e59582
In-Reply-To: <xmqqlglbqstw.fsf@gitster.mtv.corp.google.com>
References: <xmqqlglbqstw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Hm, can you say more about the context?  From a certain point of view,
> it might make sense for that command to succeed instead: if the repo
> is already unshallow, then why should't "fetch --unshallow" complain
> instead of declaring victory?

A fellow in #git on Freenode was writing a script for automation and
encountered this error, and asked how to find out whether a repo was
shallow. My *first instinct* was to check if rev-parse had a flag for
it; I wouldn't have been surprised if it did.

I agree that treating it as a fatal error is a bit much in the first
place, but I also think having a way to check can be useful. I also
wonder if a lot of the stuff rev-parse is used for now should be moved
to some sort of `git misc` command, but that's a different can of worms,
so into rev-parse a new flag went.

> What does git-path mean here?  I wonder if it's a copy/paste error.
> ...
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Yeah, the titles were copy-pasted without adjusting, thanks for fixing,
Jonathan! ;)

> I agree with the fixes to the test titles suggested, so I'll queue the
> patch with the fixes squashed in.  Hearing "yeah, the titles were
> copy-pasted without adjusting, thanks for fixing, Jonathan!" sent by
> =C3=98ystein would be super nice.

Sounds good. Thanks for queueing my patch. My fourth!

Øsse
