Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5487F205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 10:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932866AbdAJKsC (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 05:48:02 -0500
Received: from mail-io0-f179.google.com ([209.85.223.179]:36195 "EHLO
        mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932692AbdAJKsA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 05:48:00 -0500
Received: by mail-io0-f179.google.com with SMTP id j13so47066636iod.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 02:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=esZ4Dkc2sAg8sEiMT2Wx09urXj+/UIogz+uqN8WrYBE=;
        b=jk9erM9ZrfS3CCUHBWct31QMoWQMGRIEs8+MD+3tpK8y553uyxQo8L/kSJNWBkxnqp
         RvPYF5NqfafMcANLuv+MZNrnXIMj0cPwB7wYOc3r5hbrh1aHT7JO6TczIcoPvQ+mSTa/
         Dn+HnXlYhubWhVcGtsIDTDaM+yqz6lj4yFXPHhVXqEyS5gzaHJgNLllwrAqlVk1CYu9M
         DV3SfN4r/MabMOkr3fsTXfUTU5mCCxN3pQDFPHiow0IGTBYrVSEoWlBaFC7HJrcOqYyL
         zFPLFhdxrGZY9pvupQCHTViJbD88ajIXOIG13uYNizLEJkpwA7XWMgc2F8psvxGpWuUx
         NGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=esZ4Dkc2sAg8sEiMT2Wx09urXj+/UIogz+uqN8WrYBE=;
        b=CFXCaltctuFU7G31VDHj4A7g+DN+BnkKvm/p8LxSyPrtAeMWazUlYFtXouhCQszwj8
         guJfBZShjn2aoWXaYjJxtaSo7ZNmEyh9dXtNeNz7m+pkK7jiSh9r4fXxhkuQuyQzgKdl
         R8zkK4qctpvlbuzRJ46c+yGy9+DGkXNIuKupvjweOvbR+D3bPTQM4VN4D/UCiEzXvJV3
         lZOGuDcdWuslQZ3MpxKh1hR6QU364G2yDKHHbJDUIaqlBtLaYnxtQJeEi5S+EBqK8G6z
         3tmw2ExUaSLIT+B6RTBuB2y0jJFJz5JnAYb0e3/ETp0t2szcdAVokz27JBW8G7ZNRW6P
         IAeQ==
X-Gm-Message-State: AIkVDXLwbX/WK5F5UnAnF1zppiD1ddTAFemitaPmyQ0vIr3OU9V/cvy8ve3Yy40tE2tM1CuaKfhNINSMSm0LjA==
X-Received: by 10.107.198.195 with SMTP id w186mr2580999iof.19.1484045280050;
 Tue, 10 Jan 2017 02:48:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Tue, 10 Jan 2017 02:47:29 -0800 (PST)
In-Reply-To: <CA+P7+xqOrRwJsnskfGQpLYyQFjce=4z24zuhrEBd2P4gBLh0Qw@mail.gmail.com>
References: <4D106F0FF3D29E4FA1D91C1A31CE4C3501B8DEF2E6@email.novomind.com>
 <CAGZ79kaLpf1nzSAgRJQamMGk-327LO+qQYihYVVcU+86n92ivg@mail.gmail.com>
 <CACsJy8C6QWeHSwhsYyJnupkue=aoCG+3Tecytb_0p+gB-CuVKg@mail.gmail.com>
 <CA+P7+xofFufcUMBJFqEcP=C5r80HCr1-j4210gOm7t=aLYw2zw@mail.gmail.com>
 <CACsJy8AfcZOR966ypfbZa1+7=tr2RVxPUk8+XmQkGeoMBJ7Z0g@mail.gmail.com> <CA+P7+xqOrRwJsnskfGQpLYyQFjce=4z24zuhrEBd2P4gBLh0Qw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 10 Jan 2017 17:47:29 +0700
Message-ID: <CACsJy8Cd73pJ6+pakC6v79VJ9wp5MrF9eE6a1WM4jAoywgmL0g@mail.gmail.com>
Subject: Re: git branch -D doesn't work with deleted worktree
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Roland Illig <rillig@novomind.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 10, 2017 at 12:08 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Mon, Jan 9, 2017 at 2:07 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>> On Mon, Jan 9, 2017 at 10:44 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>>> Why not just update the documentation to be "when you are done with a
>>> work tree you can delete it and then run git worktree prune"?
>>
>> The document does say that (a bit verbose though):
>>
>> When you are done with a linked working tree you can simply delete it.
>> The working tree's administrative files in the repository (see
>> "DETAILS" below) will eventually be removed automatically (see
>> `gc.worktreePruneExpire` in linkgit:git-config[1]), or you can run
>> `git worktree prune` in the main or any linked working tree to
>> clean up any stale administrative files.
>> --
>> Duy
>
> Right, so maybe we can make it more clear since it's not quite as
> simple as "deleting the work tree" because of stuff like stale
> branches..

Patches are welcome. I wrote that paragraph and you could clearly see
its "quality" (from user perspective).

> or would it be worth re-scanning worktrees when we do
> branch deletion? (obviously ignoring the ones that are marked as on
> removable media)

Probably. We run "git worktree prune" as part of "git gc" and that
command is automatically called in a couple places. Adding another
"git gc" here probably does not hurt. However it could trigger a full
repack and make "git branch" hang for a few seconds...

And no I don't want to single out "git worktree prune" to be called in
git-branch. We should either go through git-gc or none. We could check
if a worktree is deleted and suggest the user to run "git gc" though,
but it's getting too complicated when "git worktree remove" will soon
be the recommended way of deleting a worktree. So.. I don't know..
-- 
Duy
