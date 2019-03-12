Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B6B820248
	for <e@80x24.org>; Tue, 12 Mar 2019 20:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfCLUxZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Mar 2019 16:53:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43708 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfCLUxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Mar 2019 16:53:25 -0400
Received: by mail-lj1-f193.google.com with SMTP id z20so3561971ljj.10
        for <git@vger.kernel.org>; Tue, 12 Mar 2019 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:from:openpgp:autocrypt:subject:message-id
         :disposition-notification-to:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8JygY38LZCB9bdtYPe+dAetL9RIV1LBn7OhN61Ot7es=;
        b=LwN8z3ptPC8G0AJucz2DDEZTUTonw0gQArtqOEI1MaS+/V7y/PuGcVr3dU5Ku7qyWH
         giIxD2MKpMzjZlSkg3kFpzDOfOzARxgyNp9XC0+qH0iH3tdyc7QI4rei0WyhXYzbIi37
         6iwp8pH/CWeT9MhycWJuTo/MsPuk1yO5lNTZ1Z/YHBsYaOlTDf908Av0OOyBWxQO0tl/
         D7NlIoEm+k1nf0Yw+QSQnmhePsr1TBWB7/ezdoUGM5DnZFK/dolegtRmi2xLCg5XefjV
         ZPcoadEYOSXYSLzETUoFjJKiKcC8gvhwNv63xq87Yvd3S4pBwPz/1X0YqScUMktsYCqU
         FR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:openpgp:autocrypt:subject
         :message-id:disposition-notification-to:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=8JygY38LZCB9bdtYPe+dAetL9RIV1LBn7OhN61Ot7es=;
        b=X2Qb+nO7W5TWwoky1XBoK92viXussA6qynzVSoOrXdlS2SMh1UZymY30q7lkfLcVdV
         +TFQXVC+36kMQ/gZ1qSi5E9KYVPm7xTomrpbVaoPfPR9OqXAog7kqSuBl0q0FDkvmE9m
         ahwTuD5EWSoo68ZRoCYWy5s5wEM3ch4Iq1khRLoSfm9DSuPfYYoxMB7D6iaipqmTLWSG
         sda7eMV2S+5a6VS0rG4+GQmFZn7/UR1NgSwJVQLd6cWdacSGcwQ8kjKfwrQQ0UK2kfny
         ENzUHf+8Nmg/GZM7BJmLxGcuEFicuIExJV5tasHDnOGE4yWENtynuaED/v4q5P9TpVnb
         zYMw==
X-Gm-Message-State: APjAAAWjo1mjOSJdKL7R9QtW4zuE+HOwZj7fhaOnvuhv58dSZH9Yhj73
        S8raQuH+F1K8Zwz+XDWhnlM2Kv80mhs=
X-Google-Smtp-Source: APXvYqw3QUCBqPy/65otDCN1ZLSckWCR3u3QlRrywkx+3Hqn9dv0lIW9ThTpYZwP1c+POB/vGhbL9g==
X-Received: by 2002:a2e:6801:: with SMTP id c1mr22621236lja.81.1552424000617;
        Tue, 12 Mar 2019 13:53:20 -0700 (PDT)
Received: from [192.168.1.2] (88-113-137-145.elisa-laajakaista.fi. [88.113.137.145])
        by smtp.googlemail.com with ESMTPSA id c1sm1746245lfk.79.2019.03.12.13.53.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 12 Mar 2019 13:53:19 -0700 (PDT)
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
References: <20190222201111.98196-1-gitster@pobox.com>
 <20190222201111.98196-4-gitster@pobox.com>
 <20190223133418.GD22403@sigill.intra.peff.net>
From:   Ntentos Stavros <stdedos@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stdedos@gmail.com; prefer-encrypt=mutual; keydata=
 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
 76aXMxBzn7/E1Ab2wrb2
Subject: Re: [PATCH 3/3] format-patch: --no-clobber refrains from overwriting
 output files
Message-ID: <a063547c-4958-aa62-cb76-e4970927730f@gmail.com>
Date:   Tue, 12 Mar 2019 22:53:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <20190223133418.GD22403@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Avast (VPS 190312-2, 12/03/2019), Outbound message
X-Antivirus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello there,

Apologies for "jumping in". I was mentioned in [PATCH 0/3] but then for
a (good) reason or another, I wasn't CC-ed in the patches.

I was the original "suggester" for this feature in the mailing list
(https://public-inbox.org/git/CAHMHMxXxo4zXcriBJE2k3mWgwAj7KGA_AChuEmyciESGOC_7Bg@mail.gmail.com/)

On 22/2/2019 10:38 μ.μ., Eric Sunshine wrote:
> Meh. I haven't particularly been following the thread, but this commit
> message doesn't necessarily provide sufficient justification for
> further bloating git-format-patch's set of options, its documentation,
> and implementation, not to mention potential user-brain overload. With
> the possible exception of a 1-patch series, anyone who stores multiple
> versions of a patch series without using -o and/or -v is going to have
> a mess to deal with regardless of this new option. (Just trying to
> figure out which *.patch file belongs to which version of a patch
> series will be a nightmare without use of -o and/or -v.)

On 23/2/2019 3:34 μ.μ., Jeff King wrote:
> I suspect it won't help much, because remembering to use --no-clobber is
> just as hard as remembering to clean up the stale patches in the first
> place.
> 
> If we were starting from scratch, I'd suggest that --no-clobber be the
> default[1]. But at this point I wonder if people would be annoyed
> (because the clobbering behavior is convenient and works _most_ of the
> time, as long as you don't add, remove, reorder, or retitle patches).
> 
> I suppose that implies having a config option, so at least people who
> want it only have to remember once.
> 
> The patch itself looks well done.
> 
> -Peff

On the last mail of the thread (the one on the link) I mentioned that a
"set and forget" setting was my original idea / wish.

"I have heard around" that [PATCH 3/3] was really meh from the
reviewers' point of view, and felt that it might not cut it. I thought a
benign nudge (and some disambiguation) could help tip the scales, since
I am the one doing "not nice things" with git-format-patch :-)

-- 
Yours faithfully,
Ntentos Stavros

---
Αυτό το e-mail ελέγχθηκε για ιούς από το πρόγραμμα Avast antivirus.
https://www.avast.com/antivirus

