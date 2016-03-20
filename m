From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v8 2/2] commit: add a commit.verbose config variable
Date: Sun, 20 Mar 2016 13:34:57 -0400
Message-ID: <CAPig+cSCrdxYb=0WOiAARrrPK07PeyTKsopPfwDOLAO4m3scnQ@mail.gmail.com>
References: <010201538b98a7e5-ee604368-5a27-4884-b01e-027fa02bf1c6-000000@eu-west-1.amazonses.com>
	<010201538b98aaa4-ad08c159-4935-48f1-acdb-7c376da2c368-000000@eu-west-1.amazonses.com>
	<CAPig+cShT2aPkoRK0pXPzbRbQqCU+O5uEqEr4oMkZ8LTwREaAA@mail.gmail.com>
	<CAFZEwPMZk9jDpi4F9WiYhv4aTqFqn3127i1AUKtNJXwG-11tyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 18:35:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahhGC-0002Le-QW
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 18:35:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbcCTRfE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 13:35:04 -0400
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35543 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbcCTRe6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Mar 2016 13:34:58 -0400
Received: by mail-vk0-f67.google.com with SMTP id e185so14312506vkb.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=PQODFBef/REpNN4exvO6KayHYAHON4262oNrOf7CtLo=;
        b=yNtuGJGQSS0B9sN1saHLD2gmsBEELN0hQfoEnkB8/q5X4awP89wNjcPT9jcvcNKcfB
         VqpTGbemvAdnTqWI3X0n9TR+FEivfD+96jEVG1JsgvVMJXOyF1vN92DUuHaDyxOi9K77
         OqCMNKC9Wi5/Nc7+VqUpXZA5u1Q9p12HLyjp0BkB3Di7qv+kTakRpQtzDbRtOJ728BYr
         +Ac+U4k9wYAVzmk+yGO99kiJdY/+FFi63iYj6IjiX3TPiUoWueyyI/ie+TXWJRr8qPBO
         YCTpzxmzVLpjzyQ+9xAdef/Yn1bq+GNezCPnOhPEBekNAVCsVtqNYmI7Mt1/TuB50Et9
         7rbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PQODFBef/REpNN4exvO6KayHYAHON4262oNrOf7CtLo=;
        b=lvPdHdJLJAzyA51g0YtIJiw0E2mOA5hVd2oVeq/P6yNQmeqcIL8g0T/A1S72S6Q/aX
         S7GlgF381S08ABqEn2DrcVBU/qt9g/ofHKliRBLJfqdA8OAXXVEg4OIPQHPdlGVreSQg
         LawvoSaQeXyQDdxo3aLB2B499aEIh6qf64F1GLiuYv9QWK15qEEQZ20dOag3+7Ojx1UE
         /y2Ze8qvvoyQHWyf+35MuENKVOh3AcsfkqwdskRup0OPMePBxFfAcS7AqR9QL3GxGQUJ
         sZBgyPWkkKizUkddVoWX60KvacUv9Q/r0ysc3SI5XbSj94KlCYzKSNYwJPydrWNqnkDW
         4UMg==
X-Gm-Message-State: AD7BkJJ9MlWgCvi+qcmHPWPOZhq+ASTKQEdg9o7xEj5ylCPkELIYnAu4I1ZHE/XPVC9dj3k0XAIbkkNSDmqQzg==
X-Received: by 10.31.141.2 with SMTP id p2mr28778128vkd.37.1458495297247; Sun,
 20 Mar 2016 10:34:57 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Sun, 20 Mar 2016 10:34:57 -0700 (PDT)
In-Reply-To: <CAFZEwPMZk9jDpi4F9WiYhv4aTqFqn3127i1AUKtNJXwG-11tyw@mail.gmail.com>
X-Google-Sender-Auth: eU8-M5lkbq-QwK8GdfTtEJmRVxY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289370>

On Sun, Mar 20, 2016 at 7:05 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> On Sun, Mar 20, 2016 at 9:26 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> However, more intuitive would probably be to create another "editor"
>> similar to the 'check-for-diff' editor this script already uses. (The
>> 'check-for-diff' editor is an obvious example about how to go about
>> such an undertaking.) You would need to invoke 'test_set_editor' in a
>> subshell for this particular test in order to avoid clobbering the
>> global editor used by this script. Or, have a preparatory patch which
>> ditches the global setting of the editor and has each test invoke
>> 'test_set_editor' as needed (and only if needed).
>
> I guess it would complicate things as sometimes I need to check
> whether it has 1 line and sometimes 2 lines.

It's not really a big complication. If I'm reading the patch
correctly, you should be able to re-use the existing check-for-diff
"editor" for the first of the new tests for which you're currently
setting a custom GIT_EDITOR. To do so, you will need to modify
check-for-diff to also count lines and assert that only one was found,
which should work for the new test and continue working for the
existing tests.

Then, you just need to create one more "editor" for the two tests
where you set custom GIT_EDITOR and expect two lines.

By the way, I forgot to mention in the review that, rather than:

    wc -l out | grep "1"

for counting lines in a test script, you'd use:

    test_line_count = 1 out

However, if you're doing it in an "editor" (which I recommend), then you'd use:

    test $(wc -l <out) = 1

And, another "by the way": You can use the write_script() function to
simplify creation of the new "editor(s)".

In fact, it would be nice to convert creation of the check-for-diff
"editor" to use write_script, as well. So, basically, I'm suggesting
splitting the current patch into three, where the first two are
preparatory cleanups:

1. use write_script() to create the check-for-diff "editor" rather
than creating it manually

2. drop the global test_set_editor() and instead have each test invoke
it as needed (and only if needed)

3. the current patch which adds new tests along with a new "editor"

Alternatively, combine #1 and #2 into a single patch which drops the
global test_set_editor() and, as an aside, also does "while here,
let's use write_script() to create 'check-for'diff' rather than doing
so manually".
