Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B62931F404
	for <e@80x24.org>; Tue, 12 Dec 2017 00:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751729AbdLLAVZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Dec 2017 19:21:25 -0500
Received: from mail-qt0-f180.google.com ([209.85.216.180]:34121 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751612AbdLLAVY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 19:21:24 -0500
Received: by mail-qt0-f180.google.com with SMTP id 33so43357680qtv.1
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 16:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1EhIJShZBJe0kl3Vc920NE0kik0+OQlHtY+0P/UqBlc=;
        b=rcCiH1uhyb16/3F3Ka4ACYKcVwlQuG91F7QN6er1qRZp49NpfpcFTRZvOT4WJcpZnc
         XPJQgYd72nKzCiZGH0Vo7r5QsdkkhA12D/HCrnfBVNjCWjUla3m10HI6derM+qLrt8P+
         bfudJ8EntOvncADsxlrN8gU5JfMpGcaEkkP3HxAPUSP8Gt2x2JQ4SZpxlOXTc7JU4aks
         jwXmecMLuqlhBNhPaCWHomJF6/eZj97hGCMWIh/D03/+N0KQ+WrQeJEg1VGvnE1VOnhz
         bu+bIRMA1rtf0ej++DyLfvWf53JozzzeVlwjRdxpjjB1qL22/i/A7/qFVJUz/9v1taqo
         ycXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1EhIJShZBJe0kl3Vc920NE0kik0+OQlHtY+0P/UqBlc=;
        b=bdGMvTRLrKdpWZ+A5AYXk+qP4g0L+9an3JREvse4v8W6iXncjSZSFb+hA54NUNG6JF
         Z8qh20oxhiUzKeFb5Kb3uNiHYjun1uHJwLHi2fVk/sSvfj+lZR9V67YYlsXVb7Ixxv6y
         OFW2hDkQOJunYKBJswCASaNRPUX7akSARpwPHrx/OxL7eo9190U00/8NE0bAg6Q1DRoS
         /mYxcZ0svuld/Bny0a5tZeb8n0IsNeColkWuz428yLqwWbUI60ibofoaD+DUBNzDdl4l
         0Kv1CdhfU6tvRQ8xYyvVvH9Fi+w+FaHlORtuh1odYLi/t64GHro8RbkBtyKLTi/MG9fR
         x2VQ==
X-Gm-Message-State: AKGB3mIzCNChhN+hXh3CtBnQBRNrHHUzJJon5jrHPNZ4bgpsbrHPYRaO
        U83J87bi2nfFs13bbIk54pmhy/oKy+yOMHtu4Bs52g==
X-Google-Smtp-Source: ACJfBoul85Dt35Y7Q2Khiaa+jOayRy/o5VWRLdVTMNxnBy/1QBsIhoIEWMSpDWZo2szQsLjdVxYsoIS5mntSU200lV0=
X-Received: by 10.55.107.65 with SMTP id g62mr3046078qkc.295.1513038083915;
 Mon, 11 Dec 2017 16:21:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Mon, 11 Dec 2017 16:21:23 -0800 (PST)
In-Reply-To: <xmqqr2s04zxw.fsf@gitster.mtv.corp.google.com>
References: <20171208002447.20261-1-sbeller@google.com> <20171211195835.57057-1-sbeller@google.com>
 <20171211195835.57057-2-sbeller@google.com> <xmqqr2s04zxw.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Dec 2017 16:21:23 -0800
Message-ID: <CAGZ79kaJgCchQKcRMkW-cjRmx_7eYQDqLs5GgDOgLEb1H=w-0g@mail.gmail.com>
Subject: Re: [PATCH 1/1] diffcore: add a filter to find a specific blob
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 11, 2017 at 3:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> the information to what is shown. For example:
>>
>>   $ ./git log --oneline --blobfind=v2.0.0:Makefile
>>   b2feb64309 Revert the whole "ask curl-config" topic for now
>>   47fbfded53 i18n: only extract comments marked with "TRANSLATORS:"
>
> This part is a bit stale???

fixed in the next reroll :(

>> +--find-object=<object-id>::
>> +     Restrict the output such that one side of the diff
>> +     matches the given object id. The object can be a blob,
>> +     or gitlink entry.
>
> OK.  In principle you should also be able to find a tree, but I do
> not now how useful it would be.  Extending it to gitlink, which is
> another kind of leaf node in the reachability DAG, does make tons of
> sense---it's a no brainer that I feel ashamed not to have thought of
> myself ;-)

The current patch under discussion doesn't find trees, though.
Hence the documentation is accurate saying that only blobs and
gitlinks work.

>
>> +LIB_OBJS += diffcore-oidfind.o
>
> Just to nitpick, but "blobfind" was to find "blob", and if you are
> extending it to find any "object", then that should be "objfind".
> "oid" is _A_ way to refer to an object (i.e. the _name_ of it), and
> name is *not* the same as the thing the name refers to, so...

obj-find sounds good.

>
>> +static int parse_oidfind_opt(struct diff_options *opt, const char *arg)
>> +{
>> +     struct object_id oid;
>> +
>> +     /* We don't even need to have the object, any oid works. */
>> +     if (get_oid_blob(arg, &oid))
>> +             return error("unable to resolve '%s'", arg);
>
> Should this still be get_oid_blob(), or should it be less specific
> to blobs?

We could check if it is a tree/commit and die as they are not
being handled correctly.
