Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0223720A40
	for <e@80x24.org>; Mon, 27 Nov 2017 01:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752425AbdK0B7F (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 20:59:05 -0500
Received: from mail-io0-f178.google.com ([209.85.223.178]:40823 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbdK0B7E (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 20:59:04 -0500
Received: by mail-io0-f178.google.com with SMTP id d21so12444407ioe.7
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 17:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=eJIXbqZGtD4ehAzGuFcgtYNjBI0VW7anaWmP/5DbF6M=;
        b=d/kG8UQAdHhkmf2FeMRHpBDgnBslrACPOtu3RDEoFly4+KWQJDy8z/JhVGP68ms4kv
         J5g+/7nEHwikMf3WgNigljrKqDGY+cbgLKGlEeHTCAZX/nTvRQlo7wVbtuRirEG52Q1I
         lokVf9hAQEwkSqKbcKxAueMIXBfnIlQsDXcwNJPaJMBNeTtCrmpASypEISeswKkbkAMw
         tfSaljRxK/nIVku6KYGk331//pq7qET2N7ssageqw/4jBL7V3i19UuVKbeHRlQFXK+qi
         nuieKzSp21h7oj1btfn8bfJqzGfgPAu7w42tjlprjkueebFfzC0ZrPJg9c5mUxvDGzYL
         6CgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=eJIXbqZGtD4ehAzGuFcgtYNjBI0VW7anaWmP/5DbF6M=;
        b=Yq1dun6klqR6XMN784yvHcSTRiUoLAOzKPHM//6WPhVnVmQ0ljjZPyUzn3C8Wnu2Or
         64M/AFdtcuopjTVsBw2PVRk/Rz+y7+T8pScEdqWiPQqz7PQ+ak+Mn62nece/Trv64W8M
         Lud6QyYOtK+EezDZY3K609ygAyhAHXt7LZ0FX7C3V85742ujRCW9M8MkpA8YF6KkQb1A
         nEm3IOUJyWyO3ciX1TcFp9Vz+1E0bmGVLSz3pS1bzY9m7BsopfOXC5TRi8xhPml2PEVr
         bvGCd9JhyZi8FXbZyX2rVPsuYN88n2hK1U3sfQiigkLlg4na/UuyKSQcAPJAU28lNbHZ
         NwHw==
X-Gm-Message-State: AJaThX7fTdvtjWdgCYERjb+LS5wsmXJU+/Rx4R3cO7x+fu7vIMsnxweG
        acU/r8tSYYCMljWsSlayrqO5n2ODR+S6DOFAYcI=
X-Google-Smtp-Source: AGs4zMYFkIvyiFCyaz0UGPlPGrby1c74BPb2wuC/SoiJ+IO8qyDxqdO+sEQa1AxpjowxU30kHPZBMf5NlwHubXWBrdM=
X-Received: by 10.107.3.86 with SMTP id 83mr42858507iod.297.1511747943346;
 Sun, 26 Nov 2017 17:59:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.37.143 with HTTP; Sun, 26 Nov 2017 17:58:42 -0800 (PST)
In-Reply-To: <CAN+rsqmEWHhnQvktxsLJC2CkOQEmBL3b_xjRkEOHzV8W72zJew@mail.gmail.com>
References: <20171123154159.17408-1-maruel@chromium.org> <xmqqwp2gpi1q.fsf@gitster.mtv.corp.google.com>
 <CAN+rsqmEWHhnQvktxsLJC2CkOQEmBL3b_xjRkEOHzV8W72zJew@mail.gmail.com>
From:   Marc-Antoine Ruel <maruel@chromium.org>
Date:   Sun, 26 Nov 2017 20:58:42 -0500
X-Google-Sender-Auth: Ad9w9ywC82ZuTVrybFBz-I4P2DU
Message-ID: <CAN+rsqnnFXxh4=mk8L5Hzk=f=rTU101XiO-GvepSXsaVePOkZQ@mail.gmail.com>
Subject: Re: [PATCH] grep: Add option --max-line-len
To:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[second try, now with text format]

Thanks a lot for the reviews. Replying to both.

If I send a follow up, I'll fix the commit description and the help
string, remove the shorthand -M, write a more sensible test.


2017-11-23 14:24 GMT-05:00 Eric Sunshine <sunshine@sunshineco.com>:
>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
>> @@ -127,6 +128,10 @@ OPTIONS
>> +-M<num>::
>> +--max-line-len<num>::
>> +       Match the pattern only for line shorter or equal to this length.
>
> This documentation doesn't explain what it means by a line's length.
> This implementation seems to take into consideration only the line's
> byte count, however, given that displayed lines are normally
> tab-expanded, people might intuitively expect that expansion to count
> toward the length. A similar question arises for Unicode characters.
>
> Should this option take tab-expansion and Unicode into account?
> Regardless of the answer to that question, the documentation should
> make it clear what "line length" means.

Excellent question. I don't have an immediate answer.


>> diff --git a/grep.c b/grep.c
>> @@ -1273,6 +1275,8 @@ static int match_line(struct grep_opt *opt, char *bol, char *eol,
>> +       if (opt->max_line_length > 0 && eol-bol > opt->max_line_length)
>> +               return 0;
>
> If the user specifies "-M0", should that error out or at least warn
> the user that the value is non-sensical? What about -1, etc.? (These
> are UX-related questions; the implementation obviously doesn't care
> one way or the other.)

Precedent with -A is to ignore the negative value. I don't have a
strong opinion.


2017-11-23 20:44 GMT-05:00 Junio C Hamano <gitster@pobox.com>:
>
> Marc-Antoine Ruel <maruel@chromium.org> writes:
>
> > This tells git grep to skip files longer than a specified length,
> > which is often the result of generators and not actual source files.
> >
> > ...
> > +-M<num>::
> > +--max-line-len<num>::
> > +     Match the pattern only for line shorter or equal to this length.
> > +
>
> All the excellent review comments from Eric I agree with.
>
> With the name of the option and the above end-user facing
> description, it is very clear that the only thing this feature does
> is to declare that an overlong line does _not_ match when trying to
> check against any pattern.
>
> That is a much clearer definition and description than random new
> features people propose here (and kicked back by reviewers, telling
> them to make the specification clearer), and I'd commend you for that.
>
> But it still leaves at least one thing unclear.  How should it
> interact with "-v"?  If we consider an overlong line never matches,
> would "git grep -v <pattern>" should include the line in its output?

Ah! No idea. :/

> Speaking of the output, it also makes me wonder if the feature
> really wants to include an overlong line as a context line when
> showing a near-by line that matches the pattern when -A/-B/-C/-W
> options are in use. Even though it is clear that it does from the
> above description, is it really the best thing the feature can do to
> help the end users?
>
> Which leads me to suspect that this "feature" might not be the ideal
> you wanted to achive, but is an approximate substitution that you
> found is "good enough" to simulate what the real thing you wanted to
> do, especially when I go back and read the justfication in the
> proposed log message that talks about "result of generators".
>
> Isn't it a property of the entire file, not individual lines, if you
> find it uninteresting to see reported by "git grep"?  I cannot shake
> the suspicion that this feature happened to have ended up in this
> shape, instead of "ignore a file with a line this long", only
> because your starting point was to use "has overlong lines" as the
> heuristic for "not interesting", and because "git grep" code is not
> structured to first scan the entire file to decide if it is worth
> working on it, and it is extra work to restructure the codeflow to
> make it so (which you avoided).
>
> If your real motivation was either
>
>  (1) whether the file has or does not have the pattern for certain
>      class of files are uninteresting; do not even run "grep"
>      processing for them; or
>
>  (2) hits or no-hits may be intereseting but output of overlong
>      lines from certain class of files I do not wish to see;
>
> then I can think of two alternatives.
>
> For (1), can't we tell "result of generators" and other files with
> pathspec?  If so, perhaps a negative pathspec can rescue.  e.g.
>
>     git grep <pattern> -- '*.cc' ':!*-autogen.cc'
>
> For (2), can't we model this after how users can tell "git diff"
> that certain paths are not worth computing and showing textual
> patches for, which is to Unset the 'diff' attribute?  When you have
>
>     *-autogen.cc        -diff
>
> in your .gitattributes, "git diff" would say "Binary files A and B
> differ" instead of explaining line-by-line differences in the patch
> form.  Perhaps we can also have a 'grep' attribute and squelch the
> output if it is Unset?
>
> It is debatable but one could propose extending the use of existing
> 'diff' attribute to cover 'grep' too, with an argument that anything
> not worth showing patch (i.e. 'diff' attribute is Unset) is not
> worth showing grep hits from.

Thanks for the thoughtful analysis. My main motivation was (1), thus
filtering with a pathspec is much better than trying to work around
the issue. The issues raised in the review are significant enough that
committing this patch could cause significant issues; I don't know how
to resolve handling with -v and how to handle tabs.

After further thinking, what I'd like is a smarter version of the
git-gs shortcut wrapper that limits the search space on well known
extensions but I'd like it to also limit itself to "source-like"
files, similar in some ways to the -I flag. So in some ways this could
be better served as a git config but I'm not even sure what kind of
heuristic would be generic enough to be valuable to a large number of
users.

As such I'll drop the patch as I don't see a clear path forward with
the current one.

Thanks,

M-A
