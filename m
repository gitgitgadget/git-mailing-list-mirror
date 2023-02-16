Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62835C61DA4
	for <git@archiver.kernel.org>; Thu, 16 Feb 2023 14:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjBPOFB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Feb 2023 09:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjBPOFA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2023 09:05:00 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD581CDE9
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 06:04:58 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id w11so2862699lfu.11
        for <git@vger.kernel.org>; Thu, 16 Feb 2023 06:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7ZTbxKhrEwxaiTbDr3WV3gjj8aIUdAcLJjppl+dTvt8=;
        b=kfsCFFLHdLtEhh9uS4mxDB10sM+IZ62Bfr+/ByVI0uqDwX47bGagsannJx/aRwzr5w
         /tJC88fzWJhwc8Z2TWiQOvScz9YroJRrwfKSl4KDlLX8+wptNBhz9up7OZIHIYurNltS
         Y9HD6W++Y0lQ4X/K/T+4iRm/gQ92zpCBWcRid7eKAuqQFmskJkWkaZADbAG9w/hIQOMw
         5wTccx56vRfP0JIZUq3lc2P2vuOV+7NuaBCYc6FIBj3j/XJCir5Fj1mL3/f51WEnonNY
         Sy4NSvI2j+7qDETwZXmPdqwxKwkX00kBNqRzpowFGcsSazvHexHA6uqq1CS6OAarA8nW
         BoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ZTbxKhrEwxaiTbDr3WV3gjj8aIUdAcLJjppl+dTvt8=;
        b=erHv2Mn5+rnh+BeHNHR9Wu+WmlAjKr/TwWayu83VehXiIdBsbv/4lzkADJF8v/LFrJ
         5ZBlQWCMqFseimqz/sq90Gi8Q9/VfGx0Te1tCbk4UDGV7edXU6ntXxCrj8givrjY8HnW
         scuH9qbiQgReWUkSOtjn09WzCAJtWVCFVo9+trTRQcEmfP4buVvXTaX5/2OfofRamMaD
         9qpoqOAs9BY13156OxHygUdRZs6nT1xQSBN6rdfV4opoQjqOBtO3i6jCTah9AON2nrf1
         2FAZwRNIxnZkced/yM2qS6zJJHmOwB7s/j32PaOxWkEDfv2pvd4C9aJAoB/gh3QPJaUd
         5WJA==
X-Gm-Message-State: AO0yUKUYaqPQWYtWuBLGl0r+yNvoRBfsJ8crde5/tPB7OtWXXm6Y7MfP
        /puduFHw+T4BxNgl64BL4qrJk0PztU5xEqfTw1IvCv2VAtg=
X-Google-Smtp-Source: AK7set9C7jsnNwoBpZ8sr97V6iItbfXeAEWmEJw1CvFyOLwTl999QCj2QYI5hGz6nmpStyziGuIElZbq3Pug8k5C9dE=
X-Received: by 2002:a19:f501:0:b0:4d8:5f47:e4d3 with SMTP id
 j1-20020a19f501000000b004d85f47e4d3mr1674268lfb.8.1676556296811; Thu, 16 Feb
 2023 06:04:56 -0800 (PST)
MIME-Version: 1.0
References: <20230215091950.2976-1-vinayakdev.sci@gmail.com> <xmqqmt5ezun0.fsf@gitster.g>
In-Reply-To: <xmqqmt5ezun0.fsf@gitster.g>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Thu, 16 Feb 2023 19:34:44 +0530
Message-ID: <CADE8Nao=ZrF7_0+G=jB8=j5Aji4ndCLfMp-xjbSpc1HKmmFM7w@mail.gmail.com>
Subject: Re: [GSoC][PATCH v3] apply: Change #define to enum and variable types
 from int to enum
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 15 Feb 2023 at 23:19, Junio C Hamano <gitster@pobox.com> wrote:
>
> Vinayak Dev <vinayakdev.sci@gmail.com> writes:
>
> > diff --git a/apply.c b/apply.c
> > index 5cc5479c9c..b2a03d9fc3 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -205,8 +205,10 @@ struct fragment {
> >   * or deflated "literal".
> >   */
> >  #define binary_patch_method leading
>
> Notice and explain what this line is doing, perhaps?

It does appear that the macro binary_patch_method actually refers to
an unsigned long.
I think leading represents the number of leading context lines in a
hunk/fragment,
and the variable is reused to store the type for a binary fragment.

> > -#define BINARY_DELTA_DEFLATED        1
> > -#define BINARY_LITERAL_DEFLATED 2
> > +enum binary_type_deflated {
> > +     BINARY_DELTA_DEFLATED = 1,
> > +     BINARY_LITERAL_DEFLATED
> > +};
>
> These days, we not just allow but encourage enum definitions to have
> a trailing comma after the last item, UNLESS we want to signal that
> the one at the end right now MUST stay to be the last one (e.g. a
> sentinel at the end).

> A patch that adds a new item to, removes an existing item from, or
> shuffles existing items in the list can be free of unnecessary patch
> noise to omit the last comma.

Ok. Point noted.

> As a faithful rewrite, forcing the same values to be given as before
> by saying that "_DEFLATED must be 1" is a good thing to do, but once
> the dust settled from the patch, it would be a good idea to go back
> to the code and see if the values MUST be these, or if it is fine to
> use any value as long as they are distinct.  If it is the latter,
> then it would make a good follow-up patch to remove "= 1", with an
> explanation why it is a safe thing to do.

Removing the 1 _may_ be a safe thing to do, because the value
fragment->patch_method
is finally used in a switch statement, which makes it apparent that
the difference in the values
is actually necessary, and maybe not the actual value they hold (Also,
random but distinct
values still pass the test cases).

> >  static void free_fragment_list(struct fragment *list)
> >  {
> > @@ -918,14 +920,17 @@ static int gitdiff_hdrend(struct gitdiff_data *state UNUSED,
> >   * their names against any previous information, just
> >   * to make sure..
> >   */
> > -#define DIFF_OLD_NAME 0
> > -#define DIFF_NEW_NAME 1
> > +
> > +enum diff_name {
> > +     DIFF_OLD_NAME = 0,
> > +     DIFF_NEW_NAME
> > +};
>
> Ditto.

I think that since enums start with zero by default, you are right in
saying that the '=0' here can be removed.
I will do so.

> >  static int gitdiff_verify_name(struct gitdiff_data *state,
> >                              const char *line,
> >                              int isnull,
> >                              char **name,
> > -                            int side)
> > +                            enum diff_name side)
> >  {
> >       if (!*name && !isnull) {
> >               *name = find_name(state->root, line, NULL, state->p_value, TERM_TAB);
> > @@ -1910,7 +1915,7 @@ static struct fragment *parse_binary_hunk(struct apply_state *state,
> >       int llen, used;
> >       unsigned long size = *sz_p;
> >       char *buffer = *buf_p;
> > -     int patch_method;
> > +     enum binary_type_deflated patch_method;
>
> This is not quite sufficient to achieve the goal of helping "modern
> debuggers" that was stated in the proposed log message, is it?
> parse_binary_hunk() copies the value from this local variable to a
> member in the fragment being parsed, like so:
>
>         frag->binary_patch_method = patch_method;
>
> but the thing is, as we have seen earlier, a compiler macro is used
> to (ab)use the "leading" member and call it "binary_patch_method".
> The type of that member is "unsigned long".
>
> Now if our ultimate goal were to use enum instead of macro, then an
> obvious "solution" would be to stop abusing "leading".  Instead, you
> would add "enum binary_type_deflated binary_patch_method" member to
> the fragment struct and use the enum throughout.

It does appear to be so. Introducing a new enum binary_type_deflated
binary_patch_method inside of
struct fragment would indeed be a solution.
This could be plausible, because struct fragment does not appear outside of
apply.c. Your suggestion appears to be the only right way to do it, so
as to achieve the
goal of this patch series.

> But is it worth it?
>
> Using enum instead of macro is *NOT* a goal.  If doing so makes our
> code better, we may do so---which tells us that use of enum is not a
> goal but a means to make our code better.  Is adding an extra member
> that is used only for binary patches improve our code?  I dunno.

apply.c actually seemed to be the best place to start such a change, because the
macros in the file suit such a change the best for a start. It would
have brought
unnecessary overhead in many other files, specifically those which
would affect a _lot_ of
the source code. It is just that the changes appear contained enough
to not cause a lot of
noise.
Your suggestions are very correct, I will make sure to keep them in
mind in the future.

Thanks a lot!
Vinayak
