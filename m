Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A539C1FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 17:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752529AbdBHRjs (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 12:39:48 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36437 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdBHRjq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 12:39:46 -0500
Received: by mail-pg0-f67.google.com with SMTP id 75so15736449pgf.3
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 09:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dbb19WLwW3bXCRS8vUEDW8Ly78zkrXzIBfgscDKOssg=;
        b=Pt+UllmzQz+gBC1l1IyNEghmGTdJ8B9jzGXoURYaVk7ZHypqUeHqrsmNIRoIx11KXD
         3DqQL1Q6r24fUUEEcSzqrb1ERgJg4Q8FQ30Yu3kNlyRAYcQeLj3fvMzDTlbEe5C5tX8z
         6rkGO5TWxVmmKOxo2tF+qJhkvE6RbLt/uJdXNkJAC5OG8EadzzL1vXni4K6xVjooqnw2
         TBpFHcE3l+oHo97D2uT1JXF+hGyNTyjicVzkPj2yt6wmzYmyQb0BmqmZbwoJSfq0Zqjs
         rnIlDRW6MvI1LYFv4qGd2DzHokitX123Cwh1LX/C7g5bK7awQiZJJL61v/VJlFoXFr5e
         p3Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dbb19WLwW3bXCRS8vUEDW8Ly78zkrXzIBfgscDKOssg=;
        b=nVaqgcX/2yb+muPLbd/ADYMQGVsls5kwIBsDrqYIsO6RB7uHmRwVKbvLl4gjHZct8C
         +hhJdPljTIabev/rpIUSTfUTWoF9i3+V5WlJ1EpXr35AZ7yzKGzS+MXQ31OJ3VlD6JZS
         nZHaMUdWZwkSHRpYg541jhgl48a94lnl5gqBPtuCQrtjCPqzW0HapFY+KSZYBD+G602k
         Pa4luAn1SfYVO3xlYicdL1IndhfKuuJ5n9ejhlil+oAkg1MlZKM+O6fhJhnqCQbH2iQr
         jAxraeqo03LyO5VAwc8HodsS4dLdibzanG0M4eLykTN3FAMWrr8WQLanA4Sde8O8eQJ2
         tSNw==
X-Gm-Message-State: AIkVDXK4pRl7TznH86PrbG3qmOzp7JhriCeQCpJpBEDoEEbnZwaT9PPu5KnAcTqLaBTdyA==
X-Received: by 10.99.8.133 with SMTP id 127mr28821304pgi.42.1486575567441;
        Wed, 08 Feb 2017 09:39:27 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id i10sm22019236pgd.37.2017.02.08.09.39.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 09:39:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
        <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
        <alpine.LFD.2.20.1702071739060.17609@i7.lan>
        <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
        <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
        <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com>
        <xmqq4m05xph4.fsf@gitster.mtv.corp.google.com>
        <alpine.LFD.2.20.1702072112160.25002@i7.lan>
        <CACsJy8AQmg+oRYATU8_gR6zY-=sPN3m9PKtk-kytkSKGK+GG1g@mail.gmail.com>
Date:   Wed, 08 Feb 2017 09:39:25 -0800
In-Reply-To: <CACsJy8AQmg+oRYATU8_gR6zY-=sPN3m9PKtk-kytkSKGK+GG1g@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 8 Feb 2017 13:39:08 +0700")
Message-ID: <xmqqy3xgwpiq.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Feb 8, 2017 at 12:12 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>> Two-patch series to follow.
>
> glossary-content.txt update for both patches would be nice.

I am no longer worried about it as I saw somebody actually sent
follow-up patches on this, but I want to pick your brain on one
thing that is related to this codepath.

We have PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL bits in flags,
added at fc12261fea ("parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
flags", 2013-07-14), and I think the intent is some commands when
given no pathspec work on all paths in the current subdirectory
while others work on the full tree, regardless of where you are.
"grep" is in the former camp, "log" is in the latter.  And there is
a check to catch a bug in a caller that sets both.

I am wondering about this hunk (this is from the original commit
that added it):

 	if (!entry) {
 		static const char *raw[2];
 
+		if (flags & PATHSPEC_PREFER_FULL)
+			return;
+
+		if (!(flags & PATHSPEC_PREFER_CWD))
+			die("BUG: PATHSPEC_PREFER_CWD requires arguments");
+
 		pathspec->items = item = xmalloc(sizeof(*item));
 		memset(item, 0, sizeof(*item));
 		item->match = prefix;
		... returns a single entry pathspec to cover cwd ...

The BUG message is given when 

 - The command got no pathspec from the caller; and
 - PATHSPEC_PREFER_FULL is not set; and
 - PATHSPEC_PREFER_CWD is NOT set.

but the message says that the caller must have args when it sets
prefer-cwd.  Is this a simple typo?  If so what should it say?

	die("BUG: one of PATHSPEC_PREFER_FULL or _CWD must be set");

If that were the case, we are expressing only one bit of information
(do we limit to cwd, or do we work on full-tree?), but there must
have been a reason why we added two bits and made them mutually
incompatible so that we can express three possibilities.

Does this third possibility (i.e. a caller is allowed to pass
"flags" that does not prefer either) exist to support a command
where the caller MUST have at least one pathspec?  If that were the
case, this wouldn't be a BUG but an end-user error, e.g.

	die("at least one pathspec element is required");

If you know offhand which callers pass neither of the two
PATHSPEC_PREFER_* bits and remember for what purpose you allowed
them to do so, please remind me.  I'll keep digging in the meantime.

Thanks.
