Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B271FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 10:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932514AbcLLKm6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 05:42:58 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33197 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932506AbcLLKm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 05:42:57 -0500
Received: by mail-yw0-f193.google.com with SMTP id s68so7411972ywg.0
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 02:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/n5eBtM8IlbGuiDHSVbk6gsj4XGjWyZLfhkyg+tvTr0=;
        b=RXIk0wghkI8MQVjzpepPPauBoaZAW0kLAeEq+NcJ96SQQYaSiqkikPhKwlGCusVznM
         EmXv6iXlkbS7Nt+q3mc1dBZAMUBVOGluKf8YDut067h8Xc6H6Vz2v7l+HkO9taOMn6FP
         hdzbbrZdJGfyragSowMBrpdulRavcTJfPImWs+RiCGrsEgMYwbW1l9SD5pCzcm2WezGw
         eqln11OpAGMEKo8/Evk6PFRxjfJDiOk6HiwtEKwJhCTh16wHD81cOgQ9nJOl2PX5dypB
         ucRapEMRUMgaCykIDChGCCkIstgGW82rmCpKfLIlXE74AoxQ4P1owTnnVahQHBsxN+pp
         gsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/n5eBtM8IlbGuiDHSVbk6gsj4XGjWyZLfhkyg+tvTr0=;
        b=Hy+f3Ortt+iZJ/xaEUxLKe+O/DkcPuaOAfjJD1g938YnYUFtiegBuhFw5lOM8ohmj+
         EX+N9kB7cIoxYHJ+zfonOMTugz2p3sf/4HGybnbRiiEZJ1Z/wzhICtopDMIE2xERtXqO
         koz5t5WZDVjtgPufIkadqT6AmQFuqeuKBdL4/zDdaS/1r+8CDd66qfWs5pds92RsxsiS
         j5ymKGV0KCN0yHOZNp858ffVkKOs/BaJWCr3n/uQU0I39llM4MsoNmgiRWRYqVUA9ONH
         BLQLgKhR2uQF1S4b1oUPsjTKMcTge5uAYs3l33gfaai1kdy6hvIajfGSOAEVIZgg66Q0
         1fRQ==
X-Gm-Message-State: AKaTC011hRWYxYWgLQM7fCNtgLDUzlRCheMRHoABuCtzH88xASMdfGpQCw21xiZjoFpc2/PfJWWF5CaFcFTplQ==
X-Received: by 10.129.46.133 with SMTP id u127mr87335056ywu.94.1481539376403;
 Mon, 12 Dec 2016 02:42:56 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Mon, 12 Dec 2016 02:42:26 -0800 (PST)
In-Reply-To: <CA+P7+xquordVY19dypqNcAuQqoRbFmHhzb0w+HXCaJmm_Ex7zQ@mail.gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com> <CA+P7+xquordVY19dypqNcAuQqoRbFmHhzb0w+HXCaJmm_Ex7zQ@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 12 Dec 2016 16:12:26 +0530
Message-ID: <CAOLa=ZRh5H=DuHJtE4p4R5M3f=2+G62OPztTDqhmpYr3c19zQw@mail.gmail.com>
Subject: Re: [PATCH v8 00/19] port branch.c to use ref-filter's printing options
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 5:31 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index f4ad297..c72baeb 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -92,13 +92,14 @@ refname::
>>         The name of the ref (the part after $GIT_DIR/).
>>         For a non-ambiguous short name of the ref append `:short`.
>>         The option core.warnAmbiguousRefs is used to select the strict
>> -       abbreviation mode. If `strip=<N>` is appended, strips `<N>`
>> -       slash-separated path components from the front of the refname
>> -       (e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
>> -       `<N>` must be a positive integer.  If a displayed ref has fewer
>> -       components than `<N>`, the command aborts with an error. For the base
>> -       directory of the ref (i.e. foo in refs/foo/bar/boz) append
>> -       `:base`. For the entire directory path append `:dir`.
>> +       abbreviation mode. If `lstrip=<N>` or `rstrip=<N>` option can
>
> Grammar here, drop the If before `lstrip since you're referring to
> multiples and you say "x can be appended to y" rather than "if x is
> added, do y"
>

Will do. Thanks.

>> +       be appended to strip `<N>` slash-separated path components
>> +       from or end of the refname respectively (e.g.,
>> +       `%(refname:lstrip=2)` turns `refs/tags/foo` into `foo` and
>> +       `%(refname:rstrip=2)` turns `refs/tags/foo` into `refs`).  if
>> +       `<N>` is a negative number, then only `<N>` path components
>> +       are left behind.  If a displayed ref has fewer components than
>> +       `<N>`, the command aborts with an error.
>>
>
> Would it make more sense to not die and instead just return the empty
> string? On the one hand, if we die() it's obvious that you tried to
> strip too many components. But on the other hand, it's also somewhat
> annoying to have the whole command fail because we happen upon a
> single ref that has fewer components?
>
> So, for positive numbers, we simply strip what we can, which may
> result in the empty string, and for negative numbers, we keep up to
> what we said, while potentially keeping the entire string. I feel
> that's a better alternative than a die() in the middle of a ref
> filter..
>
> What are other people's thoughts on this?

I am _for_ this. Even I think it'd be better to return an empty string rather
than just die in the middle.

-- 
Regards,
Karthik Nayak
