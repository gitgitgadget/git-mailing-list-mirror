Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2FC971FAE2
	for <e@80x24.org>; Mon, 26 Feb 2018 10:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752275AbeBZKXN (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 05:23:13 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:35188 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeBZKXN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 05:23:13 -0500
Received: by mail-it0-f51.google.com with SMTP id v194so10411383itb.0
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 02:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HquweXzso2RNvcjovCt2cKVYMponp3xrVnRbUP6uPk0=;
        b=p4ZHdQ9/S+3oErhGC3FPRHPGpMj28mrGKsKcKBI31u1T/3UAgPyJR37shVPvudQZCK
         6KWbVM7rAGXzeE9mwHGLp9559In8orQKDJjLBNLWea9/ftGpxaPaGaYir27yYu/e4NlP
         glsviO4C3T4nNTnzfNB6rZBMCFLVl++z6wJ9a2f3eErwi2K5smnJYHjr8bLUoK2AF8eV
         JLp4RBJWkko6d/ts3HezRvTOGJPnuGISJY0iJT282KyBgXw2WVM06d1PEOyr0yS3Nw5f
         LYOtkWeDivXGAXk5oA7sBM31Eki+VB6JpEdgeveVwyfPBljNhYJhot+3xk6uFYRnO8i9
         myoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HquweXzso2RNvcjovCt2cKVYMponp3xrVnRbUP6uPk0=;
        b=V0DW8GSSq0pjjooVfNaTG1FaK6DmItDe+ka1ZczDyOUjfY6wfGqPXr4O/23kxwvWL1
         bE+YsTf6CmAv899MnEjRIDbNRAD4cjNCslJSw+Px2EgtOLcWF/EzE6k627DTpZuy5Q7u
         sCfOsEaTlDQJUJZ/zVvK0rqMwK9POp9hBNvyVD2rtn2JRwqDJRkPUKiutu8/R0wLZ3tK
         L7+jwujCtvzr/SXvK7KMHWlPjAGZ5hrfigW1E1jSDspmzz961VtY8PtwgbPI2F6orJBM
         0Q/J13FQA3HbOAZbGIqFEXJydnZh7WOETLHmJNI+xWUT/8jn7ZvzXqb05dUXNRVhWuOG
         yKmg==
X-Gm-Message-State: APf1xPAZ/HM85b6f3zb/+eUjROycsiy3rd/N8mB/AF53Ri5kGJ7llFdI
        77AVFCZdpFFZnHdPjltQb7E4lTT8ka0W+Xva82eOwFgd
X-Google-Smtp-Source: AH8x224gZmvg6Wiv5Bb+qknm7g2AICCHTByhccm+X4ItraYpKFca6QJAdrI5gj/am5zwKXkjJ51o35upTF4ncnEjhKo=
X-Received: by 10.36.249.203 with SMTP id l194mr12054652ith.81.1519640590925;
 Mon, 26 Feb 2018 02:23:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.206.20 with HTTP; Mon, 26 Feb 2018 02:23:10 -0800 (PST)
In-Reply-To: <20180226095311.GA14831@sigill.intra.peff.net>
References: <CAP8UFD23z9YDukO=O+cK=o_0DLcxbkXWzp4rCA1kRXGTZ-TMcQ@mail.gmail.com>
 <20180226095311.GA14831@sigill.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 26 Feb 2018 11:23:10 +0100
Message-ID: <CAP8UFD01wkpNuXSHxQTETi3+tWBM0E=iYXQeT2r7tGs=2Yq2EA@mail.gmail.com>
Subject: Re: Use of uninitialised value of size 8 in sha1_name.c
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 10:53 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Feb 26, 2018 at 10:04:22AM +0100, Christian Couder wrote:
>
>> ==21455== Use of uninitialised value of size 8
>> ==21455==    at 0x2D2A73: get_hex_char_from_oid (sha1_name.c:492)
>> ==21455==    by 0x2D2AFE: extend_abbrev_len (sha1_name.c:502)
>> ==21455==    by 0x2D2C3D: find_abbrev_len_for_pack (sha1_name.c:551)
>> ==21455==    by 0x2D2CFF: find_abbrev_len_packed (sha1_name.c:569)
>> ==21455==    by 0x2D2E12: find_unique_abbrev_r (sha1_name.c:608)
>> ==21455==    by 0x2DCB66: strbuf_add_unique_abbrev (strbuf.c:877)
>> ==21455==    by 0x14F7CE: update_local_ref (fetch.c:700)
>> ==21455==    by 0x1500CF: store_updated_refs (fetch.c:871)
>> ==21455==    by 0x15035B: fetch_refs (fetch.c:932)
>> ==21455==    by 0x150CF8: do_fetch (fetch.c:1146)
>> ==21455==    by 0x1515AB: fetch_one (fetch.c:1370)
>> ==21455==    by 0x151A1D: cmd_fetch (fetch.c:1457)
>> ==21455==  Uninitialised value was created by a stack allocation
>> ==21455==    at 0x2D2B2E: find_abbrev_len_for_pack (sha1_name.c:513)
>> ==21455==
>>
>> A quick git blame seems to point to 0e87b85683 (sha1_name: minimize
>> OID comparisons during disambiguation, 2017-10-12).
>>
>> It is difficult to tell for sure though as t5616-partial-clone.sh was
>> added after that commit.
>
> I think that commit is to blame, though the error isn't exactly where
> that stack trace puts it. Try this:
>
> diff --git a/sha1_name.c b/sha1_name.c
> index 611c7d24dd..6f7f36436f 100644
> --- a/sha1_name.c
> +++ b/sha1_name.c
> @@ -547,7 +547,10 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
>          */
>         mad->init_len = 0;
>         if (!match) {
> -               nth_packed_object_oid(&oid, p, first);
> +               warning("p->num_objects = %u, first = %u",
> +                       p->num_objects, first);
> +               if (!nth_packed_object_oid(&oid, p, first))
> +                       die("oops!");
>                 extend_abbrev_len(&oid, mad);
>         } else if (first < num - 1) {
>                 nth_packed_object_oid(&oid, p, first + 1);
>
> I get failures all over the test suite, like this:
>
>   warning: p->num_objects = 4, first = 3
>   warning: p->num_objects = 8, first = 6
>   warning: p->num_objects = 10, first = 0
>   warning: p->num_objects = 4, first = 0
>   warning: p->num_objects = 8, first = 0
>   warning: p->num_objects = 10, first = 10
>   fatal: oops!

Yeah, I tried to t5601-clone.sh with --valgrind and I also get one
error (the same "Uninitialised value" error actually).

> Any time the abbreviated hex would go after the last object in the pack,
> then first==p->num_objects, and nth_packed_object_oid() will fail. That
> leaves uninitialized data in "oid", which is what valgrind complains
> about when we examine it in extend_abbrev_len().
>
> Most of the time the code behaves correctly anyway, because the
> uninitialized bytes are unlikely to match up with our hex and extend the
> length. Probably we just need to detect that case and skip the call to
> extend_abbrev_len() altogether.

Yeah, something like:

diff --git a/sha1_name.c b/sha1_name.c
index 611c7d24dd..a041d8d24f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -547,15 +547,15 @@ static void find_abbrev_len_for_pack(struct packed_git *p,
         */
        mad->init_len = 0;
        if (!match) {
-               nth_packed_object_oid(&oid, p, first);
-               extend_abbrev_len(&oid, mad);
+               if (nth_packed_object_oid(&oid, p, first))
+                       extend_abbrev_len(&oid, mad);
        } else if (first < num - 1) {
-               nth_packed_object_oid(&oid, p, first + 1);
-               extend_abbrev_len(&oid, mad);
+               if (nth_packed_object_oid(&oid, p, first + 1))
+                       extend_abbrev_len(&oid, mad);
        }
        if (first > 0) {
-               nth_packed_object_oid(&oid, p, first - 1);
-               extend_abbrev_len(&oid, mad);
+               if (nth_packed_object_oid(&oid, p, first - 1))
+                       extend_abbrev_len(&oid, mad);
        }
        mad->init_len = mad->cur_len;
 }

seems to prevent valgrind from complaining when running t5616-partial-clone.sh.
