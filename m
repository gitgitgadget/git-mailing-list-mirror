Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5B1C3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 16:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B33F121974
	for <git@archiver.kernel.org>; Sat,  2 May 2020 16:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bpngET+q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgEBQVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 12:21:52 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57934 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbgEBQVw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 12:21:52 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B6307CA9BB;
        Sat,  2 May 2020 12:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SC52xIVzmKW7cy6cE9zi5sJSmLY=; b=bpngET
        +qbf4Gtyy4g+Q9iZhVsO/Ut7hHLL2ML5ZdzfvdvXQZYL9t59FqziO1oeuv9jIJCT
        Oq4e+ZzbhuZQTI9RoIakt8ApQcB8BtjMh0VuQhP6OLlFIKZwqKxOM+WAHhpfQq9U
        tpvlj3M/NwlxRqFHzH9XqbGSm0zZbBTIYeU2g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RuFtZ3+yPqg7zCMqfy4Cyo931A7H9CkR
        9BsDiHYs+FGNutQRLadGliWR4RXfSoPh1IK9DODhzEEGgayCdxRA8nXtBKtoJtXM
        fFnTCvxjODFoOlVp5/e1oOJ79t3DQPm+h2KqQMb6lgSGbt/f3h/4Gz7J/Xta3uIW
        pUBpsXeCLmk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AF0C7CA9BA;
        Sat,  2 May 2020 12:21:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F0F0ACA9B9;
        Sat,  2 May 2020 12:21:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Danh Doan <congdanhqx@gmail.com>
Cc:     Dmitry Kulikov <dima@koulikoff.ru>, git@vger.kernel.org
Subject: Re: git log --since=<date>
References: <3860060.ab4mYtCOl4@hp470>
        <xmqqd07nl3dt.fsf@gitster.c.googlers.com> <42953119.Wv2erQna2g@hp470>
        <20200502110350.GA3143@danh.dev>
Date:   Sat, 02 May 2020 09:21:44 -0700
In-Reply-To: <20200502110350.GA3143@danh.dev> (Danh Doan's message of "Sat, 2
        May 2020 18:03:50 +0700")
Message-ID: <xmqqzhaqjoiv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04641B4A-8C91-11EA-92D1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Danh Doan <congdanhqx@gmail.com> writes:

> On 2020-05-02 07:54:03+0200, Dmitry Kulikov <dima@koulikoff.ru> wrote:
>> On Friday 01 May 2020 15:03:10 Junio C Hamano wrote:
>> > You of course can say "git log --since=yesterday.midnight" if you
>> > want to be exact ;-).
>> 
>>   What should I enter instead --since=2020-05-01 to have a midnight time?
>
>
> You can use the same syntax:
>
> 	git log --since='2020-05-01 midnight'
> 	# or ISO-8601
> 	git log --since='2020-05-01 00:00:00'

Perhaps the use of <date> in the documentation is what is causing
this confusion?  Would <timestamp> or <datetime> work better?

There is Documentation/date-formats.txt that is included by the help
pages for "git commit-tree", "git commit" and "git tag".  These pages
consistently use "date" and does not say timestamp nor datetime, so
the noun we use in "git log" documentation is OK.

But the date-formats documentation is not included there, so we
would be OK once we

 (1) adjust the contents of the date-formats.txt documentation to
     make sure it can be used in "git log" documentation, and

 (2) find the right place to include it in "git log" documentation.

Here is a rough draft to do so.  I was tempted not to touch
git-log.txt and instead include it in rev-list-options.txt (where
"--since" and friends are described), but the structure of the
document was not ready for that.  If somebody wants to go in that
direction, it might be better as it would allow us to cover things
like "git shortlog --since=3.months.ago", but then we probably
should do the following before we can do so:

 (1) remove the section title and its header level from
     date-formats.txt, and adjust the existing pages that include
     it, and

 (2) find the right place in rev-list-options.txt, and

 (3) make sure everybody that includes rev-list-options.txt are
     happy with the added description (if some of them do not offer
     an option to specify ranges, they must conditionally be
     excluded from using date-formats.txt).

Thanks.

 Documentation/date-formats.txt | 25 ++++++++++++++++++-------
 Documentation/git-commit.txt   |  1 -
 Documentation/git-log.txt      |  2 ++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
index 6926e0a4c8..ce6f6bdb95 100644
--- a/Documentation/date-formats.txt
+++ b/Documentation/date-formats.txt
@@ -1,11 +1,10 @@
-DATE FORMATS
-------------
+DATE INPUT FORMATS
+------------------
 
-The `GIT_AUTHOR_DATE`, `GIT_COMMITTER_DATE` environment variables
-ifdef::git-commit[]
-and the `--date` option
-endif::git-commit[]
-support the following date formats:
+The `GIT_AUTHOR_DATE`, `GIT_COMMITTER_DATE` environment variables,
+the `--date` option of `git commit`, and
+the options like `--since` of `git log`,
+all of which specify date-time, support the following date formats:
 
 Git internal format::
 	It is `<unix timestamp> <time zone offset>`, where `<unix
@@ -24,3 +23,15 @@ ISO 8601::
 +
 NOTE: In addition, the date part is accepted in the following formats:
 `YYYY.MM.DD`, `MM/DD/YYYY` and `DD.MM.YYYY`.
++
+NOTE: Some human-friendly date and time (e.g. `yesterday`,
+`midnight`, `4 days ago`) are also accepted.  
+The full list is left as trivia for readers to discover.
++
+NOTE: A date-time that lacks time-part is taken to be the same time on
+that day.  For example, `yesterday` used at 8 in the morning means 8 in the
+morning yesterday.  A date-time that lacks date-part is taken to be
+the given time on the same day (if the time has already passed) or
+on the day before (otherwise).  For example, `8AM` used at 9 in the morning
+means an hour ago the same day, while `noon` used at 9 in the morning 
+is taken as the noon the day before.
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index a3baea32ae..70cf5d9d4f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -494,7 +494,6 @@ the environment variables.
 The typical usage is to set just the `user.name` and `user.email` variables;
 the other options are provided for more complex use cases.
 
-:git-commit: 1
 include::date-formats.txt[]
 
 DISCUSSION
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e6d21a74..d2bda18d45 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -109,6 +109,8 @@ options or the revision range, when confusion arises.
 
 include::rev-list-options.txt[]
 
+include::date-formats.txt[]
+
 include::pretty-formats.txt[]
 
 COMMON DIFF OPTIONS
