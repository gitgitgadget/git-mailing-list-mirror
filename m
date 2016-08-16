Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3888F1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 20:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754150AbcHPU1E (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 16:27:04 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35114 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013AbcHPU1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 16:27:01 -0400
Received: by mail-yw0-f172.google.com with SMTP id j12so50078231ywb.2
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 13:26:07 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i7W2d2FHRKsp38hTMnVzihYNaKv+5uM3MbbSAJSSD8M=;
        b=Pnf8KzhOHvRqbJKuFKyEbrC7+lMhvN2v/Wv1cYIoUBOk+EhClEkhHcacYi43wuVNXx
         xlfXkCRFyfIijBN2c8I+HavilV76rLD+/jLVyqKn2u7nF2bi24e5JnXDqC/Q+r+S2Bp3
         a6lQgy3LiPKYwa8BX3uys8Xw+sWJ+ZZ3Hsaoi3yCR5Ozitu9STc+Y7Gqw4qCuMW5lPd7
         5nk6Ii99PN0/2vMbQrXH9CQ+4c6ilte9DBiKtBD9JkaJPlVDVf8mGhe6BpHwcNNqjBlB
         lbyFG/xfhjAMvAyM7NZha7oPZ43+3f2GrqXlCFHn+wsWuPhssFTGLK1rsEJI5j7Thx/E
         MAhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i7W2d2FHRKsp38hTMnVzihYNaKv+5uM3MbbSAJSSD8M=;
        b=Htd/5oy+VwZ/Ugukcc68weRu50SZdj/eJyoYpb5hy2PRT9iTcVeOcjNsc7K8M0pN7H
         mHFIyLjdzsiYV6AGhVBUlsz+83+BmE3hFOn/Z/yEMeDwgVF/fM0YeZpk9LB0GrCBriWK
         Pk/RywgIWPnTFee5SRb1zqh96DJ56w+1xYde89h5FTfVjeJ7SB22bJDEzYBlHqq/m/x6
         WLHjql6//6CxTKnSLktFsHPreFmreV1GfDlJwFjsYRkpZ93XdfzUOJ0GzOyrefgFhe6H
         pc+ychkz3Yd4jMC62BlTh7H10fbN2/O7qZhO52jLvzbC0lpKQAMFDEIpeepUDVaOGZHK
         fiFQ==
X-Gm-Message-State: AEkoousT2thDVZASXooJyPozkXzfiF3h+tOZCqysyMCHmVl7fdVE142QqyYse5fxF6o68HHfH5SqpsAtH+TaWA==
X-Received: by 10.129.135.2 with SMTP id x2mr26367377ywf.310.1471379166704;
 Tue, 16 Aug 2016 13:26:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 16 Aug 2016 13:25:46 -0700 (PDT)
In-Reply-To: <xmqqh9akczyp.fsf@gitster.mtv.corp.google.com>
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
 <20160815230702.30817-4-jacob.e.keller@intel.com> <xmqqh9akczyp.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 16 Aug 2016 13:25:46 -0700
Message-ID: <CA+P7+xqc_WwzjUnF5P4arBhBqgRbtXyKC9QWtRJ3+fmx0Q2+oA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] diff: add SUBMODULE_DIFF format to display
 submodule diff
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jacob Keller <jacob.e.keller@intel.com>,
	Git mailing list <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 11:48 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> diff --git a/Documentation/diff-config.txt b/Documentation/diff-config.txt
>> index d5a5b17d5088..f5d693afad6c 100644
>> --- a/Documentation/diff-config.txt
>> +++ b/Documentation/diff-config.txt
>> @@ -123,7 +123,8 @@ diff.suppressBlankEmpty::
>>  diff.submodule::
>>       Specify the format in which differences in submodules are
>>       shown.  The "log" format lists the commits in the range like
>> -     linkgit:git-submodule[1] `summary` does.  The "short" format
>> +     linkgit:git-submodule[1] `summary` does.  The "diff" format shows the
>> +     diff between the beginning and end of the range. The "short" format
>>       format just shows the names of the commits at the beginning
>>       and end of the range.  Defaults to short.
>
> It would be much better to describe the default one first and then
> more involved one next, no?  That would also match what the change
> to "diff-options" in this patch does (can be seen below).
>

The main thing is that "--submodule" alone means "use the log format"
so I think that's why it went first. I can reword this to make it more
clear how this works.

Thanks,
Jake

>> @@ -2311,6 +2322,15 @@ static void builtin_diff(const char *name_a,
>>                               two->dirty_submodule,
>>                               meta, del, add, reset);
>>               return;
>> +     } else if (o->submodule_format == DIFF_SUBMODULE_DIFF &&
>> +                (!one->mode || S_ISGITLINK(one->mode)) &&
>> +                (!two->mode || S_ISGITLINK(two->mode))) {
>> +             show_submodule_diff(o->file, one->path ? one->path : two->path,
>> +                             line_prefix,
>> +                             one->oid.hash, two->oid.hash,
>> +                             two->dirty_submodule,
>> +                             meta, a_prefix, b_prefix, reset);
>> +             return;
>>       }
>
> The "either missing or is submodule" check used here is being
> consistent with the existing "submodule=log" case.  Good.
>
>> diff --git a/submodule.c b/submodule.c
>> index 1b5cdfb7e784..b1da68dd49c9 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -333,6 +333,136 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
>>       strbuf_release(&sb);
>>  }
>>
>> +void show_submodule_diff(FILE *f, const char *path,
>> +             const char *line_prefix,
>> +             unsigned char one[20], unsigned char two[20],
>> +             unsigned dirty_submodule, const char *meta,
>> +             const char *a_prefix, const char *b_prefix,
>> +             const char *reset)
>> +{
>> +     struct strbuf submodule_git_dir = STRBUF_INIT, sb = STRBUF_INIT;
>> +     struct child_process cp = CHILD_PROCESS_INIT;
>> +     const char *git_dir;
>> +
>> +     if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) {
>> +             fprintf(f, "%sSubmodule %s contains untracked content\n",
>> +                     line_prefix, path);
>> +     }
>> +     if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
>> +             fprintf(f, "%sSubmodule %s contains modified content\n",
>> +                     line_prefix, path);
>> +     }
>> +
>> +     strbuf_addf(&sb, "%s%sSubmodule %s %s..",
>> +                 line_prefix, meta, path,
>> +                 find_unique_abbrev(one, DEFAULT_ABBREV));
>> +     strbuf_addf(&sb, "%s:%s",
>> +                 find_unique_abbrev(two, DEFAULT_ABBREV),
>> +                 reset);
>> +     fwrite(sb.buf, sb.len, 1, f);
>> +
>> +     if (is_null_sha1(one))
>> +             fprintf(f, " (new submodule)");
>> +     if (is_null_sha1(two))
>> +             fprintf(f, " (submodule deleted)");
>
> These messages are in sync with show_submodule_summary() that is
> used in --submodule=log codepath.  Good.
>

They're not exactly the same due to some ways of splitting up new lines.

>> +     /*
>> +      * We need to determine the most accurate location to call the sub
>> +      * command, and handle the various corner cases involved. We'll first
>> +      * attempt to use the path directly if the submodule is checked out.
>> +      * Then, if that fails, we'll check the standard module location in
>> +      * the git directory. If even this fails, it means we can't do the
>> +      * lookup because the module has not been initialized.
>> +      */
>
> This is more elaborate than what show_submodule_summary() does,
> isn't it?  Would it make the patch series (and the resulting code)
> more understandable if you used the same code by refactoring these
> two?  If so, I wonder if it makes sense to split 3/3 into a few
> separate steps:

The show_submodule_summary just uses "add_submodule_odb" which adds
the submodule as an alternate source of objects, if I understand
correctly.

>
>  * Update the internal "--submodule=<type>" handling without adding
>    the "--submodule=diff" and show_submodule_diff() function.
>
>  * Refactor the determination of the submodule status (i.e. does it
>    even have a clone?  where is its repository? etc.) from existing
>    show_submodule_summary() into a separate helper function.
>
>  * Make that helper function more elaborate like what you do here,
>    and update show_submodule_summary().  I think the state
>    show_submodule_summary() calls "not checked out" corresponds to
>    what you say "not initialized" below, and they should share the
>    same logic to determine that the submodule is in that state, and
>    share the same message, for example.

Makes sense, I might squash that with the above if it's easier.

>
>  * Introduce "--submodule=diff", and show_submodule_diff() function;
>    the latter would use the helper function prepared in the previous
>    step.
>
> perhaps?
>

That makes more sense. I'll rework the series some more.

>> +
>> +     if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
>> +             /*
>> +              * If the submodule has modified contents we want to diff
>> +              * against the work tree, so don't add a second parameter.
>> +              * This is essentially equivalent of using diff-index instead.
>> +              * Note that we can't (easily) show the diff of any untracked
>> +              * files.
>> +              */
>> +     } else if (is_null_sha1(two)) {
>
> It is safer to have ';' inside the empty if(){} block to make sure
> that one empty statement exists there.  It makes the intention of
> the code clearer, too.
>

Will do.

> I am debating myself if this is a good thing to do, though.  The
> submodule is a separate project for a reason, and there is a reason
> why the changes haven't been committed.  When asking "what's different
> between these two superproject states?", should the user really see
> these uncommitted changes?
>
> Thanks.

Well, the previous submodule code for "log" prints out "submodule has
untracked content" and "submodule has modified content" so I figured
the diff might want to show that as a diff too? Or maybe we just stick
with the messages and only show the difference of what's actually been
committed.. I think that's probably ok too.

Regards,
Jake
