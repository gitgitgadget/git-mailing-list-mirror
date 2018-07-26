Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDFE91F597
	for <e@80x24.org>; Thu, 26 Jul 2018 18:50:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730285AbeGZUIg (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jul 2018 16:08:36 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44155 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbeGZUIg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jul 2018 16:08:36 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so2694951wrt.11
        for <git@vger.kernel.org>; Thu, 26 Jul 2018 11:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dGUZrxb55UUREO4TrO2o3G1Z6BYJILZQE4nW4imXrzc=;
        b=r8e1ROr3Xw0iMEfwvb/zqRYA36UOjuGtRU0qtNSmtoS4pjpS/eWnVow5ZJXQTeXJin
         GlcaDWc2oJgftkQDJdvzaVpNPfbAmRvFIlHRbn61leBohvKoxHAxVJWDpCrrWFU49keE
         5oWuaYhqUjoz8dHRjpLbbyY8lCkEuPgY3sITHOzqjeHrTWvpsrZdHsuZs3jhBWrcU+rN
         wqyzqENiAi78BAxjHQM79ISiSvEfvgYzaedndLVpaeRjUOn8JVcnZlSLXlv7M6tXXcVj
         zOPvOndDIl9jSmuud3lv3+gvpONDq/HX1keKqpe6bynIaBHUJ6PfSaDUYirGu5NiiTn6
         v/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dGUZrxb55UUREO4TrO2o3G1Z6BYJILZQE4nW4imXrzc=;
        b=AwFfI+rjZhSeva0qceQINKbQYzSTMevzY7QG4qDw3TUHDifky3UXeXTqdTyRgsiDJd
         iKGH6q53CynRexgIqRKwQC/H+/J3qgAzI3K2QW+iFupBEelEOq5UPTkyaoO0zvG8IZwL
         E7RHbq5CTn4Sq0fJmUD8ST64kJwQFhFaepGOo22DGmZ6lKYU751W+Zr8Kfj0Id1W18Fk
         VDkw9O+5KysYl/Nkpan/ByjyO3JO8wZqEETD6TnWfW9qNDRYUUHjIYg7NbQ1qy7R1409
         PWDAZOP5H7zglAOy2vuSb/S2z6eCpUScQghxgjCWBcT2VfFO/MppWhv1MOIpXPhyYJD9
         4rWA==
X-Gm-Message-State: AOUpUlEVMyOJp3a7c3JMcbrdxZ9Rz26XfV21tutWN77OjAz21wdne/0J
        4T6NtptSg4wB9hTddZLTUdI=
X-Google-Smtp-Source: AAOMgpcYwO2xtQSSlxvWqOVZqVD4SyAbIsB92/drrQTK/fs9wUpDBhxGwzJd5gL4JVuArT8n4epwng==
X-Received: by 2002:adf:82f0:: with SMTP id 103-v6mr2390904wrc.131.1532631027773;
        Thu, 26 Jul 2018 11:50:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x14-v6sm1450622wrv.21.2018.07.26.11.50.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Jul 2018 11:50:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] RFC Highlight keywords in remote sideband output.
References: <20180726171751.178616-1-hanwen@google.com>
Date:   Thu, 26 Jul 2018 11:50:24 -0700
In-Reply-To: <20180726171751.178616-1-hanwen@google.com> (Han-Wen Nienhuys's
        message of "Thu, 26 Jul 2018 19:17:51 +0200")
Message-ID: <xmqqva91q1an.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> Supported keywords are "error", "warning", "hint" and "success".
>
> TODO:
>  * make the coloring optional? What variable to use?
>  * doc for the coloring option.
>  * how to test?

At the sideband layer, the sender only has the same level of
information as the receiver has regarding what the random bytes that
happens to be sent on the sideband, and that shows from the need to
guess with "keywords" in this code.  So if you are operating on the
sideband layer, I think the right way to do so would be to add the
coloring on the receiving end.  That way, talking to the same sender,
each receiver can decide if s/he prefers or capable of color.

    Hold your objection a bit.  I'll come back to it soon ;-)

It theoretically may make more sense to color on the sender side,
but that is true only if done at a higher layer that prepares a
string and calls into the sideband code to send.  That code must
know what the bytes _mean_ a lot better than the code at the
sideband layer, so we do not have to guess.

Having written all the above, I think you are doing this at the
receiving end, so this actually makes quite a lot of sense.  I was
fooled greatly by "EMIT_sideband", which in reality does NOT emit at
all.  That function is badly misnamed.

The function is more like "color sideband payload"; actual
"emitting" is still done at the places the code originally "emitted"
them to the receiving user.

> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> Change-Id: I090412a1288bc2caef0916447e28c2d0199da47d

That's an unusual trailer we do not use in this project.

> ---
>  sideband.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 60 insertions(+), 9 deletions(-)
>
> diff --git a/sideband.c b/sideband.c
> index 325bf0e97..c8b7cb6dd 100644
> --- a/sideband.c
> +++ b/sideband.c
> @@ -1,6 +1,53 @@
>  #include "cache.h"
>  #include "pkt-line.h"
>  #include "sideband.h"
> +#include "color.h"
> +
> +/*
> + * Optionally highlight some keywords in remote output if they appear at the
> + * start of the line.
> + */
> +void emit_sideband(struct strbuf *dest, const char *src, int n) {

Open brace on its own line.

> +        // NOSUBMIT - maybe use transport.color property?

Avoid // comment.

> +        int want_color = want_color_stderr(GIT_COLOR_AUTO);
> +
> +        if (!want_color) {
> +                strbuf_add(dest, src, n);
> +                return;
> +        }
> +
> +        struct kwtable {
> +                const char* keyword;
> +                const char* color;

In our codebase in C, asterisk sticks to the variable not the type.

> +        } keywords[] = {
> +                {"hint", GIT_COLOR_YELLOW},
> +                {"warning", GIT_COLOR_BOLD_YELLOW},
> +                {"success", GIT_COLOR_BOLD_GREEN},
> +                {"error", GIT_COLOR_BOLD_RED},
> +                {},

Drop the last sentinel element, and instead stop iteration over the
array using (i < ARRAY_SIZE(keywords)).

> +        };
> +
> +        while (isspace(*src)) {
> +                strbuf_addch(dest, *src);
> +                src++;
> +                n--;
> +        }
> +
> +        for (struct kwtable* p = keywords; p->keyword; p++) {

Does anybody know if we already use the variable decl inside the
"for (...)" construct like this?  I know we discussed the idea of
using it somewhere as a weather-balloon to see if people with exotic
environment would mind, and I certainly do not mind making this
patch serve as such a weather-baloon, but if that is what we are
doing, I want the commit log message clearly marked as such, so that
we can later "git log --grep=C99" to see how long ago such an
experiment started.  

Note that we did attempt to start such an experiment once

cf. https://public-inbox.org/git/20170719181956.15845-1-sbeller@google.com/

but failed.


> +                int len = strlen(p->keyword);
> +                if (!strncasecmp(p->keyword, src, len) && !isalnum(src[len])) {
> +                        strbuf_addstr(dest, p->color);
> +                        strbuf_add(dest, src, len);
> +                        strbuf_addstr(dest, GIT_COLOR_RESET);
> +                        n -= len;
> +                        src += len;
> +                        break;
> +                }
> +        }
> +
> +        strbuf_add(dest, src, n);
> +}
> +

I wonder how this interacts with exotics like the progress output,
which is essentially a single long line with many CRs sprinkled in,
sent on many packets?  I offhand do not think of a possible bad
interaction, but others may be able to think of some.

>  /*
>   * Receive multiplexed output stream over git native protocol.
> @@ -48,8 +95,10 @@ int recv_sideband(const char *me, int in_stream, int out)
>  		len--;
>  		switch (band) {
>  		case 3:
> -			strbuf_addf(&outbuf, "%s%s%s", outbuf.len ? "\n" : "",
> -				    DISPLAY_PREFIX, buf + 1);
> +			strbuf_addf(&outbuf, "%s%s", outbuf.len ? "\n" : "",
> +				    DISPLAY_PREFIX);
> +                        emit_sideband(&outbuf, buf+1, len);
> +

Let's not lose SP around "+" on both sides.

Also you seem to be indenting some lines with all SP and some with
mixture of HT and SP.  We prefer to use as many 8-column HT and then
fill the remainder with SP if needed to align with the opening
parenthesis on line above it (imitate the way strbuf_addf() is split
into two lines in the original in this hunk).

> @@ -69,20 +118,22 @@ int recv_sideband(const char *me, int in_stream, int out)
>  				if (!outbuf.len)
>  					strbuf_addstr(&outbuf, DISPLAY_PREFIX);
>  				if (linelen > 0) {
> -					strbuf_addf(&outbuf, "%.*s%s%c",
> -						    linelen, b, suffix, *brk);
> -				} else {
> -					strbuf_addch(&outbuf, *brk);
> +                                        emit_sideband(&outbuf, b, linelen);
> +                                        strbuf_addstr(&outbuf, suffix);

Here, suffix is the "clear to the end of the line" sequence (used
mostly for progress display), so it is correct to exclude that from
the call to "color this sideband payload" helper.  Good.

Thanks.  While there are need for mostly minor fix-ups, the logic
seems quite sane.  I think we can start without configuration and
then "fix" it later.  

While I am OK with calling that variable "transport.<something>", we
should not define/explain it as "color output coming from the other
end over the wire transport".  Those who want to see messages
emitted remotely during "git fetch" in color would want to see the
messages generated by "git fetch" locally painted in the same color
scheme, so it makes sense to let "git fetch" pay attention and honor
that variable even for its own locally generated messages.  The
variable instead means "color any message, either generated locally
or remotely, during an operation that has something to do with
object transport", or something like that.

Thanks.
