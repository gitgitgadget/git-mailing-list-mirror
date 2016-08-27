Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6EA91F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 20:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754819AbcH0URP (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 16:17:15 -0400
Received: from mail-yw0-f175.google.com ([209.85.161.175]:35525 "EHLO
        mail-yw0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751194AbcH0URO (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 16:17:14 -0400
Received: by mail-yw0-f175.google.com with SMTP id j12so66924959ywb.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 13:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yMeBlQUU5DrrGerzvyYJqlxonlUReZ81C3Psw8zWNsE=;
        b=P/jIgwsn7npXG69C3/hY2xmki4FOJ8Tu7FLXk3ngZxuFGtl0hCvQnvOe7iLHJ3URFI
         u+hGIIzLvUhiQj5tRp3Uo8QfmilY84Ys5qXuxPQWdLO5sNujmM0e+BvGkxQG0DwnyUGm
         FKJ3R2fISgmYZfIt7cBILJkPv5A3RVhEdcs/NAilsrqAx976XRLyuEVIZZ4HpIM34w2W
         zln9QaDiOUMDeAoWf9HBq1RHHLizi9We+5JwZO3OSFg9N/dJqUxr42dArI0rSIqLs6D1
         JlJOzwLu7ejl8o3DJmpd6nzI+A/p2iW+Ry7Y+sJjvI9WTPEwXdvBUnbMAxMeUuQxtWEU
         KTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yMeBlQUU5DrrGerzvyYJqlxonlUReZ81C3Psw8zWNsE=;
        b=DikFyEgcWQeT8F514hdOkBJF24hjvZyd77tEX9sc4SB9axYPAj34sXL78e/z60IMCE
         YPiojsIBmFQ9Y/KcxiTeRea6oMnuTzEWkTrbeEE7KcyAzQVQyPwF52yMeuM5rfu4AZkx
         dJK3vCH4rSB9/SHRdcNM6t6T6bXitGvtsU00WRpMwrV9kskjuCRTM3eHKBaiPhU3pfUP
         A0Ruzrzfro5MGtDAmKZdgQ/l4up6/r2YwAvXzn2fnKgn+bmSykV8Ex9eltojHXkuKJNv
         SC9emyyJLq2EMHmUao1VVJadlcLJsRmd0tCfJFG76BKTWEYuqds67MR0DDK58XGYFdjF
         wvig==
X-Gm-Message-State: AE9vXwNMfLdkA0Jst1UseCCKhtvUbTZ+Au5YmKx4o1qX3+hxn4W5KT8tlQZhsWNOkjJrLkhWzsrqlBsdXfLBPA==
X-Received: by 10.129.76.79 with SMTP id z76mr8862228ywa.33.1472329005941;
 Sat, 27 Aug 2016 13:16:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sat, 27 Aug 2016 13:16:45 -0700 (PDT)
In-Reply-To: <xmqqbn0fdt9e.fsf@gitster.mtv.corp.google.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
 <01020156b73fe6d5-6a363195-eb91-48a0-9a3c-3159fba6d327-000000@eu-west-1.amazonses.com>
 <xmqqbn0fdt9e.fsf@gitster.mtv.corp.google.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 28 Aug 2016 01:46:45 +0530
Message-ID: <CAFZEwPMWjyEzV7WsMynTOBhkgAT14eyoHdEmauAU8npq8mu0gg@mail.gmail.com>
Subject: Re: [PATCH v14 21/27] bisect--helper: `bisect_log` shell function in C
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Junio,

On Sat, Aug 27, 2016 at 4:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> +static int bisect_log(void)
>> +{
>> +     struct strbuf buf = STRBUF_INIT;
>> +
>> +     if (strbuf_read_file(&buf, git_path_bisect_log(), 256) < 0) {
>> +             strbuf_release(&buf);
>> +             return error(_("We are not bisecting.\n"));
>> +     }
>> +
>> +     printf("%s", buf.buf);
>> +     strbuf_release(&buf);
>> +
>> +     return 0;
>> +}
>
> Hmph, is it really necessary to slurp everything in a strbuf before
> sending it out to the standard output?  Wouldn't it be sufficient to
> open a file descriptor for reading on the log file and then hand it
> over to copy.c::copy_fd()?

That is actually much better. Thanks!

Regards,
Pranit Bauva
