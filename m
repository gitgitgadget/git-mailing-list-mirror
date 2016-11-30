Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22BC71FF40
	for <e@80x24.org>; Wed, 30 Nov 2016 23:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754189AbcK3XnS (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Nov 2016 18:43:18 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:34966 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752437AbcK3XnR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2016 18:43:17 -0500
Received: by mail-qt0-f175.google.com with SMTP id c47so204661000qtc.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2016 15:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=f+RTSXAGL7uSJNuu3WmT78Fv3ryJR+/pKq5up0AtWuI=;
        b=Gg+BBhXCI9gRNByP/vYbqcgm4cBO3zsqGDyoJFPY0OvLLT9VE9f4zu85diMC7aoYkt
         68Ddb9LF/s342A08EgRbvQ698eECcNe1p6DzCyCZ1ga14lJ1Wj0Lj1xYj3bxiQ+Lu0Wg
         myZ/59xZW/cCCTKwC+uTYWHc3OeSgRtdpIlPMyiIpthmJSFoP9goZfk0Z9sEligmIsgr
         RxT4+m7ZQMfte16MW7+KD+gVOH4Cdzy5Yfd2yhOs282NTdKdnfXu1/+yPg9+VuKoqG3H
         IJ9xhRJ922MGX/DQZxfhGQMvizzwQ/dyXKaGyi0BydbWoutynMK1o3fYkEkmgrHo2PP/
         GLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=f+RTSXAGL7uSJNuu3WmT78Fv3ryJR+/pKq5up0AtWuI=;
        b=TmK3DqrBNNxAShGizY/gc18Ux7VJCGu8OzQdORU8dNuMM7xY5fGqbmp9Iro70BbdAF
         5cMlJ6oWF44qgD7QsFwe1enqW1kgkxnVwA2/emiaTjMVkGv+YVCvCJm1huclbqZf8bZG
         tDg3cLy3dD+MeDfDw7MZLdUN8cnZeq/7Jy75qrCVUiC8yFjnyvyKphe27ZFEwCPw2rm7
         nIM9Cxsu1YPZrLcjMM9uAhsLTqwPJP4cmhMexZX7MpgHcinagfE5RxD0tWoilgjvzVh3
         7ch7OzXacbIrLBXciAJ/ohIgONciL2sodRq4slVRcbciApjzxbTmRU6Wc85KDlAyjWlc
         KAmw==
X-Gm-Message-State: AKaTC03YPV/ME8fMzGUpwfPnVrGWzpJACfiTiKMEQw0ifbHTj9RucmKODK6cyWtP4vJuQgjOU68unLfzP3zMmJeO
X-Received: by 10.200.49.235 with SMTP id i40mr34800980qte.170.1480549396286;
 Wed, 30 Nov 2016 15:43:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Wed, 30 Nov 2016 15:43:15 -0800 (PST)
In-Reply-To: <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
References: <xmqqk2bngn03.fsf@gitster.mtv.corp.google.com> <20161129010538.GA121643@google.com>
 <20161129063759.6mgmpqx3kbyuqjwi@sigill.intra.peff.net> <20161129065125.cwlbkctniy7oshj2@sigill.intra.peff.net>
 <20161130195427.GA166433@google.com> <20161130232823.GA192901@google.com>
 <20161130233204.ihbrjwwu3yiv4ugq@sigill.intra.peff.net> <20161130234056.iltitkszvccbjivp@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 30 Nov 2016 15:43:15 -0800
Message-ID: <CAGZ79kadJ+8CyyDTM=ZLLCirJYhFwPQ0jxZRPmGY4jCh9UB4sA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Nov 2016, #06; Mon, 28)
To:     Jeff King <peff@peff.net>
Cc:     Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 30, 2016 at 3:40 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Nov 30, 2016 at 06:32:04PM -0500, Jeff King wrote:
>
>> On Wed, Nov 30, 2016 at 03:28:23PM -0800, Brandon Williams wrote:
>>
>> > So I couldn't find a race condition in the code.  I tracked the problem
>> > to grep_source_load_file which attempts to run lstat on the file so that
>> > it can read it into a buffer.  The lstat call fails with ENOENT (which
>> > conveniently is skipped by the if statement which calls error_errno).  So
>> > for some reason the file cannot be found and read into memory resulting
>> > in nothing being grep'ed for that particular file (since the buffer is
>> > NULL).
>>
>> That's definitely weird. Is it possible that any of the underlying calls
>> from another thread are using chdir()? I think realpath() make do that
>> behind the scenes, and there may be others.
>>
>> A full strace from a failing case would be interesting reading. In
>> theory we should be able to get that by running the stress script for
>> long enough. :)
>
> Actually, it failed pretty much immediately. I guess the extra stracing
> changes the timing to make the problem _more_ likely.
>
> And indeed, I see:
>
> 20867 lstat("fi:le",  <unfinished ...>
> 20813 <... read resumed> "", 232)       = 0
> 20871 futex(0x558cdec8b164, FUTEX_WAIT_PRIVATE, 7, NULL <unfinished ...>
> 20813 close(7 <unfinished ...>
> 20870 <... futex resumed> )             = 0
> 20869 lstat(".gitmodules",  <unfinished ...>
> 20813 <... close resumed> )             = 0
> 20865 set_robust_list(0x7f1df92579e0, 24 <unfinished ...>
> 20813 lstat("su:b/../.git/modules/su:b/commondir", 0x7ffecc8b3ac0) = -1 ENOENT (No such file or directory)
> 20865 <... set_robust_list resumed> )   = 0
> 20868 set_robust_list(0x7f1df7a549e0, 24 <unfinished ...>
> 20813 access("su:b/../.git/modules/su:b/objects", X_OK) = 0
> 20813 access("su:b/../.git/modules/su:b/refs", X_OK) = 0
> 20813 stat("su:b/../.git/modules/su:b", {st_mode=S_IFDIR|0755, st_size=280, ...}) = 0
> 20813 getcwd("/var/ram/git-stress/root-4/trash directory.t7814-grep-recurse-submodules/parent", 129) = 80
> 20869 <... lstat resumed> {st_mode=S_IFREG|0644, st_size=47, ...}) = 0
> 20813 chdir("su:b/../.git/modules/su:b") = 0
> 20869 open(".gitmodules", O_RDONLY <unfinished ...>
> 20813 getcwd( <unfinished ...>
> 20867 <... lstat resumed> 0x7f1df8254cf0) = -1 ENOENT (No such file or directory)
>
> where 20813 and 20867 are two threads of the main process. One is doing
> the lstat and the other calls chdir at the same moment.
>

Lessons learned here:
The run-command API is not thread safe when used with setting the directory.
If you need to run a thing in a threaded environment run
git -C <dir> ... such that the child chdirs.

Are there any other threaded environments that run things with .dir set?
