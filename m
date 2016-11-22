Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D69F31FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 18:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933914AbcKVScx (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 13:32:53 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:33031 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933717AbcKVScw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 13:32:52 -0500
Received: by mail-yw0-f196.google.com with SMTP id s68so3022508ywg.0
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 10:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4Mg8jRBrXSnBH3FTm1jx260jbUz3HJlvlzbAj3Vo41U=;
        b=HmIdxyyKKul+GHySEe/KtmN9Qh0O8hLvghkPHYLEY2HeztFcEvbAWXR8qL7X/G5qbj
         1txkFrYQmZ47gORqDVnSmeNBYwyaJIyIWOUgHZuIHNBgRvoPm03b7h4tGuTdWvifwWBv
         LoIxl3882dKyQ39AqzOibOMrDwrgFpC6Wc+Nn/NQe4555zMql3ROdtokVMmqpATtjUji
         TzpjEA9qG8NtaQzNeAt96McVWKBW0NQIMzXtxcJcrH2+BfJU0REBT51bXIOXXiXChl6/
         oPclTITTuMY+qmjO9xMGpmxQ5nO5q/xZTRz+1ArTY9hY4VaLMHTC/fLcW26G3FDF9897
         OzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4Mg8jRBrXSnBH3FTm1jx260jbUz3HJlvlzbAj3Vo41U=;
        b=IzOcrYFz5Ovbh+veUrlzFUooKeJ7H9jTWGr+p3VcOh9vF1cyMuxaBeI/LVnjk5iXT5
         zQ0EvnkbcwQsGFIcBMPGP3fRmuhiuIJYquktv8BZOqL9r8oTrJihbfss9ceT06LNvFc4
         shokbn9iiEp+ybVrGWgOpt21Hi8jlYpK97yAOs4cdu2J6I2OiIsicH3rt6vKC4uzjwow
         23H6Ikt+B3XjnflYnkd8lymBn4TmWdv3ANxKhvZV9QQxzMSI9EZGBUR1YDFwvAuKv4T8
         OZQ/2kJAwL6hFjEHrNzaULGff3QrKhTd7rI4qVNAnn/RZSmCCjuEjSl5Jm/IUktiVjJR
         r7nw==
X-Gm-Message-State: AKaTC00yW3Gkf6nCrR5UL10YfBNkZVkslookd1GSbM9JIxLchgnvl1fnn31HhWsLpnlK3VrP1nPC0Q5Dn7q2rA==
X-Received: by 10.13.229.70 with SMTP id o67mr21054438ywe.131.1479839546195;
 Tue, 22 Nov 2016 10:32:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.13.207.69 with HTTP; Tue, 22 Nov 2016 10:31:55 -0800 (PST)
In-Reply-To: <xmqqa8cxoj7k.fsf@gitster.mtv.corp.google.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-17-Karthik.188@gmail.com>
 <xmqqinrlopge.fsf@gitster.mtv.corp.google.com> <xmqqa8cxoj7k.fsf@gitster.mtv.corp.google.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Wed, 23 Nov 2016 00:01:55 +0530
Message-ID: <CAOLa=ZT3eFZ+rf8t-TN5KSxjg2EDszV+DJM=CA=b6fGfgBnN0g@mail.gmail.com>
Subject: Re: [PATCH v7 16/17] branch: use ref-filter printing APIs
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 18, 2016 at 3:35 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> One worry that I have is if the strings embedded in this function to
>> the final format are safe.  As far as I can tell, the pieces of
>> strings that are literally inserted into the resulting format string
>> by this function are maxwidth, remote_prefix, and return values from
>> branch_get_color() calls.
>>
>> The maxwidth is inserted via "%d" and made into decimal constant,
>> and there is no risk for it being in the resulting format.  Are
>> the return values of branch_get_color() calls safe?  I do not think
>> they can have '%' in them, but if they do, they need to be quoted.
>> The same worry exists for remote_prefix.  Currently it can either be
>> an empty string or "remotes/", and is safe to be embedded in a
>> format string.
>
> In case it was not clear, in short, I do not think there is anything
> broken in the code, but it is a longer-term improvement to introduce
> a helper that takes a string and returns a version of the string
> that is safely quoted to be used in the for-each-ref format string
> use it like so:
>
>     strbuf_addf(&remote,
>                 "%s"
>                 "%%(align:%d,left)%s%%(refname:strip=2)%%(end)"
>                 ...
>                 "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
>                 quote_literal_for_format(branch_get_color(BRANCH_COLOR_REMOTE)),
>                 ...);
>
> and the implementation of the helper may look like:
>
>     const char *quote_literal_for_format(const char *s)
>     {
>         static strbuf buf = STRBUF_INIT;
>
>         strbuf_reset(&buf);
>         while (*s) {
>             const char *ep = strchrnul(s, '%');
>             if (s < ep)
>                 strbuf_add(&buf, s, ep - s);
>             if (*ep == '%') {
>                 strbuf_addstr(&buf, "%%");
>                 s = ep + 1;
>             } else {
>                 s = ep;
>             }
>         }
>         return buf.buf;
>     }
>

Perfect. I get what you're saying, I'll add this in :)

-- 
Regards,
Karthik Nayak
