Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EC681F404
	for <e@80x24.org>; Mon,  2 Apr 2018 01:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbeDBBHr (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 21:07:47 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:37057 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753988AbeDBBHq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 21:07:46 -0400
Received: by mail-lf0-f67.google.com with SMTP id m200-v6so12888659lfm.4
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 18:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=CrHSki3Mifu1K2U/FggfwC7csgb1Ynf49oJK4yM7It0=;
        b=t330WCbwRcP/9baymYCS0IvTlhmk7JBYb1kTG62QlmmuNP55pkID7644hgyDGz31zq
         FZLC6jJlasyNZZ6c19poEc6MxdpGlqNuFzQZmpe+E3W2NJut9/0Z+ulHi+GcYER1EnsY
         5CmMxdHQ3gz6WAzE7qlvpu4UsgfOKI0kpqXrkmDuPy7/DmYYioHhtuH877FRsoE0NfOj
         PhohKA27L+E+n04hf9T+lNmObMhfqp2gmdwtzCl2+tbqDU8tfj8d0p1tG3n3PEFfhMUZ
         PlIkUFnOeEme2w/wM/LfGvTfhcehChzCVE3ctK9BSWV2BqNzTOUHB4rB57hF3aNjq/WY
         RJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=CrHSki3Mifu1K2U/FggfwC7csgb1Ynf49oJK4yM7It0=;
        b=SYDaWJgHTDGgwfrhZrawa51KvpXUStt2qvPxN+Jj/nsDW9xVN7aMkvHY9Iuvt+ZmP4
         gZ+689yuPPq0gMPnhNzp+0I7xNNrWuazWTq39TK9XfDVQqe7PkmVk86myFK7iMil0MAT
         gDPlcWpAYSbSXxYR9c/4OfAxpiNSCM0kToG3i70WLyE/nJYGq8rVK7srQhowdAyXggZd
         L8LEN3dLnJ8u46MM+ZL0//XOmJKwVQFouNRP+G7njK4oC9A7TiAAcAv3xUoL3UwoFlPJ
         Fl5bwDpAOLyUtIOgRvqEaZCDUs+M4zNhaL0ge9wfZmtM3D9JSwGHr4fWVTxo9JRUgqKT
         mArw==
X-Gm-Message-State: ALQs6tBhkMHL48FlH+UDXoYzazhOr3nbXWxE1TjqG4Lrih2iJwSYC5Tl
        aC94JVBMk+WDCQnv/6t8L1JV+846kgcIuQ/43wo=
X-Google-Smtp-Source: AIpwx4+rCKEvsKFyKYxniPKUlR1hEUp6VyAMhQ/VGmSlFdW5kqD0uOoNaflObsYQdSNJmUBHMUnPLJF5Bh7WbNJmEJs=
X-Received: by 2002:a19:a60a:: with SMTP id p10-v6mr4652948lfe.41.1522631264557;
 Sun, 01 Apr 2018 18:07:44 -0700 (PDT)
MIME-Version: 1.0
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.46.151.90 with HTTP; Sun, 1 Apr 2018 18:07:43 -0700 (PDT)
In-Reply-To: <CAGZ79kZ_j3_mhk5asNEBgBe_2qD7=18foJgW=p0+p=uJa3U2nw@mail.gmail.com>
References: <20180307211140.19272-1-rcdailey@gmail.com> <CAGZ79kZk7N4zQUS1eMFMPTuPPuo5ViOeLj5hQHV=E+A=OO+D0w@mail.gmail.com>
 <xmqqina56t8h.fsf@gitster-ct.c.googlers.com> <CAGZ79kZ_j3_mhk5asNEBgBe_2qD7=18foJgW=p0+p=uJa3U2nw@mail.gmail.com>
From:   Robert Dailey <rcdailey.lists@gmail.com>
Date:   Sun, 1 Apr 2018 20:07:43 -0500
X-Google-Sender-Auth: z4cRf3-ErB4v05ZrXNd0Ea1VoKM
Message-ID: <CAHd499AraFfWY-L9+RFj2E=p58QK0njyS8dQHEOGHjeoTW=YQw@mail.gmail.com>
Subject: Re: [PATCH] Support long format for log-based submodule diff
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Stefan Beller <stefanbeller@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: multipart/mixed; boundary="000000000000a7dd440568d33754"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--000000000000a7dd440568d33754
Content-Type: text/plain; charset="UTF-8"

On Tue, Mar 27, 2018 at 5:17 PM, Stefan Beller <sbeller@google.com> wrote:
>> >> $ git diff --submodule=log --submodule-log-detail=(long|short)
>> >>
>> >> I'm not sure what makes sense here. I welcome thoughts/discussion and
>> >> will provide follow-up patches.
>> >
>> > The case of merges is usually configured with --[no-]merges, or
>> > --min-parents=<n>.
>
>> But that is a knob that controls an irrelevant aspect of the detail
>> in the context of this discussion, isn't it?  This code is about "to
>> what degree the things that happened between two submodule commits
>> in an adjacent pair of commits in the superproject are summarized?"
>
> And I took it a step further and wanted to give a general solution, which
> allows giving any option that the diff machinery accepts to only apply
> to the submodule diffing part of the current diff.
>
>> The hack Robert illustrates below is to change it to stop favouring
>> such projects with "clean" histories, and show "log --oneline
>> --no-merges --left-right".  When presented that way, clean histories
>> of topic-branch based projects will suffer by losing conciseness,
>> but clean histories of totally linear projects will still be shown
>> the same way, and messy history that sometimes merges, sometimes
>> merges mergy histories, and sometimes directly builds on the trunk
>> will be shown as an enumeration of individual commits in a flat way
>> by ignoring merges and not restricting the traversal to the first
>> parent chains, which would appear more uniform than what the current
>> code shows.
>
> Oh, I realize this is in the *summary* code path, I was thinking about the
> show_submodule_inline_diff, which would benefit from more diff options.
>
>> I do not see a point in introducing --min/max-parents as a knob to
>> control how the history is summarized.
>
> For a summary a flat list of commits may be fine, ignoring
> (ideally non-evil) merges.
>
>> This is a strongly related tangent, but I wonder if we can and/or
>> want to share more code with the codepath that prepares the log
>> message for a merge.  It summarizes what happened on the side branch
>> since it forked from the history it is joining back to (I think it
>> is merge.c::shortlog() that computes this)
>
> I do not find code there. To me it looks like builtin/fmt-merge-msg.c
> is responsible for coming up with a default merge message?
> In that file there is a shortlog() function, which walks revisions
> and puts together the subject lines of commits.
>
>> and it is quite similar
>> to what Robert wants to use for submodules here.  On the other hand,
>> in a project _without_ submodule, if you are pulling history made by
>> your lieutenant whose history is full of linear merges of topic
>> branches to the mainline, it may not be a bad idea to allow
>> fmt-merge-msg to alternatively show something similar to the "diff
>> --submodule=log" gives us, i.e. summarize the history of the side
>> branch being merged by just listing the commits on the first-parent
>> chain.  So I sense some opportunity for cross pollination here.
>
> The cross pollination that I sense is the desire in both cases to freely
> specify the format as it may depend on the workflow.

First I want to apologize for having taken so long to get back with
each of you about this. I actually have a lot of work started to
expand the --submodule option to add a "full-log" option in addition
to the existing "log". This is a pretty big task for me already,
mostly because I'm unfamiliar with git and have limited personal time
to do this at home (this is part of what I am apologizing for). I kind
of get what Stefan and Junio are saying. There's a lot of opportunity
for cleanup. More specific to my use case, adding some functionality
to generate a log message (although I've developed a bash script to do
this since I wrote my original email. I'll attach it to this email for
those interested). Also I get that taking this a notch higher and
adding a new option to pass options down to submodules also addresses
my case. Before I waste anyone's time on this, I want to make sure
that my very narrow and specific implementation will be ideal. By all
means I do not want to do things the easy way which ends up adding
"cruft" you'll have to deal with later. If there's a larger effort to
generalize this and other things related to submodules maybe I can
just wait for that to happen instead? What direction would you guys
recommend?

Junio basically hit the nail on the head with the comparisons of
different mainlines. I think some repositories are more disciplined
than others. At my workplace, I deal with a lot of folks that aren't
interested in learning git beyond the required day to day
responsibilities. It's difficult to enforce very specific branching,
rebase, and merge habits. As such, the best I can do to work around
that for building release notes is to exclude merge commits (since
most of the time, people keep the default message which is generally
useless) and include all commits in the ancestry path (since often
times commits on the right side of a merge will have important
information such as JIRA issue keys, which if shown in the parent repo
will cause appropriate links back to parent repositories to show when
changes in submodules were introduced there as well).

Based on how constructive this email thread has gotten since I started
it, I'm starting to feel like my solution is too narrowly-focused and
doesn't have the long term appeal expected. Let me know, I'm happy to
do what I can but I think it will be limited due to my lack of domain
expertise in the code base and inability to invest the required time
for significant scope of work.

--000000000000a7dd440568d33754
Content-Type: application/octet-stream; name=git-smcommit
Content-Disposition: attachment; filename=git-smcommit
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfhj8lth0

IyEvdXNyL2Jpbi9lbnYgYmFzaAojc21jb21taXQgPSAiIWYoKSB7IGdpdCBjb21taXQgLW0gXCIk
KHByaW50ZiBcIlVwZGF0ZWQgJDEgU3VibW9kdWxlXG5cblwiOyBnaXQgZGlmZiBcIiQxXCIpXCIg
LS1lZGl0IC0tICQxOyB9OyBmIgoKc3VibW9kPSIkezElL30iCgojIENoZWNrIGlmIHRoZSBzcGVj
aWZpZWQgc3VibW9kdWxlIGV4aXN0cy4gSWYgaXQgZG9lc24ndCwgdGhpcyB3aWxsIGhhdmUgYSBu
b24temVybyByZXR1cm4gY29kZS4KIyBUaGlzIHdpbGwgY2F1c2UgdGhlIHNjcmlwdCB0byBleGl0
LiBUaGUgIi4vIiBpbiBmcm9udCBhbGxvd3MgcmVsYXRpdmUgcGF0aHMgdG8gdGhlIHN1Ym1vZHVs
ZQojIGRpcmVjdG9yaWVzIHRvIGJlIHVzZWQgZnJvbSBhbnkgZGlyZWN0b3J5Cmxhc3Rfc2hhMT0k
KGdpdCByZXYtcGFyc2UgIjouLyRzdWJtb2QiIDI+IC9kZXYvbnVsbCkKaWYgW1sgJD8gIT0gMCBd
XTsgdGhlbgogICAgZWNobyAiRVJST1I6IFRoZSBzcGVjaWZpZWQgc3VibW9kdWxlIGRvZXMgbm90
IGV4aXN0IgogICAgZXhpdCAxCmZpCgojIElmIHRoZSBzdWJtb2R1bGUgaGFzIG5vdCBwaHlzaWNh
bGx5IGNoYW5nZWQgKGkuZS4gcG9pbnRpbmcgdG8gYSBkaWZmZXJlbnQgU0hBMSkgdGhlbiB3ZSBk
b24ndAojIGNhcmUuCmRpZmZfcmVzdWx0PSQoZ2l0IGRpZmYgLS1zdWJtb2R1bGU9c2hvcnQgLS1p
Z25vcmUtc3VibW9kdWxlcz1kaXJ0eSAtLSAiJHN1Ym1vZCIpCmlmIFtbIC16ICIkZGlmZl9yZXN1
bHQiIF1dOyB0aGVuCiAgICBlY2hvICJFUlJPUjogVGhhdCBzdWJtb2R1bGUgaXMgYWxyZWFkeSB1
cCB0byBkYXRlIgogICAgZXhpdCAxCmZpCgpjZCAiJDEiCgpnZXRDaGFuZ2Vsb2dzKCkgewogICAg
Z2l0IC0tbm8tcGFnZXIgbG9nIC0tb25lbGluZSAtLW5vLWRlY29yYXRlIC0tbm8tbWVyZ2VzICQx
Li4kMiB8IHNlZCAicy9eLyAgICAvZyIKfQoKY29tbWl0c19mb3J3YXJkPSQoZ2V0Q2hhbmdlbG9n
cyAkbGFzdF9zaGExIEhFQUQpCmNvbW1pdHNfYmFja3dhcmQ9JChnZXRDaGFuZ2Vsb2dzIEhFQUQg
JGxhc3Rfc2hhMSkKCmNkIC0gPiAvZGV2L251bGwKCmJ1aWxkTG9nU2VjdGlvbigpIHsKICAgICMg
JDE6IFRoZSBoZWFkZXIgbWVzc2FnZSBmb3IgdGhlIGdyb3VwIG9mIGxvZ3MKICAgICMgJDI6IFRo
ZSBzdHJpbmcgb2YgbG9ncyB0byBhZGQKICAgIGlmIFtbICEgLXogIiQyIiBdXTsgdGhlbgogICAg
ICAgIGVjaG8gLWUgIiQxXG5cbiQyIgogICAgZmkKfQoKaW50cm9kdWNlZF9zZWN0aW9uPSQoYnVp
bGRMb2dTZWN0aW9uICJJbnRyb2R1Y2VkIENvbW1pdHM6IiAiJGNvbW1pdHNfZm9yd2FyZCIpCnJl
d291bmRfc2VjdGlvbj0kKGJ1aWxkTG9nU2VjdGlvbiAiUmV3b3VuZCBDb21taXRzOiIgIiRjb21t
aXRzX2JhY2t3YXJkIikKCmlmIFsgIiRjb21taXRzX2ZvcndhcmQiIF07IHRoZW4gYWRkc3BhY2U9
JCdcblxuJzsgZmkKCnJlYWQgLXIgLWQgJycgY29tbWl0X21lc3NhZ2UgPDwgRU9GClVwZGF0ZWQg
JHN1Ym1vZCBTdWJtb2R1bGUKCiR7aW50cm9kdWNlZF9zZWN0aW9ufSR7YWRkc3BhY2V9JHtyZXdv
dW5kX3NlY3Rpb259CkVPRgoKZ2l0IGNvbW1pdCAtbSAiJGNvbW1pdF9tZXNzYWdlIiAtLWVkaXQg
LS0gIiRzdWJtb2QiCg==
--000000000000a7dd440568d33754--
