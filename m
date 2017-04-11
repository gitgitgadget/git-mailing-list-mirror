Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1EB1FA14
	for <e@80x24.org>; Tue, 11 Apr 2017 08:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753064AbdDKIY0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 04:24:26 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35514 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbdDKIYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 04:24:24 -0400
Received: by mail-oi0-f50.google.com with SMTP id f22so45278476oib.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 01:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pHClJCzwdGQnV/XXp5NWJ3colWtBq0/ra8m33sBNtBg=;
        b=RzhEoYtZQn37KVQWEAFz2XuQl+WKsUYEWWWGx+sXJP/2fBU54G3bfQWx7icxcHOEI1
         9dczTnHck4lM9HXvE5ewOhGsG8WWsbUIYUhiZ+wBXAfhxQYRJ7bk5XqBGkVvSv/QI5+0
         WuLEpC27jqZ4F//lAVQ3NqKY86jTfYJ0tJrNLJUORk56QhdSq1RVDXC4MVU0IOBx6WC6
         TV9koiO5ezAstSj6LYKrybzOwbCWcHNQzmaUvliwJvgEI39bWNh++B8JkxX+lJeSZ6ay
         u9P4aWDCJNVlpR5rl4BtH4knbGCdahwkNJomHNoPc2Yy3lNazAJ+XORt2Zwaa+nibaaB
         nRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pHClJCzwdGQnV/XXp5NWJ3colWtBq0/ra8m33sBNtBg=;
        b=AcmDRqPcb815SH3F+eNe7DbcvLnUZMZk0SHhCHub6vClOe8iVliBmuY3eRoXH/nFrs
         D0bKvX7KBm9j0kmxC91FEPPV1cbx/IpQpEvC+Ncce2NeetLaPWdqo04xHtu6rbknKcMP
         6mYmhuHg/zPFMWQQssmyqKdLwM+iW+xuah8kM4eXAVOsIXMbihpYn6K3fIY931WLQYOF
         gTwSUjMYOSWk5tATuewvfc+Qko5Tt7j9QV5hwLdHGxjl2n2ZpnFg7TCuZrzl4fZgmuQt
         EbWaiMapyxIMKCmeqD82yG+wkpo0UWlRnxyBvDmpOs0PRBOZg0f2XkFhcyyl15J0ln7o
         6C/g==
X-Gm-Message-State: AN3rC/4E9PoZ6x6f6HW+Cnkcy8zYcMOUo4eehornIUosvCyW2GWA3h25btk8gPZQm6lfVK4RfScBIfwoXa8dsQ==
X-Received: by 10.202.83.149 with SMTP id h143mr10242298oib.44.1491899063615;
 Tue, 11 Apr 2017 01:24:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.35.80 with HTTP; Tue, 11 Apr 2017 01:24:03 -0700 (PDT)
In-Reply-To: <20170410163350.3zqm33tgqafsp76u@sigill.intra.peff.net>
References: <20170410151556.10054-1-ryazanov.s.a@gmail.com> <20170410163350.3zqm33tgqafsp76u@sigill.intra.peff.net>
From:   Sergey Ryazanov <ryazanov.s.a@gmail.com>
Date:   Tue, 11 Apr 2017 11:24:03 +0300
Message-ID: <CAHNKnsRPXW+4XgMKAubv3hyaXKGVE9o6Gmuhaq2gsLyo+N7xPQ@mail.gmail.com>
Subject: Re: [PATCH] http: honnor empty http.proxy option to bypass proxy
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2017 at 7:33 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 10, 2017 at 06:15:56PM +0300, Sergey Ryazanov wrote:
>> Curl distinguish between empty proxy address and NULL proxy address. In
>> the first case it completly disable proxy usage, but if proxy address
>> option is NULL then curl attempt to determine proxy address from
>> http_proxy environment variable.
>>
>> According to documentation, if http.proxy configured to empty string
>> then git should bypass proxy and connects to the server directly:
>>
>>     export http_proxy=http://network-proxy/
>>     cd ~/foobar-project
>>     git config remote.origin.proxy ""
>>     git fetch
>>
>> Previously, proxy host was configured by one line:
>>
>>     curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
>>
>> Commit 372370f (http: use credential API to handle proxy auth...) parses
>> proxy option, extracts proxy host address and additionaly updates curl
>> configuration:
>>
>>     credential_from_url(&proxy_auth, curl_http_proxy);
>>     curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>>
>> But if proxy option is empty then proxy host field become NULL this
>> force curl to fallback to proxy configuration detection from
>> environment. This caused empty http.proxy option not working any more.
>
> That makes sense. And if I understand correctly, this was a regression
> in 372370f;

Yep this regression introduced in 372370f

> before that we fed curl_http_proxy directly, and it was
> either NULL or not, depending on whether we had seen the config option.

To be more precisely, before the mentioned changeset was committed we
either set CURLOPT_PROXY option to some not NULL value (including
empty string) or do not touch it at all. There are additional test few
lines above the discussed code.

> It looks like we _still_ set CURLOPT_PROXY to curl_http_proxy, and then
> immediately afterward set it to proxy_auth.host. That should make the
> first one always a noop, I would think,

Yep, exactly.

> and it should be removed.
>
>
> But...
>
>> diff --git a/http.c b/http.c
>> index 96d84bb..bf0e709 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -861,7 +861,12 @@ static CURL *get_curl_handle(void)
>>                       strbuf_release(&url);
>>               }
>>
>> -             curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>> +             /*
>> +              * Avoid setting CURLOPT_PROXY to NULL if empty http.proxy
>> +              * option configured.
>> +              */
>> +             if (proxy_auth.host)
>> +                     curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host);
>
> Here that second one becomes conditional, and we rely on the earlier
> setting (but only sometimes). I would think this whole thing would be
> more clear if we dropped the first CURLOPT_PROXY call entirely, and just
> did:
>
>   /*
>    * If we parsed a null host from the URL, we must convert that
>    * back into an empty string so that curl knows we want no proxy at
>    * all (not to find the default).
>    */
>   curl_easy_setopt(result, CURLOPT_PROXY, proxy_auth.host ?
>                                           proxy_auth.host : "");
>

Empty http.proxy option value is an edge case. Until we started parse
proxy value itself, all the complexity was reside inside curl library.
Since 372370f commit we should take some care about this case in our
code too. This could be a tiny hack inside common code to make patch
less invasive. Or we could explicitly handle this case to make code
clear and avoid such regressions in the future.

I will make V2 with second approach to see which one is better.

-- 
Sergey
