Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E613C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 19:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjCIT4Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 14:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjCIT4P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 14:56:15 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FEF8E66
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 11:56:12 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id y14so3065818ljq.4
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 11:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678391770;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O6IBPYwPoudVVHpgROf+oHuPY8ZoJ9r1fl+kHqB8jr4=;
        b=iDQgZFFHfeiIjhYjkZTBy02fxvc1uHHNZNgCvY6hgPpyPa9Av+uWBfTzYf+DdANc9u
         b1s2/zot32gRKnB2iKbp64ok9+xTx8Crf3vW2zjPnaUCRmHVy2LVfZQdnHwzCuS9xBVP
         r+U9VK5lpgTq5YehUcbXNAr2zbosaz8VdNIOud0/LD0GI/6da8N1TJyyU4KQtnLwwSAd
         NhRfssOz+qWxhIppKkunln1vK95xfHoJ7Q1EUifH08wxP3bVn9N5Q5dSCQublLnUQRKw
         GXlkWTGJS4g5uzpq9ZbwMsoYrb5jEB/cFPUA1EcBOmnCkQbvKEcJQ8z+rItDkpNG/M4o
         IKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678391770;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O6IBPYwPoudVVHpgROf+oHuPY8ZoJ9r1fl+kHqB8jr4=;
        b=rZLsiQNFLgT0gaxhgZ1GPqrhOUP06WvNcq/DR3CCEn7L1mcvb1b0hqGgQLGMjmUvFo
         NDMcyczu4Fc8ZC1GJP/Enlyn4npuFzxJJpsSMJ4d3whNHM6zlMXuCJmJkNtUmycogOvt
         EmvDB8tjIuTg5QZHpLoEAHuq6qmfvNDGLtowas4LuiMxD8NFgius0xWqZMAvAoFdWM9Z
         pG52mn8VnK+0fwzFOBaER/jB+jSX+354AFis2NjJv6QJ0D2Iu4viFJB2pJQfD2y4wvEz
         EdJHqLWCEits+hqmkpgJHEerMMVE0zp2VwOfqF4NrG7K3vaIXoorWPOzCOExCeDNGVf1
         RIsQ==
X-Gm-Message-State: AO0yUKUWawkAzraZigctT9sjlH/IKSQxPMlQlOP4y2SyhPeNNpD+GYbY
        TTtfa7rnmWNu4qWR8fpcR5QnCLIFGJo=
X-Google-Smtp-Source: AK7set+msyBL8oY5/uKTXWSmRHkOd2FiuDxQTvHW1Im1QZURshQvkMpyEuG0eWBtiFmWq9D/Oph+Qw==
X-Received: by 2002:a05:651c:1720:b0:293:4fe3:8f97 with SMTP id be32-20020a05651c172000b002934fe38f97mr6552182ljb.20.1678391770206;
        Thu, 09 Mar 2023 11:56:10 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id f4-20020a2eb5a4000000b0029352fc39fbsm5148ljn.63.2023.03.09.11.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 11:56:08 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: so/diff-merges-more (was Re: What's cooking in git.git (Feb
 2023, #01; Thu, 2))
References: <xmqqr0v7o0pp.fsf@gitster.g> <871qn5pyez.fsf@osv.gnss.ru>
        <kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com>
        <87wn4tej2f.fsf@osv.gnss.ru>
        <kl6lh6v43s4g.fsf@chooglen-macbookpro.roam.corp.google.com>
        <xmqqr0u7ku3j.fsf@gitster.g> <87wn3zqefx.fsf@osv.gnss.ru>
        <kl6lzg8pcygl.fsf@chooglen-macbookpro.roam.corp.google.com>
        <878rg8j2vg.fsf@osv.gnss.ru> <xmqqzg8ozbuh.fsf@gitster.g>
        <87jzzqzy20.fsf@osv.gnss.ru> <xmqqzg8mrgc8.fsf@gitster.g>
        <874jquxc67.fsf@osv.gnss.ru>
        <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Thu, 09 Mar 2023 22:56:07 +0300
In-Reply-To: <kl6lh6uthlc3.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Thu, 09 Mar 2023 09:43:24 -0800")
Message-ID: <878rg5vgvc.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I already agreed long ago that to be on the safe side we shouldn't
>> simply change -m nowadays, and addressed that concern by putting -m
>> behavior change under configuration option in the current series. So
>> what's the reason of rejection?
>
> Before we start talking in circles again, I think the responses
> elsewhere in the thread still accurately capture mine and Junio's
> views, e.g.:
>
>   https://lore.kernel.org/git/xmqqedr28wwb.fsf@gitster.g
> https://lore.kernel.org/git/kl6lr0v2i0gn.fsf@chooglen-macbookpro.roam.corp.google.com/

There were no any response from you to my recent very direct question
(that Junio did somewhat address), but what I figured from your and
Junio explanation so far looks like:

1. The fact that -m does not imply -p is a mistake. There is no any
   reasons this exact behavior could be useful. As such, it does not
   make sense to support this exact behavior in --diff-merges. So the
   reject of --diff-merges=[no-]hide.

2. This mistake is too dangerous to fix due to subtle compatibility
   problems, so we can't just fix -m behavior. Thus the reject of my
   earlier patch "let -m imply -p".

3. Moving behavior change under option is not worth it, as nobody
   presumably needs this fixed -m behavior anyway (at least among 2
   persons that are actually opposing the changes). So the reject
   of "add diffMerges-m-imply-p configuration option" patch.

4. Staring in the face inconsistency between -m and the rest
   of short diff-merge options is not significant enough to reconsider
   any of the above rejects.

Did I outline your positions correctly and to the full extent? Anything
else I forgot?

I want to make sure I got it exactly right, as I'd still like to tweak
my proposals, and I'd like to avoid the troubles I got into as much as
possible.

Thanks,
-- Sergey Organov
