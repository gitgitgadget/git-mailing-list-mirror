Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A80F61FAE2
	for <e@80x24.org>; Tue, 13 Mar 2018 09:59:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752618AbeCMJ7o (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 05:59:44 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:35289 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752372AbeCMJ7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 05:59:43 -0400
Received: by mail-wr0-f174.google.com with SMTP id n12so9642415wra.2
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=YsKsRTjed63Lem4zsyjRjJABZ0q9EsrCJQ1VoslPUVg=;
        b=IX5zewteWml2uo8Ayb+BIPwOlnpYBJbBGy7OK61dQIrF52o/rksk1KoZlZu/AvmfKB
         f2vnqCM1TZSDx8OfI5eRLSouhKwRe7HjXHfMyl4Z7AUy0tvjfMMd6tOfZAtaJS71bDwA
         OrH/XbH2pOWsj857oNtS3ihB2kZWnTlW9YSO/xiQ+Yb22bwbc/Yj3mcKgUArG5jOzOtx
         VjRoDOTTbYgOwU95aZ7TgHasi3CdwsMzUfunCiB0gSA1BGvuhgzPzL6nhn9449ex9K7x
         djuCTWK7wIYGN+Nk/nDnJvl6su5RF9w2ZOCIF4cdHULTv9KVopQfai9Y4f2Kq59lt5L1
         rfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=YsKsRTjed63Lem4zsyjRjJABZ0q9EsrCJQ1VoslPUVg=;
        b=JA+xqpsVbe2VIGtS1L5YltJxpcIXYlgTa9D+LxnaGTLvrI3drOt3lKmGtpz8ck4XB8
         QsnMmB7vtMjpTM7SU0Uj9IcqvOgiDIx5Odt9BxCctp8h/Gleopc23JUq6itOURhTYLua
         Ok8GjQPYqmhgjRqO3QIm6Kgop5fx/iN7qXetdQ6mn/GKK5806nrndLjqGCCq2j8PGIIf
         /2tzx1/iL7sH8uyzie1ixLkOtAdzCJPrL1mLkFckdvqe7eZdluxtM3Zeie4nDSfCsgqh
         5E2rUCm1KqW2SDvw6NbAHArSiLvZLjQFwBoItK2g7YhAWXTX+woYgmLDcatn9XZQmjAE
         T3zg==
X-Gm-Message-State: AElRT7GuYcbqfrlIVJoekUoVl/wnzjRIpmeoJ9pi9wJBj9mu8IdgSOVn
        J3pAjdAU89UPXIaCR3M4F6U=
X-Google-Smtp-Source: AG47ELsKXl7u4RvaB6I9Kd8Hgb/Wo7BzG46pIzZt+r1bmzB4ac8OJ7b5BwVNIjDqeiYwghSTMbamzQ==
X-Received: by 10.80.175.227 with SMTP id h90mr210919edd.173.1520935182088;
        Tue, 13 Mar 2018 02:59:42 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id a34sm123357eda.77.2018.03.13.02.59.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 02:59:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Opinions on changing add/add conflict resolution?
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com> <876061q6m6.fsf@evledraar.gmail.com> <CABPp-BHDOimDoLxWxS=BDOBkm6CUTrXTzD16=TSkWGN-HOiU2g@mail.gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <CABPp-BHDOimDoLxWxS=BDOBkm6CUTrXTzD16=TSkWGN-HOiU2g@mail.gmail.com>
Date:   Tue, 13 Mar 2018 10:59:40 +0100
Message-ID: <871sgoqos3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 13 2018, Elijah Newren jotted:

> Hi,
>
> On Mon, Mar 12, 2018 at 3:19 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> wrote:
>
>>
>> Does this mean that e.g. in this case of merging two files, one
>> containing "foo" and one containing "bar":
>>
>>     (
>>         rm -rf /tmp/test.git &&
>>         git init /tmp/test.git &&
>>         cd /tmp/test.git &&
>>         echo foo >README &&
>>         git add README &&
>>         git commit -mfoo &&
>>         git checkout --orphan trunk &&
>>         git reset --hard &&
>>         echo bar >README &&
>>         git add README &&
>>         git commit -mbar &&
>>         git merge --allow-unrelated-histories master;
>>         cat README
>>     )
>>
>> That instead of getting:
>>
>>     <<<<<<< HEAD
>>     bar
>>     =======
>>     foo
>>     >>>>>>> master
>>
>> I'd now get these split into different files?
>>
>
> As currently implemented, yes.  However, I was more concerned the idea of
> handling files differently based on whether or not they were similar,
> rather than on what the precise definition of "similar" is for this context.
>
> As far as the definition of similarity goes, estimate_similarity() is
> currently used by rename detection to compare files recorded at different
> pathnames.  By contrast, in this context, we are comparing two files which
> were recorded with the same pathname.  That suggests the heuristic could be
> a bit different and use more than just estimate_similarity().  (e.g. "We
> consider these files similar IF >50% of the lines match OR both files are
> less than 2K.")

Yeah that's fair enough, we could definitely tweak a dedicated heuristic
for just this purpose to do the right thing most of the time, although
really having completely unrelated 10-line README files use the old
two-way merge would, I guess, also be confusing to users who want this
feature.

>> I don't mind this being a configurable option if you want it, but I
>> don't think it should be on by default, reasons:
>>
>
> I don't think a configurable option makes sense, at least not for my
> purposes.  Having rename/rename conflicts be "safely" mis-detected as
> rename/add or add/add, and having rename/add conflicts be "safely"
> mis-detected as add/add is my overriding concern.  Thus, making these three
> conflict types behave consistently is what I need.  Options would make that
> more difficult for me, and would thus feel like a step backwards.

I think there's three types of users who interact with the current
format:

 1) The user using no special tool (e.g. editing with nano) and runs
    into a conflict, maybe this helps these users the most.

 2) The user who's also using no special tool (e.g. editing with nano)
    but just prefers to get in-file conflict markers.

 3) The user using a tool to solve the conflict, who doesn't care if
    we'd spew out our current format, this new formar, or some XML file
    with both versions or whatevery, they're using some other UI.

I don't think we should make some change that breaks existing tools for
users of #3 by default.

>  1) There's lots of cases where we totally screw up the "is this
>>     similar?" check, in particular with small files.
>>
>>     E.g. let's say you have a config file like 'fs-path "/tmp/git"' and
>>     in two branches you change that to 'fs-path "/opt/git"' and 'fs-path
>>     "/var/git"'. The rename detection will think this these have nothing
>>     to do with each other since they share no common lines, but to a
>>     human reader they're really similar, and would make sense in the
>>     context of resolving a bigger merge where /{opt,var}/git changes are
>>     conflicting.
>>
>>     This is not some theoretical concern, there's lots of things that
>>     e.g. use small 5-10 line config files to configure some app that
>>     because of some combo of indentation changes and changing a couple
>>     of lines will make git's rename detection totally give up, but to a
>>     human reader they're 95% the same.
>>
>
> Fair enough.  The small files case could potentially be handled by just
> changing the similarity metric for these conflict types, as noted above.
> If it's a small file, that might be the easiest way for a user to deal with
> it too.

Or it might be easier for the user to deal with even big conflicts with
in-file conflict markers, see use-case #2 & #3 above.

> I'm not sure I see the problem with the bigger files, though.  If you have
> bigger files with less than 50% of the lines matching, then you'll
> essentially end up with a great big conflict block with one file on one
> side and the other file on the other side, which doesn't seem that
> different to me than having them be in two separate files.  In fact,
> separate files seems easier to deal with because then the user can run e.g.
> 'git diff --no-index --color-words FILE1 FILE2', something that they can't
> do when it's in one file.  That has bothered me more than once, and made me
> wish they were just in separate files.

Right, but this assumes they user isn't using a merge-tool as noted in
#3.

>>  2) This will play havoc with already established merge tools on top of
>>     git which a lot of users use instead of manually resolving these in
>>     vi or whatever.
>>
>>     If we made this the default they'd need to to deal with this new
>>     state, and even if it's not the default we'll have some confused
>>     users wondering why Emacs Ediff or whatever isn't showing the right
>>     thing because it isn't supporting this yet.
>>
>> So actually, given that last point in #2 I'm slightly negative on the
>> whole thing, but maybe splitting it into some new format existing tools
>> don't understand is compelling enough to justify the downstream breakage.
>>
>
> To me, this is a bigger concern.  We have changed conflict resolutions in
> various ways at various times over the years, so I don't think the output
> should be considered fixed in stone, but I am very sympathetic to arguments
> that this particular change is too painful.

I think we've changed around a lot of the details, and certainly how the
conflict is resolved. By "format" I mean that we've been emitting a file
with conflict markers, which third-party tools know how to parse
(e.g. ediff). That's a relatively stable format that we (with minor
changes) also share with cvs, svn, or plain patch(1) etc.

> [...]
> However, I'm far more concerned with the three collision conflict types
> having consistent behavior than I am with changing add/add conflict
> handling.  And if your two concerns or Jonathan's concern would prevent you
> from wanting to use the new merge strategy (and possibly prevent it from
> becoming the default in the future), I'd much rather just modify rename/add
> and rename/rename to behave like add/add.  Would that be more to your
> liking?

I don't really object to these changes, I don't know enough about this
area, I skimmed your patches and 90% of it is over my head (although I
could keep digging...).

I'm just chiming in because it seems to me from upthread that you're
purely focusing on the use-case of the user of git who's using git at
the abstraction of using a dumb editor that doesn't do anything to help
them with conflict markers to resolve conflicts.

I think that in those cases if you have two unrelated 3k line files that
collide splitting them out is certainly more helpful.

But there's also the use-case of existing tools (e.g. ediff) essentially
using this as a plumbing format, and we have to keep those tools in
mind, because to them it really doesn't matter what the format is, but
it *does* matter that they can understand it, but if we took these
patches as-is e.g. ediff wouldn't even show these conflicting files,
correct?

Also another caveat: Since these are new side-files what happens when
you're in a conflict and run `git clean -dxf`, are these new files wiped
away, or are they somehow known to the index?
