Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C61991F855
	for <e@80x24.org>; Mon,  1 Aug 2016 17:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbcHARyZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 13:54:25 -0400
Received: from mail-it0-f48.google.com ([209.85.214.48]:37851 "EHLO
	mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754245AbcHARyU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 13:54:20 -0400
Received: by mail-it0-f48.google.com with SMTP id f6so177904786ith.0
        for <git@vger.kernel.org>; Mon, 01 Aug 2016 10:53:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=M57alzKuNmFcb6iTBPU7qq5XvlgZkLLbBVBkTpSUA9c=;
        b=IR0hGUmUjJN0YFKGMpRk14CXL0tivWpSIYBMJaq3EQc3YrOMP9YaGNhjYHgfPENxeZ
         QKtsv0gHRstzqF6SF1dkp9xiG6Tg4S4DtWVMV1ikfGjYZJ/BHO5D7OkoJes4X1CeTLe/
         tWTXjAhV/lZfVj1hFiT1IiWTZjcjimFnaxXCziovW3bGEyZYbgQsCMOnsIdqY1LpsnxI
         M7EDW1EpCpPeP50NjCkU3W5k0HPMzXz3yJMmV1sGERyuc3FsEtFR3W6u3w1+g2GmMRZV
         YfVaxkmsG78TztPfQypv7DSQ52Awu/aReHQMOyPVbtNX3g/HMBVcQFmyM4Pzv7KzAX+d
         6QwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=M57alzKuNmFcb6iTBPU7qq5XvlgZkLLbBVBkTpSUA9c=;
        b=ahXvVEkguMEeY5iMYRhbDOhRs6libZJiOws+SK3x/wfLlF2Ug7YKjdsIw82OECn8zh
         8G4+UHF9b6N2n/I5hdNjlCmuWrbQYh48sLWgad9nz1LdKYIkRxcXDwqLVX1TBHVhxXQV
         gygsOl4leAaaOwm1nSsKfqEwuOXt8wE7/4JRVJbcLDJhIE6nliJ528COjyUUCtSTmR2O
         M33SB1s76kQ9eyHRqo6KFE2M0kr7V5Jy6ebhB+iE+x2bEKpZrn3UgOybO/pua8jmvihL
         7XUnq+Oc8K1X9NFQMEqLju32A/nIRsV5Jp2uw+EFY46+W9P75gs6X596J5aPV15NqmAI
         uYfA==
X-Gm-Message-State: AEkoouvju9IXweYlRlg3XnJqYXsnZvoNxji2pwWn54/9+b+F/2JgZeQXmTqai5P9mNkD/8uygiVFz/FGTJ3XOg==
X-Received: by 10.36.91.134 with SMTP id g128mr60119549itb.42.1470073625480;
 Mon, 01 Aug 2016 10:47:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Mon, 1 Aug 2016 10:46:34 -0700 (PDT)
In-Reply-To: <20160801010557.22191-2-e@80x24.org>
References: <20160801010557.22191-1-e@80x24.org> <20160801010557.22191-2-e@80x24.org>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 1 Aug 2016 19:46:34 +0200
Message-ID: <CACsJy8AEFFTnGw01mTBrZu8QnUWmQav7bhZUyw7o91ph7DUwaA@mail.gmail.com>
Subject: Re: [PATCH 1/2] pager: move pager-specific setup into the build
To:	Eric Wong <e@80x24.org>
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Kyle J. McKay" <mackyle@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 1, 2016 at 3:05 AM, Eric Wong <e@80x24.org> wrote:
> From: Junio C Hamano <gitster@pobox.com>
>
> Allowing PAGER_ENV to be set at build-time allows us to move
> pager-specific knowledge out of our build.  Currently, this
> allows us to set a better default for FreeBSD where more(1)
> is the same binary as less(1).

Nice. I was just too lazy to do something like this and "export
PAGER=less LESS=FRX" then ignored it :-P

Slightly off topic, but pagers like 'more' does not understand colors
either. But color.ui = auto does not know what and prints color code
anyway. It would be nice if we had some configuration to describe
"this pager can show colors, that pager does not" so I don't have to
maintain separate .gitconfig files on two platforms.
-- 
Duy
