Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ADB51FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 01:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbcLPBj4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 20:39:56 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33943 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755245AbcLPBjy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 20:39:54 -0500
Received: by mail-it0-f65.google.com with SMTP id 75so937290ite.1
        for <git@vger.kernel.org>; Thu, 15 Dec 2016 17:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=OQNscD0C+MuDfpehFOskpqUfEvTvFTKvnllC/QfZY6s=;
        b=hxrWlFIZ2MtQWZCowK+Qraf12z3BNd1nQqVzIP6ln/s6YlDE3qo3wTr4fGz3+XZkV4
         h8Z+PaSCBucVqEQGVL7cp2KWe7j472IT9cTDkGqelZOb7BOJ/fKP+LZyT75IIcU6Lo+R
         3C6v9pBSEqwx1XfFhwS6XaLK408+mA7jJ6iDRcKm1mXTm+AIjD8PCw7RCbX2zpelOQMm
         YxhA2qgIvYQh0Uurzsyn8DPlGlVYNF8j0zbBtPSyyQRUSfczIOBKJfspuXwKoLwBXBNI
         9nUZZdGOWegUrJ6W+1O6IOAWr+lc3EOkz5i2gxh9dTSi8xnkFm/u1mAft902rFQREC7p
         RpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=OQNscD0C+MuDfpehFOskpqUfEvTvFTKvnllC/QfZY6s=;
        b=d+gB+uoWMd/IKuSR4k5meYCzpOSi3715Z77q6XCZzPs8CqDL19Faa2Vpl/9L/0mPHG
         mkSqxIpgRUBhevjlZ4kjCdCJp7OKPpqtrxxdQWxgjbyXAw5UUe3RsXpZEo3hBmnn3BS5
         Zs7uXOl83ElJ+rA9RekVUXKswKInTmHBd4hjE3WWAR9/hBulGrkju7lhgELtPSHMV2FU
         NWvh0p8ZP5Re40ox5JZYwRHctqi177HTHzHhuYW+liPUXMLkTE2cz05SR2xk0uZ6oTkQ
         r+xXOxFUhT7CXyG5Xs4h1jP4hnq17CqBbeiW2+MIna6fKDKsUBjslUe4ENRVvxSEEK5Q
         q9xA==
X-Gm-Message-State: AKaTC03EAm3/h/C9QPHeDlTg7xO8tVgzmbdPaA2b7+ztlGehAu+UcQVt18sSe+E7MTKeqTj2O4YjVzOqAH0KZw==
X-Received: by 10.36.148.84 with SMTP id j81mr562093ite.35.1481852394180; Thu,
 15 Dec 2016 17:39:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.65 with HTTP; Thu, 15 Dec 2016 17:39:53 -0800 (PST)
In-Reply-To: <xmqqoa0cu3nn.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzWkE43rSm-TJNKkHq4F3eOiGR0-Bo9V1=a1s=vQ0KPqQ@mail.gmail.com>
 <CA+55aFxSQ2wxU3cA+8uqS-W8mbobF35dVCZow2BcixGOOvGVFQ@mail.gmail.com> <xmqqoa0cu3nn.fsf@gitster.mtv.corp.google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 15 Dec 2016 17:39:53 -0800
X-Google-Sender-Auth: XzNF_mlLE5chyVE4cwCOPOOldyk
Message-ID: <CA+55aFySBc1Nd_xYZmXF9tdynjW+udsEz+PtkQpkrPjeFVcfDw@mail.gmail.com>
Subject: Re: Allow "git shortlog" to group by committer information
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 15, 2016 at 4:19 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> This fell off the radar partly because of the distractions like
> "there are other attempts and other ways", and also because the
> message was not a text-plain that can be reviewed inline.  Let me
> try to dig it up from the mail archive to see if I can find it.

Sorry, I'll just re-send it without the attachment. I prefer inline
myself, but I thought you didn't care (and gmail makes it
unnecessarily hard).

                Linus
