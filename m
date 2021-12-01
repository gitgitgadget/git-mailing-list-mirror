Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268B2C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 23:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353899AbhLAX7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 18:59:48 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36722 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbhLAX7s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 18:59:48 -0500
Received: by mail-pj1-f49.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so1029580pja.1
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 15:56:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mKiFSLcEj7oTyImE34GhB9IxqH6ypToU8QuY7KpgQc4=;
        b=UJRKFsWafwynHjcwZgogT54x2mwFqwuNrTd9/AmtoZbK+UEV5liNb9+kjsrGnDVMdN
         Y8+DJqZRBMStgZLJTCoSqKCnfaCwaHK8glKucRSgkt8hBkJIweujHBl3IGeu3YqeNXSj
         PANz4hG1tUy950TN7p9nSjbvu3MTt2jQ/C30Q+ruiH0Vb8KxzyJwZeTo4gB8jO0Pgi7H
         zuj5ohKhQcuIxBjj/zWYYFwVj2RtKLC5q2og2VGfeaSyc/Z0A/cqSe619ixld3BWU/zQ
         Cpcc3Hriaj+p2+lk8wRvihIB2sw1wK/aDfdwU6HeVAPRmWN8NbzE81tZYm/RbHObSy4K
         MdkA==
X-Gm-Message-State: AOAM533Hhcynlrlw9717Ev0BVIQ2TpjeZBcpWK930syzRSbkMNJt5K0k
        AmjS1XD/65klgxRz9ldWQv7R6bPT1Q6dR7turEU=
X-Google-Smtp-Source: ABdhPJzos3T2GWnurgm6K3jp93LiUlPCdVkCubdB/njIlhsdR5ZGVvrHQAY5yWuHN2v34zKqjJ+bYURXEU6HNzSsPkE=
X-Received: by 2002:a17:902:ac8e:b0:143:6e61:460 with SMTP id
 h14-20020a170902ac8e00b001436e610460mr11185281plr.85.1638402986391; Wed, 01
 Dec 2021 15:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20211201053214.2902-1-sunshine@sunshineco.com> <1f0cc771-b661-42ae-e928-75c27f1dab07@iee.email>
In-Reply-To: <1f0cc771-b661-42ae-e928-75c27f1dab07@iee.email>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 1 Dec 2021 18:56:15 -0500
Message-ID: <CAPig+cTAzmaHJa3tGniO5AsL+tQO9+bZuO-AUqU+WisDEgp4UQ@mail.gmail.com>
Subject: Re: [PATCH] CodingGuidelines: document which output goes to stdout
 vs. stderr
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>,
        Baruch Burstein <bmburstein@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 1, 2021 at 6:27 PM Philip Oakley <philipoakley@iee.email> wrote:
> On 01/12/2021 05:32, Eric Sunshine wrote:
> > +Program Output
> > +
> > + We make a distinction between a command's primary output and output
> > + which is merely chatty feedback (for instance, status messages,
> > + running transcript, or progress display), as well as error messages.
> > + Roughly speaking, a command's primary output is that which one might
> > + want to capture to a file or send down a pipe; its chatty output
> > + should not interfere with those use-cases.
>
> Is there a case for commenting on whether chatty output may be
> suppressed if not feeding a terminal, or is that mentioned elsewhere? I
> often see comments about the isatty() detection.

I don't think I saw any such mention when reading through
CodingGuidelines before composing the new text. That's certainly a
topic which could be addressed, but I don't plan on adding it to this
patch since I don't have any specific idea in mind for how it would be
discussed. However, the new "Program Output" section added by this
patch seems a good place to add that discussion if someone wants to
have a go at it as a separate patch atop this one.
