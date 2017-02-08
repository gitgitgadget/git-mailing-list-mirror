Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E8F541FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 04:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbdBHEmu (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Feb 2017 23:42:50 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36480 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbdBHEmt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2017 23:42:49 -0500
Received: by mail-pf0-f194.google.com with SMTP id 19so10727934pfo.3
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 20:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=mRrBVhwLUhVzKBnZCwS3TnRceTShhlShOzMSohvHG68=;
        b=lsfNyYLVuOcJuCnqqHl996YkwQrbNXZAqc68XwrJm7viuOwvV6fkd45H/L/R1k88+H
         pb0sLiHY2I3NJA+C9n/rvOAJ7pz++EiM8aYwWALtfE+S5j6ZTXNWWyXIR/f/T9ylUfwL
         yfyvF0ITDCfia981AYX+3PrU/daeLKw13c5bFDKTqqVWhS61kgZ7qudSmmi3YdP9iXjp
         yJ5KCu9yfyt76tZo2TZC3jPPk1n12Q3mrPhgInqBsG+NjtSXn/fyDslTCkA5zpe2epjQ
         rPi2WZb0QXidJu9AnwoRWJzZZSo6Dzl+xypOfbIynG/DQNhnWumqArC/BN4Jq8P+/ABg
         VyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=mRrBVhwLUhVzKBnZCwS3TnRceTShhlShOzMSohvHG68=;
        b=Va9kergRNpTxKkBH8h34/s0qJ20DcRy4M4FJV5hq8X9qdNHbHFB4QMMjby8qJo4+hX
         vuJoB+5P4ca6NZBhoCAmoNxMrJ/2oYLpEN/x04L16xjxFWfZwTJcM2vbQj7LQqC/srA6
         gzhPWBc37l620UZ748Sl0SiFwqhxKrtTAVZxhUDtMkPTvasIYHKFqkByh5g2bOLs4znJ
         5Ygh0dc0hEAx1OOD4khNtQ1jM/LkKE65ulNXr+JwnGN7Zf1Ulmuf2Rb3YGqkI76xa2RP
         4nvJtPu9enBimb9xHwaGmJgQn23vFantDdG1kTzJ2TThjVchTgtFc+P95gDTfbOPddKH
         2STQ==
X-Gm-Message-State: AIkVDXL/QbQMuTOAtupx3pXW4NqCGAAjDvL3J+50O+i/33VeYUslMZuK4qTNW1YJfSBT7g==
X-Received: by 10.98.66.82 with SMTP id p79mr24117548pfa.10.1486528968761;
        Tue, 07 Feb 2017 20:42:48 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:1564:f4f3:f1b4:c9b2])
        by smtp.gmail.com with ESMTPSA id p25sm15509259pfd.0.2017.02.07.20.42.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 07 Feb 2017 20:42:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
        <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
        <alpine.LFD.2.20.1702071739060.17609@i7.lan>
        <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
        <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
        <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com>
        <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com>
Date:   Tue, 07 Feb 2017 20:42:47 -0800
In-Reply-To: <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com>
        (Linus Torvalds's message of "Tue, 7 Feb 2017 19:28:05 -0800")
Message-ID: <xmqq4m05xph4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> People don't expect set theory from their pathspecs. They expect their
> pathspecs to limit the output. They've learnt that within a
> subdirectory, the pathspec limits to that subdirectory. And now it
> suddenly starts showing things outside the subdirectory?
>
> At that point no amount of "but but think about set theory" will
> matter, methinks.

I do not feel too strongly about it, either, but when we invoke
"what would people who go down into subdirectories expect", the
issue becomes a lot bigger.

"git diff/log" without any pathspec in a subdirectory still shows
the whole diff.  "git grep" looks for hits inside that subdirectory,
on the other hand.

I think the former design decision is mostly a historical accident.
"The project tree as the whole is what matters" was one reason, and
another is that historically we didn't have ":/"--defaulting to the
whole tree and telling people to give "." was easier than defaulting
to the current and telling people to give "../.." after counting how
many levels deep you started at.  If we were designing the system
today with "." and ":/", I wouldn't be surprised if we chose "always
limit to cwd if there is no pathspec" for any command for the sake
of consistency.  We can easily say "if you want whole-tree, pass :/"
instead.

But we do not live in that world, and I do not think change them to
make things consistent is what we are discussing in this thread.
Given users accept and expect that "diff" without pathspec is whole
tree, while "grep" without pathspec is limited to cwd, what is the
reasonable definition of "everything from which negative ones are
excluded"?  That is the question I am trying to answer.

As Mike mentioned earlier in the thread, if we used "." (limit to
cwd) for "diff/log" when there are only negative pathspec elements,
the resulting UI would become inconsistent within a single command,
as in my world view, giving no pathspec means "work on everything
you would ordinarily work on", a positive pathspec means "among
everything you would ordinarily work on, only work on the ones that
match this pattern", and giving only a negative one ought to mean
"among everything you would ordinarily work on, only work on the
ones that do NOT match this pattern."

>  pathspec.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/pathspec.c b/pathspec.c
> index 7ababb315..2a91247bc 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -224,6 +224,12 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
>  		char ch = *pos;
>  		int i;
>  
> +		// Special case alias for '!'

/* style? */

> +		if (ch == '^') {
> +			*magic |= PATHSPEC_EXCLUDE;
> +			continue;
> +		}
> +
>  		if (!is_pathspec_magic(ch))
>  			break;
>  
> +	/*
> +	 * If everything is an exclude pattern, add one positive pattern
> +	 * that matches everyting. We allocated an extra one for this.
> +	 */
> +	if (nr_exclude == n) {
> +		init_pathspec_item(item + n, 0, "", 0, "");
> +		pathspec->nr++;
> +	}

I somehow do not think this is correct.  I expect

	cd t && git grep -e foo -- :^perf/

to look into things in 't' except for things in 't/perf', but the
above will grab hits from ../Documentation/ etc.  We need to pay
attention to PATHSPEC_PREFER_CWD bit in the flags word, I think.

A real change probably wants to become a two-patch series (one for
the new :^ alias, the other is for "everything except...") with log
message ;-)
