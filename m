Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB6ED1F461
	for <e@80x24.org>; Mon, 19 Aug 2019 15:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbfHSPmX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Aug 2019 11:42:23 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46586 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727647AbfHSPmU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Aug 2019 11:42:20 -0400
Received: by mail-qt1-f193.google.com with SMTP id j15so2341828qtl.13
        for <git@vger.kernel.org>; Mon, 19 Aug 2019 08:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eB3Tptwn7w94XCvx1AD+yqGVlts8IfQZaNtCZwABMik=;
        b=lG/6Yvy2qIr+9jVjZx0ViWuY/msX/YKdwVwjjhQW25quNHLKR7KycuAgdwdShlW9cA
         B8PG4Obx2nn7c5BGeYWbrEZm+6UGUR0y7MuQZsUV/us8ofzVPLvIfQ+yWho9ISvFDGTr
         Zpj8ehti6uJA4I5+GigxB3Cc0vvc1quGRgftJlnEptp3vsbB1V9xOZJeYzTY4gDShH0z
         u1R0UaBpWA6DCevgaqXbUW9FLXpHRUTGcesyvvdHn2MJRyiLF+5UfODLVa5iBnw1VXpH
         8cWLstztLd+Y6zXRU5FtqkWXtD08bsYD0LRf2NmNaPKOK1n7Zl7xZXTt2BxppctkII56
         nnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eB3Tptwn7w94XCvx1AD+yqGVlts8IfQZaNtCZwABMik=;
        b=O6BU6+byDeVvXAO5WsL+SItiq5tdJZndthfOo7SSTgLLGLgiJJHbmUkVmaNszNT9Yd
         lFN/zkrU47fONAxyNPyo1Lln18gU9g6+JW463tfASVaRhTuTB8jHmsP2YIjyD6YgBMW1
         S8zuzXg4EOVv8cC4ndpqjyY57JHrjdXvuNySfPDQJtW/9kULnCscFhJ52beZYK5p5u8d
         OtFVNyk3Qd3KUTGim6DmAD23NqSVtlCfG3jeUTDfbbX8NvDEBCYOpwCgvG2WH/dQcpvb
         ALaGC2AwEwVzeaveLNuzwlrCP0tQb+GjtXmcs8T5Wi+/TY+2PPcfbnOIRRw6MGcECjKc
         tu5g==
X-Gm-Message-State: APjAAAUZmnrTHCfd5R+zK0Eghe+hiUPnGnko2pzVC3PkSI5MVuvFABt0
        6WJOWcjhx+4L+XuEu7kaDvyARc/qNBGsUwoJJak=
X-Google-Smtp-Source: APXvYqziDxZP2nZQRTO1N5ujH6x+NloCafz+FzeTh9f0DLzupcW2REqNCk3JQ7Rr198nqgmkigfhwPm1drSyjC9E1A4=
X-Received: by 2002:a0c:e1cd:: with SMTP id v13mr11190848qvl.245.1566229339275;
 Mon, 19 Aug 2019 08:42:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190712150235.12633-1-vcnaik94@gmail.com> <20190801161558.12838-1-vcnaik94@gmail.com>
 <xmqqv9uy2qpj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqv9uy2qpj.fsf@gitster-ct.c.googlers.com>
From:   Varun Naik <vcnaik94@gmail.com>
Date:   Mon, 19 Aug 2019 08:42:08 -0700
Message-ID: <CAK_rgsH0Yb=CAsCgD20xx==RaDzchtEua=q6K=7R-cfURFGHuQ@mail.gmail.com>
Subject: Re: [PATCH v3] diff-lib.c: handle empty deleted ita files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 15, 2019 at 12:06 PM Junio C Hamano <gitster@pobox.com> wrote:
>
>         /*
>          * i-t-a entries do not actually exist in the index (if we're
>          * looking at its content)
>          */
>         if (o->index_only &&
>             revs->diffopt.ita_invisible_in_index &&
>             idx && ce_intent_to_add(idx)) {
>                 idx = NULL;
>                 if (!tree)
>                         return; /* nothing to diff.. */
>         }
>
> IOW, when ita-invisible-in-index flag is set, idx is made NULL and
> all the rest of the function behaves as if there is no such entry in
> the index (e.g. relative to HEAD it looks as if the entry is removed
> in the index).
>

That's right. I was hoping to avoid simply setting the ita-invisible-in-
index flag because then an ita file (i.e. a file marked as ita in the
index with no contents in HEAD) would be considered nonexistent in both
the tree and the index, and so the function would hit the return
statement above because it believes there is "nothing to diff".

> So for example, when ita-invisible-in-index is not set, this piece,
> just above the part you touched, kicks in:
>
>         /*
>          * Something added to the tree?
>          */
>         if (!tree) {
>                 show_new_file(revs, idx, cached, match_missing);
>                 return;
>         }
>
> and says "no such entry in the tree, but you have an I-T-A entry
> there in the index".
>

That sounds right, an ita file is considered to be a "new file".

> It is unclear why we can unconditionally declare "I-T-A entry does
> not exist, the entry was in the tree but not in the index" in the
> code you touched, without consulting ita-invisible-in-index flag.
> It feels awfully inconsistent to me.
>
> Of course, consistency could go the other way around, and the right
> fix to achieve consistency might turn out to be to drop the check
> for ita-invisible-in-index flag (and perhaps the flag itself) from
> the early part of this function.  I dunno.

Actually, I agree that it seems strange to consider a deleted ita file
as a "deleted file", when an ita file that did not previously exist in
the tree is considered a "new file". It felt like a dirty hack when I
was originally writing it. And the longer I look at the logic that I
added towards the end of the function, the more I worry that it
sacrifices readability and maintainability to achieve minimal gain.

Dropping the check at the beginning is probably not right either - this
would break a lot of other places that call into do_oneway_diff().

This function is probably not the place where we want to make changes.
It would be better to change diff-lib.c:show_modified() and
diff.c:diff_change() to consider the intent-to-add bit when performing a
diff. A small change to show_modified() prevents the function from
returning prematurely when "new_entry" has the intent-to-add bit set.
But now, the call to diff_change() hits the error "feeding unmodified %s
to diffcore". We can avoid this by adding a boolean "int ita" field to
"struct diff_filespec" and adjusting the following code:

@@ -5847,7 +5847,7 @@ static void diff_resolve_rename_copy(void)
                        else
                                p->status = DIFF_STATUS_RENAMED;
                }
-               else if (!oideq(&p->one->oid, &p->two->oid) ||
+               else if (!oideq(&p->one->oid, &p->two->oid) || p->two->ita ||
                         p->one->mode != p->two->mode ||
                         p->one->dirty_submodule ||
                         p->two->dirty_submodule ||

Next, we need to pass something like "int new_ita" to diff_change() and
set "two->ita" accordingly. This is where I'm stuck right now. It's easy
enough to adjust the call to diff_change() inside show_modified(), but
the adjustments to other calls to diff_change(), especially the one
inside diff-lib.c:run_diff_files(), might need some other accompanying
changes.

Does changing the diffcore code seem like a reasonable approach? If not,
then I can't think of a better one, and it might be best to leave this
patch unmerged.

Varun
