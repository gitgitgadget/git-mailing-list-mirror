Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86C731F829
	for <e@80x24.org>; Mon,  1 May 2017 01:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S642179AbdEAB5G (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 21:57:06 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34325 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S642176AbdEAB5E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 21:57:04 -0400
Received: by mail-pf0-f180.google.com with SMTP id e64so32538135pfd.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 18:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V3bFIhtJK36K2DSEIo278UISby/AsKefLt8/a9SkjUI=;
        b=tLgbbfs60MpCuyEH8dM+/yPbVEug9G3AC5FPpnWHmByFGgAIVc2CCxlny2JST7GfDo
         E6QmfRWM4li41jB1uNHP7y3uKfG4vP2+xfoYWLXhL5dg7yF7Eb28QZPzRgi8LKdBNBkN
         vhAqeotDn9/uk3cqpzRGE5CSg3+fZP/P6D3vSnJIlpyy1JrTfSsQfeAhQN658xvh/CzT
         wMvrHTBwxiQ4yIifX7xx0DMkX7Ei4JenO4ZpEVJJroMMCkTvwFJer8J5xt6PO4TVhTdI
         eYvnM1aHWzpmq/go408zNgzW66lg/IaaJrDVNnJRSkoq2rp8IDuN63uXYGfhGy4mFsYw
         qncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V3bFIhtJK36K2DSEIo278UISby/AsKefLt8/a9SkjUI=;
        b=RBNGcWVJ06ToAGjAIvwBJJcuY1Zo+77iy/8+7QHD2p7Gdn13qXsKLkIML2aEjNQEBb
         YvSPgtREQgyLGS6tYrdZ1HfHHCIyX9HfJ61pSJaUmQaM6apIEqIygTNC+nbN0bv2R3b0
         6UpNQQLqVtKWQDJLffZ2nIRhL6A8B7TpiNQST10/II1yGowg0ChPe/K9semoGm+EALCe
         09hu429V2UryxwYT/Ma4r+74OgVeWpRf5CMuU+gNDm0YIbPf4rW6w3DuVa5WPg+khSvE
         NgiD06WEX2rU9o1iwyMBylqpAfM1uuQskhk5BJYatDIot/Bj1ALqjXh5B8exzYF9+Pvu
         3+9w==
X-Gm-Message-State: AN3rC/7C6ck9hPFuTQzqYj5FQkmkFHUX58+5HjeRBHbmJQPNAaCcht3A
        9yxm+WMZOq8Gm7Vsd+5huH5nnrAB/nK/
X-Received: by 10.99.62.11 with SMTP id l11mr7551158pga.238.1493603824076;
 Sun, 30 Apr 2017 18:57:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.176.161 with HTTP; Sun, 30 Apr 2017 18:56:43 -0700 (PDT)
In-Reply-To: <xmqq60hljqud.fsf@gitster.mtv.corp.google.com>
References: <CABfTTAchc61aB02sCD=Oa9gRMGr94h7mC53B9q6Qy2k2hDqzAQ@mail.gmail.com>
 <xmqq60hljqud.fsf@gitster.mtv.corp.google.com>
From:   Chris Johnson <chrisjohnson0@gmail.com>
Date:   Sun, 30 Apr 2017 21:56:43 -0400
Message-ID: <CABfTTAdQPGei6CZoHGJGUtKHdJ4eT822pzc=DATynfeaZ94gxA@mail.gmail.com>
Subject: Re: Bug Report: .gitignore behavior is not matching in git clean and
 git status
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Good assessment/understanding of the issue. git clean -n  does not
report anything as being targeted for removal, and git clean -f
matches that behavior. I agree with it probably being related
specifically to the -d flag.

As another experiment I modified .gitignore to ignore /A/B/C instead
of /A/B/ and the same result occurs (-n reports nothing, -dn reports
removing A/)

Lastly, I changed .gitignore to just be /A/, and in doing so, clean
-dn stops reporting that it will remove A/. I=E2=80=99m not exactly sure if
this last one is surprising or not.

Also, and sorry for the noise, but I did a reply-all here, but will a
reply automatically include the rest of the list? Or was reply-all the
right move?

On Sun, Apr 30, 2017 at 9:41 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Chris Johnson <chrisjohnson0@gmail.com> writes:
>
>> I am a mailing list noob so I=E2=80=99m sorry if this is the wrong forma=
t or
>> the wrong please.
>>
>> Here=E2=80=99s the setup for the bug (I will call it a bug but I half ex=
pect
>> somebody to tell me I=E2=80=99m an idiot):
>>
>> git init
>> echo "/A/B/" > .gitignore
>
> You tell Git that anything in A/B/ are uninteresting.
>
>> git add .gitignore && git commit -m 'Add ignore'
>> mkdir -p A/B
>> touch A/B/C
>
> And create an uninteresting cruft.
>
>> git status
>
> And Git does not bug you about it.
>
>> git clean -dn
>
> This incorrectly reports "Would remove A/" and if you gave 'f'
> instead of 'n', it does remove A/, A/B, and A/B/C.
>
> Despite that "git clean --help" says 'only files unknown to Git are
> removed' (with an undefined term 'unknown to Git').  What it wants
> the term mean can be guessed by seeing 'if the -x option is
> specified, ignored files are also removed'---so 'unknown to Git'
> does not include what you told .gitignore that they are
> uninteresting.  IOW, Git knows they are not interesting.
>
> It looks like a bug in "git clean -d" to me.  Do you see the same
> issue if you use "git clean" without "-d"?  IOW, does it offer to
> remove A/B/C?
