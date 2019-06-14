Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27F261F462
	for <e@80x24.org>; Fri, 14 Jun 2019 03:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfFNDrI (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 23:47:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46106 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbfFNDrH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 23:47:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id v9so695117pgr.13
        for <git@vger.kernel.org>; Thu, 13 Jun 2019 20:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+wrGaGXj4KsMIUriA+ivikjJGfvFBFG9FbS1MVXl3wg=;
        b=K92y3kO0/i0inYC/WGzu8PJyhcGd+xu6bFu7+C1IbfN1VCAxz9/IDkQbX1STy7N3lv
         hNjkTSD53PDG9viX+oqj8aPs/TvHTDEBttxvkwSxACsQR5RkMSwUfmNh5kbvkIRlTr1O
         pWOAZizgIuEQCBUuPWzDiYl2E++i241SgNshdHw6R6Z2uEjEJoOe8T84RwaJwVXY2ihE
         aDHRlITd7XR+A6WbxVt6Vj861cmKKpVmourB+M47/6E2R2/OalmVBxqpoRToBPA44ptL
         xWfY+/VvOtpfOQpGPlj/dtX1ov/r8rIDZ5mccOHtfbJshIgtti9saZtjsNG8LW4Mn32n
         dcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+wrGaGXj4KsMIUriA+ivikjJGfvFBFG9FbS1MVXl3wg=;
        b=mlc+eIX875IcZmrpXRRSYAEpCklqqi1dkQqPTgJ5PKJw5jYryqC1+G7GpQIzj/r7MD
         Zdj+V6c0MggOf3+wNxaSNvq6Des0oeykielVSwxZ6yHBftUWu3gjX/DLOpJYKHdAzAo4
         rjDbf8xAs5nf29UjJ20FaAh8YjSqbtY94h3HChhnInOcTkNJbDyuzoJ84tRshx5EkJ+M
         7iTP67YSAHm6k58F24P7Uxa+egjHZq0+HLQfUcxbw3RgxL7GgRiXie9VhMUnlzv6Vak0
         kxiEv4MxMuUJ2k1cEqlwwYmeUhTBoVZ8NTJoypHQfkPK3yC/Gk5zyT+XurN27Mp8i841
         a4vg==
X-Gm-Message-State: APjAAAVIxdHhA2flyajnU32J1SVICmW7pBu7ZZNs+M9Fh2G85ZBedVW0
        QLIvFXj0YgTncdOmKKa3I5IpadVCtI4=
X-Google-Smtp-Source: APXvYqyg90XrmT8ehk2U/1ro+fAEz+49jMV3QP5A7TispJKnNkc8phacir+4a4/ZFevYGDbjg4E9Zg==
X-Received: by 2002:a65:62c6:: with SMTP id m6mr34032247pgv.306.1560484026928;
        Thu, 13 Jun 2019 20:47:06 -0700 (PDT)
Received: from ar135.iitr.local ([117.234.2.144])
        by smtp.gmail.com with ESMTPSA id o13sm1258071pgr.86.2019.06.13.20.47.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 13 Jun 2019 20:47:06 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     martin.agren@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, rohit.ashiwal265@gmail.com,
        t.gummerer@gmail.com
Subject: Re: [GSoC][PATCH v3 1/3] sequencer: add advice for revert
Date:   Fri, 14 Jun 2019 09:14:57 +0530
Message-Id: <20190614034457.19183-1-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <CAN0heSp_XDZTviwGDpOuXhuh+8k-BA7Ld6z9gSHA9My+16BnbQ@mail.gmail.com>
References: <CAN0heSp_XDZTviwGDpOuXhuh+8k-BA7Ld6z9gSHA9My+16BnbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin

On 2019-06-13 19:21 UTC Martin Ågren <martin.agren@gmail.com> wrote:
> 
> > > +     const char *in_progress_advice;
> > > +     const char *in_progress_error = NULL;
> 
> The assigning vs not assigning is a bit inconsistent, but that's a very
> minor nit, and not why I started replying. Only noticed it just now. :-)

Let's make both NULL then.

> I agree 100% with Phillip, but I'll also note that "the control must not
> reach here" doesn't tell me anything that BUG() doesn't already. That
> is, the point of BUG() is to document that, indeed, we shouldn't get
> here and to alert if we do anyway.

Agreed.

> An obvious alternative would be
> 
>         BUG("action is neither revert nor pick");
> 
> but that doesn't say much more than the code already says quite clearly,
> plus it risks getting outdated. I'd probably settle on something like
> 
>         BUG("unexpected action in create_seq_dir");

Yeah, now that I know more about what BUG is truly intended for, I
think you are right here. We should change it.

> which should give us a good clue even if all we have is this message (so
> no file, no line number), but I am sure there are other good choices
> here. :-)
> 
> Thanks Rohit for your work on this. I'm impressed by how you've polished
> this series.

Thank you very much Martin. Appreciations like these help us developers
keep going and working even harder.

Thanks
Rohit

