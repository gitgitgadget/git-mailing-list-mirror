Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6630202C9
	for <e@80x24.org>; Wed,  1 Mar 2017 00:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751487AbdCAABi (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 19:01:38 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:34793 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdB1X7y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 18:59:54 -0500
Received: by mail-io0-f176.google.com with SMTP id 90so20594573ios.1
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 15:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=vOv4SAMZfsyHh0R8fK60lnZPIzX8TXO0IQagY//goZc=;
        b=DuK8B4TfxecPHqfBRX+5jbJRcX79C4ggKC/PnwcGJFrPq3j6VT/f3vJUQhBhdGLqHF
         SDqv4J/l7lkPeFPcZQMMoHYiT22EXUeqRTm2Yj+JlgBZubBsY5LfYwWC6+A/kPajorml
         j7YuHnHA6OtWlZugGot+BVJGm8jQ3eBGy5xDMuvQTOddgOfjznRDa2dpLhLKo5DHkYSV
         JU0qGe3OGrS3H6e+zFuEYnFNZDhZtFHP8TGo5sGbQcho6oHVnZKnKFGT9fbjew3Z+RvO
         uQ01zYJJ94kL+r9o5P4gVG6mVb2/eoIYgO8H8z7oobC9wNhj47gpM3uwhRjhytrQs8mR
         DVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to;
        bh=vOv4SAMZfsyHh0R8fK60lnZPIzX8TXO0IQagY//goZc=;
        b=ZaSM0PdyzKeeTENJDOA4I7JRPQ3z3vaUmc9M8IdRrojv+fJFm8lAHEGFSjrUy2yLIn
         6ZMzyjTVBVs+6sq5mfueIUK0OuWNEsyL7UhXJiaETumT4Kf5t86xx3/MZJr7i9W5yZ2+
         5KQcW4540nJzfI0mlnUUeDZuEX+93Z7HZK8Bqua/cbpuKXsXWWD4FuCQnPjMdSJpTXoZ
         rwR1L+G3gUDmRyZ2pwgl/SeuPBzcXmKrYWdP5T2FHb1a60BEATwkgWHLfnttjAqG1yUT
         444Cn3tANXfIAgsNhJwerLre9zb6MfZTOC1R44xl1JzCev/RYZBx9Uqi9E3W+wldE8zf
         BgIg==
X-Gm-Message-State: AMke39kbtKDnkTYpGA3mUi4Z7C+X9qf8BK9Vmb6elb21ZjIFjGXKFxMytvrfCrJVYduXcmd+9bdBjbIxtJxGAQ==
X-Received: by 10.107.136.93 with SMTP id k90mr4791491iod.224.1488314301366;
 Tue, 28 Feb 2017 12:38:21 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.146.131 with HTTP; Tue, 28 Feb 2017 12:38:20 -0800 (PST)
In-Reply-To: <20170228201918.dpqrrijibdapemaf@genre.crustytoothpaste.net>
References: <CA+55aFxYs1zp2c-UPe8EfshNNOxRVxZ2H+ipsnG489NBsE+DLQ@mail.gmail.com>
 <xmqqvarujdmv.fsf@gitster.mtv.corp.google.com> <20170228201918.dpqrrijibdapemaf@genre.crustytoothpaste.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 28 Feb 2017 12:38:20 -0800
X-Google-Sender-Auth: aXZ9Np8jOP9Q5nTFFex2oEE5qfU
Message-ID: <CA+55aFxUrJW-uAA369deXc10jNkE+M71GVveaM=pz4rSHNaunw@mail.gmail.com>
Subject: Re: Typesafer git hash patch
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 12:19 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> The bigger issue is the assumptions in the code base that assume a given
> hash size.

Absolutely. And I think those are going to be the "real" patches.

I actually saw your status report about

  "After another 27 commits, I've got it down from 1244 to 1119."

when I had just started, and I applauded the approach, but the numbers
made me go "ugh, that sounds painful".

What I actually wanted to do was to write a coccinelle script to
automate it, but it wasn't entirely obvious, and I started out just
doing it with "sed" and hand-fixing, and it got tedious byt then I had
done X% and just kept going.

I think an automated script that also guarantees that no code
generation could possibly change would have been lovely. We do that
over the kernel occasionally, where those kinds of patches that are
four thousand insertions/deletions in size are called "last Tuesday".

So my approach was really just brute-force and stupid, I admit it. I'm
not proud of the patch either.

It might be one of those "bandaid removal moments" - get it over and
done with and just rip that thing off ;)

So the patch is

 216 files changed, 4174 insertions(+), 4080 deletions(-)

and about 27k lines and 950kB total size.

The list limits are apparently much lower than that, but I'll happily
send it to people in private.

               Linus
