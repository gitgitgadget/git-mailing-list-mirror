Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CFAE2070F
	for <e@80x24.org>; Mon, 19 Sep 2016 18:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932388AbcISSUX (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 14:20:23 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36522 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932237AbcISSUW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 14:20:22 -0400
Received: by mail-wm0-f46.google.com with SMTP id w84so90645313wmg.1
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 11:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ND9+T3qGvEcSkr1yLuxeiu/TuBckkl1AlAZjGFm5Ys0=;
        b=j+fafezgN4Vbn/0Dr1zWtMzCnOrUXn6JrwWyAxkxXWKmOaHtr2o+pGuv6PNh31feLC
         h5duiIMyc6hNIkrHFb7OFEvHFOO4FlNFUXhGf69q0SYXMuQQB7wWnzFB2On3uzpPLyL6
         tSSh8L/5pfMrcKGFr1Am8kB6vWclKVIfA9ZpEvKFCYhWzWc6z6HbA0OqYhAjZ+Kta+4+
         ZbCr7IxZukZQrMyw1qQ3sJRqh1K+dWvFuXBf2mWEBFGcnvQsDeYwaUaJoJDe/EY3yqqO
         JnveN0hu9T7XI1hgt0ub+6W4MPJPAv7hraDh1lx2Ska1rM9QseJvEhIwdXFC52O4CaBJ
         ugYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ND9+T3qGvEcSkr1yLuxeiu/TuBckkl1AlAZjGFm5Ys0=;
        b=bGW+p//sVxLtJjurQ6SqkgycgUDumtEOfWfn1L8fs69cXaZQ2SyXM+WLPsqTw+S7tS
         cr4BcrwUVoLilcg5+OEZpFuM0Ggaixb95tAQ7ZuByU+3i+3eVmG7FdWrY9HqkGnolEev
         iX6SAUg0nYp0u2kff9F7Hzsje1NxsZZogIRhQ69RvP6L8nsWtdX/6qb+UYYGn+94KWMl
         v054ljp8mfg/3PWAizBbJJyjlnT/pdkbR0XJhNNuQ1b2bR1YhEcqBU//+kv7Kkkdx91/
         +Z+S6GZFQHzGseBYrtBUWWKRGA/3H+pzcIlpVTnh7XRwzwUURzFbgHAX31Nxwc7/OixS
         bavA==
X-Gm-Message-State: AE9vXwMLrTax6op+7OjYW4pP56JG2FWmGXaCciZPIQtfP6mCq6xSu6Bphfj+NxLwcGuWfUzxW54alpUgvDaRABH5
X-Received: by 10.194.164.102 with SMTP id yp6mr24757157wjb.50.1474309220321;
 Mon, 19 Sep 2016 11:20:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.69.25 with HTTP; Mon, 19 Sep 2016 11:20:19 -0700 (PDT)
In-Reply-To: <xmqq1t0fg417.fsf@gitster.mtv.corp.google.com>
References: <CAKoko1pewoxD4=_9M45pchdDg03K8fc73raJOsf4A+=KKw_EMw@mail.gmail.com>
 <1474073981-96620-1-git-send-email-bmwill@google.com> <xmqqtwdfgpd0.fsf@gitster.mtv.corp.google.com>
 <CAKoko1r6cfv-2HVCJPgGbXyCVe-wdUBS+2nXtaTHO3jshVg8MA@mail.gmail.com>
 <xmqqvaxrg6zt.fsf@gitster.mtv.corp.google.com> <CAKoko1r_WATxJzxQrQW2VBkhuKquv=yQv6sB_eCMgH6qavS__Q@mail.gmail.com>
 <xmqq1t0fg417.fsf@gitster.mtv.corp.google.com>
From:   Brandon Williams <bmwill@google.com>
Date:   Mon, 19 Sep 2016 11:20:19 -0700
Message-ID: <CAKoko1oSvBF3=-hvSGVMQYpZkUvnwAEYg=U-g8927F6dt4Q8mA@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add pathspec matching for submodules
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 11:04 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Brandon Williams <bmwill@google.com> writes:
>
>>> Again, what do we have in "name" and "item" at this point?  If we
>>> have a submodule at "sub/" and we are checking a pathspec element
>>> "sub/dir1/*", what is the non-wildcard part of the pathspec and what
>>> is the "string"?  Aren't they "sub/dir1/" and "sub/" respectively,
>>> which would not pass ps_strncmp() and produce a (false) negative?
>>
>> item will be the pathspec_item struct that we are trying to match against.
>
> ... which would mean "sub/dir1/" in the above example (which is
> followed by '*' that is wildcard).
>
>> name will be the file we are trying to match, which should already have the
>> 'prefix' cut off (this is the prefix that is used as an optimization
>> in the common
>> case, which isn't used in the submodule case).
>
> ... which would be "sub/" in the above example, because we disable
> the common-prefix optimization.
>
> So in short, the answer to the last questions in the first quoted
> paragraph are yes, yes, and "no they do not pass ps_strncmp()"?

Yes in that case it wouldn't have passed ps_strncmp()...but we should have never
made it there in the first place due to a piece of logic in match_pathspec_item:

@@ -283,6 +308,24 @@ static int match_pathspec_item(const struct
pathspec_item *item, int prefix,
                         item->nowildcard_len - prefix))
                return MATCHED_FNMATCH;

+       /* Perform checks to see if "name" is a super set of the pathspec */
+       if (flags & DO_MATCH_SUBMODULE) {
+               int matched = 0;
+
+               /* Check if the name is a literal prefix of the pathspec */
+               if ((item->match[namelen] == '/') &&
+                   !ps_strncmp(item, match, name, namelen)) {
+                       matched = MATCHED_RECURSIVELY;
+               /* Check if the name wildmatches to the pathspec */
+               } else if (item->nowildcard_len < item->len &&
+                          !prefix_fnmatch(item, match, name,
+                                          item->nowildcard_len - prefix)) {
+                       matched = MATCHED_FNMATCH;
+               }
+
+               return matched;
+       }

Perhaps the call structure and code organization could be changes a bit to make
a little more sense.
