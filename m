From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Transaction patch series overview
Date: Wed, 20 Aug 2014 16:17:23 -0700
Message-ID: <20140820231723.GF20185@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 01:17:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKF8I-0000My-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 01:17:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbaHTXRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2014 19:17:30 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:38387 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229AbaHTXR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2014 19:17:29 -0400
Received: by mail-pa0-f50.google.com with SMTP id et14so12901942pad.37
        for <git@vger.kernel.org>; Wed, 20 Aug 2014 16:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=4HNQAlYqvs4Gqwo9XnNznDqH/kMvusjE2/ijg/VHd5Q=;
        b=pBjlROlf6zLuWQWxsk8jVZU9EjRawgbzYNZ9/3TTyovxD6cH7s4ZXzMyZdqSwiuQA3
         Ndll/3bjhp/l9lcnjZnysBeZKM7a4UFrR32MWVnksFUvTJ9XHJ09v1BX5SQI66p5G592
         kOv41/QUTatM0u37fAuroQA26rDkfbmKAoyy9nRNvfcsbkA0BCAFd8fZank/BeYoIDMG
         lr63eOHSktg6hVhSrMgN3Zz5K2cI896pvoxGBs1Vhoga3L4n9m3YYimeOihOGpWxfDJV
         qHYilaTAxLmF+ZQl7oUrBJHywBbK8DW6o8zq5TcubTpNW/EBKCtoDT2iFUDG6wbMsq38
         r1LA==
X-Received: by 10.66.139.232 with SMTP id rb8mr56980233pab.130.1408576645848;
        Wed, 20 Aug 2014 16:17:25 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:2490:21da:8eb0:dc73])
        by mx.google.com with ESMTPSA id zh7sm84492088pab.1.2014.08.20.16.17.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 20 Aug 2014 16:17:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255593>

Hi,

Ronnie Sahlberg wrote:

> List, please see here an overview and ordering of the ref transaction
> patch series.

Thanks much for this.

[...]
> rs/ref-transaction-0
[...]
> Has been merged into next.

This is even part of "master" now, so if people have review comments
then they can make them most easily by submitting new patches on top.

> ref-transaction-1 (2014-07-16) 20 commits
> -------------------------------------------------------------
> Second batch of ref transactions
>
>  - refs.c: make delete_ref use a transaction
>  - refs.c: make prune_ref use a transaction to delete the ref
>  - refs.c: remove lock_ref_sha1
>  - refs.c: remove the update_ref_write function
>  - refs.c: remove the update_ref_lock function
>  - refs.c: make lock_ref_sha1 static
>  - walker.c: use ref transaction for ref updates
>  - fast-import.c: use a ref transaction when dumping tags
>  - receive-pack.c: use a reference transaction for updating the refs
>  - refs.c: change update_ref to use a transaction
>  - branch.c: use ref transaction for all ref updates
>  - fast-import.c: change update_branch to use ref transactions
>  - sequencer.c: use ref transactions for all ref updates
>  - commit.c: use ref transactions for updates
>  - replace.c: use the ref transaction functions for updates
>  - tag.c: use ref transactions when doing updates
>  - refs.c: add transaction.status and track OPEN/CLOSED/ERROR
>  - refs.c: make ref_transaction_begin take an err argument
>  - refs.c: update ref_transaction_delete to check for error and return status
>  - refs.c: change ref_transaction_create to do error checking and return status
>  (this branch is used by rs/ref-transaction, rs/ref-transaction-multi,
> rs/ref-transaction-reflog and rs/ref-transaction-rename.)
>
>  The second batch of the transactional ref update series.
>
> Has been merged into pu

Last reviewed at
http://thread.gmane.org/gmane.comp.version-control.git/252226, if
I am using gmane search correctly.

Are there any pending questions for this part?

I've having trouble keeping track of how patches change, which patches
have been reviewed and which haven't, unaddressed comments, and so on,
so as an experiment I've pushed this part of the series to the Gerrit
server at

 https://code-review.googlesource.com/#/q/topic:ref-transaction-1

It's running a copy of gerrit code review
(https://code.google.com/p/gerrit).

Maybe this can be useful as a way of keeping track of the state of
long and long-lived series like this one.  It works something like
this:

Preparation
-----------
Get a password from https://code-review.googlesource.com/new-password
and put it in netrc.

Install the hook from
https://code-review.googlesource.com/tools/hooks/commit-msg to
.git/hooks/commit-msg.  This automatically populates a Change-Id
line in the commit message if none is present so gerrit can
tell when you are uploading a new version of an existing patch.

(The commit-msg hook can be annoying when not working with gerrit
code review.  To turn it off, use 'git config gerrit.createChangeId false'.)

Uploading patches
-----------------
Write a patch series against 'maint' or 'master' as usual, then push:

	git push https://code.googlesource.com/git \
		HEAD:refs/for/master; # or refs/for/maint

There can be a parameter '%topic=<name>' after the refs/for/<branch>
(e.g., refs/for/master%topic=ref-transaction-1) if the series should
be labelled with a topic name, or that can be set in the web UI or
using the HTTP API after the fact.

Commenting on patches
---------------------
Visit https://code-review.googlesource.com.  Patches can be found
under "All" -> "Open".  Patches you're involved with somehow are
at "My" -> "Changes".

To prepare inline comments, choose a file, highlight the text to comment
on or click a line number, and comment.

To publish comments, go back up to the change overview screen (using
the up arrow button or by pressing "u"), click "Reply", and say
something.

'?' brings up keyboard shortcuts.

Downloading patches
-------------------
In the change overview screen, there's a 'Download' menu in the
top-right corner with commands to download the patch.

Revising patches
----------------
After modifying a patch locally using the usual tools such as rebase
--interactive, push again:

	git push https://code.googlesource.com/git \
		HEAD:refs/for/master; # or refs/for/maint

When a patch seems polished
---------------------------
Get rid of the Change-Id lines --- they shouldn't be needed any
more.  Send the patches or a request to pull from a public git
repository, as usual.  A link (in the top-left corner where it says
'Change 1000', the "1000" is a link to the change) can be helpful
for letting people on-list see how the patch got into the form it's
in today.

Maybe it can be useful.

Thanks,
Jonathan
