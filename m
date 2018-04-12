Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CEC71F404
	for <e@80x24.org>; Thu, 12 Apr 2018 23:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDLXSQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 19:18:16 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:34627 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752628AbeDLXSP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 19:18:15 -0400
Received: by mail-it0-f45.google.com with SMTP id t192-v6so3730794itc.1
        for <git@vger.kernel.org>; Thu, 12 Apr 2018 16:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LwVM6w559jMZs9sCw/dwjRrkJ2zYajNvzgE9Fy4bk2I=;
        b=UIk6MlZPy8+7swqwmQLZtBAScLRNuXH/Apdz+7QGYf2huVwRIYdWQJ51FaIwKP51PG
         MdSSezypA5KCow8SglVLRVNJ4yyMent/fOIo5B9Hq3MT3t1qbkCIokRbUxt+4eat23wX
         Kidj4Johw2/OrHMCjg6sQUoALYX0OXqLVKi5ma+TLDlI/5S6MOUnXTf3MZOMc2W0yQv1
         +kNUUotRU0sWFhFtBTTByaDUz5VIzbY07+7kfpV50ZBp6/BbxKex+xI4kv8/RpUJL6Yt
         K5pmWOnhnUqBE4JHcjpscGGxPv0cetYL/uCfR6qdaoo1fiwhAQ2ncUhBxm40h7qiEbYl
         1YxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=LwVM6w559jMZs9sCw/dwjRrkJ2zYajNvzgE9Fy4bk2I=;
        b=ZMEgv9my7jY1czSfnRbun8YRvQr2FB9fKQiFiXi4UWamLQZItQQ7jMFgiDvrZD/0I/
         u9xr9QJ7YHcqj4ZjXnu6XprJfgX/fAOuTvTAmUuLzaK8yKw2UFrewAvHa0Z629jxFyrf
         cbEXRcYB+i6G57bIjXcddBG4Dj7vzCEXy3Xkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=LwVM6w559jMZs9sCw/dwjRrkJ2zYajNvzgE9Fy4bk2I=;
        b=TpTpirhKufYhyqUbvdYG86hnZIi1g90DoqBNb/CORlCxUfhPa8ISGL7+ClceWUt96d
         wY9SIXSDxbtqOtAje7l1kwBII0Ca219fjf8d5+7Wiq2JyhcqAYZAOkMyku11q3ASeAfc
         jULlpJzOTH1+pj5iNTM9e57MY91hPREPDWVeBSljIyKF9AoTSAvyam6Yzw6MmztfM5f8
         8RDocbF+DGVJM+PrhnF+MCQ46Eue04nWbsnzT2A4C+ciQrAS38t32eHQG6aoVPst1XTJ
         VI6DNxHAphAcIrU2sWWrcvYPgbfqZS+CebfUcgogi6VnrlmmqFul7L6kssfRfBRPf2Rm
         q5jw==
X-Gm-Message-State: ALQs6tDZBKSAiy3PdzSSEhi8EWfoxup3eWu9s55np/7pOGqkX4zAc3g7
        OiNAgCB3H1stvVBkGAY7TrtVt+u+pj3pZFRLeu0=
X-Google-Smtp-Source: AIpwx4+11xOT8IZmZstOdyEW6Ky7WRkyvvZW2ia5Y8kxZJ974Uvo+gDgu/oDDwzEkSwljTdxkeDkuIm5M9RMuMttbpg=
X-Received: by 2002:a24:5b02:: with SMTP id g2-v6mr3140264itb.100.1523575094549;
 Thu, 12 Apr 2018 16:18:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.95.15 with HTTP; Thu, 12 Apr 2018 16:18:14 -0700 (PDT)
In-Reply-To: <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
References: <CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com>
 <xmqq604w2j4u.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Apr 2018 16:18:14 -0700
X-Google-Sender-Auth: 6Sk4Fm5P0kZpkM8uMMb_D7y-9mU
Message-ID: <CA+55aFzNJXMktB1owXtuD=KXEQRcZmdETMJOiv+RcRZv9Pgz7A@mail.gmail.com>
Subject: Re: Optimizing writes to unchanged files during merges?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 12, 2018 at 2:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Thanks for a clear description of the issue.  It does sound
> interesting.

I decided to show it with a simpler case that could be scripted and
doesn't need the kernel.

NOTE! This obviously doesn't happen for files with the trivial merge
cases (ie the ones that don't require any real merging at all).

There *is* a three-way merge going on, it's just that the end result
is the same as the original file.

Example script just appended here at the end.

NOTE: The script uses "ls -l --full-time", which afaik is a GNU ls
extension. So the script below is not portable.

                 Linus

---

  # Create throw-away test repository
  mkdir merge-test
  cd merge-test
  git init

  # Create silly baseline file with 10 lines of numbers in it
  for i in $(seq 1 10); do echo $i; done > a
  git add a
  git commit -m"Original"

  # Make a branch that changes '9' to 'nine'
  git checkout -b branch
  sed -i 's/9/nine/' a
  git commit -m "Nine" a

  # On the master, change '2' to 'two' _and_ '9' to 'nine'
  git checkout master
  sed -i 's/9/nine/' a
  sed -i 's/2/two/' a
  git commit -m "Two and nine" a

  # sleep to show the time difference
  sleep 1

  # show the date on 'a' and do the merge
  ls -l --full-time a
  git merge -m "Merge contents" branch

  # The merge didn't change the contents, but did rewrite the file
  ls -l --full-time a
