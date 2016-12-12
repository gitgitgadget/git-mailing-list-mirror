Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 336921FF76
	for <e@80x24.org>; Mon, 12 Dec 2016 11:20:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752418AbcLLLUx (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 06:20:53 -0500
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36839 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752396AbcLLLUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 06:20:52 -0500
Received: by mail-yw0-f194.google.com with SMTP id r204so7477260ywb.3
        for <git@vger.kernel.org>; Mon, 12 Dec 2016 03:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GmICN+91R28q3bH4At1H48gsXJjcS6whXJvdDtMSVvM=;
        b=T6qrusmarIbQ1oBFB09U4dewZPz3ttsdby5IQWuw0NTNzYLsxjfPd9YdM1fHwg24v2
         WdgDy9blqsCVPOZ3tS5QMCrSQYmRRXoRiTxFSNvBO6PYZtUUMY42ZnewVXfH7sWQtcmd
         9hMuz5lGD0k7Kn6QOZZ1SDnhgE5Ve46nij18UEK/J8M/dThuFH+pN7+DsXYNQf2+TZNp
         YdXe0zTxiO+f5UQszUk0VUMT6cIKZYidBwRN24gcuFXgBTwYDYThvEG8b3IHdzphhh3R
         DHSDEb6ukqSnn6Q5bd2SYLJNlh5GyEAW2m+xz86wXFj5qFrIzKhA54eB0nJdq2ixuWoE
         IFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GmICN+91R28q3bH4At1H48gsXJjcS6whXJvdDtMSVvM=;
        b=M2fbU4UkN2x2RV5zT/Zn/60D6hXlBxN6esr8Da0hPA5X5KCdngrpmzsKvjjbu2vKVl
         r17kqj56ZhpWeLSzPpG1/A9VA7+tN5Q64NN5tWzTqTtAVAmFUirS23JaWlKEA9e6e9mK
         YnxglMAcmsGsG5WzjF8kekm6AFEUPF/4ylRaP4dgQbhOk+nL5fQoWX/hpuAiPKw7Bkli
         2nhxLXKexHSObKwFwSe4fTTvB3NwC5InWC9VCNBhuc65w0FGJnAZ3uFdmMFqSbOrH+Zw
         8duJ+In1MFO5LQX/5ES0kMyUSfQ/UuO6zNPu+qh2Ay54XE3BrrTYFzM1nDo3FrWbVvwN
         kz6w==
X-Gm-Message-State: AKaTC02BvLNr1Ni596MKHNIEGz4lQih4/h/FhVFNREGkaV65SLbGUinEeTnK8xRVFDxUrKBTdjpm6pB2Pd4wJw==
X-Received: by 10.129.46.133 with SMTP id u127mr87499815ywu.94.1481541651345;
 Mon, 12 Dec 2016 03:20:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.129.19.214 with HTTP; Mon, 12 Dec 2016 03:20:20 -0800 (PST)
In-Reply-To: <20161209140345.76ybodldmg2lxgbn@sigill.intra.peff.net>
References: <20161207153627.1468-1-Karthik.188@gmail.com> <20161207153627.1468-19-Karthik.188@gmail.com>
 <20161209140345.76ybodldmg2lxgbn@sigill.intra.peff.net>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Mon, 12 Dec 2016 16:50:20 +0530
Message-ID: <CAOLa=ZSPDLwziGEvyixebAkS2M1JMYidQNHfDbnmYarFCjn80A@mail.gmail.com>
Subject: Re: [PATCH v8 18/19] branch: use ref-filter printing APIs
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 9, 2016 at 7:33 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 07, 2016 at 09:06:26PM +0530, Karthik Nayak wrote:
>
>> +const char *quote_literal_for_format(const char *s)
>>  {
>> +     struct strbuf buf = STRBUF_INIT;
>>
>> +     strbuf_reset(&buf);
>> +     while (*s) {
>> +             const char *ep = strchrnul(s, '%');
>> +             if (s < ep)
>> +                     strbuf_add(&buf, s, ep - s);
>> +             if (*ep == '%') {
>> +                     strbuf_addstr(&buf, "%%");
>> +                     s = ep + 1;
>> +             } else {
>> +                     s = ep;
>> +             }
>>       }
>> +     return buf.buf;
>>  }
>
> You should use strbuf_detach() to return the buffer from a strbuf.
> Otherwise it is undefined whether the pointer is allocated or not (and
> whether it needs to be freed).
>
> In this case, if "s" is empty, buf.buf would point to a string literal,
> but otherwise to allocated memory. strbuf_detach() normalizes that.
>
> But...
>
>> +                         branch_get_color(BRANCH_COLOR_REMOTE), maxwidth, quote_literal_for_format(remote_prefix),
>
> This caller never stores the return value, and it ends up leaking. So I
> wonder if you wanted "static struct strbuf" in the first place (and that
> would explain the strbuf_reset() in your function).
>
> -Peff

Ah! Yes this should be 'static struct strbuf' indeed, I blindly copied Junio's
suggestion.

strbuf_detach() is also a better way to go.

Thanks.

-- 
Regards,
Karthik Nayak
