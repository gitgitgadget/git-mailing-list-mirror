Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5523E1F790
	for <e@80x24.org>; Tue,  2 May 2017 23:18:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdEBXS1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 19:18:27 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35122 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750769AbdEBXS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 19:18:26 -0400
Received: by mail-it0-f67.google.com with SMTP id 131so4484715itz.2
        for <git@vger.kernel.org>; Tue, 02 May 2017 16:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ql6tMDa20fWkz6mPRhv0+aD2iXxGkkdmZ1PreJL8Q0s=;
        b=WV0gNeejx5rB0ItGHyvOvFff+3/89nG6PMspRvQlp/xLBCUt4F7FDmV/jSiOqW39OX
         TtDIEgxXAKlTB6sXs5MXqtiZlC0Nm5KCzgrAkMNMQmZyM9ZSS8N50sXE+RQycK9CvQ72
         rltQtHbXTbvzEQHYl67RE/ohiq0PF7Nc7wCMAS01/5mXxalPfGUASp9b+iDcYIIk/VEa
         JMTWQVFqlnb8yntMaVk2Uq1MdUzPb0KkxzKwOWysWLK02iB2JICRnClXJ+BPWphM+1wc
         7kV8loPxqNOLiZYmRSqyjTHAjFK6IvK7T5ZACkUr/7srld8fSGe3f5TRHFOM2L6ZyGNp
         d/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ql6tMDa20fWkz6mPRhv0+aD2iXxGkkdmZ1PreJL8Q0s=;
        b=X1DxOOXDZq3B93O14e03hwPCu4lzHIgJEwSvg8um65IZoNq/wj+MuKfV5pmJl6rHmZ
         YwVaiYw4Ka8P1KSU+jdIztEFZ098ZyIuGxHvHe51LQ5js8y79SMcBqfcvUoB/MewoNsH
         wVzKhu4Qq5Vh1VY4dZ+j3e4ZPGrZjjTnaH6AF+1pysMg05vzn005rIfIvQFV7yBtrhSy
         7fc6+2SKuy/0+jOQR/ulLZN6tEK0uUGty4b1j53FyMTuy0FgAvZzHuHdpckD2DcK75hY
         rGqJTFiMqTHk1z3/dN3aFUvAFmTKp/iePoMUkLPQLIqMLM8dNCak7AtxYvjNsS3+d34s
         jxjQ==
X-Gm-Message-State: AN3rC/66ThxlDFyyCseEA+zDWisQpZuqfyaXMYIHzMlYUFTpRcrHxuHz
        TF1x6lA5JIb6tdfAb6w=
X-Received: by 10.36.172.45 with SMTP id s45mr5874222ite.11.1493767105315;
        Tue, 02 May 2017 16:18:25 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id v18sm1635699ita.18.2017.05.02.16.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 May 2017 16:18:24 -0700 (PDT)
Message-ID: <1493767094.29673.37.camel@gmail.com>
Subject: Re: [PATCH v3 3/6] rebase -i: add short command-name in --autosquash
From:   Liam Beguin <liambeguin@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, peff@peff.net
Date:   Tue, 02 May 2017 19:18:14 -0400
In-Reply-To: <alpine.DEB.2.20.1705021732570.3480@virtualbox>
References: <20170502040048.9065-1-liambeguin@gmail.com>
         <20170502040048.9065-4-liambeguin@gmail.com>
         <alpine.DEB.2.20.1705021732570.3480@virtualbox>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On Tue, 2017-05-02 at 17:34 +0200, Johannes Schindelin wrote:
> Hi Liam,
> 
> On Tue, 2 May 2017, Liam Beguin wrote:
> 
> > teach `git rebase -i` to recognise short command-names when using the
> > '--autosquash' option. This allows commit with titles beginning with
> > "s! ..." and "f! ..." to be treated the same way as "squash! ..." and
> > "fixup! ..." respectively.
> 
> As the recommended way to generate those commits is by using the
> --fixup/--squash options of git-commit, and as there is *a much higher*
> chance of false positives when using a very short tell-tale such as `f!`
> (which could be an abbreviation for an expletive, likewise `s!`), I do not
> think we will want this change.
> 
> Let's keep handling just fixup!/squash!
> 
> Ciao,
> Johannes

I was not quite sure about this change. My guess was that since --autosquash
needs the whole commit title to find a match, the short version had little
probability of generating a false positive. I thought it made sense to include
the change in this series, but I understand why it's probably not a good idea
to take it. I'll remove it in the next series.

Thanks, 
Liam
