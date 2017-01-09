Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D6C205C9
	for <e@80x24.org>; Mon,  9 Jan 2017 03:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S939236AbdAIDon (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jan 2017 22:44:43 -0500
Received: from mail-lf0-f48.google.com ([209.85.215.48]:33659 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbdAIDom (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jan 2017 22:44:42 -0500
Received: by mail-lf0-f48.google.com with SMTP id k86so87010274lfi.0
        for <git@vger.kernel.org>; Sun, 08 Jan 2017 19:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wpfXDeITKaq91cwp0sKHiBVG7URgy+g7KvgVTjWD+fQ=;
        b=cBsjq2g7iiEACSFnbf/m0PbQFZwYZmKdNeFsWS1ILeG/Fc4arSpEAc/iUAkR/5i/vm
         4qdXKM1/24KXOyqrRHGYbkpqXkFu5iReUEQRZ0totuYYpbm448LTPId+eMnzVwsU8LD3
         PfgDkoDokifxpaepMOkm8VMb4EkFhCgFEXgqBBLOQXL2Xn0aXhwg1mKy6VvlXymFZG2v
         Y4cjHxUsKEw2Oxv8U1UrrxK1+tOThxCY/nbwshrJh4to0FPDaPG5ZWOcPsVrrqWSmT/F
         +I/4B+ppavVOwB/PbxNkxFStxQImNMX+76C11BXvV6i+0vvsZ0i1btAWzl0kQL/QOWe1
         j6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wpfXDeITKaq91cwp0sKHiBVG7URgy+g7KvgVTjWD+fQ=;
        b=PnfOukIk61rrAjE7KA4zFoxBZzAz61Tpeg3wtEbDTBs2XfWh25OIKlkb7ZS4EI7jk/
         dXtR3XvpnntLNjmP9AHDL5fkgFBqgLX0HuMAdgHI1udyqKxX4KALfZD/aIb3B8nkNZRU
         wG8nZITRwYNvXme6Hqb6ZRUyaLKB1ueGqHF1Sjw3dWMoJTcHxAKUH8VwgStpFr0fU8xa
         t6xFl6DFfVMJ9gy2HSUylGo1vZsKjQowTqPwm56MKp38Y9ZqTPYTaFfhGL9cIpk2h4Jv
         NF6A86T0NLXtshOO808KEdxjW9MFfmfx8euUaWnhSXIVe4BvWCwRqJk51crVXcaRqxex
         N2Ew==
X-Gm-Message-State: AIkVDXJB6uDRrIYnnCrB+OQzuZYaLMu8sOW4M7YNE6nYMaLJKM6UfWWXOGk6YMxo/KRogyMxn2luwgc0T6dhdA==
X-Received: by 10.25.27.145 with SMTP id b139mr25852453lfb.114.1483933480972;
 Sun, 08 Jan 2017 19:44:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Sun, 8 Jan 2017 19:44:20 -0800 (PST)
In-Reply-To: <CACsJy8C6QWeHSwhsYyJnupkue=aoCG+3Tecytb_0p+gB-CuVKg@mail.gmail.com>
References: <4D106F0FF3D29E4FA1D91C1A31CE4C3501B8DEF2E6@email.novomind.com>
 <CAGZ79kaLpf1nzSAgRJQamMGk-327LO+qQYihYVVcU+86n92ivg@mail.gmail.com> <CACsJy8C6QWeHSwhsYyJnupkue=aoCG+3Tecytb_0p+gB-CuVKg@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 8 Jan 2017 19:44:20 -0800
Message-ID: <CA+P7+xofFufcUMBJFqEcP=C5r80HCr1-j4210gOm7t=aLYw2zw@mail.gmail.com>
Subject: Re: git branch -D doesn't work with deleted worktree
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Roland Illig <rillig@novomind.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 6, 2017 at 2:05 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Jan 5, 2017 at 9:02 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, Jan 5, 2017 at 2:06 AM, Roland Illig <rillig@novomind.com> wrote:
>>> Git 2.11.0 gives a wrong error message after the following commands:
>>>
>>> $ git init
>>> $ echo hello >file
>>> $ git add file
>>> $ git commit -m "message"
>>> $ git worktree add ../worktree
>>> $ rm -rf ../worktree
>>> $ git br -D worktree
>>> error: Cannot delete branch 'worktree' checked out at '../worktree'
>>>
>>> Since ../worktree has been deleted, there cannot be anything checked out at that location.
>>>
>>> In my opinion, deleting the branch should just work. Especially since I used the -D option and the "git worktree" documentation says "When you are done with a linked working tree you can simply delete it."
>
> Since -D means "I know what I'm doing, get out of my way", maybe we
> should continue if any worktree has the branch checked out by
> detaching it?
>
> (Yes I'm carefully tip toeing around the deleted worktree issue since
> "git worktree remove" is coming. After that point, running "worktree
> prune" before "branch -D" does not sound so bad)
> --
> Duy

Why not just update the documentation to be "when you are done with a
work tree you can delete it and then run git worktree prune"?

Thanks,
Jake
