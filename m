Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA66920970
	for <e@80x24.org>; Tue, 11 Apr 2017 14:57:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbdDKO5T (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 10:57:19 -0400
Received: from mail-oi0-f42.google.com ([209.85.218.42]:35504 "EHLO
        mail-oi0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752672AbdDKO5R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 10:57:17 -0400
Received: by mail-oi0-f42.google.com with SMTP id f22so56307738oib.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 07:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=mttH4Z77tP8ufZ+/QKA860qruyT3RU9srRseww7a5qs=;
        b=M3hcK6XWLvUEzrwqGh+kErvqtrh+IGIlYFkBNrSesVrHoeZ48rvjhUD7HeDwcfondk
         69Ki5BtU+2TU/vNUG1tdvxMZ8t2Y+8R5XoOwjbwdvXUyfXMUxa7gqpvHy4cWCyxEjteJ
         dAxQNliu8Jqz615ABBUv1GWupz2ZLNLtxakagRv/Khka89Ta9yqbhloLEY0LOwFml856
         NeVTaEXLAk0x/2aZQXMg6A22jAgb18X4Z2arijoEN6woJlZdejI8Km1fEInFTXQPFuyU
         rTXdfCu+0/FGPPJ8l5gfm3MIs63L2zgkr2h3Njc82WBTXpJJNfDN19Lv7DCfjLNLHgwD
         OzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=mttH4Z77tP8ufZ+/QKA860qruyT3RU9srRseww7a5qs=;
        b=HnB1j+LKOJQTWP0D3wc4Vz0RpRo4F0D2cH1ASdPuXDIz2zUALAJ+LBsMRcfMV+p+Jk
         7gnjp3p7LvjzRiS3HMd2xhHFN0XtEaWs5Ydn4TUsXpyzDP0xZNjrDtE7SUvdpwICION0
         gd/Mxr765Isp1tWT4hpwVnNAxWcqxNwqJDV04H22GWnNPdMaD50e8st6uK+eayCOvOy1
         nAmkRBG5ZiwuhjL308fKd61f1DzWT8BJgcleWYVIyduHIvdWKTx8bmZZTYiizxqr/Mvq
         /JBv99APQBdJcCutTHjVPrTxsr+GP8nX8pbo+VTZ2z9pFNG4CPFGrEjECcGxHia5flxI
         fzXA==
X-Gm-Message-State: AN3rC/7O3BOf6pFH0o3cWSk0rQ3HWWlYZ2ReNQ9JLWl5mPk3mZcjQli6s7lrMWx1TQW8oadiy/ovhM5a9ygSow==
X-Received: by 10.202.83.149 with SMTP id h143mr11147896oib.44.1491922637263;
 Tue, 11 Apr 2017 07:57:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.35.80 with HTTP; Tue, 11 Apr 2017 07:56:56 -0700 (PDT)
In-Reply-To: <20170411130659.ehit7jdhnk43m23g@sigill.intra.peff.net>
References: <20170411092050.15867-1-ryazanov.s.a@gmail.com> <20170411130659.ehit7jdhnk43m23g@sigill.intra.peff.net>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 11 Apr 2017 17:56:56 +0300
Message-ID: <CAHNKnsRxNMS4fYTaoHSRgcTmCr+rcjVOGE1kqJGHqLTgBxdC0w@mail.gmail.com>
Subject: Re: [PATCH v2] http: honnor empty http.proxy option to bypass proxy
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 11, 2017 at 4:06 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Apr 11, 2017 at 12:20:50PM +0300, Sergey Ryazanov wrote:
>> diff --git a/http.c b/http.c
>> index 96d84bb..8be75b2 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -836,8 +836,14 @@ static CURL *get_curl_handle(void)
>>               }
>>       }
>>
>> -     if (curl_http_proxy) {
>> -             curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>> +     if (curl_http_proxy && curl_http_proxy[0] == '\0') {
>> +             /*
>> +              * Handle case with the empty http.proxy value here to keep
>> +              * common code clean.
>> +              * NB: empty option disables proxying at all.
>> +              */
>> +             curl_easy_setopt(result, CURLOPT_PROXY, "");
>> +     } else if (curl_http_proxy) {
>
> This seems pretty reasonable. You could bump this under the existing "if
> (curl_http_proxy)" condition, but that would add an extra level of
> indentation to the rest of the parsing.
>
Because of this additional indentation I decide to add new if () block.

> One thing I do wonder, though: can credential_from_url() ever return a
> NULL host field for other inputs, and what should we do on those inputs?
>
> For example, if I set the value to just "https://" with no hostname,
> then I think we'll end up with a NULL proxy_auth.host field. And we'll
> feed that NULL to CURLOPT_PROXY, which will cause it to use the
> defaults.
>
> I don't know _what_ "https://" should do. It's clearly bogus. But
> telling curl to use the defaults seems funny. In that sense, your
> original was much better (we'd feed it to curl, which would be free to
> complain).
>

I thought about this situation too. IMHO the best solution here is to
check host after credential_from_url() call. If host is NULL then we
should show warning message and exit. Then user could fix its
configuration.

Since I in any case will send v3 with grammar fixes then I could add
new patch to the series. This new patch will check host for NULL and
print warning message. Are you Ok with such solution?

-- 
Sergey
