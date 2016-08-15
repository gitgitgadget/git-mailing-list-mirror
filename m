Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA36C1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 09:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbcHOJlZ (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 05:41:25 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34975 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932227AbcHOJlX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 05:41:23 -0400
Received: by mail-io0-f172.google.com with SMTP id m101so75463246ioi.2
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 02:41:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XJkiQi856B+8ssc1tPrzJ9yqq4GYYlUAFIRezusFj7I=;
        b=YtAXi3TarVFNPBuSBlmVKfLBsL56YqlIVa6p/o0yCx4NVd64XyOmGLo2/p91Hx58oq
         H3j4HOaoeh4H6QEZohBfNy8UlZLu7v9hUdu8+BSVZ7gFTP4/KSJdnOLUC92C/RQLJ/9K
         nnHUoGsRemSZL220QAOnJuT/YMf/j+Z7igzcPTdK3DqFlh8zmWTeYkckvnNb1nw9S+Ed
         kJEuIMXP+qT4RI4nk7XSxVC9Qfu+hx8bJjAtiRXFXHTY8fD/Tg5B8NuGt/xIHjWWiwyH
         351eZHn0YbFbc2alO4MKPPlW0CYYtOkIIwE66U12bOJHID2ktFtfgBEuCWXqasOzNu+S
         pd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XJkiQi856B+8ssc1tPrzJ9yqq4GYYlUAFIRezusFj7I=;
        b=gIC7ggWra9mtg9pjRfLHyKSDUIH7NW4SsDfFbkqVkOV3FJG8zu4cbN7Hhx7Ok0tMs/
         HE/TDGkDs5GeZ2ouM8efb30izBnSaMZYhxN6YOb1+cJSPZdqNNBULI6DYyfgLb+E6Uvl
         YW5opJYjsjZJ4lqLWfrLQdWH53NA5bLNpjDxYGnbJ3yGTBviJSvogfo7P8hLbMou5k5M
         rPFv/lQ4TJDsOw83kZVgvawzMloT4QmQ9HcGmTxFeOHYwrMGUs3lEemiLS6svwjOohUD
         kmT02yNlfyFp+nmWLToxf0+xWqdGDgHj2lfaexOrkqLHdsJuTwui6md1mnTXzT+/J7dx
         xBlA==
X-Gm-Message-State: AEkoout4zysuJIBUGOWfX1QS0SoxcCXR5XVjGjTx/b7ss0HElu2jm5Vqe0MM7agmftW5LxT1gKPwUeFmmn5vuA==
X-Received: by 10.107.159.147 with SMTP id i141mr30890024ioe.29.1471254082155;
 Mon, 15 Aug 2016 02:41:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.125.199 with HTTP; Mon, 15 Aug 2016 02:40:51 -0700 (PDT)
In-Reply-To: <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <CAGZ79kba36GprgHA04_q4NmY2=_amoWyafUaLKkcknc3HsT_-g@mail.gmail.com>
 <CACsJy8C51UkH=tLSfGigAF0JjPxVS3fY0EHi0CNVRG8LY8YiCg@mail.gmail.com>
 <CA+P7+xo4UJ8W4G0gV=DMLs-9Ve4v0OKc0ZunmS5Y5B1k7L0P9w@mail.gmail.com> <CAGZ79kb27JZepMD5AmrHjOnf8haE8LehZd_CkvOQ1UoLEDuxKQ@mail.gmail.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Mon, 15 Aug 2016 16:40:51 +0700
Message-ID: <CACsJy8BdmR5USJvjJ6xbjj=bP787tdS72_oL+PDq0D+FPYmiPA@mail.gmail.com>
Subject: Re: storing cover letter of a patch series?
To:	Stefan Beller <sbeller@google.com>
Cc:	Jacob Keller <jacob.keller@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 15, 2016 at 1:28 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, Aug 14, 2016 at 12:15 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Sat, Aug 13, 2016 at 1:49 AM, Duy Nguyen <pclouds@gmail.com> wrote:
>>> On Tue, Aug 9, 2016 at 12:27 AM, Stefan Beller <sbeller@google.com> wrote:
>>>> is what you want. Maybe we want to see a patch that adds the reverse
>>>> functionality as well, i.e. git-am will store the the cover letter as the
>>>> branch description and git-merge will propose the branch description for
>>>> the merge commit.
>>>
>>> I almost suggested the same, but there is a problem with this
>>> approach: if you're are on a detached head, where does git-am save it?
>
> What would the user expect? We can have a range of expectations:
> 1) reject and error out git-am
> 2) warn about not saving branch.description and continue with am
> 3) have a (maybe special) branch.HEAD.description thing, same for FETCH_HEAD etc
> 4) have a config option to choose between 1 and 2, if unset default to 1
>
> I think 3 is a bad choice.
> 4 seems reasonable to me, though I wonder if some people use git-am in
> a scripted workflow with a detached head and then create the branch afterwards?
> So
>
> 5) create a branch for them? (such as $(date)-${subject})
>
> My gut reaction doesn't like 5 either.

I'm starting to think option 6 (storing cover latter as an empty
commit at tip then git-merge replaces it with a merge commit in a
permanent history) may be the way to go. It handles detached heads
just fine, we have reflog to store older cover letters. Though it will
not play nice with 'git commit --amend' and 'git reset' for people who
rewrites history heavily during development, but maybe 'git rebase -i
--autosquash' would be an ok workflow alternative.
-- 
Duy
