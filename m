Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D57B20954
	for <e@80x24.org>; Mon,  4 Dec 2017 16:42:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752273AbdLDQmF (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 11:42:05 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:39186 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751069AbdLDQmB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 11:42:01 -0500
Received: by mail-pg0-f68.google.com with SMTP id w7so8563955pgv.6
        for <git@vger.kernel.org>; Mon, 04 Dec 2017 08:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=w+xt2N1GDj8uP5tVQKypgt7w08p84GhgIzSAnlLyS1A=;
        b=avVCi0UHhNd3c9ml3R/dtLMMMepN+d7LxFlqR0ulDB1tXKM8oT3XmWQ1NJ5W0IXJ17
         WLBYsxy9Orqc8Jp67HpfB9XzS9K7tv0eQnDiFR+dlNDBdJUGLgTCuR1qUQY2vjhLBlyh
         TffwyPkuD0XdBuiC/O9GIbjn1B9EDFaPAW/eBBjhAjPRB8e5nzVGg03Qp+hcV1ZEnpEo
         7F1qGB4SQu/h4zht7j85S1tgbvYAnL3JAQ3o38Zwv+G4x/wi21kQeMQCc4LK4MIh2NW8
         hU9BSEM3haGtjay04CYD5aR/lwKtbSTwwpHqQJpP/mmhMR0Bj6TaQ67fMNWz6iX/W5Ba
         8AZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=w+xt2N1GDj8uP5tVQKypgt7w08p84GhgIzSAnlLyS1A=;
        b=bIAypZJnxB4RlQXdfw0u7MPQ2bp/Wu4oT7/BLu5s8pWaJ3yps5X2Us8TnYyplQDfAN
         Wvmrc/9F2dNyKdRIHq6jgn6FvXdED0DRUJk31ouhV37qHW3SKVm8WT+TJ/pPTKa9C1iV
         aIvISi3kmUAOYTJjl+zIr/Qsola8rSdWKJgEm9T1blX/jF3sWdVq3yWpnxiT6rlcvAD0
         N1wJP3aAKP8jWpbyLoB8qZODg5fZef7xQ6TVlHMjzGlzETiTFNvkVNWN2SarMXsGrV+O
         qXfKcnSAlGipQmazzE7fxE0VMjaQJkn1Ou37xfO1uyHQ6NrYGP8E7oLFF5KFS0Z3YgMV
         QUgg==
X-Gm-Message-State: AJaThX7E3/hT9EpKkCKMXOFIBd4FWbbeaD4db+aqR2OtOl2tis2c7Qq7
        oy9TXQRy+CNQ/Vs+UrYGTqg=
X-Google-Smtp-Source: AGs4zMaynfWoKKvQqhZYclHzfb59XqVWjoCJJA8A4ZYOB5RVbfmHx20zsRDDqELCLNoft/0DPXjjNg==
X-Received: by 10.84.129.70 with SMTP id 64mr15185163plb.444.1512405720516;
        Mon, 04 Dec 2017 08:42:00 -0800 (PST)
Received: from unique-pc ([117.209.183.214])
        by smtp.gmail.com with ESMTPSA id n6sm25693650pfg.188.2017.12.04.08.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Dec 2017 08:41:59 -0800 (PST)
Message-ID: <1512405704.15792.2.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] launch_editor(): indicate that Git waits for
 user input
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Jeff King <peff@peff.net>, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        sunshine@sunshineco.com, sandals@crustytoothpaste.net
In-Reply-To: <D330CEDD-7F6B-49DB-A30E-EE0BDB80E28A@gmail.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
         <20171129143752.60553-3-lars.schneider@autodesk.com>
         <20171130205137.GC3313@sigill.intra.peff.net>
         <BB878570-F214-4BAA-AB58-4A9C0F8F80AB@gmail.com>
         <20171201182924.GB27688@sigill.intra.peff.net>
         <aacb7604-edc3-a920-da43-701b57045956@gmail.com>
         <D330CEDD-7F6B-49DB-A30E-EE0BDB80E28A@gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Mon, 04 Dec 2017 22:11:44 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2017-12-03 at 17:39 +0100, Lars Schneider wrote:
> > On 02 Dec 2017, at 04:45, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> wrote:
> > 
> > On Friday 01 December 2017 11:59 PM, Jeff King wrote:
> > > On Fri, Dec 01, 2017 at 01:52:14PM +0100, Lars Schneider wrote:
> > > > 
> > > > Thanks for the review :-)
> > > 
> > > Actually, I meant to bikeshed one part but forgot. ;)
> > > > +                       fprintf(stderr, _("hint: Waiting for your editor input..."));
> > > 
> > > I found "waiting for editor input" to be a funny way of saying this. I
> > > input to the editor, the editor does not input to Git. :)
> > > Maybe "waiting for your editor finish" or something would make more
> > > sense?
> > 
> > May be the good "Launched editor. Waiting ..." message, that was used in a previous version, itself makes sense?
> 
> Perfect bikeshed topic :-)
> 

Yep :-)


> I would like to add "for your input" or "for you" to convey 
> that Git is not waiting for the machine but for the user.
> 
>     "hint: Launched editor. Waiting for your input..."
> 
> Would that work for you?
> 

Yeah, this one does look fine.

That said, FWIW I don't have strong opinions about the phrase/sentence
except that they should be readable and shouldn't get too verbose.


Thanks, 
Kaartic
