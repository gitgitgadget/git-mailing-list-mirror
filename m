Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CA581F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 15:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbeK0Cln (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Nov 2018 21:41:43 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36873 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbeK0Cln (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Nov 2018 21:41:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so5551099wmd.2
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 07:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=U/j+a6FFuFpsU4uARpjIQD8Oh3CfeA3oEUjtRaB2/Mo=;
        b=RYcNgyJ6qovUhvV/7eSsChGR9/FpK5b5kDUGzP6Sh7bj1T6t/S7ClGUz6ZWeJRPamM
         XWV/7kRg9URzdltlm4vJH6RXUVmv7VBvyo2S/s6cbTMBWWA8gor7UwIRQ8kESl27/9jC
         6lEQnLjdOvyvx/gqmjMlPBxhl3Q2cA+Ei4lHi4w2KsExMp2Jnq7EFXB0aXx4fmNKkMfQ
         56+wxuoLfdILgOOMj4n9PUQGPD/51rDxB9EBWgdC0j5LRMWZWc7YZuv6nmsBuCZ7u+TF
         KvzYD117znR//PMtih9OOZ8Q1Xfba0bOf5H26Kn3y9jQ+pAARQFKwZ9R96Q2810HVyNc
         etTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=U/j+a6FFuFpsU4uARpjIQD8Oh3CfeA3oEUjtRaB2/Mo=;
        b=BJq0ZB9+5Ug0ygx3gGjomBUekGA9auPJXWLrhR6D107370ieZaNeaZuidyD0yTHtlD
         t/XxvQHi+eipsyavbhKB1RHmsClCCNrTYwMMxOmM3VhaAbZUu3xs/UF8POVF5y6pIm2D
         vXUW+WKjPeZiN6q2DInEzT9HUP4qv8IVhDQXFnmmZz2QcQVD61veyjopcLmSuLYLEKp5
         clpIrA5kwJMIc6j0+FwIpwOJEsQ684uMGF8ByJpnXtLxYSnWN6pqqKCRHmYR2IEaDiD/
         h0qwlKK5aBL2DWORii4Yob4C+U+dL3m4+jzWzAlLZ47L8OAGxAwlur9fxiNKyVUtUo16
         Oj+w==
X-Gm-Message-State: AGRZ1gLJzU3tM8bA+tMUNLsXoAxxYTu4tMJRq6Q8d4yEeBxczzDEJtFw
        /ltUqrhvyWISprzmu0YDQ/Q=
X-Google-Smtp-Source: AJdET5fFWons+n0hLxKFPFNVrWyfwE+5p0OyCHgIluzD9UrS1RsrBVCnNrC5AgS10yATxQjng/mf9A==
X-Received: by 2002:a1c:f112:: with SMTP id p18mr23123810wmh.83.1543247231328;
        Mon, 26 Nov 2018 07:47:11 -0800 (PST)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id f66sm1589218wmd.28.2018.11.26.07.47.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 07:47:10 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     per.lundberg@hibox.tv,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>, jost@tcs.ifi.lmu.de,
        Joshua Jensen <jjensen@workspacewhiz.com>,
        Junio C Hamano <gitster@pobox.com>, git@matthieu-moy.fr,
        Clemens Buchacher <drizzd@gmx.net>,
        "Holger Hellmuth \(IKS\)" <hellmuth@ira.uka.de>,
        Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH] Introduce "precious" file concept
References: <20181111095254.30473-1-pclouds@gmail.com> <875zxa6xzp.fsf@evledraar.gmail.com> <871s7r4wuv.fsf@evledraar.gmail.com> <20181112232209.GK890086@genre.crustytoothpaste.net> <280aa9c3-0b67-c992-1a79-fc87bbc74906@hibox.tv> <CACsJy8AzmgkCm=_pJpcXY4xwujnfx9vFKJgbJ_BB__4UybACTQ@mail.gmail.com> <87sgznzwcp.fsf@evledraar.gmail.com> <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CACsJy8C4deg=M+sjmTBM-qs_=zZ9KarND3MNaR6-MqxukBJoSA@mail.gmail.com>
Date:   Mon, 26 Nov 2018 16:47:09 +0100
Message-ID: <87pnurzvr6.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 26 2018, Duy Nguyen wrote:

> On Mon, Nov 26, 2018 at 4:34 PM Ævar Arnfjörð Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Mon, Nov 26 2018, Duy Nguyen wrote:
>>
>> > On Mon, Nov 26, 2018 at 10:30 AM Per Lundberg <per.lundberg@hibox.tv> wrote:
>> >>
>> >> On 11/13/18 1:22 AM, brian m. carlson wrote:
>> >> > This is going to totally hose automation.  My last job had files which
>> >> > might move from tracked to untracked (a file that had become generated),
>> >> > and long-running CI and build systems would need to be able to check out
>> >> > one status and switch to the other.  Your proposed change will prevent
>> >> > those systems from working, whereas they previously did.
>> >> >
>> >> > I agree that your proposal would have been a better design originally,
>> >> > but breaking the way automated systems currently work is probably going
>> >> > to be a dealbreaker.
>> >>
>> >> How about something like this:
>> >>
>> >> 1. Introduce a concept with "garbage" files, which git is "permitted to
>> >> delete" without prompting.
>> >>
>> >> 2. Retain the current default, i.e. "ignored files are garbage" for now,
>> >> making the new behavior _opt in_ to avoid breaking automated
>> >> systems/existing scripts for anyone. Put the setting for this behind a
>> >> new core.* config flag.
>> >>
>> >> 3. In the plan for version 3.0 (a new major version where some breakage
>> >> can be tolerable, according to Semantic Versioning), change the default
>> >> so that "only explicit garbage is garbage". Include very clear notices
>> >> of this in the release notes. The config flag is retained, but its
>> >> default changes from true->false or vice versa. People who dislike the
>> >> new behavior can easily change back to the 2.x semantics.
>> >
>> > How does this garbage thing interact with "git clean -x"? My
>> > interpretation of this flag/attribute is that at version 3.0 by
>> > default all ignored files are _not_ garbage, so "git clean -x" should
>> > not remove any of them. Which is weird because most of ignored files
>> > are like *.o that should be removed.
>> >
>> > I also need to mark "precious" on untracked or even tracked files (*).
>> > Not sure how this "garbage" attribute interacts with that.
>> >
>> > (*) I was hoping I could get the idea [1] implemented in somewhat good
>> > shape before presenting here. But I'm a bit slow on that front. So
>> > yeah this "precious" on untracked/tracked thingy may be even
>> > irrelevant if the patch series will be rejected.
>>
>> I think a garbage (or trashable) flag, if implemented, wouldn't need any
>> special case in git-clean, i.e. -x would remove all untracked files,
>> whether ignored or garbage/trashable. That's what my patch to implement
>> it does:
>> https://public-inbox.org/git/87zhuf3gs0.fsf@evledraar.gmail.com/
>>
>> I think that makes sense. Users running "git clean" have "--dry-run" and
>> unlike "checkout a branch" or "merge this commit" where we'll now shred
>> data implicitly it's obvious that git-clean is going to shred your data.
>
> Then that't not what I want. If I'm going to mark to keep "config.mak"
> around, I'm not going to carefully move it away before doing "git
> clean -fdx" then move it back. No "git clean --dry-run" telling me to
> make a backup of config.mak is no good.

Understood. I mean this in the context of solving the problem users have
with running otherwise non-data-destroying commands like "checkout" and
"merge" and getting their data destroyed, which is overwhelmingly why
this topic gets resurrected.

Some of the solutions overlap with this thing you want, but I think it's
worth keeping the distinction between the two in mind. I.e. I can
imagine us finding some acceptable solution to the data shredding
problem that doesn't implement this mode for "git-clean", or the other
way around.
