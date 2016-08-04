Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45C1A20193
	for <e@80x24.org>; Thu,  4 Aug 2016 17:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758932AbcHDR5u (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 13:57:50 -0400
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35446 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758758AbcHDR5u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 13:57:50 -0400
Received: by mail-yw0-f172.google.com with SMTP id j12so254929239ywb.2
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 10:57:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=8+1bqq2iVVbP2fE+4eRy1x1CTwhGLfHy4gDlGGn+Weo=;
        b=Hbh97Ch72Dg/W679o99piCgseYB9JnPBF1AiyM3lGjGY+AzLQHoXdm21WmvXCGfn3V
         U9xe/TobynjC68JAFFdJZBg5YpmHIg7bFTNlnH903wGMLzH+mOz4emGmdFTDc06ei3B2
         drv8Mc/LlIQQkEHUI1/X/yeieaJ1A8So2updZwU4e3uPcpz/45vmZSSSqT2WDStvOQuc
         8TSZ21JRaR2Rt+9dkjb9bXovCzebUhWpW/5v/a5jCEsARLhg8SBUkxUbglDRILDYDd3b
         BoW7pAdUr/Mw9LaEFWDQKQ+IgYHb+b593wraDs+dd6RHkh3LSBqgEl2aI1MH9tFfPUJK
         L4SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=8+1bqq2iVVbP2fE+4eRy1x1CTwhGLfHy4gDlGGn+Weo=;
        b=T6GW0vRkClgTcC3iR4GBBT5MvnhP3iwUAepRzKaF2w/8QC9bg7Qk0VxTyCauw8W+VJ
         +VfiNzWn4FYRbAdIJfHaPvKo1cViUrubI7EH9mDomsHZiXF05UYbCyQ5hvc63Ado9W4F
         bVQDMFkdaJBjt7Ii242vpvF8bAU3AxXxLSwqH8ILWaI+vR4FB31iWYQRSJzjkrmEbu25
         6oaYpVGjQU3I0XsIuUS1o8AuwEjdK/H3xIW4B4iynoiUt6y+hNuPXITbWID7PWe+frSw
         Lo2UiEkldZmWgapZyxMOh6PlsupcS+TITuXHf7g1SXZPn5YwoSTJ67v8laCKDvXmXZck
         q2BQ==
X-Gm-Message-State: AEkoouvJH/pWsD2TersQXjIuuczXO21CvnAy8aacSvs48Rhaazd+/Rv3vG7RqGPFgVbJ9vcU5wBXzyK6/+FZKQ==
X-Received: by 10.129.105.136 with SMTP id e130mr54819279ywc.176.1470333469289;
 Thu, 04 Aug 2016 10:57:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.13.250.4 with HTTP; Thu, 4 Aug 2016 10:57:28 -0700 (PDT)
In-Reply-To: <36ecaea6-5f09-25fd-ffa7-61bdaf91414d@greenberg.org>
References: <0aab65de-21a3-eb48-c5b0-3e36d924348a@greenberg.org>
 <xmqqshuk4f6g.fsf@gitster.mtv.corp.google.com> <36ecaea6-5f09-25fd-ffa7-61bdaf91414d@greenberg.org>
From:	Junio C Hamano <gitster@pobox.com>
Date:	Thu, 4 Aug 2016 10:57:28 -0700
X-Google-Sender-Auth: gZSZyzWW_D7k58oueQ2qlEqxFQw
Message-ID: <CAPc5daU7cyUNYOPbg1cYrkvCzYZ9xCsx4MhSZRHaeoXy9Ltcrg@mail.gmail.com>
Subject: Re: Problem with two copies of same branch diverging
To:	Ed Greenberg <edg@greenberg.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 4, 2016 at 10:50 AM, Ed Greenberg <edg@greenberg.org> wrote:
> On 08/04/2016 01:28 PM, Junio C Hamano wrote:
>>
>> ... indicates that you are not pushing to update the remote
>> repository correctly.  Once you get that part working correctly,
>> after you push at the end of the session, you should be able to do
>> "git reset" at the other side to tell Git to notice that the updated
>> working tree files that were transferred behind its back are now in
>> sync with what is supposed to be checked out.
>
> If this is the case, why do my fresh clones contain the most recent commit?

Exactly. Why does your "push" not result in "git log" to show the
most recent commit? Once you solve that, "git reset" would do
the right thing, I would think, just like a fresh clone shows the
latest.  The thing is, that I didn't quite find out what your "push"
is doing wrong in your original message.
