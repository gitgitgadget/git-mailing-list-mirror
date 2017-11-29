Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5F4120A40
	for <e@80x24.org>; Wed, 29 Nov 2017 23:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752708AbdK2XK3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 18:10:29 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:41016 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752687AbdK2XK2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 18:10:28 -0500
Received: by mail-wm0-f65.google.com with SMTP id g75so9667378wme.0
        for <git@vger.kernel.org>; Wed, 29 Nov 2017 15:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vrLgmWF1orH+3HbdNdyMzLW7EwmdF4eqJdSyCdkrbsk=;
        b=XTOo+wC5vO5zpVqTXczw6jz944mpgIWb6E8IiI8ckN44XyesmL9Vy/Stck5ZucuR8q
         YBVJ0KVaH2PR24yMIEs+ZjDSNY2peU8b71mRA/sj14d/cEgKbkuPE0px0iOfC//3Qh4a
         /DyRe6jIcofdeTJcXTm3z0z/1ulhZycJD80LURh+kZ7UwkgKwJkYrqcA7sx5rOFXbCcT
         hOTtJbM4hY5k6+AXngjpHq1Xn4TCu8r8jZRY/mWspiI6Ppa5mwfyqDicKi08YBTcDYpt
         2z2RzmjYxLPC6yd4kUx1cKifjspSWTRb2aQ/aQ+T3uocwKtVz+ATPvV3SEkncebWa+pt
         jnnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vrLgmWF1orH+3HbdNdyMzLW7EwmdF4eqJdSyCdkrbsk=;
        b=NmJX2qx0OXkfFJganvwQFIilRz6HueNYX/LBmw+qteAfSmYHLCBOtPSmc04quQq1wE
         YX9rz14yhyrJVNVVIWwQDd09TqEHOZgUTXIOcw2HcegM7OoEMHqPD6p6rcoWvTGQjl0E
         Uzh5G9NE03nu9crpHYkhG3GuQjMCPDytN9OOxRqnyaINKKCjWc9GAW/njEQV2XKHkHLb
         AleRZP2TLtvrpfnqlWqjcH0vj7pmpCpmTqmlKjgGs7S8lSi58YzJo7h75cdSoz1yJMVT
         c9leriyI6dfBrDLM9sAdrLRaXYTRYnbJW2vTuHjDrNhflG0nppaKWOKird/f7cNJB8IP
         bo0w==
X-Gm-Message-State: AJaThX66BtEIsIOfFk5t5iaG25zJ9MDdQB83r47QaqebBkuNdw1SJNdT
        rYCYtgNxHxZX/TBZ7+3+gLQyEfdU7NY=
X-Google-Smtp-Source: AGs4zMaLa4ceFtfoMEuUfnwnhppEeq64eKL1Jsg0Ai4vpKuUFgC6q3u+wGzZc2dce+HY/WOirvHs2Q==
X-Received: by 10.28.226.214 with SMTP id z205mr298935wmg.149.1511997026652;
        Wed, 29 Nov 2017 15:10:26 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id g99sm3896837wrd.72.2017.11.29.15.10.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Nov 2017 15:10:25 -0800 (PST)
Subject: Re: [SCRIPT/RFC 0/3] git-commit --onto-parent (three-way merge, no
 working tree file changes)
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
 <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
 <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
 <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <741dfedc-07f8-24fb-ebe2-940f8b2639d4@gmail.com>
Date:   Thu, 30 Nov 2017 00:10:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <ea156b8b-29d8-7501-b5a5-a29cfbd7d1d6@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On 29/11/2017 20:11, Johannes Sixt wrote:
> 
> Ok, then please explain, how this process should work in my workflow
> and with the `commit --onto-parent` feature that you have in mind. I
> have an integration branch (which is a throw-away type, so you can
> mangle it in any way you want); it is a series of merges:
> 
>  ...A    ...C            <- topics A, C
>      \       \ E
>    ---o---o---o---o I    <- integration
>          /       /
>      ...B    ...D        <- topics B, D
> 
> Now I find a bug in topic B. Assume that the merges of C and D have
> textual conflicts with the integration branch (but not with B) and/or
> may be evil. What should I do?
> 
> With git-post, I make a fixup commit commit on the integration
> branch, then `git post B && git merge B`:
> 
>  ...A    ...C                  <- topics A, C
>      \       \
>    ---o---o---o---o---f---F    <- integration
>          /       /       /
>      ...B    ...D       /      <- topic D
>          \             /
>           f'----------'        <- topic B
> 
> The merge F does not introduce any changes on the integration branch,
> so I do not need it, but it helps keep topic B off radar when I ask
> `git branch --no-merged` later.

But you`re not committing (posting) on your HEAD`s (direct) parent in 
the first place (topic B), so `commit --onto-parent` isn`t right tool 
for the job... yet :)

To make it easier to explain, I marked your integration branch 
initial head with "I" in the quote above (commit merging-in branch 
D), and marked commit merging-in branch C with "E".

HEAD being currently on commit "I", you can only use `--onto-parent` 
option to commit onto "E" or "D", being parents of "I".

To work with `--onto-parent` and be able to commit on top of any of 
the topic branches, you would need a situation like this instead:

 (1)  ...C      <- topic C
         |
    ...A |      <- topic A
        \|
      ...o I    <- integration
        /|
    ...B |      <- topic B
         |
      ...D      <- topic D

With `commit --onto-parent` you would skip `git post B && git merge 
B` steps, where "fixup commit" would be done with `--onto-parent B`, 
So you end up in situation like this:

 (2)      ...C      <- topic C
             |
        ...A |      <- topic A
            \|
          ...o I'   <- integration
            /|
    ...B---f |      <- topic B
             |
          ...D      <- topic D

State of index and working tree files in your F and my I' commit is 
exactly the same (I' = I + f), where in my case (2) history looks 
like "f" was part of topic B from the start, before integration 
merge happened.

BUT, all this said, I understand that your starting position, where 
not all topic branches are merged at the same time (possibly to keep 
conflict resolution sane), is probably more often to be encountered 
in real-life work... and as existing `--onto-parent` machinery should 
be able to support it already, I`m looking forward to make it happen :)

Once there, starting from your initial position:

>    ...A    ...C            <- topics A, C
>        \       \ E
>      ---o---o---o---o I    <- integration <- HEAD
>            /       /
>        ...B    ...D        <- topics B, D

... and doing something like `git commit --onto B --merge` would yield:
 
 (3) ...A    ...C            <- topics A, C
         \       \ E
       ---o---o---o---o I'   <- integration
             /       /|
         ...B    ...D |      <- topic D
             \        |
              f-------'      <- topic B

... where (I' = I + f) is still true. If that`s preferred in some 
cases, it could even look like this instead:

 (4) ...A    ...C             <- topics A, C
         \       \ E  I
       ---o---o---o---o---F   <- integration
             /       /   /
         ...B    ...D   /     <- topic D
             \         /
              f-------'       <- topic B

... where F(4) = I'(3), so similar situation, just that we don`t 
discard I but post F on top of it.

Good thing is all necessary logic should already be in place, I just 
need to think a bit about the most sane user interface, and get back 
to you. Thanks for invaluable input so far :)

Of course, do feel free to drop any ideas you come up with as well, 
on how `git commit` user interface/options leading to (3) or (4) 
should look like (they could both be supported).

> > Like working on multiple branches at the same time, in the manner
> > similar to what `git add --patch` allows in regards to working on
> > multiple commits at the same time. This just takes it on yet another
> > level... hopefully :)
> 
> 'kay, I'm not eagerly waiting for this particular next level (I
> prefer to keep things plain and simple), but I would never say this
> were a broken workflow. ;)

Hehe, thanks, I guess :) Simplicity, but user-oriented, is the major 
point here, where you can work on unrelated patch series at the same 
time (patch queues?), without a need to switch branches, while you 
still make "per series" history as you go, without a need to do it 
after the fact.

It`s a matter of possibilities (where Git usually excels), so one can 
choose for himself, depending on the situation at hand.

> > [SCRIPT/RFC 3/3] git-commit--onto-parent.sh[1] (I guess you didn`t
> > have time to checked that one yet?):
> 
> I did have a brief look, but I stopped when I saw
> 
>     # Remove entry from HEAD reflog, not to pollute it with
>     # uninteresting in-between steps we take, leaking implementation
>     # details to end user.
> 
> It's a clear sign for me that's something wrong. It is not just
> reflogs that can become stale, but all operations that follow the
> `git commit` can fail. How do you clean up such a mess?

I would respectfully disagree about it being wrong per se, but that 
said, "cleaning up" reflogs was a last minute design decision so we 
don`t show uninteresting states - from user`s point of view, all that 
happened is commit on top of --onto-parent, and merging that commit 
into where he already was (instead of the commit he was on). 

Implementation details on how we got there should be irrelevant, even 
more if we failed to do so, cluttering reflog with unimportant 
leftovers.

Commands are chained, and in case _anything_ goes wrong, we just bail 
out and restore original index and HEAD position. As working tree is 
not touched at all, no cleanup needed there, so everything is pretty 
simple. Of course, valid tests still should/need to be made, to make 
sure everything is covered, but there really isn`t much to cover in 
the first place.

But this is open for discussion, of course, and code for ref-logging 
all steps is still inside the script, just commented out. Heck, 
there`s even get_checkout_reflog_message() function at the end of the 
script, used to mimic real checkout reflog message, that`s currently 
unused ;)

> The "complex situation" I had in mind was not so much about the
> user's view, but how the implementation has to work when there are
> errors.

Simple - abort. Restore backed up index and HEAD state is all that`s 
to it, and it looks like we never issued the command to begin with.

> > From what I understand, your `git-post` makes a commit where you
> > are _and copies_ it over to destination, so you end up with same
> > changes in two places (two commits). More, you seem to keep working
> > on top of your previous commit(s), which seems logical, later
> > "posting" it where desired - so after the fact. It also means you
> > do still have all your "fix" commits in HEAD while you work on them
> > (and until you git-post and abandon them, discarding the
> > integration branch).
> 
> Just to clarify: git-post only copies existing commits, but does not
> make the original itself.

Yes, I understand that (hopefully communicated from the second part 
of the quote), but I see my wording of that first sentence was a bit 
unfortunate there (to say the least, lol), thanks for clarifying.

> > Could it be that you`re looking at `git commit --onto-parent` from
> > an unexpected perspective (through your `git-post`, being
> > conceptually different)...?
> 
> That may be the case. I'm very interested in your answer to my
> challenge above.

From everything said above, it seems so - at the moment, but I`m 
looking forward making it work for you, too, as it does make sense 
"out in the wild", in real-life scenarios.

Thank you again, for inspiring discussion.

Regards, Buga
