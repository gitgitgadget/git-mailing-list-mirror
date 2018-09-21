Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A7AE31F453
	for <e@80x24.org>; Fri, 21 Sep 2018 16:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390650AbeIUWDM (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 18:03:12 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:41924 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389657AbeIUWDM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 18:03:12 -0400
Received: by mail-io1-f53.google.com with SMTP id q4-v6so12793942iob.8
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmYobqo4Zd6JePfn8DTpXoPydOtUR14OfUzx5LGiV1E=;
        b=C+YvezOhUGw2n/z0ZhakfMxLoAqoNk/0XFWgsmLmeH7yEvhsnV79Jo6+jQNO8YHGw1
         xJOkavKZExkUMlz7eu1aGcQ3MQIv2XP6Kj9SzOBZwW61Li3B1Edp/fznilf6TepNIH51
         pWRzkZRM8XzmcwTL9VBJ+S3wfH88oiLxmZ1j+E1fv9/C+fpGilO+b0uy9b+VrSXyydPb
         ppn2JXhTwTTQyt9PJIPEJuSXeYuc76spG276NOWspzB3XkEVaV9/+7L/gBkkNYXRgAIA
         tYHbLX0FZ0yMISyljP3NfGymUVx0TE//DUPogowPKaWPEbysU4i0x/eax3brmGHBX9jE
         vzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmYobqo4Zd6JePfn8DTpXoPydOtUR14OfUzx5LGiV1E=;
        b=EEHCzLeqAqcHqV9M6S+6tuB4+39luZITt/gGiPzO5AgIWCIprcBgg6JMDBQMSYqSDA
         GxsROUghgox7qZQYhxOyV5ntPjohgMkUOhEJQtcCeX0yMjlVdmxGfwTJVGUFmoNnqUlp
         cDQI7gmUJ/Bj6LaUJn9k1US+Srt8AIMtm7wr+22ldV8gLC/FhuF4yUVgYL7rAnU/iaTE
         HZTsysZb6imMVDjaS7U0rqYi2e8HZqdVpDCZSf+WKnS/sYapEZXfhJXhk3m03qHF1Btq
         N65PhbFG5WuQ6XI1AloXEaDlc4HdVQ8kgILcb+8z+O/vVAQp+vqgyTGvQSZj8iL6RaW6
         BJJA==
X-Gm-Message-State: APzg51CGj3jxfGe6orR7RmTx5vMEo3JDnImfjVlUwCwXHT62WzqhMHNT
        dfX6ZnNkqGl9mtr2fnY8ZSA3Z8O9ZImt7zT4MvKfpw==
X-Google-Smtp-Source: ANB0VdbgL1FB9HM88XO8ZHHPZri41o6w5o3MJ3zAyLybmIOwR2AC9liUfSu+dvw9NEKEs4XGiVsTQOyZGud/Weyedts=
X-Received: by 2002:a6b:9885:: with SMTP id a127-v6mr34756964ioe.282.1537546417101;
 Fri, 21 Sep 2018 09:13:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAB=bJ9Mjw2keJ3aspLWcreLBcB15Eq-WjtBO0XS8B=C3XJmx9A@mail.gmail.com>
In-Reply-To: <CAB=bJ9Mjw2keJ3aspLWcreLBcB15Eq-WjtBO0XS8B=C3XJmx9A@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 21 Sep 2018 18:13:10 +0200
Message-ID: <CACsJy8Cn-SyY6E8O3ttmr8k2vJ+8gGoN+NFmUSD71yiC1t552w@mail.gmail.com>
Subject: Re: git check-ignore ignores negated entries
To:     david.alphus@gmail.com
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 20, 2018 at 7:25 PM David Alphus <david.alphus@gmail.com> wrote:
> In looking through check-ignore.c, it appears that we check that
> last_exclude_matching() returns an exclude object. It should be noted
> that we do not consider that exclude struct can be set with the
> EXC_FLAG_NEGATIVE flag. This flag says that the final matching rule
> should not be ignored.
> check_ignore needs to consider this condition in order to work properly.

I haven't checked the code yet. But since you already did, patches are
welcome ;-)
-- 
Duy
