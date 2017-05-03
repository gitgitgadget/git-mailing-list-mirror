Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADD301F829
	for <e@80x24.org>; Wed,  3 May 2017 18:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbdECS1X (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 14:27:23 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35367 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbdECS1V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:27:21 -0400
Received: by mail-it0-f65.google.com with SMTP id 131so7168092itz.2
        for <git@vger.kernel.org>; Wed, 03 May 2017 11:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zkFXSgsinaSZO8EYYm+WTxo5vA/kf7IvZl7BWWrPPU8=;
        b=NR16opewADXVNrPyfhAiAGEZ0yZGwczsqV0iov0W7cPzDDyVAFVSyFkwee3T3yW6Gz
         gMvS0udUbSeUtkURQX1csnq4ZHpBymQ6SD1FnFlSuSiWCpO4EN+q5BfxBJIy1bhor1jh
         QwqaVnIRi9KyIa095rSNro5sH6FSCtylcMba3BlIIBB/8h5ZLFLXyL97X0kst2ei8E4a
         YvAX+zG9/UoFaggQSIi9YoMxGPJeRApLJyXHE17D9QrEOO+OMAFgFKOZ0RcJQ5jr4mjt
         WabKxOv06KpSuifVWq1Xnkj2rct0hRHn8bmIqDAp9dMwo5T7weXVp2XNucb93HyQRMto
         qKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zkFXSgsinaSZO8EYYm+WTxo5vA/kf7IvZl7BWWrPPU8=;
        b=SrW4iY0pnYyLZ3p1I0Om3ynJ6+y0XVlV4LI1C3MaFVeXGPlALaIr4F+6twfmEfDkQW
         +i7pQ6DopSO/eKWg1qzrLah/ODVLFG7jxwHyZPj3XhRnfKvnMrX/cUPg51O++FlWVX2L
         9iqmcPangZ97TevbUpKFFI/SzWBJP0Fh0klCsOsqUDA4w7NB7Bmu5mLkUmhZHnqCswH3
         6ij+0gd5Qt3+ybjyyM7q6dH+T7/jY9yEiHTTT3rEgC8B0qSrOcW1VCu2J21M91au98rB
         JWkGP1aQxhVqWQ70+rXj6zcAnbeCB90ZtA0B2M1B1mcOgixZLICFJO4Jfx4HkCVif8ru
         Vdow==
X-Gm-Message-State: AN3rC/434AR5ydVyDvj2NArz0VsW1XjexBhqFmW6h92A1bpwmPTf/wg/
        QNbBM6qdASu+9r+Ws+9wvR6EvE1MGA==
X-Received: by 10.36.46.193 with SMTP id i184mr2323346ita.51.1493836040745;
 Wed, 03 May 2017 11:27:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.150.90 with HTTP; Wed, 3 May 2017 11:26:39 -0700 (PDT)
In-Reply-To: <CAGZ79kauf5tAEv1JJCbTsuKhPYFKq0DVChBBt2EjHxRRZEzYAw@mail.gmail.com>
References: <xmqqshkof6jd.fsf@gitster.mtv.corp.google.com> <20170503032932.16043-1-sxlijin@gmail.com>
 <20170503032932.16043-2-sxlijin@gmail.com> <CAGZ79kauf5tAEv1JJCbTsuKhPYFKq0DVChBBt2EjHxRRZEzYAw@mail.gmail.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 3 May 2017 13:26:39 -0500
Message-ID: <CAJZjrdWLuXF7c=kt4SM1CcOUPpmmZXmOZPUCuzcO0z2nNsVMLQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] t7300: skip untracked dirs containing ignored files
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 3, 2017 at 1:19 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, May 2, 2017 at 8:29 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
>> If git sees a directory which contains only untracked and ignored
>> files, clean -d should not remove that directory.
>
> Yes that states a fact; it is not clear why we want to have this test here
> and now. (Is it testing for a recently fixed regression?)

It was recently discovered that this is not true of clean -d (and I'm
not sure if it ever was, to be honest). See
http://public-inbox.org/git/xmqqshkof6jd.fsf@gitster.mtv.corp.google.com/T/#mf541c06250724bb000461d210b4ed157e415a596

> Are you just introducing the test to demonstrate it keeps working later on?
> Do you plan on changing this behavior in a later patch?)

The idea was to introduce the broken test and then have the rest of
the patch series fix it; Junio pointed out to me (off-list, since he
was responding from his phone, I think) that I got the convention
backwards, so I'll be changing this in the next version.

>> ---
>>  t/t7300-clean.sh | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
>> index b89fd2a6a..948a455e8 100755
>> --- a/t/t7300-clean.sh
>> +++ b/t/t7300-clean.sh
>> @@ -653,4 +653,14 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
>>         test_path_is_dir foobar
>>  '
>>
>> +test_expect_success 'git clean -d skips untracked dirs containing ignored files' '
>> +       echo /foo/bar >.gitignore &&
>> +       rm -rf foo &&
>> +       mkdir -p foo &&
>> +       touch foo/bar &&
>> +       git clean -df &&
>> +       test_path_is_file foo/bar &&
>> +       test_path_is_dir foo
>> +'
>
> The test makes sense, though I am wondering if we can integrate
> this test into another test e.g. "ok 15 - git clean -d".
>
> Is the -f flag needed?

Will look into both.

> Thanks,
> Stefan
