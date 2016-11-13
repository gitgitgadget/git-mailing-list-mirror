Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A37581F40E
	for <e@80x24.org>; Sun, 13 Nov 2016 14:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933674AbcKMOIN (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 Nov 2016 09:08:13 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:35584 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933505AbcKMOIM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2016 09:08:12 -0500
Received: by mail-yb0-f194.google.com with SMTP id d59so1790574ybi.2
        for <git@vger.kernel.org>; Sun, 13 Nov 2016 06:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8gVp/FLYCFoJB+ot5sv7+/+4o0w/xW1pL+v2XxPo6dw=;
        b=gRHX7K9rqY4lYtLbJc9GYIyTX9s4htHQ9XKsKbJTJE3djb6kNchxHrSXpDCrE9WGsh
         avY4thtaeb444v8DY/UP7GVbntm5JrGPhGLdTGBF2cPzxw609gt0eSeFDS6yfLvp5hc9
         gFPLSFogm/wbrblKhY48Jsm0kHSJ5Qis/+O8Iun92AnuG8vVkxjJ/XXUFc2wpJB1zVjP
         Sfl3YhydsJD8HrpyDzo4ixGBSU/qbKi2QBPbbpBJW9jCkQDpCuGBpr9LSQkxBsMfT920
         XwWi0ZY2NQMlrAiyjwuvBjkF5s1D0aODQXax5PtfJTc2o4giaeTruI4rYAbncsa/oyY1
         n5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8gVp/FLYCFoJB+ot5sv7+/+4o0w/xW1pL+v2XxPo6dw=;
        b=K4wAXitPnhRUt8a8uDJkFscAqXT6TokabwkdlT1w7VQNaaY2Ch4gp6GZivrjGUm61V
         7NcRzEWE6FgPFNzpzKyZriVuGWpmgKwQr4pFJgmaw+iQAmQPByjO2FywgK7b9vTjlqvJ
         8O7KyxtHsuJRFcWGnHOa936iWx4lB0Yx4WoaSUG47o7ArAH96HnIQ7J1iJ4fHVh+oo9K
         hZaUUYYcJ3zMFT463rq4ik0vnH3zq50H3T2wNRtIO+JVM4b/0zuIStwG1Z0RlZ6dZ8Xh
         8DbOUN6OF9uq2Pa8GOvM45IPo+4rQhbyv7vUM77DwXf+PeTdl+P9DjA8vGXnQGGn9qWk
         Lf1A==
X-Gm-Message-State: ABUngvdzT7kjfvQR6btObpwi+Lt6n3mHN6G0LnCpPA/Q21vbgaJkHOuhKB0W8aSCgshSG/IE5e0C7uzIa7gxeQ==
X-Received: by 10.37.80.134 with SMTP id e128mr11037193ybb.89.1479046091710;
 Sun, 13 Nov 2016 06:08:11 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Sun, 13 Nov 2016 06:07:41 -0800 (PST)
In-Reply-To: <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-14-Karthik.188@gmail.com>
 <CA+P7+xqHKVUfNm+jCsbMNazHpVhB46h60k75JzS35CrkR-d-UQ@mail.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sun, 13 Nov 2016 19:37:41 +0530
Message-ID: <CAOLa=ZTWFuzWBjGUX_nV4rVVDRpaabmj0-M6S7aJkX3w+dK2Jw@mail.gmail.com>
Subject: Re: [PATCH v7 13/17] ref-filter: add `:dir` and `:base` options for
 ref printing atoms
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Nov 9, 2016 at 5:28 AM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> From: Karthik Nayak <karthik.188@gmail.com>
>> Add tests and documentation for the same.
>>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>>  Documentation/git-for-each-ref.txt | 34 +++++++++++++++++++---------------
>>  ref-filter.c                       | 29 +++++++++++++++++++++++++----
>>  t/t6300-for-each-ref.sh            | 24 ++++++++++++++++++++++++
>>  3 files changed, 68 insertions(+), 19 deletions(-)
>>
>> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
>> index 600b703..f4ad297 100644
>> --- a/Documentation/git-for-each-ref.txt
>> +++ b/Documentation/git-for-each-ref.txt
>> @@ -96,7 +96,9 @@ refname::
>>         slash-separated path components from the front of the refname
>>         (e.g., `%(refname:strip=2)` turns `refs/tags/foo` into `foo`.
>>         `<N>` must be a positive integer.  If a displayed ref has fewer
>> -       components than `<N>`, the command aborts with an error.
>> +       components than `<N>`, the command aborts with an error. For the base
>> +       directory of the ref (i.e. foo in refs/foo/bar/boz) append
>> +       `:base`. For the entire directory path append `:dir`.
>>
>>  objecttype::
>>         The type of the object (`blob`, `tree`, `commit`, `tag`).
>> @@ -114,22 +116,23 @@ objectname::
>>
>>  upstream::
>>         The name of a local ref which can be considered ``upstream''
>> -       from the displayed ref. Respects `:short` and `:strip` in the
>> -       same way as `refname` above.  Additionally respects `:track`
>> -       to show "[ahead N, behind M]" and `:trackshort` to show the
>> -       terse version: ">" (ahead), "<" (behind), "<>" (ahead and
>> -       behind), or "=" (in sync). `:track` also prints "[gone]"
>> -       whenever unknown upstream ref is encountered. Append
>> -       `:track,nobracket` to show tracking information without
>> -       brackets (i.e "ahead N, behind M").  Has no effect if the ref
>> -       does not have tracking information associated with it.
>> +       from the displayed ref. Respects `:short`, `:strip`, `:base`
>> +       and `:dir` in the same way as `refname` above.  Additionally
>> +       respects `:track` to show "[ahead N, behind M]" and
>> +       `:trackshort` to show the terse version: ">" (ahead), "<"
>> +       (behind), "<>" (ahead and behind), or "=" (in sync). `:track`
>> +       also prints "[gone]" whenever unknown upstream ref is
>> +       encountered. Append `:track,nobracket` to show tracking
>> +       information without brackets (i.e "ahead N, behind M").  Has
>> +       no effect if the ref does not have tracking information
>> +       associated with it.
>>
>>  push::
>>         The name of a local ref which represents the `@{push}`
>>         location for the displayed ref. Respects `:short`, `:strip`,
>> -       `:track`, and `:trackshort` options as `upstream`
>> -       does. Produces an empty string if no `@{push}` ref is
>> -       configured.
>> +       `:track`, `:trackshort`, `:base` and `:dir` options as
>> +       `upstream` does. Produces an empty string if no `@{push}` ref
>> +       is configured.
>>
>
> At this point would it make more sense to document the extra values
> here in one block separately? For example, the upstream atom is
> getting pretty complex with all those options. Additionally, some of
> the options can be combined, like nobracket, but others cannot be
> comined so It may be worth documenting how and when those combinations
> work?
>

I do agree. The documentation seems cluttered. It'd be nice to clean
it up. Maybe
after this series? Or any suggestions on how to go about it?

-- 
Regards,
Karthik Nayak
