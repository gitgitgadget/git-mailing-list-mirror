Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 075171F404
	for <e@80x24.org>; Thu, 12 Apr 2018 23:41:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753356AbeDLXlM (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 19:41:12 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:33540 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeDLXlM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 19:41:12 -0400
Received: by mail-io0-f176.google.com with SMTP id p139so8309531iod.0
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 16:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=E9yL5eN3V6MqlYn/2Xft4rVICb5lqFb8K9lySaeqlKY=;
        b=sjMr/bLqU0s+VByiWQOsfuC2wuk0lVzJrL7wj7egVAY83txp26j2vTDFZYbGUyPPIK
         u9JhWneJzWvYYUvXN+Bv1ndjLxqfrsz0D7kCOQ8k6nQ6WJqKOj5mnCaszpoTosicnw0l
         mCmmfxayfL4mWwBQ24gW+KBSclbYkbRTjv586vQteQize/UPqjbdrQP+bJTcrrSLvd28
         pM7ABhOfVslLWCH6alXziNHK4G+M7xGVW4nfiroFi76UK9hjxEJMFGwcBIF173FFWyQh
         SFTh2gHq39Gc9yfUdfHT6Nsl8XYSrUoiBkpI5l850amIkEj04VzyqMSPQxrwPqwt8Oxq
         t25A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=E9yL5eN3V6MqlYn/2Xft4rVICb5lqFb8K9lySaeqlKY=;
        b=El4R8MtSWK9JHcJME9H/RU+JJH6q8soOofIUrsXDTPRxD53FhqNYv/4r1bX0nLf6xc
         HGEjiKi88XRrL6gjFQiQnqm4zvK7hR2TsWJ/34jmCJyHt16jInU6ZP5EFRyIi2xsPZPB
         7Dmd5+mVoSiH2XFHYWQ0i3hrQLgUpYHUAahrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=E9yL5eN3V6MqlYn/2Xft4rVICb5lqFb8K9lySaeqlKY=;
        b=r+yiykGAoYN+Syf8BeaMklig4ORQnto5bt5GIC5RKXPnmZ01urcaKcyzRPxXYWTOsk
         stnuokAAYplLL3p0EWErCKdmwtslGOZcHwelnNfUmDNskw2AGAKjFga+zW3shrMRe6Tl
         7O3TD1PjpjDy5uuaILoDiYnIg5ZaAn4sb1J7mb9m22h5hb8MjPFdd5NAAjSpFqjT3EZi
         B/F3O2U+6m0b29wFgCIZAaByh65pr2LHuJ/uUzyatBkSSOd6MAakt0vmeQKg3hkgbhO4
         D2Xd+xsFeg1JszNKdgmTZsCK+l2h/zUfVYkt9972DAuWYYErn6GLOzReJoyLhqABfr3X
         cFMw==
X-Gm-Message-State: ALQs6tATLPGSwnM38SjN05EDepbn9xgkgXcJ1RlibxkH8HJEIFskAbHm
        2tDG1Kp/JczNGxvXcITKudses6vCE1br4pSDZ4gfKZtO
X-Google-Smtp-Source: AIpwx4/JZbv0nn+m8ljCGVcKfrbTO1zXJU6i+e3209/9b/dUrxJr6efeBvExp9QdRu9CphqOujX70HAr2PMdZlzipWk=
X-Received: by 10.107.175.219 with SMTP id p88mr10947384ioo.257.1523576471055;
 Thu, 12 Apr 2018 16:41:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Thu, 12 Apr 2018 16:41:10 -0700 (PDT)
In-Reply-To: <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com> <xmqqtvsg10bu.fsf@gitster-ct.c.googlers.com>
 <CA+55aFxA9YVLoh_23V8Hi+X7ODEmqg-dhdAYZz1jbq5JhXqBFw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Apr 2018 16:41:10 -0700
X-Google-Sender-Auth: 68nrH-J_3okqXpfg_6YVdLMGB_g
Message-ID: <CA+55aFwM2CaafNGq8_=GkYAw9inpm-4xcyHUmKprLv4Gb3-aVg@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 4:35 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> in process_entry(), and I think  we could just there add a test for if
> o_old,o_mod == a_oid,a_mode or something?

Actually, not process_entry, but merge_content().

Oddly, that *already* has the check:

        if (mfi.clean && !df_conflict_remains &&
            oid_eq(&mfi.oid, a_oid) && mfi.mode == a_mode) {
                int path_renamed_outside_HEAD;
                output(o, 3, _("Skipped %s (merged same as existing)"), path);

but that doesn't seem to actually trigger for some reason.

But the code really seems to have the _intention_ of skipping the case
where the result ended up the same as the source.

Maybe I'm missing something.

                 Linus
