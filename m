Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E76892079E
	for <e@80x24.org>; Sat, 14 Jan 2017 10:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbdANKEP (ORCPT <rfc822;e@80x24.org>);
        Sat, 14 Jan 2017 05:04:15 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:34671 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbdANKEL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2017 05:04:11 -0500
Received: by mail-yw0-f180.google.com with SMTP id w75so44803686ywg.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2017 02:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7RzbRNt8RGCXGD2iUw8q8d00pT7m5lG/mluyeMSv7Vc=;
        b=R9SRTjUB52JqtB7NgshLkeulIQPDa52Qw4YsY3F7b+FqV8qkK/o1Z+sZ5F2yKMKhlu
         ZybwzROEluMMcfvzAPZUaWIkDHf9d6GDojj+HJtY3wpRQNL4iLG3z1AnOx85AKSe7yh4
         dMsExxet0FmNW5Fcqb++jD01/6r/2xR7MgDefeIlg/Cqffg5zpFPVmcoPezQXQsHmCe1
         bfaZ4/XnaYZZSqJRF2mgdroNGE/tno8t2s5CZAMFe4HS6B+fpQ+DryvK6FqTtngma8F3
         h0Q25RT15gYB/Y1DGbSU8vplFyoskYdCfxnl693QzndvC2kT2SDQkp0JFtUyoJO+0xVn
         SJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7RzbRNt8RGCXGD2iUw8q8d00pT7m5lG/mluyeMSv7Vc=;
        b=j+zAB9d6S7hnSwqmRpzRYey8GGANTCxlAOmlMegcjZdkQo/NBGia+flrlusMWd/f/J
         Zgs9bmXLCqJu/fD1MTW7apT7/dDz5morwLM/i4rryMpLb3QgpyAQMwlqX3zk8AkA/iwV
         bLNqhjKgcAqBpsh0TblwJEYZIu7H/jyQevbZwTwM/jpHslpRfrLP7KSeFflxQWr1bNKC
         mGOsdgj6cyR88mf365MLB9xMviDHJESxxkv2r6QYdYyEbm0UWo70oZLxqciQUYOJLYni
         Yls/FSBnShQvYZ30Eal117LxFqR3gMBt8RDA+M7Fh/bFV0kD7HbgP7ej36Uyze7zpDGR
         vfZA==
X-Gm-Message-State: AIkVDXKvgF5D+JsrCD8Tic1EssCVF2Tf34vbx5hTx0sAj+i1KuI1zo9C/PULTZ8yYgsQpTQ1WC6XilGnp6YCoA==
X-Received: by 10.129.78.79 with SMTP id c76mr18278427ywb.346.1484388249438;
 Sat, 14 Jan 2017 02:04:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Sat, 14 Jan 2017 02:03:39 -0800 (PST)
In-Reply-To: <xmqqbmver63s.fsf@gitster.mtv.corp.google.com>
References: <20170110084953.15890-1-Karthik.188@gmail.com> <xmqqbmver63s.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 14 Jan 2017 15:33:39 +0530
Message-ID: <CAOLa=ZTuk6Qd_LbCFUrV7ChCON8GvQin90JbKP+j0ibi=4iLTQ@mail.gmail.com>
Subject: Re: [PATCH v10 00/20] port branch.c to use ref-filter's printing options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 11, 2017 at 2:21 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> index 81db67d74..08be8462c 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -95,13 +95,17 @@ refname::
>>       The name of the ref (the part after $GIT_DIR/).
>>       For a non-ambiguous short name of the ref append `:short`.
>>       The option core.warnAmbiguousRefs is used to select the strict
>> +     abbreviation mode. If `lstrip=<N>` is appended, strips `<N>`
>> +     slash-separated path components from the front of the refname
>> +     (e.g., `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
>> +     `%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).
>
> I hiccupped while reading this, as the (e.g.) example talks about rstrip
> that is not mentioned in the main text that is enhanced by the
> example.
>
>         If `lstrip=<N>` (`rstrip=<N>`) is appended, strips `<N>`
>         slash-separated path components from the front (tail) of the
>         refname (e.g. `%(refname:lstrip=2)` ...
>
> perhaps?
>
>> +     if `<N>` is a negative number, then only `<N>` path components
>> +     are left behind.
>
> Begin the sentence with cap?  I'd rephrase it a bit while at it if I
> were doing this:
>
>         If `<N>` is a negative number, strip as many path components
>         as necessary from the specified end to leave `-<N>` path
>         components.
>
> Other than the above, looks very good to me.
>
> Thanks.

I like how you rephrased it.
So apart form this and the other change suggested by you and Jacob,
nothing to be added.
Should I re-roll?

-- 
Regards,
Karthik Nayak
