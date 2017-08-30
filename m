Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB43820285
	for <e@80x24.org>; Wed, 30 Aug 2017 20:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750872AbdH3Use (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 16:48:34 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33203 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750793AbdH3Usd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 16:48:33 -0400
Received: by mail-io0-f176.google.com with SMTP id s101so11076557ioe.0
        for <git@vger.kernel.org>; Wed, 30 Aug 2017 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CoC1FjyIa/NThWDhMCYbaZ2mzkPUeiuotJhcAoicEVg=;
        b=HGrHQTNJT55KXec/LR0HqjqUZDUToyvnypO4c8uaazsjeV7PTcyScuRHnPbYmEaVlY
         +nxSdxx6H/G6DwWIu+AMJgkeKvLsCnnRubK2UZcUy/64ifEXu4o6ThE5ri18zMuq1Gxh
         UBQwfjeAshhEX4RZsZFJAf9D/t2riiV9iOY9VF5ObnFKmTV9HMasCrC061EO+1hKfDl+
         qo6HxWOW1+g+vLPEHjAEWpVeB7gKsTzP52kvvyXAR8zkPTwVWM1fkAZ+OiAKDC/1+M39
         eWiiN1fSXRfIxUHNn/wVbTbi//qZfhV0D/0Ed5G+t5lvUpScj6oHT1+PpCKxgdlP/e8C
         pq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CoC1FjyIa/NThWDhMCYbaZ2mzkPUeiuotJhcAoicEVg=;
        b=FDNa39OpNtofvHSXAo06lVK8D0nAZvkCCyy9TXVrCoD0JtS3Yq8wv0UiuTlU6LtAHN
         Pe1I5dzTj2JLCtEOcgsskliVha1qrT2w/tTRU+Zoawo7r7ywtuVmElPbQ0ha2b6WYyVr
         WeSsL5frQFGlAjbhoaoX2SoHgGhQQwWcmdotujeP9hfmzUoo7TG7IqcO4sNXo3BEHO44
         MiuOpyw73ukA8dEasY47li/PEH/SXlhw1MLPFcmYska9waMqxlwP4BAhOfe1PguLj1QU
         1u/FTwc6psptuM0KOcBKQRdxpTsFeCxI7mRJCpLqZrrBJ5wBkcvLPKJd6JyXDnBQ08fI
         KVBQ==
X-Gm-Message-State: AHPjjUiIY3CWpcSMyuSX1GRQYB9nlwLkswhRUrHjsUTStJFBfMjhkWyQ
        O+Kww4PjnOB8n6ob56nQBNVsKSZzKg==
X-Received: by 10.107.181.212 with SMTP id e203mr2632774iof.53.1504126112593;
 Wed, 30 Aug 2017 13:48:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.23 with HTTP; Wed, 30 Aug 2017 13:48:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1.1708302223510.7424@virtualbox>
References: <oo62vr$pvq$1@blaine.gmane.org> <alpine.DEB.2.21.1.1708302223510.7424@virtualbox>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Date:   Wed, 30 Aug 2017 22:48:31 +0200
Message-ID: <CAHGBnuO0dviVr0zD+KqANc6Ju8-cZh2KLbLz6NH3h+jprRzbaw@mail.gmail.com>
Subject: Re: Commit dropped when swapping commits with rebase -i -p
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 30, 2017 at 10:28 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Please see 'exchange two commits with -p' in t3404. This is a known

Thank for pointing out the test.

> breakage, and due to the fact that -p and -i are fundamentally
> incompatible with one another (even if -p's implementation was based on
> -i's). I never had in mind for -p to be allowed together with -i, and was
> against allowing it because of the design.

In any case, I wouldn't have expected *that* kind of side effect for
such a simple case (that does not involve any merge commits).

If these options are fundamentally incompatible as you say, would you
agree that it makes sense to disallow their usage together (instead of
just documenting that you should know what you're doing)?

-- 
Sebastian Schuberth
