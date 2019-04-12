Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 361D920248
	for <e@80x24.org>; Fri, 12 Apr 2019 09:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbfDLJWR (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Apr 2019 05:22:17 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:46780 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfDLJWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Apr 2019 05:22:16 -0400
Received: by mail-io1-f49.google.com with SMTP id p23so7848964iol.13
        for <git@vger.kernel.org>; Fri, 12 Apr 2019 02:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3LoFkQaW2odJStYydav1kHjgiUns+oKfQsnymL5IWA4=;
        b=O1cq3mT+UKO1CxFAgMlAhPDxfx80YXtX8BPdER7yPbJmRydflQbTDzWGSL1UZaH1Ct
         CgIVOswaB0IHxle1dYI8KMn2xv/i25J+BJVneDXZWYo8xCB2nGiAAK6MEM3GLUoyiC3I
         b9cJWCBd3DwCgBI/XrL4K9DafHXnfZ+J36hRUruw3W3/IV4krUxMQ8T2ks2reNhNydZL
         W9s7hvY5byF5N0pBVn4HqvjKeOgoaUPnkDuBVecmxNlU7a6wpwfdUK9wOjLLrETraD1O
         X7UyxRweu0TiFOfbNxQ5z9rCcQTmFQN6I9WahwfTITFfAOZa16cMDlJwt5ehI+HF2/5P
         ugTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3LoFkQaW2odJStYydav1kHjgiUns+oKfQsnymL5IWA4=;
        b=HMKBu6OKiCwoE3fZKvjUjHKBVQD8SZ7Rs8PCAiA+i6V6g03PMDqve42qfwHl4Y2d42
         +79TP+Ns6BelPaM9s1rXPQOicrFLE9INPaPLo9f5N6VZL0N0+s6Tn1Bs3gQJNTqAc8+n
         vKJRCfqbLyel+FQJ4DXSSZAJweMBZUDLZIjCtoz6PU2GV51+SwZG37cLMTos+4A+5FLK
         C/zRKwbVXqvJ0AWmK9Esw4N97TK6tU5cnQNRP8FyOhfkYxrmLD9ZNXWt9ZO+Dz9JZcnH
         jLz+kp0wgjnMh6sdAkGSGaH/q+Q44YUy0EblJuoQrkupmFYkJu5zCPAP4WZ/ZeTpIR0L
         /hCg==
X-Gm-Message-State: APjAAAVxNMgl9rw6mUPszkppqThu6L4DZzUKFb6b0jNwEGwBiUFUeYVB
        bUB/v9FqHGAYIjyov8oBxpcqeRpFxzFH0xa7Lf4=
X-Google-Smtp-Source: APXvYqxXzIFHI9UxXxOR0aOrd5m2cgoco0POl7mnlMwqvpCMiULalJvSikX1p/edpIJp1WpVnKJTXHR7+JY50A3Xlng=
X-Received: by 2002:a5e:9805:: with SMTP id s5mr38264638ioj.149.1555060936019;
 Fri, 12 Apr 2019 02:22:16 -0700 (PDT)
MIME-Version: 1.0
References: <20190411111729.GB5620@ash> <20190411220532.GG32487@hank.intra.tgummerer.com>
In-Reply-To: <20190411220532.GG32487@hank.intra.tgummerer.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 12 Apr 2019 16:21:49 +0700
Message-ID: <CACsJy8DTQV=U3gP_b5eOX7fXy4_rs+iyJFVGWLkC3VwagdVnPA@mail.gmail.com>
Subject: Re: incorrect range-diff output?
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 12, 2019 at 5:05 AM Thomas Gummerer <t.gummerer@gmail.com> wrote:
> I'm not sure what the right solution for this is.  I think one thing
> I'd like range-diff to do is to add the filename, or some context
> (e.g. is this part of the commit message etc.) to the @@ line (not
> sure what that is called?).

I don't know what that "@@" line is called either but if possible
please keep those lines too. I quite often depend on them to know what
function I'm reading.
-- 
Duy
