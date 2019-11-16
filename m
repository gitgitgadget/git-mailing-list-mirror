Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7A11F4B5
	for <e@80x24.org>; Sat, 16 Nov 2019 21:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbfKPVmn (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Nov 2019 16:42:43 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42364 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727273AbfKPVmn (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Nov 2019 16:42:43 -0500
Received: by mail-lf1-f66.google.com with SMTP id z12so10722237lfj.9
        for <git@vger.kernel.org>; Sat, 16 Nov 2019 13:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deltaq.org; s=deltaq;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8alBkk6bjf5GoQb8KDlsh5uzS2iyV5gdPMwBvXhZsh0=;
        b=DCFHZhJ2IYGisOiM9MJpkB9ZDfbzvjET0cY4zUcavs1NAPEsCUIe+D8SwQepy9p6hO
         HagzmkUEmCEqbESN3hmWE5gagk9ZwXHHFfVQ/gOQeo6rMg7wWiEQxxU8zqyvtQ3kZ+cC
         5MDf9XvCI9XZ3sfl5GI45bOtlk5eK1cdmaBRA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8alBkk6bjf5GoQb8KDlsh5uzS2iyV5gdPMwBvXhZsh0=;
        b=mPpPToTX0Jorep4Fzo3qWT1wm56eZ7/yivOfoJRei5I9bADhsTyK9e5eje2q3iz5wZ
         iEZlYEBiKR/coKSFrEqWX4PYOtf6+Oau1SgAY5JHNj7gFz8ettYSCIRHAik6dj3EfbgI
         oENkMlAG1xHe81Eet1bIg+uQaqdeQgj+kY3oZLkG3RMp1mgFl8ySZDNk74tUvTwLzGCi
         jlqzhmMxM5iyVCcdfio9LmQa1T61jKjETdbWfY/x6peHsehq+y6x3M11DDN1pEf9Mlte
         shJAfTiZjGBvyMcijmTy2YHjlnZ7FPxv0OxpqBryWFyuapgIL/5aOKgode9nmK42u3E+
         JESg==
X-Gm-Message-State: APjAAAVKBP+DmcMWw1xmmRdopIwvXJtPH2VLP8xsagIxqo611d26HQEl
        IDB0SccVdHyPqf5Z8FroebZFK8dnRuL/03Yc1llD2Q==
X-Google-Smtp-Source: APXvYqyBUM7I5gmoFTyLE3trDep5EOpeGJE2Qkc6yzYv3ZYZSGtl+CyY0U0x3RFEensijiu79I6arvtzK7SS3Tpxh2g=
X-Received: by 2002:a19:3845:: with SMTP id d5mr15086303lfj.162.1573940560221;
 Sat, 16 Nov 2019 13:42:40 -0800 (PST)
MIME-Version: 1.0
References: <pull.436.v2.git.1573110335.gitgitgadget@gmail.com>
 <pull.436.v3.git.1573638988.gitgitgadget@gmail.com> <dc12c1668dce875c99a45fb49ad5854a13ef4f35.1573638988.git.gitgitgadget@gmail.com>
 <20191116151113.mwbaendh6lgykfw3@yadavpratyush.com>
In-Reply-To: <20191116151113.mwbaendh6lgykfw3@yadavpratyush.com>
From:   Jonathan Gilbert <logic@deltaq.org>
Date:   Sat, 16 Nov 2019 15:42:28 -0600
Message-ID: <CAPSOpYuv1d_yAgBnVBDXMwaA3B3QpmbVKtiSpexpJDwC6Bz33w@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] git-gui: revert untracked files by deleting them
To:     "Pratyush Yadav me-at-yadavpratyush.com |GitHub Public/Example Allow|" 
        <172q77k4bxwj0zt@sneakemail.com>
Cc:     Jonathan Gilbert via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Gilbert <rcq8n2xf3v@liamekaens.com>,
        Jonathan Gilbert <JonathanG@iqmetrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 16, 2019 at 9:11 AM Pratyush Yadav me-at-yadavpratyush.com
|GitHub Public/Example Allow| <172q77k4bxwj0zt@sneakemail.com> wrote:
> > -             grid $w.msg - $w.vs -sticky news
> > -             grid $w.unlock $w.continue - -sticky se -padx 2 -pady 2
> > -             grid columnconfigure $w 0 -weight 1
> > -             grid rowconfigure $w 0 -weight 1
> > -
> > -             wm protocol $w WM_DELETE_WINDOW update
> > -             bind $w.continue <Visibility> "
> > -                     grab $w
> > -                     focus %W
> > -             "
> > -             wm deiconify $w
> > -             tkwait window $w
> > +     close $fd
> > +     $::main_status stop
>
> I didn't spot this earlier. Will this call to 'stop' interfere with the
> 'start' in 'delete_files'?

Hmm, I think this actually highlights a larger issue. Both
`write_checkout_index` and `delete_helper` display their progress in
the status bar, so if the user elects to do a check-out, and then
while it is still in progress asynchronously, elects to delete files,
they'll fight over who gets to set the status. If I'm understanding
correctly, this won't actually interfere with correct operation, but
of course it won't look very nice.

If they overlap in this manner, _then_ multiple calls to `stop` could
be made, though it does appear that `stop` is idempotent. The Tk
documentation states that `destroy` doesn't return any error if you
point it at a window that doesn't exist.

`start` is explicitly idempotent, only creating a new canvas if it
doesn't already have one.

I'll see what I can come up with for letting operations more cleanly
share the status bar.

> >       if {$update_index_cp >= $total_cnt} {
> > -             _close_updateindex $fd $after
> > +             if {[_close_updateindex_rescan_on_error $fd]} {
> > +                     unlock_index
> > +             }
> > +
> > +             uplevel #0 $after
>
> This changes when $after is called. If you pass it to 'rescan', it runs
> _after_ the rescan is finished. Now it runs "in parallel" with it. Are
> you sure that is the intended behaviour? Should we just stick to passing
> $after to rescan on failure?
>
> [..]
>
> While we're here, how about just moving this entire thing to
> '_close_updateindex_rescan_on_error', since the only two consumers of
> the function do the _exact_ same thing?
>
> This would also allow us to pass $after to 'rescan'. It would also
> hopefully make the code a bit easier to follow because you can clearly
> see that we only unlock the index when there is no error.
>
> Even better, unlock the index unconditionally in
> '_close_updateindex_rescan_on_error', and remove the 'unlock_index' call
> from 'rescan_on_error'. I generally prefer to keep locking/unlocking
> paths as simple as possible.

Hmm, yeah, this makes sense. Pass it `$after`, and then if it calls
`rescan`, it can hand it off, and `rescan` also (I'm assuming?)
implicitly unlocks the index. If it doesn't need to call `rescan`,
then `_close_updateindex_rescan_on_error` itself unlocks the index
_and_ invokes `$after`.

> >       if {$update_index_cp >= $total_cnt} {
> > -             _close_updateindex $fd $after
> > +             if {[catch {_close_updateindex $fd} err]} {
> > +                     uplevel #0 $capture_error [list $err]
> > +             }
> > +
> > +             uplevel #0 $after
> > +
>
> Nitpick: Please explicitly mention why we _don't_ want to unlock the
> index here.
>
> There are two function very similar to this one: 'write_update_index'
> and 'write_update_indexinfo'. This subtle but important difference is
> very easy to gloss over.

Hmm, so, this suggests a rename of
`_close_updateindex_rescan_on_error`, because (with the previous
proposal) it implicitly includes unlocking the index, whereas
`_close_updateindex` does not.

Thanks,

Jonathan Gilbert
