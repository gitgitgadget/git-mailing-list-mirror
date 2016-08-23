Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE5A71FD99
	for <e@80x24.org>; Tue, 23 Aug 2016 21:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750899AbcHWV3K (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 17:29:10 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36409 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752864AbcHWV3J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2016 17:29:09 -0400
Received: by mail-yb0-f194.google.com with SMTP id f60so2871182ybi.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 14:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HIMWhTvEGp16nM94zDa/K5+7sUUJ259SYcRKxtODbR0=;
        b=NbXc4bTiqiH9UPNkRRmwCB9IIBvb1gu3Twy40jl8iKOe2pWq8CNbfs8FgGSG/MndkG
         oI+d2qD9IembZL5cpNtO+/1TNUWp2k8CNK42rbn+Qhf8Wp0yTs/4qOpgmX5he7sYJFI+
         7WL+kwzhpMooTIghUe0NKDSsq+bK+rMR0VycTrx1hAZdVUUuY8skc94vOx981dbgQmdO
         wwXJiR0E6jL0bpbmFI2u37vpFgkLtIDwKEtbPk8Jc/0OBNS/uWySKrfs6JaM/g4GvEqj
         ijStpEYzWYDLxcVoOAlPvPnv9SUdZqrsX9BU2NfPk278SY+Ln4vUAAf2aWQha2FQ2AtB
         pFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HIMWhTvEGp16nM94zDa/K5+7sUUJ259SYcRKxtODbR0=;
        b=PmTpffbu/khHEzFJoVqGh2w5IVg9De8VfPnPVYLNl9yy4q1Sx1oliHRVbuYp8CMC9r
         HoyTg2FPfa7wYRsdFayuA4jKSzNITYzVkm8CJmSQ5zl01E6MA6347NzblGj2eHzpUYZm
         TAPEMxgx9j/mWMyUR82QwqO45fFnSoiKJ59ADAzJtJ5bmhwZKhAO5e1hqyV983i7e2ck
         0gf1rPneEza3ggusMxp+rjUVv6o5k684V2Tok66AUlBVUXra01UMcleUhDqZ2l54wFE4
         uNIjY4Nb49zklvi/q7rsbCYtCD8r2tT/awBpIajitycysaKh1F9p5ZVz8y0MvBk/XJE6
         0ZmQ==
X-Gm-Message-State: AEkoouubB1GBn1QJs+SWe95/ctKwf0tW+XTsFP/bw2/bMkfaoN50QZQqq4RmJN9o9u/tpjW5+YJIWL/MbtuksQ==
X-Received: by 10.37.42.71 with SMTP id q68mr10959119ybq.29.1471987702636;
 Tue, 23 Aug 2016 14:28:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.50.199 with HTTP; Tue, 23 Aug 2016 14:28:02 -0700 (PDT)
In-Reply-To: <xmqqinuruqpk.fsf@gitster.mtv.corp.google.com>
References: <20160819234959.26308-1-jacob.e.keller@intel.com>
 <xmqq37lvxx5o.fsf@gitster.mtv.corp.google.com> <xmqqinuruqpk.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 14:28:02 -0700
Message-ID: <CA+P7+xqSurMJG7+z7yZGxpfuYWAuoZggQ_09KLiPBAs5E6yxZA@mail.gmail.com>
Subject: Re: [PATCH] format-patch: show 0/1 and 1/1 for singleton patch with
 cover letter
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        James Hogan <james.hogan@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 2:21 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>>>      total = nr;
>>> -    if (!keep_subject && auto_number && total > 1)
>>> +    if (!keep_subject && auto_number && (total > 1 || cover_letter))
>>>              numbered = 1;
>>>      if (numbered)
>>>              rev.total = total + start_number - 1;
>
> Actually there is a very good reason why this patch is not good
> (yet).  When the --cover option is not specified on the command
> line, cover_letter is -1 (use configuration or turn it on only when
> it is a multi-patch series) at this point.
>
> I think you would have noticed it if you ran any format-patch tests.
> t/t4021-format-patch-numbered.sh fails at the very beginning.
>

Oops! Sorry for not running tests.

> With the attached SQUASH, existing tests pass, which is a strong
> sign that this new feature needs to be protected by a new test in
> the t4021 script to make sure other people would not break it in the
> future.
>

I'll add a new test and squash your fix in.

Thanks,
Jake

>  builtin/log.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/log.c b/builtin/log.c
> index e50d361..b7bfeb9 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1650,16 +1650,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
>                 /* nothing to do */
>                 return 0;
>         total = nr;
> -       if (!keep_subject && auto_number && (total > 1 || cover_letter))
> -               numbered = 1;
> -       if (numbered)
> -               rev.total = total + start_number - 1;
>         if (cover_letter == -1) {
>                 if (config_cover_letter == COVER_AUTO)
>                         cover_letter = (total > 1);
>                 else
>                         cover_letter = (config_cover_letter == COVER_ON);
>         }
> +       if (!keep_subject && auto_number && (total > 1 || cover_letter))
> +               numbered = 1;
> +       if (numbered)
> +               rev.total = total + start_number - 1;
>
>         if (!signature) {
>                 ; /* --no-signature inhibits all signatures */
