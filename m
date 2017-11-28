Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 553D520C11
	for <e@80x24.org>; Tue, 28 Nov 2017 01:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752880AbdK1BP6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 20:15:58 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33654 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbdK1BP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 20:15:57 -0500
Received: by mail-wr0-f193.google.com with SMTP id 55so11978534wrx.0
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 17:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/r6HpA9OHv51Kn+CGE6FXaWVvqlyv2kkeDyJuMjIj8c=;
        b=bMngtnKKflFqYus1yqedkTAgeBY1xREB7DlADcv6drnd6XIfLrxjayfyUpjgao+hMi
         CsvSgNdlLzFcHGK6grf+5ckGUbmtWrCl9p2fW+4IeOtmuB/poCJLdVz5Ca06p4PkgfbJ
         gruVtVEusZhzMj55FJ2DGJMpuW17f1JslB7vZVAV3UbGvdDUmu8zZAs2Sx6ypSD5S8Io
         WGSzj8m8v7ZgvrR3rtmZrETnv6sEJiC3toSDAJqEYQYgk59XC21OKmAuFl3+pCahhL4Q
         kYEatVjovBOHUP20whgVICUbtdl41DhYiIToq2VXDKMdEg0xXAn3LErWJ2qyYvyJQy9Z
         YpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/r6HpA9OHv51Kn+CGE6FXaWVvqlyv2kkeDyJuMjIj8c=;
        b=XSLlm8Wi0YrzRW+rMwPAgO751HaaPlWmY9BjtxpsA9BAatAqXaRFulKsowpXSy+4BA
         RzzzdZLP0qUVF8g25UcR44Mxi7CO2+n1phejS+wZgYM90gsLJqV57mVEeD3noFbHwgHy
         yCtPdN3TZ5MHJOo0bIAkSUqriZE+sKUpVhIQFuumAxlY29xTlEeI3p3FXofKazlQGBH8
         fYiY5b5x3h9i+eqZwz1GVEhYWb6EAkJF+SCZELVlMdUvXR0NiuEFsESaIEPZF4cBD3qw
         zU6UrGkDgLxqLNpG4Nxu1kiOGwb/1FHSwCtz0CIureMZGRyaW1jA7NMNxS0Ewwx/vBUF
         t89w==
X-Gm-Message-State: AJaThX7Tr/jKi21/apPUuzF2DoaQ/EGUEoJ5VtuNSZ5S1nuSGgUvpyfr
        PW74iRWLaykff1EdAJV18p5tUH3xGKo=
X-Google-Smtp-Source: AGs4zMYX5de4ibHhXLcwROWDn7TLQ5TdPhWHeD5XqnwworC4+qhpAw1gInM51BOMgbNBfhFlMlWb7w==
X-Received: by 10.223.138.246 with SMTP id z51mr33826292wrz.152.1511831755802;
        Mon, 27 Nov 2017 17:15:55 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id 68sm23141834wmh.2.2017.11.27.17.15.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 17:15:55 -0800 (PST)
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
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
Message-ID: <203a75c8-0c58-253c-2c18-05450f7ae49b@gmail.com>
Date:   Tue, 28 Nov 2017 02:15:52 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 27/11/2017 22:54, Johannes Sixt wrote:
> 
> I my opinion, putting the focus on integration merge commits and the
> desire to automate the re-merge step brings in a LOT of complexity in
> the implementation for a very specific use-case that does not
> necessarily help other cases.

It might seem more complex than it is, until you examine the guts to 
see how it really works :)

Basic concept is pretty simple, as I actually don`t automate 
anything, at least not in terms of what would manual user steps look 
like - for example, there`s no real re-merge step in terms of 
actually redoing the merge, I just reuse what was already there in a 
very clean way, I would think (supported by my current, humble 
knowledge, still).

The only merge that could possibly ever happen is upon committing 
desired subset of changes onto parent, and that shouldn`t be too 
complex by definition, otherwise that commit doesn`t really belong 
there in the first place, if it can`t be meaningfully applied where 
we want it (for now, at least).

That said, the whole operation of "posting on parent and re-merging 
everything", the way it looks like from the outside, could end just 
with a simple diff-apply-commit-commit internally, no merges at all. 
Only if simple `git apply` fails, we try some trivial merging - and 
all that inside separate (parent) index only, not touching original 
HEAD index nor working tree, staying pristine for the whole process, 
untouched.

Once done, you should be in the very same situation you started from, 
nothing changed, just having your history tweaked a bit to tell a 
different story on how you got there (now including a commit you 
posted on your HEAD`s parent).

Otherwise, I agree that explained use case might be a bit specific, 
but that is only because I recognized that one to be the most 
interesting to initially present (not to say one of more complex 
cases) - to me, at least, but it is certainly not the only one.

Don`t let "usual/preferred/recommended" Git workflow distract you too 
much - one of the reasons I made this is because it also allows _kind 
of_ "vanilla Git" patch queue, where you can quickly work on top of 
the merge head, pushing commits onto parents below, being tips of 
your "queues", putting you up to speed without a need to ever switch 
a branch (hypothetically), until satisfied with what you have, where 
you can slow down and polish each branch separately, as usual.

Like working on multiple branches at the same time, in the manner 
similar to what `git add --patch` allows in regards to working on 
multiple commits at the same time. This just takes it on yet another 
level... hopefully :)

> For example, in my daily work, I have encountered situations where,
> while working on one topic, I made a hot-fix for a different topic.
> There is no demand for a merge step in this scenario.
> 
> In your scenario above, it would certainly not be too bad if you
> forgo the automatic merge and have the user issue a merge command
> manually. The resulting history could look like this:
> 
> (3)         o---o---A---X    (topicA)
>            /         \   \
>           /           M1--M2 (test, HEAD)
>          /           /||
>      ---o---o---M---' ||     (master)
>          \   \       / |
>           \   o-----B /      (topicB)
>            \         /
>             o---o---C        (topicC)
> 
> I.e., commit --onto-parent A produced commit X, but M2 was then a
> regular manual merge. (Of course, I am assuming that the merge
> commits are dispensible, and only the resulting tree is of
> interest.)

I see - and what you`re asking for is what I already envisioned and 
hoped to get some more feedback about, here`s excerpt from 
[SCRIPT/RFC 3/3] git-commit--onto-parent.sh[1] (I guess you didn`t 
have time to checked that one yet?):

  For example, it might make sense to separate commit creation (on 
  current HEAD`s parent) and its actual re-merging into integration 
  test branch, where "--remerge" (or something) parameter would be used 
  on top of "--onto-parent" to trigger both, if/when desired.
  
  Another direction to think in might be introducing more general 
  "--onto" parameter, too (or instead), without "parent" restriction, 
  allowing to record a commit on top of any arbitrary commit (other 
  than HEAD). This could even be defaulted to "git commit <commit-ish>" 
  (no option needed), where current "git commit" behaviour would then 
  just be a special case of omitted <commit-ish> defaulting to HEAD, 
  aligning well with other Git commands sharing the same behaviour.

So I definitely look forward decoupling these two ((1) commit to 
parent and (2) remerge), with enough discussion flowing :)

Heck, even "to parent" is an artificial/imposed restriction now, in 
reality you could commit on top of any other commit you want (without 
switching branches)... but let`s take one step at a time.

Just note that omitting the remerge step is what actually makes the 
logic more complex, as we now need to change the original situation, 
too, both HEAD index and working tree, to remove changes which we 
committed elsewhere (without "merging" back in).

But it is interesting case to look into ;)

> Moreover, you seem to assume that an integration branch is an octopus
> merge, that can be re-created easily. I would say that this a very,
> very exceptional situation.

Actually, I make no assumptions - head of "integration branch" 
doesn`t even have to be a merge commit. And as we are not really 
"remerging" anything, there is no need to recreate anything ;) (what 
I tried to explain at the beginning of this e-mail).

The sole point is that your current situation inside HEAD doesn`t 
change at all, no matter how complex it is, we just rewrite history 
on how we got there (to include new commit onto desired parent).

> At this point, I spent five minutes thinking of how I would use
> commit --onto-parent if I did not have git-post.
> 
> While on the integration branch, I typically make separate commits
> for each fix, mostly because the bugs are discovered and fixed not
> simultaneously, but over time. So, I have a small number of commits
> that I distribute later using my git-post script. But that does not
> have to be so. I think I could work with a git commit --onto-parent
> feature as long as it does not attempt to make a merge commit for me.
> (I would hate that.)

I would be interested in looking into this, thanks for your feedback.

But, thinking about it more, you do realize that, without "updated 
merge", that would be removing committed changes from where you`re 
currently working at (once committed where you want it), is that what 
you expect?

Because it seems a bit strange, as you loose overview on how all 
those commits work together, and what you did so far, even, so some 
future merge might yield unexpected conflicts, which could have been 
avoided.

From what I understand, your `git-post` makes a commit where you are 
_and copies_ it over to destination, so you end up with same changes 
in two places (two commits). More, you seem to keep working on top of 
your previous commit(s), which seems logical, later "posting" it 
where desired - so after the fact. It also means you do still have 
all your "fix" commits in HEAD while you work on them (and until you 
git-post and abandon them, discarding the integration branch).

But `git commit --onto-parent` proposed here does the commit on 
destination only, where later "remerge" is crucial part of still 
keeping that commit changes in the current HEAD working tree as well, 
so you can still keep working on top of them.

Could it be that you`re looking at `git commit --onto-parent` from an 
unexpected perspective (through your `git-post`, being conceptually 
different)...?

Though your use case graph (3) above should mean you`re very well 
aware of implications, I guess, so I don`t know... :)

> Sometimes, however I have two bug fixes in the worktree, ready to be
> committed. Then the ability to pass pathspec to git commit is useful.
> Does your implementation support this use case (partially staged
> worktree changes)?

From what the idea is, it should work with anything that already 
works with plain `git commit`, as script is currently just a wrapper 
around it, providing additional functionality to speed things up.

So yes, `--onto-parent` works with `--patch`, `--amend`, etc :) If 
not, that`s a bug which I`d appreciate being reported.

Might be some `git commit` options don`t have sense in combination 
with `--onto-parent` as well, so those could be restricted, once 
recognized.

... aaand that said, I`ve just noticed that pathspec doesn`t actually 
work, for no good reason. If you add path through `git add` first, it 
will work, but not through `git commit --onto-parent -- <pathspec>` 
directly, which I need to address. Currently, it complains about no 
changes added to commit. Thanks for spotting! ;)

> Thanks,
> -- Hannes

Thank you for your time and valuable feedback, and one from a real 
life use-case perspective.

Regards, Buga

[1] https://public-inbox.org/git/d5f243a5-6e35-f3fc-4daf-6e1376bef897@kdbg.org/T/#m72f45ad7a8f1c733266a875bca087ee82cc781e7
