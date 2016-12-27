Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76DA51FF76
	for <e@80x24.org>; Tue, 27 Dec 2016 00:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755611AbcL0A1B (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 19:27:01 -0500
Received: from mail-wj0-f195.google.com ([209.85.210.195]:34170 "EHLO
        mail-wj0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755569AbcL0A1B (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 19:27:01 -0500
Received: by mail-wj0-f195.google.com with SMTP id qs7so12149316wjc.1
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 16:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=7vcpCG59OzROc6xqlX30oUToNt1flzRe1indBAQoLgs=;
        b=OMD23LhRQm26lxeuzrkC6KwsCw3/3N187qCKTeCyWnKhNqi7rRgC1+6Yad5HZ2E1VS
         lt7g1Z91ZviBxEk8DYT/7JcXTpSlb9mwK0DJYEGsV5Vnernoq5Ua0701vJ28fQnO9aL4
         ez4MVCH2LAMMUrEZTk9pzkXwINHsudTvK1zhEjLxzsiY98NxfEJPfXfl9yr/FFq5AmVr
         NCcvvVubShRaKV62FeaOIkWJ9RGS99OYc0FPE3ajkZ79w276Kg1zINOSGLJIMZNRHJzW
         3tSFK53yZvunSCd13wH3xGX6x1sbbj8f7tcldbMt7GLrU7TtY4iM/OhxqrP7dr8HogQR
         5fSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=7vcpCG59OzROc6xqlX30oUToNt1flzRe1indBAQoLgs=;
        b=prVK7j/DCgHGQ7+zxWKJNRWzoRaNT2+uBVKFY2AD2RAvW4HOhEeMW0Y14ohvHe8FYA
         TZbcewnoXKFUFLOY93yLGyaYQQglx2Ron8KwW08GOD/rLsa09Bo26o1GqXXBXkqzwltJ
         RsPoMx7YCQo6tqpEd7xoyydDz09SbDAFzK9kOvBN8OJP6E4A881jD8723drQPxF57Hcp
         srjU7Fn9n/WEbiVao1Vbyk45SMksWx7bG9CxQ13d7GdblZBHz3sASFwaIguLV1/sr4kV
         7mtk+flnXNmZw7hUXa7JIvapwYg5FKXq+mwWme0TO/M0eifNUyyjeHaSGOGeGgVa2X2o
         8TEQ==
X-Gm-Message-State: AIkVDXI7MbAKBoWpQc20h/OLx7FChgnm6GCFw0f8ljyXgqk3HiOx4jULCCh1Sf4ovI61BA==
X-Received: by 10.194.23.67 with SMTP id k3mr26574981wjf.103.1482798419050;
        Mon, 26 Dec 2016 16:26:59 -0800 (PST)
Received: from [192.168.5.102] ([87.116.181.175])
        by smtp.gmail.com with ESMTPSA id f76sm53567215wmd.15.2016.12.26.16.26.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Dec 2016 16:26:58 -0800 (PST)
Subject: Re: git-apply: warn/fail on *changed* end of line (eol) *only*?
To:     Junio C Hamano <gitster@pobox.com>
References: <ac97f925-d930-0592-0a2a-66c9218b1417@gmail.com>
 <xmqqvau7cqy1.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
Newsgroups: gmane.comp.version-control.git
From:   Igor Djordjevic BugA <igor.d.djordjevic@gmail.com>
Message-ID: <e08ebc36-1f1a-871d-53aa-b42770ace044@gmail.com>
Date:   Tue, 27 Dec 2016 01:26:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqvau7cqy1.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio, and thanks for sharing your thoughts.

You understood it pretty well, except the context "scope". Example does
show a single line change, and a single line old/new comparison, but
that is for simplicity sake of the initial example. What I was
discussing about was the whole patch "hunk" instead (mentioned inside
the part you quoted, too).

> But what if the patch was like this?
> 
>      1 <CRLF>
>     -3 <CRLF>
>     +three <CRLF>
>     +four <CRLF>
>      5 <CRLF>
> 
> Do you want to warn on "four <CRLF>" because it does not have any
> "previous" corresponding line?

No, because the old hunk (single - line) has <CRLF> line ending(s), the
same as the new hunk (both + lines), so effectively there is no end of
line change between old and new _hunks_, so no warning needed.

> Extending the thought further, which line do you want to warn and
> which line do you not want to, if the patch were like this instead?
> 
>      1 <CRLF>
>     -3 <CRLF>
>     +four <CRLF>
>     +three <CRLF>
>      5 <CRLF>

Again, no warnings here, same as described above.

> Extending this thought experiment further, you would realize that
> fundamentally the concept of "previous contents" has no sensible
> definition.

This one is interesting, and maybe arguable - I certainly don`t have
enough knowledge about the overall matter (Git heuristics for diff
creation, in terms of which parts get marked as "old" (-), and which as
"new" (+), which probably even depends on user defined settings)...

... BUT, the overall idea here seems rather simple (to me :P) - if *all*
removed lines inside the old hunk have the same line endings (<CRLF>,
for example), where there is *any* (at least one) added line inside the
new hunk that has a different line ending than the ones in the old hunk
(like <LF>), then warning or failure might be preferred (optionally,
at least), as it does seem like something fishy is going on.

I appreciate and understand a need for Git being able to know "correct"
line endings, but in case where the whole previous hunk (or the whole
file, even) has "incorrect" line endings (<CRLF>, as far as Git is
concerned, as in the given example), it seems more sensible to me for
Git to warn you about _that_ first, rather than keep silent and apply a
new hunk introducing <LF> line endings without you even knowing - heck,
maybe your core end of line setting is incorrect, indeed, so actually
having someone to let you know seems nice, before potentially corrupting
your file.

It felt like - "Hey, I do have a mean to know that your _whole file_
has incorrect line endings (as per my current settings), but I don`t
want to tell you, yet I`ll rather happily apply this patch which
introduces n lines with _correct_ line endings... So, now you still have
your whole incorrect file, but don`t worry, I fixed those n lines for
you behind your back, life is good, and you`re welcome."

Ok, I might be exaggerating, but it just doesn`t seem right, the end
result seems even worse - having "incorrect" and "correct" endings
silently mixed.

To prevent this, the most important question seems to be - do we have a
sensible way to tell "this is THE line ending of the old hunk (the only
line ending used)"?

And the worst case answer would probably be - you need to check the
whole (old) file, if all line endings are the same, that is THE line
ending you`ll use for comparison against line endings of the newly added
lines.

For the best case scenario, I don`t know enough of Git diff heuristics
to say if we would even be able to determine THE line endings based on
the old _hunk_ only, not to examine the whole old file.

_If_ we can find THE old hunk (or file) line endings, and patch
introduces different ones, then warn/fail option seems sensible...?

Of course, in case where old hunk/file already has mixed line endings
(like both <CRLF> and <LF>), we can either choose to warn right away (as
mixed lines endings are found already), or maybe even not warn at all,
as nothing actually changes in regards to line endings no matter which
one gets added, and we`re discussing "warn/fail on eol *change* only".

Otherwise, I agree about "previous contents" sensibility, especially in
the "blame" case, but this does seem a bit different... or does it?

Regards, BugA
