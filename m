Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF6C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 21:55:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjBNVzv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 16:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjBNVzt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 16:55:49 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACC31F494
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:55:47 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id hg24-20020a05600c539800b003e1f5f2a29cso121264wmb.4
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 13:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOzVUXlR/e/9lAEwV6rS1LbOSKoLFL0RpouIm/q5aVQ=;
        b=RXS9wEAF2NQKOzdnxULsGNf6U+DRKOQZDtBNXjTwhEx5HhtLxUhibYcTOiRxxwF0dq
         M5D+lOGFBS6lZBDaYj9lsVThGZGF2RTYP3EAA3tJIffQhZ/SWVo1QMFyIKnLL7UW0ajx
         Gjac+4S5ln4ZsupTCMEdUxS5wkwTD97iXN8rw3LnQ0b+XrK7kXCf3gNYBgaOj4AnIAMt
         AAfqWSrHufO3khnuETRRuAw/G/gHiMw4YwKluJkNTNOfOmlSLvhI/XhOo7XFIXJL/1zz
         oMzXiHxzSLHx7y5DA0sDJb0UoRv5UlujGXoxV01nHt+Nfme2asYglcWo/MVDyH2jn3Hm
         8XXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOzVUXlR/e/9lAEwV6rS1LbOSKoLFL0RpouIm/q5aVQ=;
        b=71uTYfzuOCAo0sDTuvpn/Fhio9xMXFDkYgkYFeJbG1jZ2PmyvFX/7kWuiWiQ0llUBQ
         zvpYWMdIgcZDKHraTGExj/xTREfbl2bOI05OiZs7V6OVaY7PrSy+UEv0O/YavnCRMugq
         RRfD7SvUFkY0STs9uIVA1N+7iNj1XPoOpTUzx+Cfn6hwCyW7ncIQhAljyqJL3JUTg15p
         NfVIyHAMBxJEUc+FIMSWGfTTCG7bCfjejJnAo01iMRCA2zmO63e28krBqvnGqR6C68Ja
         gikGw64To6XzzI/xthrxG9V28Iy0MSPenjfFFzE0esoaUOqqi0RFqvXHt6+5eaelQjI2
         LzCw==
X-Gm-Message-State: AO0yUKXENst+h7fL9Q6GO2xO7krKdjrGJY730UIpLfBjfsCLdnNYtoW4
        dQ6KnGZt+GUiaGxqpUeHjK14ZEtPFDcYV2HewYNCTOEdwZk=
X-Google-Smtp-Source: AK7set+nQEow+spMfLq26hSC+DooJUTmoT+lEqBBuQDfhvaQESip+ajkOmcIO+SwWylSlsNi4E6ae/VesSn7rYSrpEg=
X-Received: by 2002:a05:600c:3d06:b0:3df:ee65:9c44 with SMTP id
 bh6-20020a05600c3d0600b003dfee659c44mr31369wmb.197.1676411745887; Tue, 14 Feb
 2023 13:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20230214032534.507628-1-cheskaqiqi@gmail.com> <xmqqbklw95in.fsf@gitster.g>
In-Reply-To: <xmqqbklw95in.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Tue, 14 Feb 2023 16:55:33 -0500
Message-ID: <CAMO4yUHWJGB1SiqMK5dwb6q84DuavNWBx1JVjGk2f3_bqYYioA@mail.gmail.com>
Subject: Re: [GSoC][PATCH] builtin/clean.c: fix error message usage typo
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio

On Tue, Feb 14, 2023 at 12:32 AM Junio C Hamano <gitster@pobox.com> wrote:


> I think the "do not caplitalize" rule is about the sentence after
> "fatal:", "error:", "warning:", and "info:" labels.

Thanks, sorry for misunderstanding the "error message ". Will go and
find another that meets the requirements.
-------------------
Thanks


Shuqi
