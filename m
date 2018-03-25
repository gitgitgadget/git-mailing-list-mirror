Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADA361F42D
	for <e@80x24.org>; Sun, 25 Mar 2018 07:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeCYHQE (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 03:16:04 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:52810 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751029AbeCYHQE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 03:16:04 -0400
Received: by mail-wm0-f52.google.com with SMTP id l9so10082046wmh.2
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 00:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BmSXyG1af68tNL7B50YKOUbfXyb+FVfDA38DUZ7L218=;
        b=HKQb2t7NpsB7lIlKh+MTl3DT527jzjSo68kymc82jlIe/Z6rq/aRFgpMfkhiXy1gBx
         jCVVH6IoloNqREHHahWBBXa49dPH0hGGrRsuk3dHQRfiMbrhFJhhvdf70QX41ON1BMnm
         eoXwrea0HErmshcus4JIX28Qeu4AVZuqgQQg+JJjKuXWWwbdO4ehXUDN7KEm74xGCJ6h
         mj+8qCt5FIiS8ZwDwfVfWw1bZcb8m35Uf1FuGk8dunDKQ9rNn1IBjaENM9viBXhD2+wj
         eWV3vwLeGF7KxqkDAjlLEzem8MOEX9bHzvS6DAkJLognsbRCIZ+89LQ5pdTTGeCIg3pm
         YrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BmSXyG1af68tNL7B50YKOUbfXyb+FVfDA38DUZ7L218=;
        b=ILU60cTv7R5OWr4FH2xXCy8+4csMTdjb4zMv5fHN1fV4D/xF0z3DtGAZyfONxS0V1q
         3cOk6MB78CZQKUfl15KkycrYlqp1zEES0iErk9G2LIEhmPArzQnensIYegqvYfWQdm/B
         F6Z8C8FXEzNF5AGSUxcIU1CvlrD7fQl0Aie8kmMOrzANz3e0GnkWEeVttxqxrIaSORzb
         8xR7vFJyiyJSgf2cfnTEP3gc7t19f8VVSqVoYCTMFc5tcRmgqYqdQNwlhS09CDvH5KXX
         UB/PXWvEkjZfR3EFHoXrf3rHSIB3OVTJBkhhN8ddlmcTWg41p82J7FJJukpq5iAx93Bm
         PlIQ==
X-Gm-Message-State: AElRT7H0O2m2BHImlJDxqKMz+TwbVgTYu48ADwVQu3ahjgmM2rKVNmiu
        6Zzsp1nMBR2flCyDPZDxZso8wdUcjoMZtT+pMxY=
X-Google-Smtp-Source: AG47ELsggYILElf1wiAj7IDjyY0Jwh6ESclsQaDTYgJHgyarkcito6hevgdQr3iOXDiU8mKfJNmmETYEhk578qpwlKI=
X-Received: by 10.80.214.206 with SMTP id l14mr36110203edj.44.1521962162903;
 Sun, 25 Mar 2018 00:16:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.203.135 with HTTP; Sun, 25 Mar 2018 00:15:42 -0700 (PDT)
In-Reply-To: <20180325043337.GA32465@sigill.intra.peff.net>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com> <20180325041056.GA22321@sigill.intra.peff.net>
 <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com> <20180325043337.GA32465@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 25 Mar 2018 00:15:42 -0700
Message-ID: <CA+P7+xr2-OidiX9ve6GwOR4pSOe4Gn=A3Aow5L=oLZgZE+XqMQ@mail.gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local branch
To:     Jeff King <peff@peff.net>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 24, 2018 at 9:33 PM, Jeff King <peff@peff.net> wrote:
> IMHO we should do one of:
>
>   1. Nothing. ;)
>
>   2. Complain about "-l" in list mode to help educate users about the
>      current craziness.
>

I think we should do this at a minimum. It's easy, and it doesn't
break any scripts who are doing something sane.

>   3. Drop "-l" (probably with a deprecation period); it seems unlikely
>      to me that anybody uses it for branch creation, and this would at
>      least reduce the confusion (then it would just be "so why don't we
>      have -l" instead of "why is -l not what I expect").

Personally, I'd prefer this, because it's minimal effort on scripts
part to fix themselves to use the long option name for reflog, and
doesn't cause that much heart burn.

>
>   4. Repurpose "-l" as a shortcut for --list (also after a deprecation
>      period). This is slightly more dangerous in that it may confuse
>      people using multiple versions of Git that cross the deprecation
>      line. But that's kind of what the deprecation period is for...
>
> -Peff

I don't think this is particularly all that valuable, since we default
to list mode so it only helps if you want to pass an argument to the
list mode (since otherwise we'd create a branch). Maybe it could be
useful, but if we did it, I'd do it as a sort of double deprecation
period where we use one period to remove the -l functionality
entirely, before adding anything back. I think the *gain* of having -l
is not really worth it though.

Regards,
Jake
