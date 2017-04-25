Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A75A207E4
	for <e@80x24.org>; Tue, 25 Apr 2017 23:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1950694AbdDYXex (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 19:34:53 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33000 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1949062AbdDYXev (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 19:34:51 -0400
Received: by mail-it0-f68.google.com with SMTP id z67so23569309itb.0
        for <git@vger.kernel.org>; Tue, 25 Apr 2017 16:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEIYqcSL/wWnlTi0cw61MqY2MQ9g1Ad2TrqO4a8VrZw=;
        b=oUaa3CoFi2rnxteumw/7ojnQRCdPu0FqAVtUyR/Xu3aK4/5aIZqDIMrf+tKysn989F
         THRZ7tPzn/xkMIeimJ0S0ZYLupUxDIlzrVJlV0FuR6rFbMRetyigTZRkauaI3Sr2R3fL
         oa2YnqNwrT2XFrZBzsTlP9pYImfuo/RaDEwb+QV2WcUkpQXR7vRb/Hws02gV17DMZpEI
         y9DexBtVJP8mQ45OiaGaMzESSvBl9t1uLNPZSrL9oN2MNf6qCoVWlDd5A3YA6Mua1H1e
         1ObJCFL9h/g/d7nh2ZxzgNWT/pu53s5cHkUKIrHXQBg/jEMXOjCEvAU7TBHE6tYu99x6
         RKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEIYqcSL/wWnlTi0cw61MqY2MQ9g1Ad2TrqO4a8VrZw=;
        b=ZlZlS6xDYPD3kdF6Gu4P9+GeL+eV4YQQ/QCqbeLWW6z/XI8u33GwMiv/AlM/qdjMyc
         lWBXfuILYGnH4fdrLWhutOYUgzECebS7GxqA3WXPw/Pu4Er/2zSkK/KD/2XKRUTTGhNT
         SHBB+TDE+/fx6Der9jyt6R3e+Q7aA2+TyrR/JHBQk8g2adFE9COVFEVJvmhn3pCOqs2L
         LVsewwM8B8yFAUpE3y08NcUUc2/pl7kEGQYdZH/jJFJyKvD5txiwro1HJWy7JqL8q1dk
         4JY516OPzBr75MyNV2k9Q0fzFSvKUeTr94Db+y7xVYLm6F00UutocjnGOje7/JXi0MQA
         HguA==
X-Gm-Message-State: AN3rC/51paKkg9plVMQtmgVHFxnn7MxAFY/lAexnPJfO17kUr04Djyti
        1f8dR3VZm20XAQ==
X-Received: by 10.36.70.204 with SMTP id j195mr4015683itb.22.1493163290735;
        Tue, 25 Apr 2017 16:34:50 -0700 (PDT)
Received: from atris (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.googlemail.com with ESMTPSA id r138sm2786640ita.24.2017.04.25.16.34.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Apr 2017 16:34:50 -0700 (PDT)
Message-ID: <1493163266.29673.29.camel@gmail.com>
Subject: Re: [PATCH v2] rebase -i: add config to abbreviate command-names
From:   liam Beguin <liambeguin@gmail.com>
To:     Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>, Jhannes.Schindelin@gmx.de,
        Jeff King <peff@peff.net>
Date:   Tue, 25 Apr 2017 19:34:26 -0400
In-Reply-To: <CA+P7+xrXyguugTETd_C-JXDSZ5zHUC3d_1cU4CuiaJjAqWQ=RA@mail.gmail.com>
References: <20170424032347.10878-1-liambeguin@gmail.com>
         <20170425043742.15529-1-liambeguin@gmail.com>
         <xmqqinltuhiv.fsf@gitster.mtv.corp.google.com>
         <CA+P7+xrXyguugTETd_C-JXDSZ5zHUC3d_1cU4CuiaJjAqWQ=RA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.5 (3.22.5-1.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jake, 

On Tue, 2017-04-25 at 01:29 -0700, Jacob Keller wrote:
> On Mon, Apr 24, 2017 at 11:29 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > Personally I am happy with the beginning of each instruction line
> > aligned, so from that point of view, this patch is a mild Meh to me,
> > even though I do a fair amount of "rebase -i" myself.  But obviously
> > I am not the only user of Git you need to please, so...
> 
> I would instead justify this as making it easier to change the action,
> since you only need to rewrite a single letter, which at least in vim
> takes "r<letter>" to change the action, vs slightly more keystrokes
> such as "ct <letter" or otherwise.

It's another reason that motivated the change but I didn't think the
vim shortcuts would justify the patch. Since you pointed it out, 
I'll probably add it.

> 
> Also, if you change the default commit hash length, it becomes long
> enough to cover most commits and you see all commits at say 12 digits
> commit hash and everything is nicely aligned.
> 
> Thanks,
> Jake

Thanks,
Liam 
