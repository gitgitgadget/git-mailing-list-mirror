Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E05C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 03:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiGIDwB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 23:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGIDwA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 23:52:00 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFFB85D67
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 20:51:59 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g126so601443pfb.3
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 20:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=K7XKnufM+k5chAHsrxB04N/+40IFHrNWrhFVrhyj1oI=;
        b=b71uEJEBJnPJOswKv19iEarRfYNR2mY6C4WUMeiCF3q5TTKg8FN/keQmHO6a1OGP0p
         7ELQRQelQ+xJyDUZtAcFY2kpLlc8/fi4WDDamzUNirwUCwDZOebFE4hMP98abbOO2ODo
         KHNqsDSp4HdwD00NkmqE/ei+U7wjQew6VgRQJbceDPihc4L49l7fnMhcuuFOHVBJtH+l
         INoqfmGhP9TLe60wgKkcVWu6XPqw+HCExypIVx+OlI2uQqMwWxaWlLWDTC1538BweNXF
         ihSf8zPAsr9YRAWwuvzqqpb3c5hSTIx9oKzIo9rGuTb35gHNwm3bLFNWp3h7EJZ4j3yc
         J5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=K7XKnufM+k5chAHsrxB04N/+40IFHrNWrhFVrhyj1oI=;
        b=ToN2XUlvQQV99llxCfUmp4tAM6Sdg0tqsJanafPnvZaqhVWrTVlFlo/zg0v8zC50CO
         Jg9fctnzdoFEGglAIgCY6WXa6mLo5gWr3jZCKb4+akgDUzs/i/Mff/MXMn/ddvPNV/vy
         RRsNvHwy4WsInxh2Uz61bPzvo2RSne9s5LAxP/CLPj4NxrZY9xbIYwyXfujpNJomFTrO
         uZp4/XD321yTK7I0HtZ4skB2Yi9YGOp4TzsNjgejvFC8VW321pys1yDPndWdkkiIZpko
         aay8VpHkzVLWi/lIlIU4VIWpL8EZ5NCPsU42sODkUDuFydTSdaw3CbRE43rwZEhSS2gs
         Cl4A==
X-Gm-Message-State: AJIora9nfku3pmPKY26fXaePn+jfyBNs54aV5+Kx1l2ty+V/mpZRLIz7
        +6VKlGu2h94ehscOUhwgjD+OJ/wSOYmtV8yLQTM=
X-Google-Smtp-Source: AGRyM1vAEftPZwCT8CMAucCjmY3RsNBs25tMFkuCm5oPfWFE+rGh93sbIOqrnlfaZaOZmkFlF04vsw==
X-Received: by 2002:a63:fe09:0:b0:40d:34e6:7c69 with SMTP id p9-20020a63fe09000000b0040d34e67c69mr5913552pgh.368.1657338718482;
        Fri, 08 Jul 2022 20:51:58 -0700 (PDT)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id g10-20020a656cca000000b004126fb46b02sm209735pgw.82.2022.07.08.20.51.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jul 2022 20:51:58 -0700 (PDT)
Message-ID: <123af6b4-aa4c-b528-62b6-d9d5257f441b@gmail.com>
Date:   Sat, 9 Jul 2022 09:21:53 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Jaydeep Das via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH v2] gpg-interface: add function for converting trust level
 to string
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
 <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com>
 <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
In-Reply-To: <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/9/22 6:28 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Jul 8, 2022 at 7:28 AM Jaydeep Das via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > Signed-off-by: Jaydeep Das <jaydeepjd.8914@gmail.com>
> > ---
> > diff --git a/gpg-interface.h b/gpg-interface.h
> > @@ -71,6 +71,14 @@ size_t parse_signed_buffer(const char *buf, size_t size);
> > +/*
> > + * Returns corresponding string in lowercase for a given member of
> > + * enum signature_trust_level. For example, `TRUST_ULTIMATE` will
> > + * return "ultimate".
> > + */
> > +char *gpg_trust_level_to_str(enum signature_trust_level level);
> 
> It would be a good idea to update the function documentation to
> mention that the caller is responsible for freeing the returned
> string.

Yeah. Will do in next version.

Thanks,
Jaydeep.
