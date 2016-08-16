Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9339A1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 21:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbcHPVVB (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 17:21:01 -0400
Received: from mail-yw0-f180.google.com ([209.85.161.180]:36703 "EHLO
	mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753240AbcHPVU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 17:20:58 -0400
Received: by mail-yw0-f180.google.com with SMTP id u134so50937642ywg.3
        for <git@vger.kernel.org>; Tue, 16 Aug 2016 14:20:51 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bBzEW8C+g7bvnOENUmlBbmLeQREH+jb7EaDbQqA1ORk=;
        b=cK+PYH9pS/V6A8DLiKoCxUicNiz74uREMIxqx/y8dLx0KHPjfVEw9sZG9Tg+/q+Ez8
         bWes3ZGg6KjND3HgHywEzUBn0u34Lf4cpbzIEkOu90LTLK0fLo6K9ZysFkgO8nukXb7/
         ozK6t0FYuhTyug6UG5ixGRkSL9UPlTdOsC3P6tWEhVSywKajOPyiUHSfACxVp0XRWoT9
         C1xiNOz82I1YBGL98RJPh+8qD8/6nlTSbUodS98ho6uH7wEA1kQR6/xyipc6sxZHKjWv
         BNPgeZ4vUtNHS0nSe+9G3EnZau/J8Tfzg2dGpAAjieD4U18IElpVXF/EW+zbTFBlqAVJ
         ZmDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bBzEW8C+g7bvnOENUmlBbmLeQREH+jb7EaDbQqA1ORk=;
        b=i5nFRPluG32IgFFeyHioLBmwcMi5te+db5Sc6BbsCnxS7UljvnAubBA/Xa86r4bCY5
         2X2AhtDsJxrkzWo1+vbBfwj3xEhYakHHn1RkxIfEOhOZ6QlFLRV7mXB6DSPOZyEZ63QR
         vKhVH5OOiXV7MjrmsAPlx8MVgCvxZoY0zhrr+Z87d3WQAvSwG+Fcj8WGI+jev0PVuGIl
         Wd+ZSCzu6UJ74iWit/TiJR2xdJGYSe7801rfXDBDbetwYG5bnh41cuVScmaiVUQkG51i
         oIcy0D2JbK9W6tL3dn9WePgCNoqGQjeTrA68KOvcmEg2HcOkMxamCtXeE0R+Z4dnXoFL
         3+lg==
X-Gm-Message-State: AEkoousio3IrqRFjEprpwwQmqSEKnubOpHd5IsBmT/UcOpy4u9c1LR2h00ZrI0zoFXby9nbsCuGIyDyk1gS95Q==
X-Received: by 10.129.46.136 with SMTP id u130mr28217140ywu.234.1471382451189;
 Tue, 16 Aug 2016 14:20:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.196 with HTTP; Tue, 16 Aug 2016 14:20:30 -0700 (PDT)
In-Reply-To: <xmqqvaz0bemk.fsf@gitster.mtv.corp.google.com>
References: <20160815230702.30817-1-jacob.e.keller@intel.com>
 <20160815230702.30817-4-jacob.e.keller@intel.com> <xmqqh9akczyp.fsf@gitster.mtv.corp.google.com>
 <CA+P7+xqc_WwzjUnF5P4arBhBqgRbtXyKC9QWtRJ3+fmx0Q2+oA@mail.gmail.com> <xmqqvaz0bemk.fsf@gitster.mtv.corp.google.com>
From:	Jacob Keller <jacob.keller@gmail.com>
Date:	Tue, 16 Aug 2016 14:20:30 -0700
Message-ID: <CA+P7+xrnUAN8M4UX0hZN213yUKndb_4d+AjohWV45KvCdJm9PQ@mail.gmail.com>
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

On Tue, Aug 16, 2016 at 2:14 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>>> +
>>>> +     if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED) {
>>>> +             /*
>>>> +              * If the submodule has modified contents we want to diff
>>>> +              * against the work tree, so don't add a second parameter.
>>>> +              * This is essentially equivalent of using diff-index instead.
>>>> +              * Note that we can't (easily) show the diff of any untracked
>>>> +              * files.
>>>> +              */
>>> ...
>>> I am debating myself if this is a good thing to do, though.  The
>>> submodule is a separate project for a reason, and there is a reason
>>> why the changes haven't been committed.  When asking "what's different
>>> between these two superproject states?", should the user really see
>>> these uncommitted changes?
>>
>> Well, the previous submodule code for "log" prints out "submodule has
>> untracked content" and "submodule has modified content" so I figured
>> the diff might want to show that as a diff too? Or maybe we just stick
>> with the messages and only show the difference of what's actually been
>> committed.. I think that's probably ok too.
>
> I do not have a strong opinion.  We only see DIRTY when we are
> looking at the working tree at the top-level diff (i.e. "git diff
> HEAD~ HEAD" at the top-level, or "git diff --cached" will not show
> DIRTY_SUBMODULE_MODIFIED when a submodule has local modifications in
> its working tree), so in that sense, it probably makes sense to show
> the more detailed picture of the working tree like your patch does.
> After all, choosing to use --submodule=diff is a strong sign that
> the user who says top-level "git diff [<tree>]" wants to see the
> details of her work-in-progress.
>
> Do you need to handle "git diff -R [<tree>]" at the top-level a bit
> differently, by the way?  If this function gets the full diff_options
> that is driving the top-level diff, the DIFF_OPT_REVERSE_DIFF bit
> would tell you that.
>

Probably. Unfortunately what I really need is to be able to convert
(almost) all diff options from the diff_options structure back into
command line flags. This is the primary reason I would prefer to not
use a sub-command, but I'm not really sure what's the best way to
actually DO that in a safe way.

The sub command brings nice separation between the superproject and
its submodules... but it has problem because we can't use C calls
directly, so I can't pass the options along myself.

Thoughts on that? Or should we just limit ourselves to only some
options get propagated to the submodule?

Thanks,
Jake
