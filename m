Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DC412095E
	for <e@80x24.org>; Sat, 25 Mar 2017 12:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbdCYM3l (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Mar 2017 08:29:41 -0400
Received: from mail-oi0-f47.google.com ([209.85.218.47]:33891 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdCYM3k (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2017 08:29:40 -0400
Received: by mail-oi0-f47.google.com with SMTP id w81so6093092oig.1
        for <git@vger.kernel.org>; Sat, 25 Mar 2017 05:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HrUGfuoCaR1nnwu37U23UtQARe03Day4io7PnLO36Uo=;
        b=gnmPzXc3OwED9BFKQs7xYm0+FnllDrzIDgFmDyG1d1QPB+K4UGd+YDZxyceamU9+Jw
         qVZyIyloP+78WLizzMT2jfrYOZSfcLpOhfY7e9deAgaug+tj9JZ2k1/PV8kLvhhxEYZl
         dUo/1Qpcv9Vi9QuOI/QpI+MNGKzcVVuIBgwSaof6C0t2xgQrbW2p57bIz/nszIL0XKOw
         kTMqokdeDLiqX/0Orv9vhdF8aiKmReTw4LLRsf5U+BCGsmRwVfDEr9uYmwJi+Wl1mkvf
         An1EiS6SCDqANFUqwWcBOnRbZF9cQwR9NlxWa2gM+aiORo3linoFnP3UgrwmacbAm4PW
         ubIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HrUGfuoCaR1nnwu37U23UtQARe03Day4io7PnLO36Uo=;
        b=R7zxjpBPAf3YQvhw88XMxJH7dQnVWxgx8TIHJ02JIEtYWR1IIano30N49bN/yIaFV8
         d0nRYpUBRNSGm2I28R414Bl2Ikfi2EhAV4/nHByJP/2xdQLaAejGdSvoT+jrPwtk0Aci
         LYax02w0uxfexgAPw/U10TbgpCcj2VwalIIcxmrhCZRNaZZXBNoUUA7uazn1GGawKFcP
         GH9HL7W40MneHAhmb6JH0Lglrv5+nLDrvhj9RgIwYcvGJG2XxFuywssixUJVC7vBzeOv
         f1VPl8E2LWMoVO4Fa/4JYyukw4lAleQo8Yub9pl8g5aU2Y5tY55+F4/9pI2KuDDIYuAv
         CI7A==
X-Gm-Message-State: AFeK/H3v27yWR0M+ufMx1V7OBGlYqq616Pp18xvl4bC03UHLhj78X+ccbrgXCFg3Q8s4JcKlZtKy27xmm875tA==
X-Received: by 10.202.199.85 with SMTP id x82mr6215966oif.186.1490444979260;
 Sat, 25 Mar 2017 05:29:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Sat, 25 Mar 2017 05:29:08 -0700 (PDT)
In-Reply-To: <CAEA2_RK=zMwKeidPDS9u5Ep1htb3TUeOqJ6Cfd644ira4DeXaA@mail.gmail.com>
References: <1490441257-44727-1-git-send-email-bnmvco@gmail.com>
 <CACsJy8Aajf1Lb4mKC=NEUQTNy7QRK99Aont_UCRnHJfho8n+UA@mail.gmail.com> <CAEA2_RK=zMwKeidPDS9u5Ep1htb3TUeOqJ6Cfd644ira4DeXaA@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 25 Mar 2017 19:29:08 +0700
Message-ID: <CACsJy8Dxh-QPBBLfaFWPAWUsbA9GVXA7x+mXLjEvYKhk1zOpig@mail.gmail.com>
Subject: Re: [PATCH v2] [GSoC] remove_subtree(): reimplement using iterators
To:     "Daniel Ferreira (theiostream)" <bnmvco@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 25, 2017 at 7:13 PM, Daniel Ferreira (theiostream)
<bnmvco@gmail.com> wrote:
> You are correct, which shows that since all tests pass, we need to
> come up with better cases for this function.
>
> As for a solution, I believe that the best way to go for it is to
> dir_iterator's implementation to have an "Option to iterate over
> directory paths before vs. after their contents" (something predicted
> in the commit that created it). If it iterates over directories after
> all of its contents (currently it does so before) we just need to
> check if the entry is a directory and if so, rmdir() it. Does that
> make sense?

Yes. However since this is a microproject, intended to be done quickly
just to get you familiarize with the community and the process, I
suggest you look for another readdir() place that can be easily
converted to using dir-iterator first so you could go through the
whole thing. But of course I will not object you improving
dir-iterator and clean remove_subtree() up ;-)
-- 
Duy
