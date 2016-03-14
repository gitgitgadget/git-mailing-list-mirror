From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH] clone: add `--shallow-submodules` flag
Date: Mon, 14 Mar 2016 11:17:22 -0700
Message-ID: <CAGZ79kb731RzLco_thuucTokLCe4xNMbEod9C=gWG+P+ruih7g@mail.gmail.com>
References: <1457739683-1972-1-git-send-email-sbeller@google.com>
	<xmqqa8m4a5nx.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYc1WR9CTBi1F3KpLaYRUSxNPQkQ2jk+P09pshR3jG8aw@mail.gmail.com>
	<xmqq60wra40h.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Lars Schneider <larsxschneider@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:18:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afX4F-0006H9-U1
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 19:18:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbcCNSSF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 14:18:05 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:33545 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810AbcCNSRY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 14:17:24 -0400
Received: by mail-ig0-f175.google.com with SMTP id ig19so68869063igb.0
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 11:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=80G1wG9ky8gqxsTJvnt8bgbBc4v+0LsHIZX9SXyz504=;
        b=O27JXRdpSjxeW62Er4GR3tCNhLAu+QpGcpk+FLvmlT3I1rU5GHvkOlN1Y0EftsKyfe
         5QZty6ILT4kIE7iYKzA9QQmz37prMNQZwdjXE16rvucx1lcBKLtq9uXS40T2kL09Y0za
         C4bDIVnvtkqKu5+E4RCyHxsg+t1JU5MVLIzG3kcgJbA4OqGkXBZHK0JCH3tYVLBBDZIt
         Z6DoNygpp2B40Fq01bK7KqTKFzoA7tf0SQmHnUfhyNWbceRcLukRQgAke5IlJ+x3XaSx
         b+lOJkVy7H59BPlD2iwnggjFYjRnGj4rRJz2fZVCi6Y3hEcw9yBID4SBtetIkLPC2x0B
         2rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=80G1wG9ky8gqxsTJvnt8bgbBc4v+0LsHIZX9SXyz504=;
        b=VE6yA80JntqMGxjXgWszmVq/zMG4kcXhRjtNmH7Loe4VyiAsnE4a810tRTeUeFU8tu
         mswzNrEy7ypXjGFx9kYf5J3iWNLYOZQMwl0pl1waWo1ZJDy5kbj6KQ7rA2IEdJNv0FeZ
         kktdUAUEdxqayoOgKhPBcS/R8xb/pSBzcel5GCNsC/MlbtBWGvspOKfunD13/LzgYkCp
         hj4ZWEPNOuAS7phxWgodPmRdQVPnh4w/8+jDFQG97b/1Drk53KYcFyYGZOYWJ2C3JEqK
         +vwA2F5Rn+rqI6UdFVdFvx1Ha3NkUFstOpqKZiIAVSS5w90Z6wjo6KdnXH1w9ttMOroL
         jxkg==
X-Gm-Message-State: AD7BkJJ5so+lh4oENt5aicKWIU/Srt5bqJzvLDy+CXq22kYbx0qY7b0iNmW6B1BrQindq5b5BKe8bysLlbC0eck4
X-Received: by 10.50.132.42 with SMTP id or10mr19391402igb.85.1457979442943;
 Mon, 14 Mar 2016 11:17:22 -0700 (PDT)
Received: by 10.107.58.6 with HTTP; Mon, 14 Mar 2016 11:17:22 -0700 (PDT)
In-Reply-To: <xmqq60wra40h.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288796>

On Sat, Mar 12, 2016 at 11:29 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Why is it interesting for submodules but not for standard repositories?
>>
>> If I clone a repository without submodules, it is also not recorded
>> that I cloned with an explicit depth=1. If you fetch, you may end up with
>> a deeper history as git fetch doesn't do a "reshallow" to the configured
>> depth.
>
> Very simple.
>
> If you do not have submodule, you would always interact with the
> other side directly with "git fetch" or "git pull" and have total
> control over when you choose to pass or not to pass extra options to
> choose to 1. incrementally extend, 2. deepen, or 3. unshallow.  The
> user will always explicitly tell you, and knowing how you got there
> would not help you, as there is no need to guess for you.

But the 1. being the default when no options are given, would fit into
the story of submodule treatment here, too?

Say you have run

    $ git clone --recurse-submodules --shallow-submodules --depth 42

and later

    $ git fetch --recurse-submodules

you'd fetch as usual without moving the anchor point. You could have
options like

    $ git fetch --recurse-submodules[=label/pattern]
--unshallow-submodules[=label/pattern]

So first a switch for submodule behavior during fetch and that switch could
be narrowed down to specific submodules only.


>
> The user can do the same explicit "cd dir && git fetch" update in
> each submodule directory and give appropriate options to choose
> among the three, but I have an impression that your recent work is
> going in the direction of making commands that are run in the
> superproject recurse into submodules that automatically fetches and
> updates the history down there, discouraging users from working on
> individual submodules.

Glad you see the high level direction where the submodules are heading,
I was just fixing the most obvious problems (as indicated by their existence
in the "repo" tool).

For the workflow I would think you'd only operate in the supermodule for
synchronizing, e.g.

  $ (cd super_project && git pull --recurse-submodules)
  $ (cd super_project/submoduleA && $EDITOR && git add <...> && git
commit <...>)
  $ (cd super_project/submoduleB && $EDITOR && git add <...> && git
commit <...>)
  # now it becomes a Gerrit specific workflow; no need to commit
submodule changes
  # to the super project, (but it may not do harm?)
  $ (cd super_project && git push --recurse-submodules
--submodules-only origin HEAD:refs/for/master)

The last command pushes submodules only as Gerrit will perform the
superproject update
on your behalf. This is needed as submodules are treated as binary
files, i.e. merging
diverged submodules is hard. So to avoid diverging submodules, Gerrit
can do that for you.

Another workflow could be to improve the merge algorithm for
submodules, such that
you can specify how they should be integrated (merged when no conflict
in the submodules
occurs; or rebase the commits in the submodules, altering the commit
in the superproject.)

>  You lose the flexibility to explicitly
> choose among the three for individual submodules, and you may want
> to have some smart in your "run from the superproject and recurse"
> tools.

But that smart can also come from commandline options (or configuration in
the super project). So you would suggest to configure the superproject
to a certain behavior when you clone with submodules in a certain way?

>
> A submodule that was initially cloned with depth=1, perhaps because
> the user didn't know if the module was interesting to her in the
> context of working on the superproject before she had her clone of
> the superproject hence she only wanted to see what's there, and a
> submodule that was not even fetched initially when the superproject
> was cloned and later was "submodule init"ed and fetched with
> depth=1, would have the same shallow boundary, but the intent of the
> user would clearly be different in the larger picture.  I imagined
> that your "run in top-level and recurse to fetch in submodules"
> tools would benefit if it has more information to intuit what the
> end user meant.

So the first one should be shallowed after fetch, but the second would
fetch or even deepen automatically?

I am not sure if we add too much "intuitive magic" here as it would be
hard to explain why that happens?
