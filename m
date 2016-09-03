Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 467A81F6BF
	for <e@80x24.org>; Sat,  3 Sep 2016 14:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753492AbcICONT (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Sep 2016 10:13:19 -0400
Received: from mail-ua0-f182.google.com ([209.85.217.182]:33068 "EHLO
        mail-ua0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbcICONS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Sep 2016 10:13:18 -0400
Received: by mail-ua0-f182.google.com with SMTP id l94so201080608ual.0
        for <git@vger.kernel.org>; Sat, 03 Sep 2016 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OcO4mNNltKVN7p1fiJEsFZ9AW8vKE8hfE8/vwKCzNLE=;
        b=w1e1r1c+EbCY0Ub0G+znHB8BVQmQXiWJl7cLArJwKoxALxHAgSHa7ZhWueF/PpnDb+
         xY+76tU1lYfPOHR7ZAST19NxeyRlTKaUpBTsu4g4CnFfhFKAV0TjGZjV8jZscgiYR/q0
         CE8TO8UFlQGLLmsxj6Ph2xtstlYVqriFn7e3mCOetj6rSnB/gwV4KgvHao29PL+m74dd
         ip6ELr7boOx7rLk2kcXTsnF5SdrX1NgfH52WD46KmP1xdl4AsjqBItAXDcoWCd9xTTPZ
         lwq8ja37oZvqdSpgzAIIdkDngY+8gqzq7LEF/zxfTWhOw5N5NGtNV7PGxYFFG7xAcvzo
         oKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OcO4mNNltKVN7p1fiJEsFZ9AW8vKE8hfE8/vwKCzNLE=;
        b=V5Ou3YfGzOh2kowUTAYxhgAVen2QH3ByUCBzEiloykMp+PyW5wviLLVetJeREr9vzB
         Ix6QofRdbofuySXqjHVAuKD7n/GhGWPXWKdZzBjswE4fBEzwSj6N51f/RQek62PcZj75
         9ceXz1/lLggy5nxhoJsN/rI83uBRrt4B0r4/PUNj/x10ec7aKkhjypDFMpYz1u2mYZEL
         eY79b/3Rhv7olETXaDks/HEgaGER53R4GgQgFTVw6yUuDhshpiKYX+0GXFuA+QM4kge9
         NbwGLwM393Snzq43TiPkrE/2BJycd5bDbvHeYVbZhU+loBI/V8a4zbqtN7qr2vls+QLa
         YOwQ==
X-Gm-Message-State: AE9vXwMCIJNA+rO1hWtD4pYWzPNWyJ1VCPsVXWgoZO7KCozncYiuKcWus6ZiL1OQRNFfWRRQRMc/93hQP8nbCg==
X-Received: by 10.176.68.162 with SMTP id n31mr16726731uan.52.1472911963463;
 Sat, 03 Sep 2016 07:12:43 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.176.4.230 with HTTP; Sat, 3 Sep 2016 07:12:43 -0700 (PDT)
In-Reply-To: <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com>
References: <CAHd499AQFDRps6POF2xuUjbYv5DJYxt3DA8aFFArXF=qQEz_CA@mail.gmail.com>
 <55512A8927384A0790DDC7F526B09053@PhilipOakley> <xmqq60qdsoxj.fsf@gitster.mtv.corp.google.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Sat, 3 Sep 2016 09:12:43 -0500
X-Google-Sender-Auth: THQ0E5lKMVIV-l03AHGcXurBEAI
Message-ID: <CAHd499Bd7CHZ-O8HLd_iNnVNxz1C1=vO-4kxD80sEgBiesrMXg@mail.gmail.com>
Subject: Re: Fixup of a fixup not working right
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.org>, Git <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 2, 2016 at 9:22 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Perhaps a change like this to "rebase -i":
>
>  - The search for "original" when handling "pick fixup! original",
>    when it does not find "original", could turn it into "reword
>    fixup! original" without changing its position in the instruction
>    sequence.

If it did this, then later when I'm ready to merge and all
contributions upstream are completed, I would most likely lose track
of which original commit to fixup to. This would only be an issue if
you gave the option to reword the "fixup! original". Rewording it, to
me, inherently means you no longer want to meld it into another commit
and instead intend on it being independent (looking at this
semantically, without relying on translating the commit message
itself, even though it may clearly tell me to squash it to something
else, that's not as reliable as the fixup! mechanics IMHO).

>  - The search for "original" when handling "pick fixup! fixup!
>    original", could be (probably unconditionally) changed to look
>    for "fixup! original" to amend, instead of looking for "original"
>    as the current code (this is your "separate issue").  The same
>    "if the commit to be amended is not found, turn it into reword"
>    rule from the above applies to this one, too.

So this is mostly for my education, since I don't see a difference
from a user-standpoint. Why would "fixup! fixup! original" look for
"original" instead of "fixup! original"? As far as I can see, the
behavior would be the same and the order would be retained since you
are essentially "chaining" the fixups together this way. This also
gives you the behavior you want directly because the algorithm will
naturally tie to "fixup! original" even if "original" doesn't exist,
because Git would expect that "fixup! original" will automatically
manage its own order, and that subsequent processed nested "fixup!"
commits would not need to depend on any other commits.
