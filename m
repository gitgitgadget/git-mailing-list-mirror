Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEBE61F404
	for <e@80x24.org>; Thu, 30 Aug 2018 16:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbeH3UOl (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 16:14:41 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:34642 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbeH3UOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 16:14:40 -0400
Received: by mail-ua1-f46.google.com with SMTP id r15-v6so5989965uao.1
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 09:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Bn2gybg4tdvE4Wnyhb5ThhkuWw9jQFWPasT0jGxOGc=;
        b=BvlyUGRqKODdxVTAhazOVBRSvVzd7FcfwBAWQL42kXsX+OylFylGmmHdCDKIg6OWcK
         rK/8AXigRmgwGQEr3vw+J70A/yqJCi5gfbeYDigYvMXkMLFEM3/6eJ+obA4VN27MA9Vr
         UofrrvDta5P6gbdz7JZHt2EXv2uWDUEKBLaozvNRF79JMryWBtTbCXy0lHKCqfuBGBPA
         LHl2/ixp5s/qWaW9VhEbHaU3lpX1nUwPyqNeZKcIPB4yJW2dOZlfU5G8KtrGSnq1VKJg
         D27Gc8XNVAHNih1xCRRyEMdslQAw3EPkns4+9vQQ6OW/LesBPXLW5tO6/ro/vh0gyT2W
         02ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Bn2gybg4tdvE4Wnyhb5ThhkuWw9jQFWPasT0jGxOGc=;
        b=ntZRnuTFbcv1J2olH6ZEcjle4HSFILbAxDnJG+PyhuSRk203jd7/RdQDeUyQTlHXgf
         W27Zy8QZ4EUvA+/+XmVYOef21Y4WLOrZbCxTGL6SE7ubJ5smiXdlkBGzHU6OUkoUkw0q
         YyFMFDkH+wXW8uSbo5serwqaBX+Vbe36nZUQVAW8DwnZD1pYaVVSbyS+xRw8Ycf7Ignf
         7xXYmLjgggLMyEpP4rfONvd7v+Itw25vz4pf8O22gM7HczK4D6yVP6wIXinYA9xThWtF
         R9NMIMK4OKwcw9Y4yZ+5vWZLmWJWgWTDIHfFcYiVmLC/YJPz9P+gAt1FlHd15rueeGnS
         TVgw==
X-Gm-Message-State: APzg51DeaXgIDbTwj+vtOoVbw3PcZ6bfbnnE+mez6Xz5pd4QcIRSGl4N
        6lAluAtuRZu0/W0hexpZKdI0RreWi0K6Qgwb9Xo=
X-Google-Smtp-Source: ANB0VdbEifojXszPiR6E8JtSHKPvIbpNYMOPiNzDu6KLKZmLD4K3KfnTwTOSICNaZFhfKIP+rs13dAnfUJbcOCJtvHk=
X-Received: by 2002:a67:f60f:: with SMTP id k15-v6mr643463vso.71.1535645507808;
 Thu, 30 Aug 2018 09:11:47 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com> <CABPp-BG1VCmCMHe=5qayS0G_Z_=e8aVQ121LWuo-OBuiUxiCYg@mail.gmail.com>
 <xmqqzhx36er2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhx36er2.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 30 Aug 2018 09:11:35 -0700
Message-ID: <CABPp-BE43kFwRZ90-EWB9Em6xk-T=QfNXCepY=0O5OYYZe-qAg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Aug 2018, #06; Wed, 29)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 30, 2018 at 8:44 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >>  Recent addition of "directory rename" heuristics to the
> >>  merge-recursive backend makes the command susceptible to false
> >>  positives and false negatives, but the risk is even more grave when
> >>  used in the context of "git am -3", which does not know about any
> >>  surrounding unmodified paths while inspecting a patch.  The
> >>  heuristic is disabled to keep the machinery "more stupid but
> >>  predicable".

...
> > - Do we really want to say "even more" here?  I'd rather we left those
> > two words off or found another rewording.  Obviously, I'm biased, but
> > there's more than just my own opinion of and vested interest in the
> > directory rename detection feature.  I'm afraid users may interpret
> > this sentence as saying the git project feels we've shipped a
> > generally bad/unsafe feature, but are only taking corrective action in
> > the most egregious of cases.  That seems to me like a scary message to
> > send.  Maybe I'm just mis-reading what you meant, but I wanted to at
> > least check what you meant here and, if that meaning was not
> > intentional, ask whether we could improve the wording.
>
> I am biased towards "keep it stupid and simple and predictable"
> camp, and want to make sure that users do not to blindly trust
> overly-clever behaviour of the tool.  As heuristics can always make
> mistakes either way, I felt that not saying "more" would be sending
> the opposite message---"in normal cases, dir-rename code will notice
> presence or absense of whole-directory renames without mistakes but
> when used in 'am -3' it misbehaves".
>
> But it was not my intention to say "it is generally bad/unsafe".  I
> just wanted to make sure that the users would understand it is "not
> fool-proof and can make mistakes".
>
> Suggestions for a better rewrite is very much appreciated.

That makes sense.  I'm not sure I can concisely convey all the right
points, but here's a stab at rewording:

Recent addition of "directory rename" heuristics to the
merge-recursive backend makes the command susceptible to false
positives and false negatives.  In the context of "git am -3", which
does not know about surrounding unmodified paths and thus cannot
inform the merge machinery about the full trees involved, this risk is
particularly severe.  As such, the heuristic is disabled for "git am
-3" to keep the machinery "more stupid but predictable".
