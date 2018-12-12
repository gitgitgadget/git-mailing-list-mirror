Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD1BE20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 20:09:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbeLLUJo (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 15:09:44 -0500
Received: from mail-io1-f49.google.com ([209.85.166.49]:39354 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeLLUJo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 15:09:44 -0500
Received: by mail-io1-f49.google.com with SMTP id k7so15883030iob.6
        for <git@vger.kernel.org>; Wed, 12 Dec 2018 12:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=504F+Jip2CarCd7sAgVO9OOsoCwBm1AKPXH012nMkv0=;
        b=LFxg91mFVoE/91FMMzgJC4CHMdojVB8WUFqWWydkgGN4FHF4m7uCALkwp4iKJlV4tL
         cfIpBNyJvfLp3oxHvdC2k3rCR3W5V9kT7J0apVrUmqhBxbm9oHhJc3hdJ6HVPJz+fnqo
         jwvQluWRSLxSBGVZIOcd7yTMcb1HDGJhOJ/vBPowxWaNGdokYAcQX1Hc53+DDET4Pjbk
         sCby99zy3peLq+KQPJr5r2a3yJwtHH229fuXLRPOcwfESgyvA36BCZ9483P5z8GBTdAh
         jGAKWZ6fzxwSz3PsVo7K7b0JRR+mLJeNMPcApQyXzGxMGwN+W7xVvwOPydR8ZNCqLUBD
         PSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=504F+Jip2CarCd7sAgVO9OOsoCwBm1AKPXH012nMkv0=;
        b=H1HRo5Uu7dlKWJ4ggoDJtXqWxhojKL8AiX9k2JDo7J2QqKZI4s+dBTZ4d/m4D/Ql+K
         qBktp/j/RCU0tyWBTL1sGq3C3RBK1eZ+DVay8SNlLVesvwwjIMb7VvE94mPoTZ9uuNXU
         Y8liO1ExtxYLhiAv36HjTBgKjXsFI+MHhRLPnyaavW0q2b9DBge5B6lQVrK8e4uM51BA
         Gh0LBCIEbVTTHswG0qOEypFRUDhVSg5NjmNwE/0YozjGIU2Mf4o2idC5A4pF/nR77lNP
         NKIg+kk4Z7LGrK5EcnwH98RX5Bwlr7NxXyOZof7Y9R8UKFgILFK3LcT6VgRznUvS7kKW
         8O9Q==
X-Gm-Message-State: AA+aEWaayH/OaVsbHlt3sXDTzWajm5G0gwhXw3lqVdsMlrSZUz3OezSL
        abmgo9mz4ovJ/JVePI8etApHnufW+N2PCtydUD4=
X-Google-Smtp-Source: AFSGD/W+FVKbVMjosZ6Qc85crwPFiTOEgdum+2Giyy1PlJeN9IbzzXgCtWbb41rZuFFz1F/H3UqNx8gYFNnyLcahr34=
X-Received: by 2002:a5d:944d:: with SMTP id x13mr15254186ior.282.1544645383797;
 Wed, 12 Dec 2018 12:09:43 -0800 (PST)
MIME-Version: 1.0
References: <20181212194658.GA25117@duynguyen.home> <CAGZ79kZwS4J_bOd+2iTbVTJqMW_+P5Lzt1Zs92JBtfkBnj3juw@mail.gmail.com>
In-Reply-To: <CAGZ79kZwS4J_bOd+2iTbVTJqMW_+P5Lzt1Zs92JBtfkBnj3juw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 12 Dec 2018 21:09:16 +0100
Message-ID: <CACsJy8C4LkdB2E7qQEwgPniP5cVwNK9f2jgbbB_14o2LiBQL5w@mail.gmail.com>
Subject: Re: review "git range-diff -h" output
To:     Stefan Beller <sbeller@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 12, 2018 at 9:05 PM Stefan Beller <sbeller@google.com> wrote:
>
> On Wed, Dec 12, 2018 at 11:47 AM Duy Nguyen <pclouds@gmail.com> wrote:
> >
> > I'm not going to bother you with patches (yet) but I could use a few
> > eyeballs to check the help usage (and perhaps the option grouping) for
> > commands that take diff options.
>
> The grouping looks good from a cursory view, but ...
>
> > Forget about hiding irrelevant options for this particular command for
> > now. This is something we can do later.
>
> .. this seems relevant: range-diff is a diff of diffs,
> so for that particular command, I'd want to know if the option
> (e.g. --stat) is applied to the inner or outer diff.

Yeah I'll probably should send "git diff --no-index -h" instead.

> Now back to your topic: Are you planning to send patches that
> autogenerate these helps based on our source code?
> Should I pay attention to some specific part of the output?

All this comes from a new 'struct option' array in diff.c, very much
like how we handle options everywhere else. So yeah sort of auto
generation, but all the text has to be typed in manually first.
-- 
Duy
