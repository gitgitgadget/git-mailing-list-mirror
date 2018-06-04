Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B45F1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 16:19:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeFDQTm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 12:19:42 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:41596 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbeFDQTl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 12:19:41 -0400
Received: by mail-io0-f194.google.com with SMTP id t5-v6so26143073ioa.8
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 09:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=47R7gl8+ophDCZjZX0ld5uRzpARnKhtVQdPwLLuYplQ=;
        b=EemEpN/CghWk/7AP5xLu7q567L3EerE7IPDui1yO+L+JqbTXbBaXzTRL3lIEJwTXN9
         PimXCPkVcFcJDDuT1eY5AwDtH0R1Oor8se9hTLRljxdwo2MMu713IgJZ+n+UE8aYVluz
         0bBdKmii/jQNvzmjuffbLcRmvXJHzbnOOwkFuJIzbtXAEJUxk9sWE4KHGqT/DpIfhRmg
         2FR6Fb3Vwq8BuULSBtdX1m8GZDZW2Jfx0j2h/lMPkt4w7R/GEFka4Mj3+sScltYgxyqq
         NZGx+Isacm5vni8gv5A95yA+2z54nUCE+4VNf2R9XWxM3CZBmhLkYeMvCqoDEaD4xwBu
         Gv1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=47R7gl8+ophDCZjZX0ld5uRzpARnKhtVQdPwLLuYplQ=;
        b=p0qpSwrDIi01JtxT9y3o6zSA/OcY01iQPnIx/PA3IikW9jpq2cUsRldyJlnavbaXS8
         IJ5J58dBQubEskkEOZ3EMtGl7TrHkyT50EUWhd4J940QUmuQ6tEwMUbFL1TAlcTUOYQL
         D45aLcel+27BfF1BJEKOOx68Eey+xE3JSxxvcQdN+fEH8/H8YAFZnrQaH+l9kQzePoqL
         2HMZWMOJWASD79bpjD+BOU2rBmX88qKUZUPNNQUwQofYA3sHmf4nU1Q4bc0jCZiq+riE
         7DUkYjT3uUWYo/xH3X020KJZnDfmkUEwfzfNtHIpJuA46w/30F7xgaT23B6rv3NcfTZ5
         g+fQ==
X-Gm-Message-State: APt69E1fjA1gyvg1+aTroptc74FazveXqk6mVoUg9LMvmckiqZjYcS7/
        NE/hAIj8fLB/kI/c5P6pYpv2q7EB74ZrkbtrJpQ=
X-Google-Smtp-Source: ADUXVKIRA5hPY8gnxkzxfBLd4l6W3hvHFtV18PlIWYbWvVnQs85aqHciP9bJ7HjoP7s5X6wP0WGiJR+d+H54B8k888c=
X-Received: by 2002:a6b:380b:: with SMTP id f11-v6mr10946104ioa.105.1528129180219;
 Mon, 04 Jun 2018 09:19:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:278d:0:0:0:0:0 with HTTP; Mon, 4 Jun 2018 09:18:59 -0700 (PDT)
In-Reply-To: <20180604144747.GA27655@sigill.intra.peff.net>
References: <20180604122635.95342-1-lars.schneider@autodesk.com> <20180604144747.GA27655@sigill.intra.peff.net>
From:   Martin-Louis Bright <mlbright@gmail.com>
Date:   Mon, 4 Jun 2018 12:18:59 -0400
Message-ID: <CAG2PGsoHajiYbS29F2nD+_0i2b4+Min5NR3tQYDb3MH=BW=0Aw@mail.gmail.com>
Subject: Re: [RFC PATCH v1] http: add http.keepRejectedCredentials config
To:     Jeff King <peff@peff.net>
Cc:     lars.schneider@autodesk.com, git@vger.kernel.org,
        sandals@crustytoothpaste.net, Johannes.Schindelin@gmx.de,
        pstodulk@redhat.com, nickh@reactrix.com,
        jeremy.wyman@microsoft.com,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why must the credentials must be deleted after receiving the 401 (or
any) error? What's the rationale for this?

On Mon, Jun 4, 2018 at 10:47 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 04, 2018 at 05:26:35AM -0700, lars.schneider@autodesk.com wrote:
>
>> From: Lars Schneider <larsxschneider@gmail.com>
>>
>> If a Git HTTP server responds with 401 or 407, then Git tells the
>> credential helper to reject and delete the credentials. In general
>> this is good.
>>
>> However, in certain automation environments it is not desired to remove
>> credentials automatically. This is in particular the case if credentials
>> are only invalid temporarily (e.g. because of problems in the server's
>> authentication backend).
>>
>> Therefore, add the config "http.keepRejectedCredentials" which tells
>> Git to keep invalid credentials if set to "true".
>
> It seems like those servers should be returning a value besides "401" if
> it's a temporary error.
>
> But alas, we live in the real world, and your patch seems like a pretty
> sensible workaround for clients. This could be done at the helper layer,
> but I think in practice doing it here is going to be a lot more
> convenient (and doesn't preclude helpers having their own logic if
> people care to extend them in that direction).
>
>> It was considered to disable the credential deletion in credential.c
>> directly. This approach was not chosen as it could be confusing to
>> other callers of credential_reject() if the function does not do what
>> its name says (e.g. in imap-send.c).
>
> Yeah, I think "git credential" relies on that code, too, and you
> probably should be able to manually forget a credential at that plumbing
> layer.
>
>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index ab641bf5a9..184aee8dbc 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1997,6 +1997,12 @@ http.emptyAuth::
>>       a username in the URL, as libcurl normally requires a username for
>>       authentication.
>>
>> +http.keepRejectedCredentials::
>> +     Keep credentials in the credential helper that a Git server responded
>> +     to with 401 (unauthorized) or 407 (proxy authentication required).
>> +     This can be useful in automation environments where credentials might
>> +     become temporarily invalid. The default is `false`.
>
> Looks good.
>
>>  http.delegation::
>>       Control GSSAPI credential delegation. The delegation is disabled
>>       by default in libcurl since version 7.21.7. Set parameter to tell
>> diff --git a/http.c b/http.c
>> index b4bfbceaeb..ff6932813f 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -138,6 +138,7 @@ static int ssl_cert_password_required;
>>  #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
>>  static unsigned long http_auth_methods = CURLAUTH_ANY;
>>  static int http_auth_methods_restricted;
>> +static int keep_rejected_credentials = 0;
>
> Minor nit, but we usually skip the redundant "= 0" for BSS variables.
>
>> @@ -403,6 +404,11 @@ static int http_options(const char *var, const char *value, void *cb)
>>               return 0;
>>       }
>>
>> +     if (!strcmp("http.keeprejectedcredentials", var)) {
>> +             keep_rejected_credentials = git_config_bool(var, value);
>> +             return 0;
>> +     }
>> +
>>       /* Fall back on the default ones */
>>       return git_default_config(var, value, cb);
>>  }
>> @@ -1471,7 +1477,8 @@ static int handle_curl_result(struct slot_results *results)
>>               return HTTP_MISSING_TARGET;
>>       else if (results->http_code == 401) {
>>               if (http_auth.username && http_auth.password) {
>> -                     credential_reject(&http_auth);
>> +                     if (!keep_rejected_credentials)
>> +                             credential_reject(&http_auth);
>
> The rest of the patch looks good.
>
> It's possible we'd eventually want a similar feature for other
> protocols, like IMAP. And that we'd in the long run prefer to have a
> single credential.keepRejected that covers them all. Or maybe not. Given
> that this is kind of a workaround, people might ultimately want
> protocol-specific options. So I'm happy to start with "http" for now and
> deal with other protocols down the road (if it's even necessary).
>
> Some scripts that use "git credential" may want to support this config
> option, too (I'm thinking of git-remote-mediawiki, which I believe
> uses it for http requests). But those can be added one by one to the
> porcelain scripts.
>
> So modulo the minor "= 0" nit, this all looks good to me.
>
> -Peff
