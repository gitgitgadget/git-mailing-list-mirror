Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 571B020C11
	for <e@80x24.org>; Fri,  1 Dec 2017 03:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbdLADmH (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 22:42:07 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38964 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752221AbdLADmG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Nov 2017 22:42:06 -0500
Received: by mail-pl0-f67.google.com with SMTP id bi12so5524806plb.6
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 19:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:in-reply-to:references:date
         :mime-version:content-transfer-encoding;
        bh=XsHcebwYMfc7q4O/R2WhkeNKMZiITHGp53WE6eP5T30=;
        b=TmA9DequMHpYYK3VMJ0mCs8ICAvUrtE8m/S6oqFs/B21fSlbkjZChekGB9lBk/UhzA
         x8RqI9L94V8ISeWjt4pxGliuphzZRWjqEAa3uCTe6j3Lb/BfMdGUQSLavEuIQJrC0/8J
         D/sFAJaigRMsnZcmksh+TLNqRn4XZjFCl/Fjy3quPeNYNBfiKN+nsL9K3sMSqlb98uUI
         GgrwhyZESM3iWCNssYP0uXh/eY2uzgPrzvNIST/SQWPGeBma8bEvf9K8jNG9QIluE+6j
         ZAXRvAkKML2ardPOlV/yInYnvCLk7LD0uzW9lkwtZ06Z7me8nOOJUBUzJwTjHDBQtan1
         34UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:date:mime-version:content-transfer-encoding;
        bh=XsHcebwYMfc7q4O/R2WhkeNKMZiITHGp53WE6eP5T30=;
        b=tYKNtYrLI+nR8PwE0WonT/id/JOir6dSZfYo2eTlNafAwRYqNnLKqBLkhi+bJ76kTC
         +ukUjnKxM3JAGW/vTk0I95w2OrdR9r8K9QXtruCSY/X0/QJt+oVzLXoUcQ85kxSRSdEJ
         igo1W8LpqOGDYXMW1fzyQY1iyOBWuIkjWZg5PlNrYX1ULqakSC8xh6HlAWe4jUSGoPW5
         QpaL5f2F4QnbehkK1vRBgfcA4LumnSTqekRhq6VaHk9Lb+4nhfPpAqR2SPg3hUK1Gp+A
         r+aYcGnClt71+C+Rw0ZqG7lHz5dCnWq1RWyumClcCLzhou4EvUb5EF8qLdja54D77UlM
         KvIw==
X-Gm-Message-State: AJaThX4Kaf1N/PMl0FTx9cUZZqPHVakAc7av9QZspK9y07MkChColZrC
        1uPir3HKBZuwRsH4+T3VSQw=
X-Google-Smtp-Source: AGs4zMY/jiGgw7SPPhW0HBNXecim3b5fPWpys5J/+3dKVF6HnwtzPeN7tmqq13d6JnrvcLJUqRHVJw==
X-Received: by 10.84.238.140 with SMTP id v12mr4760506plk.356.1512099725925;
        Thu, 30 Nov 2017 19:42:05 -0800 (PST)
Received: from unique-pc ([117.249.175.222])
        by smtp.gmail.com with ESMTPSA id 77sm10033240pfh.43.2017.11.30.19.42.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 19:42:05 -0800 (PST)
Message-ID: <1512099716.7882.2.camel@gmail.com>
Subject: Re: [PATCH v4 0/2] launch_editor(): indicate that Git waits for
 user input
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Thomas Adam <thomas@xteddy.org>,
        Lars Schneider <larsxschneider@gmail.com>
Cc:     Lars Schneider <lars.schneider@autodesk.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, sunshine@sunshineco.com,
        sandals@crustytoothpaste.net, peff@peff.net
In-Reply-To: <87a7z3re9a.fsf@linux-m68k.org>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
         <20171129183514.wze5trxjfgqxqs7z@laptop.local>
         <C91E8F24-DD13-4FEC-BAB3-A8B8F2DBBA8D@gmail.com>
         <20171130144255.5w72jcpz4a5igiro@laptop> <87a7z3re9a.fsf@linux-m68k.org>
Content-Type: text/plain; charset="ISO-8859-15"
Date:   Fri, 01 Dec 2017 09:11:56 +0530
Mime-Version: 1.0
X-Mailer: Evolution 3.22.6-1+deb9u1 
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-11-30 at 16:13 +0100, Andreas Schwab wrote:
> On Nov 30 2017, Thomas Adam <thomas@xteddy.org> wrote:
> 
> > On Thu, Nov 30, 2017 at 02:55:35PM +0100, Lars Schneider wrote:
> > > 
> > > > On 29 Nov 2017, at 19:35, Thomas Adam <thomas@xteddy.org> wrote:
> > > > 
> > > > On Wed, Nov 29, 2017 at 03:37:50PM +0100, lars.schneider@autodesk.com wrote:
> > > > > +		if (print_waiting_for_editor) {
> > > > > +			fprintf(stderr, _("hint: Waiting for your editor input..."));
> > > > > 			fflush(stderr);
> > > > 
> > > > Just FYI, stderr is typically unbuffered on most systems I've used, and
> > > > although the call to fflush() is harmless, I suspect it's not having any
> > > > effect.  That said, there's plenty of other places in Git which seems to think
> > > > fflush()ing stderr actually does something.
> > > 
> > > I agree with the "unbuffered" statement. I am surprised that you expect fflush()
> > > to do nothing in that situation... but I am no expert in that area. Can you
> > > point me to some documentation?
> > 
> > Because stderr is unbuffered, it will get printed immediately.
> 
> POSIX only requires stderr to be "not fully buffered".  If it is line
> buffered, the message may not appear immediately.
> 

I guess Junio's reply for the same "unbuffered" question I asked for an
earlier version of this patch (now, a series) might be relevant here,

> > Being curious again, is flushing 'stderr' required ? AFAIK, 'stderr'
> > is unbuffered by default and I didn't notice any calls that changed
> > the buffering mode of it along this code path.
> 
> "By default" is the key phrase.  The code is merely being defensive
> to changes in other area of the code.

cf. <xmqq8tf3oz3n.fsf@gitster.mtv.corp.google.com>


-- 
Kaartic
