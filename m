Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D7791FEB3
	for <e@80x24.org>; Mon,  9 Jan 2017 12:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759417AbdAIMDU (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 07:03:20 -0500
Received: from mail-it0-f49.google.com ([209.85.214.49]:34154 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938538AbdAIMDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 07:03:16 -0500
Received: by mail-it0-f49.google.com with SMTP id x2so15680264itf.1
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 04:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mrs9G+A0FFs0airwg+nDbyJJqsazJdNX3SFzfjM8v4g=;
        b=qN9r2iqgbaqxFAVNDXdxRjtL+3YyZbUK2lO/17/j4C1+qpMvLr2r3itaemY3Yyh0ff
         aqZZ3T88zJslNhbHaM7afhGIWKrGWRAVvpyP9aB6xSw2XV9puAOace/hShgFvJcEGKFo
         f14HYatZOIQjq2ozyN/ExNvzoxqP7FggpUpoIeG33MVlVnsrgps1mLgTkRnX5PTJt5nV
         zr3dizhcyHLAHR3XvnnQFHXL+YFpPopyS6TKoAuaXj/zMa247PGl94SG8/3Pc/UNwcdi
         zqeqN5AmGALw/RPiE0ehzPYRihbMk5XxMR/sP0pn2hrNYnmcnkeT9zRwznIYJ7QE2L7Z
         Fsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mrs9G+A0FFs0airwg+nDbyJJqsazJdNX3SFzfjM8v4g=;
        b=gf195TeGatl19llrFs420NwCGvJairL2QL84s+Tlg2lyOrpy4MDchvL28oa07MQthp
         2Nt6VANMDkIoRUyRB7NjIFkDTj01nnDg7w9/g5lnimBMKf3VnDwDwVp34vThbaTf/s2M
         UgQhL8bjUg1uAepZbLltTB+lHa+HpozY04cP1CesdGy0VoGe+xB4/LlfRNVXU2nTh0aL
         P/u1CwOFleq1sJOiBzoNtYaG+gVq7AeSL99LCCnTNvSHmVj3JyZI21YmfGAvuM6XwfMX
         9Bq92WbWIQmQHVySz/rbQmUizBMXgoxRzYy5D10KJZ31gXDFB7rJqiYErCWdXsWszGf3
         JrfQ==
X-Gm-Message-State: AIkVDXKLEnp/Imkyvg65lD06QHDJrcjALz5Le3LlpUfbo/SkcSo7jKSICLXN+IXN+e44vWTztfGBafAi9IjbtQ==
X-Received: by 10.36.184.194 with SMTP id m185mr8472812ite.3.1483963395841;
 Mon, 09 Jan 2017 04:03:15 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 9 Jan 2017 04:02:45 -0800 (PST)
In-Reply-To: <20170105112359.GN8116@chrystal.oracle.com>
References: <20170105112359.GN8116@chrystal.oracle.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Jan 2017 19:02:45 +0700
Message-ID: <CACsJy8BRfJG6L49VyC+qsrQ9Arz0gCGpMATpK9uLq61Lx6_Jtg@mail.gmail.com>
Subject: Re: Refreshing index timestamps without reading content
To:     Quentin Casasnovas <quentin.casasnovas@oracle.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 5, 2017 at 6:23 PM, Quentin Casasnovas
<quentin.casasnovas@oracle.com> wrote:
> Hi guys,
>
> Apologies if this is documented somewhere, I have fairly bad search vudu
> skills.
>
> I'm looking for a way to cause a full refresh of the index without causing
> any read of the files, basically telling git "trust me, all worktree files
> are matching the index, but their stat information have changed".  I have
> read about the update-index --assume-unchanged and --skip-worktree flags in
> the documentation, but these do not cause any index refresh - rather, they
> fake that the respective worktree files are matching the index until you
> remove those assume-unchanged/skip-worktree bits.
>
> This might sound like a really weird thing to do, but I do have a use case
> for it - we have some build farm setup where the resulting objects of a
> compilation are stored on a shared server.  The source files are not stored
> on the shared server, but locally on each of the build server (as to
> decrease network load and make good use of local storage as caches).
>
> We then use an onion filesystem to mount the compiled objects on top of the
> local sources - and change the modification time of the source to be older
> than the object files, so that on subsequent builds, make does not rebuild
> the whole world.
>
> This works fine except for one thing, after changing the mtime of the
> source files, the first subsequent git command needing to compare the tree
> with the index will take a LONG time since it will read all of the object
> content:
>
>   cd linux-2.6
>
>   # Less than a second  when the index is up to date
>   time git status > /dev/null
>   git status 0.06s user 0.09s system 172% cpu 0.087 total
>                                               ~~~~~~~~~~~
>
>   # Change the mtime..
>   git ls-tree -r --name-only HEAD | xargs -n 1024 touch
>
>   # Now 30s..
>   time git status > /dev/null
>   git status  2.73s user 1.79s system 13% cpu 32.453 total
>                                               ~~~~~~~~~~~~
>
> The timing information above was captured on my laptop SSD and the penalty
> is obviously much higher on spinning disks - especially when this operation
> is done on *hundreds* of different work tree in parallel, all hosted on the
> same filesystem (it can take tens of minutes!).
>
> Is there any way to tell git, after the git ls-tree command above, to
> refresh its stat cache information and trust us that the file content has
> not changed, as to avoid any useless file read (though it will obviously
> will have to stat all of them, but that's not something we can really
> avoid)

I don't think there's any way to do that, unfortunately.

> If not, I am willing to implement a --assume-content-unchanged to the git
> update-index if you guys don't see something fundamentally wrong with this
> approach.

If you do that, I think you should go with either of the following options

- Extend git-update-index --index-info to take stat info as well (or
maybe make a new option instead). Then you can feed stat info directly
to git without a use-case-specific "assume-content-unchanged".

- Add "git update-index --touch" that does what "touch" does. In this
case, it blindly updates stat info to latest. But like touch, we can
also specify  mtime from command line if we need to. It's a bit less
generic than the above option, but easier to use.

Caveat: The options I'm proposing can be rejected. So maybe wait a bit
to see how people feel and perhaps send an RFC patch, again to gauge
the reception.

-- 
Duy
