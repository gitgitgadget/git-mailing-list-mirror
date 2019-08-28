Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AE691F4B7
	for <e@80x24.org>; Wed, 28 Aug 2019 19:03:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfH1TDL (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 15:03:11 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46603 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbfH1TDL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 15:03:11 -0400
Received: by mail-lj1-f196.google.com with SMTP id f9so536209ljc.13
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 12:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OJxBUNezyjDwdMZ/xzt+Lp3dqu9Hs3wq7RO+42oOSTk=;
        b=QuPzwcHT8DzF9e3C5lK0FWpI4jADaeNzaQOgDzOTRBXeHjJjLghdkz37uqUzCDT/Sk
         YdQKxYivdHcFkJPTmlHu8daj+ziFzoEef8wQRGTd3i77EPvRi2V5hyG+qoF0rtsTHNAl
         FpwOh4zBkdfilVGrUm6DFNaFqQcLLFNwnTtbts70oAKyok/UwMq3pYtdOzlNaCtzC4n+
         23Pf6rVrhRrZ6Lr7z8h0IFWgaYRH3x2Z5JjhtHtoqssOcJHUx+aj8Al3TBrqDwthInJ1
         v3BBPMfZyvF0BW++NvjXVORS8btwHUbXUBWYXLMP1Ka1VGRs/lDI+aVQCkjfgdDqQmd0
         oKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=OJxBUNezyjDwdMZ/xzt+Lp3dqu9Hs3wq7RO+42oOSTk=;
        b=A4HupH9OzHLVa6MAJkzjS8xrrOCDxxKFsFU461Vq2g6TWO0pP5MPoK0uw6EEYJLgMk
         Y2F9/FqzQOjDaUdNac2pObq7nl7j1S1Scw8qoU8S3ra3uPpibrgIDKg3PIkcpR7Osz12
         WU9e3vyViRzCcVzdLEDxYDn0Z6UwDH3tD2RQoM/UIjHQnaVd110Gz0ZVXba/Bdo4PrcR
         Q5TcLvgGeAq/EZu+MC9LSmZ6fP01EXDtke1eJuWND2p+HBGj1qgaQH8vKepP2XSnHc3s
         UdHeKELZzHrqiHsRL1OQG8R6aHf6E8r6mzPIuqpjLZ0mRop+rA1fN0xO5S8CApu/ORcr
         3B0A==
X-Gm-Message-State: APjAAAVgrrNO66uzUkSUqNIW2m94rmElTaYlXvXfrQhNifDntyxQf6yG
        0l/txuarJsX3jLHlevo0KME=
X-Google-Smtp-Source: APXvYqwDUSPVIAGzjx1svy3PdU47FdRdyOXDq8mBAjZ9totTz4EwYsxyClK1xWBKzd5zVrCAk5xR/Q==
X-Received: by 2002:a2e:8183:: with SMTP id e3mr2824864ljg.97.1567018987865;
        Wed, 28 Aug 2019 12:03:07 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id c197sm994639lfg.46.2019.08.28.12.03.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2019 12:03:07 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Eric Wong <e@80x24.org>, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it elsewhere
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com>
        <20190826235226.15386-1-newren@gmail.com>
        <20190827070324.7l2cpc3dlnithbm6@whir> <87v9ujc827.fsf@osv.gnss.ru>
        <CABPp-BGfoRX-ob986kd-vvBo3meg-MpJ8Jo85G_2GgARY=cxxg@mail.gmail.com>
        <87blw93c5n.fsf@osv.gnss.ru>
        <CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com>
Date:   Wed, 28 Aug 2019 22:03:06 +0300
In-Reply-To: <CABPp-BEYRmhrb4Tx3bGzkx8y53T_0BYhLE5J0cEmxj18WtZs9A@mail.gmail.com>
        (Elijah Newren's message of "Wed, 28 Aug 2019 10:16:18 -0700")
Message-ID: <87muftqfit.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

Elijah Newren <newren@gmail.com> writes:

> Hi Sergey,
>
> On Wed, Aug 28, 2019 at 1:52 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Tue, Aug 27, 2019 at 1:43 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> Eric Wong <e@80x24.org> writes:
>> >>
>> >>
>> >> [...]

[...]

>> >
>> > Side note: Is the goal to "fix names and email addresses in this
>> > repository"?  If so, this guide fails: it doesn't update tagger names
>> > or email addresses.  Indeed, filter-branch doesn't provide a way to do
>> > that.  (Not to mention other problems like not updating references to
>> > commit hashes in commit messages when it busy rewriting everything.)
>>
>> No. Maybe the original goal was like that, by I, personally, use
>> modified version of this to change my "Author" credentials from
>> "internal" to "public" in branches that I'm going to send upstream, so
>> the actual aim is to change e-mail of particular Author from a@b to c@d
>> in all the commits in a (feature) branch.
>
> There's an interesting usecase I hadn't heard of or thought of before.
> Quick question to see if I'm understanding correctly: "all commits in
> a branch" or "all commits *unique* to a branch"?
>
> (Perhaps the only commits with the author you want to change are among
> the commits that are unique to that branch and so the distinction
> doesn't matter, but it wasn't clear from the description.)

Yes, this is exactly the case for me, as I'm changing entirely linear
topic branch that is going to become patch series to send out. No
complications.

>
>> >> > But I agree that filter-branch isn't useful and certainly
>> >> > shouldn't be encouraged/promoted.
>> >>
>> >> Well, is there more suitable way to change author for a (large) set of
>> >> commits then?
>> >
>> > I would say yes, use git filter-repo (note that this thread started
>> > with me proposing filter-repo for inclusion in git.git -- and getting
>> > suggestions that we should remove stuff instead of adding more stuff).
>> > I'm biased, but I think it's much better at this particular job as
>> > well:
>>
>> Well, I don't want to change the entire repo, and I don't immediately
>> see how to do it with git filter-repo. Is it at all possible?
>
> Yes, it is possible.  filter-repo has a hidden --refs argument
> defaulting to --all; you could instead set it to e.g.
> origin/master..master.

Cool!

>
> --refs is the only hidden option in filter-repo.  I know it may look
> funny that I spent a bunch of effort to create the
> --reference-excluded-parents option to fast-export explicitly so that
> it would be possible to do partial history rewrites like this, and
> then to hide and avoid documenting this option (though I did hint that
> it existed in the documentation if you search for "Partial-repo
> filtering"), but there was a few reasons for this:
>
>   * mixing old and new history for most rewrites that
> filter-branch/filter-repo/bfg/etc are used for can really mess things
> up and make it hard to recover from.  I don't like trying to clean up
> repos with accidental duplicate copies of most commits in the repo,
> and I suspect others like it even less.  So, anything that makes it
> easier to make such mistakes needs to have a really good rationale in
> order for me to expose it.
>   * The only usecases I knew of for partial repo filtering prior to
> your email were (1) side-stepping insanely slow execution time of poor
> filtering tools like filter-branch, and (2) performing operations
> better suited to git-rebase anyway (e.g. the --signoff option to
> rebase did not exist once upon a time and so folks could have used
> filter-branch to fake it, but using rebase is the better way to make
> this change).  And, even after your email, I'm not sure that has
> changed though, as noted below.

Yeah, I share your worries.

[...]

>> Actually, I'd rather expect some support for this in "git rebase", being
>> git history editing/reshaping tool, but it looks like it only has it in
>> the form that is very difficult to automate.
>
> I agree that git rebase would be the better choice here; I typically
> feel it's the better choice for rewrites of recent history.  I think
> it provides just what you need:
>
>   git rebase --exec="git commit --amend --reset-author -C HEAD" $UPSTREAM
>
> (Assuming, of course, that you've either set the right environment
> variables or set user.name and user.email to the new values you want
> so that commit's --reset-author flag can reset to the *new* author.)

This should do the trick for me most of times, thanks a lot for the clue!

However, the script that I'm using doesn't change _all_ the authors, it
only changes those that match particular specific author specified in
the script. I didn't yet actually need this feature, but I can well
imagine it's probable that I will have commits by other author(s) in the
branch and I won't want to attribute their job to myself.

Hmm... That said, using the generic "--exec" to "git rebase" I could
probably come-up with a script that will check the Author of the latest
commit and will choose to either rewrite it or not. Nothing terribly
complex.

>
>> >> > Yet there's probably still users which ARE happy with it, that
>> >> > will never hit the edge cases and problems it poses; and will
>> >> > never read release notes.  And said users are probably getting
>> >> > git from a slow-moving distro, so it'd be a disservice to them
>> >> > if they lost a tool they depend on without any warning.
>> >>
>> >> Personally, I'm far from happy with it, but I have no clue how to
>> >> substitute it in the job above. Anybody?
>> >
>> > The start of this thread where I proposed git filter-repo for
>> > inclusion in git[1] had links to documentation and comparisons to
>> > other tools and such.  You may find those links helpful; if not, let
>> > me know what needs to be fixed in the documentation.
>>
>> Thank you for the references, I find it a very nice tool to have!
>>
>> Pity it's not an entire substitute for git filter-branch.
>
> Au contraire, I believe it is.  :-)

I take your word for it :-)

>
> Thanks for the interesting usecase.  It sounds like we both think this
> one happens to be better solved by rebase, and the command snippet I
> provided above should show you to use rebase to solve it.  However, if
> you come up with any others where partial repo filtering makes sense,
> I'm always willing to reconsider my decision to make the --refs
> argument hidden; it may just mean adding more warnings, but it might
> also involve changing other defaults (e.g. the automatic
> repacking/pruning).  I'd need concrete usecases to know for sure how
> I'd want to handle it.

OK, thanks a lot! Doesn't seem to be necessary for now due to the rebase
trick you've suggested.

>
> Hope that helps,

Sure it does!

-- Sergey
