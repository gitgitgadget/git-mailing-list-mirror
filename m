From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] format-patch: Add config option format.coverbodytext
 to change the cover letter body
Date: Tue, 6 Jan 2015 10:08:46 -0800
Message-ID: <CAGZ79kabhx1q2pxY0_UXAy64G94GQZaP4nSUgeUjV0c_sjt+QQ@mail.gmail.com>
References: <1420486105-30242-1-git-send-email-sbeller@google.com>
	<xmqqzj9wp52y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 06 19:09:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8YYm-00034T-9j
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 19:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544AbbAFSIs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 13:08:48 -0500
Received: from mail-ig0-f178.google.com ([209.85.213.178]:51003 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754472AbbAFSIq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 13:08:46 -0500
Received: by mail-ig0-f178.google.com with SMTP id b16so3824966igk.11
        for <git@vger.kernel.org>; Tue, 06 Jan 2015 10:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=EyurpaO+E9L9NNlpSIYshV2KBwBTBeB3SWuUx5NpJK4=;
        b=FkkFfg0C4SWcHC2tv9O8pMHlb6hxPkJI/Q4661VOABbMx9kKkAWbxm9UlIarRjdEqN
         MWb5aGaH7lJ9PmAVpdlFOh5mfsfH7COrM6qOLhy3s3yyQnRJh+b6NmKUgLactwCmW7HJ
         hJv3QNg4TLkT+hZxTLeHHyeN+TfQkATH7k3wjcvkJ9cAF3uXOOS73l9EfxsNWRCZ/czW
         OJeYeefAKhBq2jusMLaLJCepXTWAe0xbGt4PPIcC2VGrbR9T63foDDPzm74jQcOaa8Cy
         ShGZ0s1P4bUyWBoEmUS7V5XxaOVJejjgd5oNt7OgM/7u1DrtpOa14VtbRPorJWHazRI2
         Jdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EyurpaO+E9L9NNlpSIYshV2KBwBTBeB3SWuUx5NpJK4=;
        b=gxuaxAC0BqIh4YLh+AXk5NB0J+Qcn9FPFCXa3hGxK5r5c270yu7wctQbY0Gdr5nxUe
         unqoAj/L+o6gZ9ywhUDJAmFLtxcBcUcXmr8rC5y94iJo7nr09RRE6axdd7siIkh56G8V
         fqp/ivTVE63irH8V/EIuIu6FrGHZIDeVDC2AL3xoc6uGB5SJR0e4fpNkFI1u5g5sDBCN
         WdNL/G1zw3iUUcXLHy8dGZ8MaweFMiqIv5zUeWWwJIWIe8meF9+rEHtI3ZD6IFc1/ox6
         LcnBpjMv4JQHEzuujrE5I5ONY0j0mvivybAH7cs61S8RilCvZo9K7qn9dAUCVixD5IBI
         sYcQ==
X-Gm-Message-State: ALoCoQlTwxA9P1iC2S2V/EULPic7wbOMmir54DuSy7+swjl/SQaR5vWVS0ULXaymFgFc58PXZMx2
X-Received: by 10.43.82.72 with SMTP id ab8mr75008260icc.76.1420567726171;
 Tue, 06 Jan 2015 10:08:46 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 6 Jan 2015 10:08:46 -0800 (PST)
In-Reply-To: <xmqqzj9wp52y.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262081>

On Tue, Jan 6, 2015 at 2:37 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When sending out patch series one of the last things doing is writing
>> the cover letter. The cover letter would be a good place to remind
>> people to check the todo list for sending patches.
>
> I do not quite understand.  Wouldn't a check-list be useful _before_
> you start series of things (I am assuming that you meant a list like
> 1. run spell check; 2. run checkpatch; 3. run full test suite;
> 4. format the docs for HTML and manpage)?  Time to write cover
> letter (or running format-patch in general) is way too late for
> many of these things.

Actually I do mean these things.
As I have all changes to be sent in branches, each commit having all the
notes, sending them to the mailing list is becoming less of a hassle.
All I need to do is

    git format-patch --cover-letter --notes -subject-prefix=PATCHvX
origin/master.. &&
    $editor 0000-cover-letter.patch &&
    git send-email 00* --to=git@vger.kernel.org --cc=...

There is *no* postprocessing of other *.patch files apart from the cover letter
involved any more in my workflow. If something needs to change I need to
change it directly in the commit with

    git rebase -i origin/master
     ... and edit/reword the specific patch

By choosing this way of working I am able to send out any branch for review
in a heartbeat. I think the advantage of this approach is to have git
support for
most of the time, i.e. I can use gitk for reviewing my patches
including notes as
well as inspecting the filesystem. Also I try to force myself into
reviewing each
patch twice (with time in between) before sending it out for public review.

The disadvantage is that I need to have the high quality in a branch before
sending it out for review. But I personally find it easier to deal
with git branches
than with patch files of different versions. Branches do not forget
anything once
I edited it in which turns that point into an advantage for me.

>
> There may be a check-list that is still useful after commits to be
> sent are perfect and ready to be formatted.

> "Describe change since
> the last round after three-dash line." would be one of them
> ("Sign-off the patch" is not---without one, the commits would not
> have been perfect yet).

But how do I know if a patch is perfect?
By checking all points of my checklist for each patch. But during the
iterations of reviews, patches come and go, so I need to have
a checklist after I think each patch is perfect on its own.
So what about:
    * Are the patches in the correct order? (Implement the feature
      before advertising it)
    * Do some of the patches still make sense in the context of this
      series? (Sometimes the focus of a series changes quite a bit
      after input from reviewers, so some patches may be dropped)


> But for such a check-list, wouldn't we want
> remainder not only on the cover but on each individual patch?

>
> Perhaps --add-header="x-reminder: what changed since the last?"
> would be sufficient for your purpose instead?

I am not quite sure if that is my problem any more. Say I have the
following check list:
* Do I follow the coding style?
  * indentation by tabs and spaces
  * no superfluous braces

* The code itself
  * Does it embed into the current logic flow?
  * memory leaks?
  * Does it compile and test (git rebase --exec=make --exec="make test") ?

* Is a patch small enough?
  * Does it do one thing? (move code or add code, not both!)

* Do I have a proper commit message?
  * spelling and grammar
  * Does the commit message (still) describe the changes of the patch?

* After doing changes, wait at least 12 hours for second self-review

* sending out:
    git format-patch --cover-letter --notes --subject-prefix=PATCHvX

Most of it is on a per-patch basis, but it is easier to check for the whole
branch/series in one go after some time when you found some mental
distance to the code you wrote yourself. And for me this is usually
the next day, when I review it again and ask myself: Do I send out or not?

As you can see there may be quite some discussion on what you want
to put into that check list, hence it should be configurable. We could of
course think about pre-populating the check list for new comers.

Thanks,
Stefan
