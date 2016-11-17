Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6377E1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 22:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbcKQW2f (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 17:28:35 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33952 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752209AbcKQW2e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 17:28:34 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so241385768qke.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 14:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T+gyiyYrv41A5MMuKCLlUc7nU9NpSrYQ0dOvrAMoQb8=;
        b=Dqe7To8j9Y5/5DjDlL6lONsKOAUTqNEvVnKS0hghNWGgJYAJxsBASzpZBzIDaA5V+9
         sC8fnBvfKPHFSRRYsKflOWnOYD9IT+sejRzXFNFLMyt/zmex01fDIyljBC+ej2c8Rijd
         2mwlrQuFdCKgwBqd5NUMfZnX0Tou5dFFDP/odIVTVyEEbH1VcbAy4eKJJ+FqGjKcQdHB
         COlGsNkhzkGz7c6wevrIb3pe7LFGxIpTdlf/0JQPdNxKaDUkA8OBM+ZKu0Glww+11RxR
         c8kwoB+73gzS1bQsjKfeL+RBp9PnIO79gwtk8/9AWRPVDX3M0obPpr4Fu3AxBvMQXN4W
         71qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T+gyiyYrv41A5MMuKCLlUc7nU9NpSrYQ0dOvrAMoQb8=;
        b=iSy+QENQRxPgz9VWT3+R0odx/ObMMofKqkvLEqh6Xrkh/isV4U22xjswQfFD2oMKQV
         GXhrQ+Cuw0k07cdSbmMR77NyN3Igo8qUzmk8CJaa023EBviF2wrtSkCgIQTLUutdqgqr
         K3rJxhT9zmZOTc1lBgJjmXzeirJQQSolIsVV5XYtQfUSYXIiPjBVwNJxS16szI5MLbI2
         yO5rHTAMp8EayhZsOH7CRJ4tX5s91Ep/n5LPNlu5F0CRMsIDF6PQho/QYQ0uAIcgHrBY
         PKWA1d6ZSbRXnxWCMYvr1IWOmP5ZuS7lBICRzFz2FM/s83nnyMpiQeTcnCDNkUEGj/6t
         xUVA==
X-Gm-Message-State: AKaTC00QYipV4/ARraCa+/hMFE7pWwdR3S71mRZBQUfUvnu5TfdYnk965Ww4bpY+2byuBobUMy9Smf/LD/JZUzQ5
X-Received: by 10.55.105.129 with SMTP id e123mr6943973qkc.173.1479421713232;
 Thu, 17 Nov 2016 14:28:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 14:28:32 -0800 (PST)
In-Reply-To: <20161117111337.GD39230@book.hvoigt.net>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-9-sbeller@google.com>
 <20161117111337.GD39230@book.hvoigt.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 14:28:32 -0800
Message-ID: <CAGZ79kZLqVg=FTiF+tOCSrqca_5zQoZHqGswJ0u+9u_kdmMaig@mail.gmail.com>
Subject: Re: [PATCH 08/16] update submodules: add depopulate_submodule
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Martin Fick <mogulguy10@gmail.com>,
        David Turner <David.Turner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 17, 2016 at 3:13 AM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> On Tue, Nov 15, 2016 at 03:06:43PM -0800, Stefan Beller wrote:
>> diff --git a/cache.h b/cache.h
>> index a50a61a..65c47e4 100644
>> --- a/cache.h
>> +++ b/cache.h
>> @@ -2018,4 +2018,6 @@ void sleep_millisec(int millisec);
>>   */
>>  void safe_create_dir(const char *dir, int share);
>>
>> +void remove_subtree_or_die(const char *path);
>
> It seems that it is called remove_subtree already internally but can we
> maybe change that name? The term 'subtree' refers to something else[1] for
> me.

Doh, right.

> Maybe just: remove_directory() would make it also clear that there
> is no special internal git datatype meant by that but just a directory
> in the filesystem.

I'll go with `remove_directory_or_die` for now.

>
>> +
>>  #endif /* CACHE_H */
>> diff --git a/entry.c b/entry.c
>> index c6eea24..019826b 100644
>> --- a/entry.c
>> +++ b/entry.c
>> @@ -73,6 +73,14 @@ static void remove_subtree(struct strbuf *path)
>>               die_errno("cannot rmdir '%s'", path->buf);
>>  }
>>
>> +void remove_subtree_or_die(const char *path)
>> +{
>> +     struct strbuf sb = STRBUF_INIT;
>> +     strbuf_addstr(&sb, path);
>> +     remove_subtree(&sb);
>> +     strbuf_release(&sb);
>> +}
>
> Why are you exposing it with const char * instead of strbuf? We get
> unnecessary conversions in case a caller already has a strbuf ready.
> Just in case later code also wants to use it.

For the cleanliness of API design. (I thought `void remove(char *dir)` is
the closest approximation of `rm -rf $1`)

I'll use a strbuf instead.

Thanks!
Stefan
