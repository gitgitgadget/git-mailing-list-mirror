Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 952AB207D6
	for <e@80x24.org>; Wed,  3 May 2017 07:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbdECHMt (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 03:12:49 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:33548 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751014AbdECHMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 03:12:47 -0400
Received: by mail-it0-f47.google.com with SMTP id w68so6228814itc.0
        for <git@vger.kernel.org>; Wed, 03 May 2017 00:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FZ3AEgM7lFB7uNJ6OfDjkeLhwBB7w8AbmXYSOYc+mMk=;
        b=NjMPnupzrlVk3bRvpdRXIVfCf6XwBR0gFvjdiOzulQ1PQF4mdaZRZphyvAHOyLaivQ
         yyVK7G95wFJgnzfoQ1vMWLakbRNlQhrMV9FMjZri5ku8ZyMHgzoqGhyts/vn0JFfk4Qu
         rL5mQF6d50ktb69XRotp3rv9xdCH2AATUDhFyIK4ZxPnd4XkKQOUpbxxha79Siu8bGmU
         joqw0A98NO8d/AK91tbLTQaOMDoRPJoS7QzOi/v0kHwHRwfhHg1puOmlIox+2nR23KKf
         AtfTv6nDioniO0s3zhv8v36a7T7kGbTBlkHQOyDQqsRWXBYbBvIDsPiqvCEy2lc7j4Qj
         HaCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FZ3AEgM7lFB7uNJ6OfDjkeLhwBB7w8AbmXYSOYc+mMk=;
        b=bokWIwPQpravQDmMRE1PnMqQkx3asQ267oHYgI9BbetEjkMapVS9Epaqcvm5i1Pcm5
         tq81bPW+nbi/iJ7lmAYdDUcf2F0F/xQcd1brBlRKCKPBe0iCtUefW1KR50KtQsPClj+f
         fIeQ7b1OV3mII7M5xaACM4m1FlrJXv7tjsjp5P96GU/d92BY9tWKIaniwYl9mM3yNVY0
         MxOCxnqz3W4jd8/H2Gd51acBjwNMXVKHxbjyuDGnYYIQTf+UcmhXjgiuIR0cMu9AiIaw
         uzvSxrYIqAiAkMkI1d/4KZTT+p8JQ3CjeQpMlzn7QoVlOENkag/DtQjsv4D+RRQR6Og4
         O+Bw==
X-Gm-Message-State: AN3rC/7VgucPkgLxTsqS6uGZkBp1JewWSv5KHxD5aovRGLwXyvg/L8mf
        jY/W6vv6inH0ZlVTiw4wFjqqPuCS5A==
X-Received: by 10.36.66.67 with SMTP id i64mr15125696itb.22.1493795566679;
 Wed, 03 May 2017 00:12:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 3 May 2017 00:12:06 -0700 (PDT)
In-Reply-To: <xmqqfugof4zb.fsf@gitster.mtv.corp.google.com>
References: <58DE0598020000A1000256CE@gwsmtp1.uni-regensburg.de>
 <xmqq60ip1m0f.fsf@gitster.mtv.corp.google.com> <CAJZjrdUt+=oLt0cDcs2+bJMCFR4h8UUSFmZkx6-1menz4haPig@mail.gmail.com>
 <xmqqfugof4zb.fsf@gitster.mtv.corp.google.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 3 May 2017 02:12:06 -0500
Message-ID: <CAJZjrdVZ7gTZvm=CcG7pUPWtXjsMsHgyMRiE8xoXm=bZ4j6FEQ@mail.gmail.com>
Subject: Re: Terrible bad performance for it blame --date=iso -C -C master -- <file>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 1, 2017 at 7:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Samuel Lijin <sxlijin@gmail.com> writes:
>
>> On Fri, Mar 31, 2017 at 10:52 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> It might not be a bad idea to teach "blame" not to pay attention to
>>> any path that is marked as "-diff" (e.g. binary files) when trying
>>> to see if remaining contents appeared by borrowing from them.  We do
>>> not have that heuristics (yet).
>>
>> Could you elaborate on this? Do you mean to tell diffcore-rename to
>> ignore diff_filespec objects if they're binary?
>
> No and yes ;-).  I do not think it is a good idea to unconditionally
> ignore binary in diffcore-rename.
>
> But when we know that the rename detection is called from inside
> blame.c, where by definition we would be digging line-oriented
> contents, there is no point checking if the contents we are looking
> for came from an existing binary file.

A followup thought: perhaps it would make sense for blame.c rename
detection to only consider files with the same extension?
