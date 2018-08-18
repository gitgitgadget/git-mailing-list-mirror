Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C21951F97E
	for <e@80x24.org>; Sat, 18 Aug 2018 20:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeHRXck (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 19:32:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39015 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbeHRXck (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 19:32:40 -0400
Received: by mail-wm0-f65.google.com with SMTP id q8-v6so10320389wmq.4
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 13:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Piz1aPxLIYIBxKSBrcM9qhSV+ITXbOawrpl5vDjWfRM=;
        b=GHvss/hXj7qgsCfg5PVXWZLMMOKTrpcOKaP7pJnn62qbVOYw6zXoWDExL6sCseCXMT
         FjExCkNyKiT89PIw5YzINDT4hwnw8Ul2zzYnWUd5LeWQrAQbDvV4pwWJRtl2/Y19AhQF
         fEYllSV4SJOctGS0cKfconxMnsW0Eh/Wg5kKx4Xv5B3PXhxnHJ+N1Bw0dn/zzQwoOkGp
         CzXjPiZjFzbMRBypPbCcICwan5pMa8DPc+PjqxA+2s4YxIa2C9n5OOG4R7O/4Lbu0YGY
         WvtD/jI+WVGUINnbT7wzoP5imTz7jCW20lhhRp9MW7t0gYDcpP9D0miDHWbQ36ZWe/89
         YJLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Piz1aPxLIYIBxKSBrcM9qhSV+ITXbOawrpl5vDjWfRM=;
        b=niSHVDhF1QwHbYf1lhUBLJuy9OJ9jaA0jviyan+l+x75Dtn7i37CbsyV5KKhmtdyDH
         5LgZ1NtUAgI/ZlMqCIcrK1T/WaRj0na0OzbO8tGmkqulerkq6u8zXoyUVOockjY0LwfD
         KA8KnHsBByDxlpnukKHZVCJosWZobWrpcmFPErVMCaNeZ3/LChC19L7MD9nDZrKdA8oi
         zYV/rhKgIIxB6+ueDfegiBjfgMos1awfI9dG28k/cpVur6HKtoXerO4RtjFFKvb7ptFY
         nCSux3XO0Lk2fk2M2Mv0YoxZaqcusFop7C1i9tKol1T8iZG5XmMOkM7EktAmdzh7HTKq
         leLw==
X-Gm-Message-State: AOUpUlEbTvT6iihcJqhrNYlFGtsD7JY4hNeXHDf5w04ge27Hbj75VaA3
        kCX5ojy4JG6bCXEl9qKP+uM=
X-Google-Smtp-Source: AA+uWPxDH/r4qRGDJZMXcACKPdwRjBed5dJtQQK0NrCqw6LGAJP3pEIKpZTNr5H6XWwmhAoImAB4bw==
X-Received: by 2002:a1c:6f44:: with SMTP id k65-v6mr12447453wmc.19.1534623823205;
        Sat, 18 Aug 2018 13:23:43 -0700 (PDT)
Received: from localhost ([2.30.88.37])
        by smtp.gmail.com with ESMTPSA id i125-v6sm16222615wmd.23.2018.08.18.13.23.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 18 Aug 2018 13:23:42 -0700 (PDT)
Date:   Sat, 18 Aug 2018 21:23:41 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Paul Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC][PATCH v7 15/26] stash: convert create to builtin
Message-ID: <20180818202341.GS2734@hank.intra.tgummerer.com>
References: <cover.1533753605.git.ungureanupaulsebastian@gmail.com>
 <0393bbd09daeb7ab67da4a343ba58d824c35532b.1533753605.git.ungureanupaulsebastian@gmail.com>
 <20180815221305.GQ2734@hank.intra.tgummerer.com>
 <CADzBBBaO3em0kcebL5kiE1JxSEsea2OFrzyRUgfEDjrwV6fxsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADzBBBaO3em0kcebL5kiE1JxSEsea2OFrzyRUgfEDjrwV6fxsw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/18, Paul Sebastian Ungureanu wrote:
> On Thu, Aug 16, 2018 at 1:13 AM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > On 08/08, Paul-Sebastian Ungureanu wrote:
> >>
> >>  [...]
> >>
> >> +                     ret = -1;
> >> +                     goto done;
> >> +             }
> >> +             untracked_commit_option = 1;
> >> +     }
> >> +     if (patch_mode) {
> >> +             ret = stash_patch(info, argv);
> >> +             if (ret < 0) {
> >> +                     printf_ln("Cannot save the current worktree state");
> >> +                     goto done;
> >> +             } else if (ret > 0) {
> >> +                     goto done;
> >> +             }
> >> +     } else {
> >> +             if (stash_working_tree(info, argv)) {
> >> +                     printf_ln("Cannot save the current worktree state");
> >> +                     ret = -1;
> >> +                     goto done;
> >> +             }
> >> +     }
> >> +
> >> +     if (!*stash_msg || !strlen(*stash_msg))
> >> +             strbuf_addf(&final_stash_msg, "WIP on %s", msg.buf);
> >> +     else
> >> +             strbuf_addf(&final_stash_msg, "On %s: %s\n", branch_name,
> >> +                         *stash_msg);
> >> +     *stash_msg = strbuf_detach(&final_stash_msg, NULL);
> >
> > strbuf_detach means we're taking ownership of the memory, so we'll
> > have to free it afterwards. Looking at this we may not even want to
> > re-use the 'stash_msg' variable here, but instead introduce another
> > variable for it, so it doesn't have a dual meaning in this function.
> >
> >> +
> >> +     /*
> >> +      * `parents` will be empty after calling `commit_tree()`, so there is
> >> +      * no need to call `free_commit_list()`
> >> +      */
> >> +     parents = NULL;
> >> +     if (untracked_commit_option)
> >> +             commit_list_insert(lookup_commit(the_repository, &info->u_commit), &parents);
> >> +     commit_list_insert(lookup_commit(the_repository, &info->i_commit), &parents);
> >> +     commit_list_insert(head_commit, &parents);
> >> +
> >> +     if (commit_tree(*stash_msg, strlen(*stash_msg), &info->w_tree,
> >> +                     parents, &info->w_commit, NULL, NULL)) {
> >> +             printf_ln("Cannot record working tree state");
> >> +             ret = -1;
> >> +             goto done;
> >> +     }
> >> +
> >> +done:
> >> +     strbuf_release(&commit_tree_label);
> >> +     strbuf_release(&msg);
> >> +     strbuf_release(&out);
> >> +     strbuf_release(&final_stash_msg);
> >> +     return ret;
> >> +}
> >> +
> >> +static int create_stash(int argc, const char **argv, const char *prefix)
> >> +{
> >> +     int include_untracked = 0;
> >> +     int ret = 0;
> >> +     const char *stash_msg = NULL;
> >> +     struct stash_info info;
> >> +     struct option options[] = {
> >> +             OPT_BOOL('u', "include-untracked", &include_untracked,
> >> +                      N_("include untracked files in stash")),
> >> +             OPT_STRING('m', "message", &stash_msg, N_("message"),
> >> +                      N_("stash message")),
> >> +             OPT_END()
> >> +     };
> >> +
> >> +     argc = parse_options(argc, argv, prefix, options,
> >> +                          git_stash_helper_create_usage,
> >> +                          0);
> >> +
> >> +     ret = do_create_stash(argc, argv, prefix, &stash_msg,
> >> +                           include_untracked, 0, &info);
> >
> > stash_msg doesn't have to be passed as a pointer to a pointer here, as
> > we never need the modified value after this function returns.  I think
> > just passing 'stash_msg' here instead of '&stash_msg' will make
> > 'do_create_stash' slightly easier to read.
> 
> That's right, but `do_create_stash()` is also called by
> `do_push_stash()`, which will need the modified value.

Ah right, I didn't read that far yet when leaving this comment :)

Reading the original push_stash again though, do we actually need the
modified value in 'do_push_stash()'?  The original lines are:

	create_stash -m "$stash_msg" -u "$untracked" -- "$@"
	store_stash -m "$stash_msg" -q $w_commit ||
	die "$(gettext "Cannot save the current status")"

'$stash_msg' gets passed in to 'create_stash()', but is the
'stash_msg' variable inside of 'create_stash()' is local and only the
local copy is modified, so 'store_stash()' would still get the
original.  Or am I missing something?
