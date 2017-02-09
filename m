Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A17661FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 13:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751375AbdBIN2R (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 08:28:17 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:35723 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751250AbdBIN2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 08:28:14 -0500
Received: by mail-ot0-f181.google.com with SMTP id 65so2703247otq.2
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 05:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PhWr7Rj7eMNNtlczOABY9sz+amfKxAr6MMr2WykENzs=;
        b=hMI+feclclGkJ5nX9ZYiOsDgQ8tBpcYLi/Mku4HVkrdIytvuLpIXTZNNdLRT6EJm1b
         d8PegCQxcjn+Rr/cwS9WPdnxUp6tZwncQY98kJip/m6HS2lsVaccKyBVJKmBb+CmjPbZ
         iTZOYgdSyjSu2miFxnK4SNSll5SqYfNxq+MHzOaOjD0eq+j/WTv8eR6L/z4+eDZeTDuC
         9RvXoEzIXLDeH3SPDQUJh8FScnillx0HsiBP4YVpTtmSN76j3jnovjQZboibd5V6No1O
         N178LLEVs2DjqyANtlH0do2+FyXdYBAX7k9qySqmPyvl3CQsR02C6ioPeWzX/W0jVEr8
         VrVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PhWr7Rj7eMNNtlczOABY9sz+amfKxAr6MMr2WykENzs=;
        b=VgEDBk8tBBRoKydChKo3jDPKUjLsmqwAyHQO9Ku7oNie2oJqPt6ZQpb7267bNdL2LR
         75phmpVjshHRgLNHgYAqEyfq9BXn6WzfFjHbZO3de6I59C/JIpesam0wXcdeTgf/RpiQ
         BufIHw8Mz6Buz9Dgavqckzq00OKdiw+y6SsalK1Ejn+ea0cAci+7sng/+3Wpe13Qabw3
         Cf+sqpJ24D8zcsarKhcmZQKum4VfJm5KU782UH86lNfggdkB/rn73gqKRTl6IlS637+8
         ky75TR0Tp9ITsNdaYdMvcrUpuK2c+Fn8sVWeqwDPENjzDg23b5WV/S0acFsn88ypAwPm
         Vgmw==
X-Gm-Message-State: AMke39k1wgh3jwZ/PD+s+qVyF9QE5pqZBxS0bAi7hRi4lbtWKxz2Wy+j6aySzG+jdkttNctyXaMIjBnM9K3vwQ==
X-Received: by 10.157.18.246 with SMTP id g109mr1840272otg.10.1486646882091;
 Thu, 09 Feb 2017 05:28:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.137.148 with HTTP; Thu, 9 Feb 2017 05:27:31 -0800 (PST)
In-Reply-To: <xmqqy3xgwpiq.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFyznf1k=iyiQx6KLj3okpid0-HexZWsVkxt7LqCdz+O5A@mail.gmail.com>
 <CA+55aFzkTZAb1vy3G5M_Nb1BeOhTiCGksUfLa+ZQtiU2x6Q=Fw@mail.gmail.com>
 <alpine.LFD.2.20.1702071739060.17609@i7.lan> <xmqqefz9xv0x.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwPLtuPciN1o_03CwkKqFWgZd_br9Q14qyr7a7N7mxTeA@mail.gmail.com>
 <xmqqa89xxtnd.fsf@gitster.mtv.corp.google.com> <CA+55aFyAEaMKA+2oPJct4ffJ0-_z2vrYxmQ9yrkbxzB3Hk6WfQ@mail.gmail.com>
 <xmqq4m05xph4.fsf@gitster.mtv.corp.google.com> <alpine.LFD.2.20.1702072112160.25002@i7.lan>
 <CACsJy8AQmg+oRYATU8_gR6zY-=sPN3m9PKtk-kytkSKGK+GG1g@mail.gmail.com> <xmqqy3xgwpiq.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 9 Feb 2017 20:27:31 +0700
Message-ID: <CACsJy8AbSrcqEiDByyTha9UdQvwFFXkjzKpAn6H96WD+aMdh1Q@mail.gmail.com>
Subject: Re: Fwd: Possibly nicer pathspec syntax?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 12:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Wed, Feb 8, 2017 at 12:12 PM, Linus Torvalds
>> <torvalds@linux-foundation.org> wrote:
>>> Two-patch series to follow.
>>
>> glossary-content.txt update for both patches would be nice.
>
> I am no longer worried about it as I saw somebody actually sent
> follow-up patches on this, but I want to pick your brain on one
> thing that is related to this codepath.
>
> We have PATHSPEC_PREFER_CWD and PATHSPEC_PREFER_FULL bits in flags,
> added at fc12261fea ("parse_pathspec: add PATHSPEC_PREFER_{CWD,FULL}
> flags", 2013-07-14), and I think the intent is some commands when
> given no pathspec work on all paths in the current subdirectory
> while others work on the full tree, regardless of where you are.
> "grep" is in the former camp, "log" is in the latter.  And there is
> a check to catch a bug in a caller that sets both.
>
> I am wondering about this hunk (this is from the original commit
> that added it):
>
>         if (!entry) {
>                 static const char *raw[2];
>
> +               if (flags & PATHSPEC_PREFER_FULL)
> +                       return;
> +
> +               if (!(flags & PATHSPEC_PREFER_CWD))
> +                       die("BUG: PATHSPEC_PREFER_CWD requires arguments");
> +
>                 pathspec->items = item = xmalloc(sizeof(*item));
>                 memset(item, 0, sizeof(*item));
>                 item->match = prefix;
>                 ... returns a single entry pathspec to cover cwd ...
>
> The BUG message is given when
>
>  - The command got no pathspec from the caller; and
>  - PATHSPEC_PREFER_FULL is not set; and
>  - PATHSPEC_PREFER_CWD is NOT set.
>
> but the message says that the caller must have args when it sets
> prefer-cwd.  Is this a simple typo?  If so what should it say?
>
>         die("BUG: one of PATHSPEC_PREFER_FULL or _CWD must be set");

Without reading through your next mail, I'd say "BUG: this command
requires arguments".

> Does this third possibility (i.e. a caller is allowed to pass
> "flags" that does not prefer either) exist to support a command
> where the caller MUST have at least one pathspec?  If that were the
> case, this wouldn't be a BUG but an end-user error, e.g.
>
>         die("at least one pathspec element is required");

Or this. Yes. I might have just been defensive at then and kept the
third option open.

> If you know offhand which callers pass neither of the two
> PATHSPEC_PREFER_* bits and remember for what purpose you allowed
> them to do so, please remind me.  I'll keep digging in the meantime.

I don't usually remember what I ate yesterday and this commit was from
2013 :D But I'll see if your findings spark anything in my brain.
-- 
Duy
