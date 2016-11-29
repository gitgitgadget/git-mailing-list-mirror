Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BB11FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 12:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754898AbcK2MST (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 07:18:19 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:34385 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752270AbcK2MSS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 07:18:18 -0500
Received: by mail-yw0-f179.google.com with SMTP id t125so136051339ywc.1
        for <git@vger.kernel.org>; Tue, 29 Nov 2016 04:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/cyeLT69dYqWHV1YNq/4KH6CQr+PFf2Wv/Q/ORZTcUM=;
        b=GhDK7fr2JXix/A6lSltAIR24wDLc+vHMz1g4yShTvy61skTdUbnz0jLagaYrJ/Y0Md
         0sHsbBun7dvfrRAy/gyVl1ejMIwSuTPENpTvlEQJwDNTPjZXr3sJZhpTcMuL2qRRBEx7
         aS4DXw6X385/STw6jvnrpTNUs2xWs1hYfCSkyeO9IZgRE6s/GKj33oWZ3I6xyPnojbIc
         D5E3VQAABUtEiIHopVtQKrmtwA/lh1XOQHxec3f6dWrEM2dYL9RPtuLyvqJ1DWJd6vdB
         VEEoZ2XBYydnLTw+cYfbBsUEp4cNFlyOTToUE9wQBYUmTHbVzQFrP9ovVbSUHId9SyOZ
         Oquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/cyeLT69dYqWHV1YNq/4KH6CQr+PFf2Wv/Q/ORZTcUM=;
        b=EKV0psaeHczeW75Hd2ToxuCOkjz7zzoHeXQkZRzbHP+QKioQbm2kWteJDLFREyJ9fa
         r4gltiqMVeam7Y4gDlUSY6Y6ehieDBCDFsa1j+V7wev5zNbzV8Z8EnEFHzjfKRedRDVY
         ldx0MD6oFcJ3guf7BlvUeaoDt4DTKjqvUgvvnrMdMjEzfsQ/a+p7BllRXlMcCq6Godug
         DP/WXcemZVdPTNdOh1ya7GW2CmTXxicX4C2MW0sYh+hEh8mf0aU6CPd48dC/nnXB2XeW
         Pe25C9jz0p2TwqpNkhO2anwrGpc9dIBI1LWFSr4o88OZdfzTa/MYA0iGbA0Cs8mDbMdr
         pcgg==
X-Gm-Message-State: AKaTC02UEtCi/jfKx0lgB5s+mx0y3o6fv3n5L698Ldsc+9C6fdrwxcL4cUzt6dmqNK+w3vyIHK1FclxxhwLxrQ==
X-Received: by 10.129.56.10 with SMTP id f10mr31316643ywa.45.1480421897578;
 Tue, 29 Nov 2016 04:18:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.162.39 with HTTP; Tue, 29 Nov 2016 04:17:47 -0800 (PST)
In-Reply-To: <73836804-a581-85a4-b0c0-2aa46a7f9b8d@kdbg.org>
References: <20161112022337.13317-1-pclouds@gmail.com> <20161128094319.16176-1-pclouds@gmail.com>
 <xmqqwpfnidxm.fsf@gitster.mtv.corp.google.com> <xmqqshqbicga.fsf@gitster.mtv.corp.google.com>
 <73836804-a581-85a4-b0c0-2aa46a7f9b8d@kdbg.org>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 29 Nov 2016 19:17:47 +0700
Message-ID: <CACsJy8DhAe3Br06p8i46UUhtnq5GzJGxHsp6AG4iXcg4P+g4nA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] git worktree (re)move
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 29, 2016 at 4:25 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 28.11.2016 um 21:20 schrieb Junio C Hamano:
>>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Does this round address the issue raised in
>>>
>>>
>>> http://public-inbox.org/git/alpine.DEB.2.20.1611161041040.3746@virtualbox
>>>
>>> by Dscho?
>>>
>>> Even if you are not tracking a fifo, for example, your working tree
>>> may have one created in t/trash* directory during testing, and
>>> letting platform "cp -r" taking care of it (if that is possible---I
>>> didn't look at the code that calls busybox copy to see if you are
>>> doing something exotic or just blindly copying everything in the
>>> directory) may turn out to be a more portable way to do this, and I
>>> suspect that the cost of copying one whole-tree would dominate the
>>> run_command() overhead.
>>
>>
>> Please do not take the above as me saying "you must spawn the
>> platform cp -r".
>
>
> copy_dir_recursively is used in 'worktree move' when the move is across file
> systems. My stance on it is to punt in this case. *I* would not trust Git,
> or any other program that is not *specifically* made to copy a whole
> directory structure, to get all cases right when a simple rename() is not
> sufficent.

This is why I did not write new  copy code. The code was from busybox,
probably battle tested for many years now. Of course bugs can slip in
when I integrated it to git.

> And, uh, oh, it does a remove_dir_recursively() after it has
> finshed copying. No, Git is not a tool to move directories, thank you very
> much!

I guess you won't like my (unsent) patch for moving .git dir either
;-) which does make me nervous. The thing is, these operations require
some more modification in .git. We can't ask the user to "move this
directory yourself, then come back to me and I will fix up the rest in
.git". First step "only support moving within the same filesystem"
works for me. But I don't know how rename() works on Windows...
-- 
Duy
