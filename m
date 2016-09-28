Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E48BD20986
	for <e@80x24.org>; Wed, 28 Sep 2016 05:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbcI1FB4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Sep 2016 01:01:56 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:42203 "EHLO
        alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752209AbcI1FBy (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Sep 2016 01:01:54 -0400
X-AuditID: 12074412-1c3ff70000000931-83-57eb4eb4d602
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        by  (Symantec Messaging Gateway) with SMTP id EF.4C.02353.4BE4BE75; Wed, 28 Sep 2016 01:01:41 -0400 (EDT)
Received: from [192.168.69.190] (p579071D9.dip0.t-ipconnect.de [87.144.113.217])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id u8S51cfv030884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
        Wed, 28 Sep 2016 01:01:39 -0400
Subject: Re: thoughts on error passing, was Re: [PATCH 2/2] fsck: handle bad
 trees like other errors
To:     Jeff King <peff@peff.net>, David Turner <novalis@novalis.org>
References: <1474918365-10937-1-git-send-email-novalis@novalis.org>
 <1474918365-10937-3-git-send-email-novalis@novalis.org>
 <20160927052754.bs4frcfy4y7fey62@sigill.intra.peff.net>
 <1474989574.26902.7.camel@frank>
 <20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Message-ID: <06b1a3bc-18dc-bd9e-4200-a2eedbec7b97@alum.mit.edu>
Date:   Wed, 28 Sep 2016 07:01:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20160927191955.mympqgylrxhkp24n@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsUixO6iqLvV73W4wf2Zxhbz5/9it+i60s1k
        seTha2aLHy09zA4sHl3tR9g8nvXuYfR48Womm8fnTXIBLFFcNimpOZllqUX6dglcGSvbt7EV
        zOKuWPh0PVMD4132LkZODgkBE4lXF3qZuhi5OIQEtjJKzJ1+gQ3CucAksfXZa7AqYYE0ib3f
        JjKB2CICjhKbTndAdUxhkjixt4MRJMEsYCOx7c8LMJtNQFdiUU8zWAOvgL3Eu6X/mUFsFgFV
        iVdT/4PViAqESLQvWw9VIyhxcuYTFhCbU8BFYsfGD0wQM9Ul/sy7xAxhy0tsfzuHeQIj/ywk
        LbOQlM1CUraAkXkVo1xiTmmubm5iZk5xarJucXJiXl5qka6ZXm5miV5qSukmRkjoCu1gXH9S
        7hCjAAejEg8vQ9GrcCHWxLLiytxDjJIcTEqivBE8r8OF+JLyUyozEosz4otKc1KLDzFKcDAr
        ifBOcQPK8aYkVlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ8D7yBWoULEpN
        T61Iy8wpQUgzcXCCDOcBGv4apIa3uCAxtzgzHSJ/ilFRSpxXBCQhAJLIKM2D64WllleM4kCv
        CPMqAxONEA8wLcF1vwIazAQ0eOmJFyCDSxIRUlINjMnzq0JCv+4qE/1+p3HhoqW9/3tmefw+
        o3iUpST0Zd7jKQX5Wq0nFOL22QdeY8jVaL9gq/E++dft7ry3oZb6H3cU3jnZ8a5QgjG4qo/5
        vrnnNaeXjbcvFS83bvpitemO0QKO3tMrpz0TubDzqeYpqbbPJYK8p+9YN/z0z5jkX8o/n7Fe
        kedFrRJLcUaioRZzUXEiAAezg+UIAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/27/2016 09:19 PM, Jeff King wrote:
> [...]
> I'm going to ramble for a minute, and I don't think it's worth exploring
> for this patch series in particular, so feel free to ignore me.
> 
> I think this error concept could be extended fairly elegantly with
> something like:
> 
>   typedef void (*err_fn)(void *, const char *fmt, va_list ap)
>   struct error_context {
>         err_fn fn;
>         void *data;
>   };
> 
>   int report_error(struct error_context *err, const char *fmt, ...)
>   {
>         if (err->fn) {
>                 va_list ap;
>                 va_start(ap, fmt);
>                 err->fn(err->data, fmt, ap);
>                 va_end(ap);
>         }
>         return -1;
>   }

I like this idea. It's nicely flexible (more so than the `struct strbuf
*err` that is currently used for reference transactions) without being
cumbersome.

> Then low-level functions just take a context and do:
> 
>   return report_error(&err, "some error: %s", foo);
> 
> And then the callers would pick one of a few generic error contexts:
> 
>   - passing NULL silences the errors
> 
>   - a global for chaining to error, like:
> 
>        struct error_context print_errors = {
>           error, /* actually a wrapper to handle va_list and NULL data */
>           NULL
>        };

There could also be a global for chaining to `warn()` or `die()`.

> [...]

Michael

