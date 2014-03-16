From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH] Rewrite diff-no-index.c:read_directory() to use is_dot_or_dotdot() and rename it to read_dir()
Date: Sun, 16 Mar 2014 12:07:20 +0100
Message-ID: <87eh22xuzb.fsf@thomasrast.ch>
References: <1394800759-87648-1-git-send-email-akshayaurora@yahoo.com>
	<CAPGnZZn_Wz=LywVevmuXWQX4nO67EKMPazB8jKv-jTZ178=HdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Akshay Aurora <akshayaurora@yahoo.com>
X-From: git-owner@vger.kernel.org Sun Mar 16 12:07:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WP8uq-0000dT-SW
	for gcvg-git-2@plane.gmane.org; Sun, 16 Mar 2014 12:07:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066AbaCPLHe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Mar 2014 07:07:34 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:56800 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbaCPLHd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Mar 2014 07:07:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A1E9F4D6510;
	Sun, 16 Mar 2014 12:07:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 4weOiAitfefk; Sun, 16 Mar 2014 12:07:20 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id A4FFD4D64BD;
	Sun, 16 Mar 2014 12:07:20 +0100 (CET)
In-Reply-To: <CAPGnZZn_Wz=LywVevmuXWQX4nO67EKMPazB8jKv-jTZ178=HdQ@mail.gmail.com>
	(Akshay Aurora's message of "Sat, 15 Mar 2014 12:14:18 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244187>

Akshay Aurora <akshayaurora@yahoo.com> writes:

> Forgot to mention, this is one of the microprojects for GSoC this
> year. Would be great to have some feedback.
>
> On Fri, Mar 14, 2014 at 6:09 PM, Akshay Aurora <akshayaurora@yahoo.com> wrote:
>> I have renamed diff-no-index.c:read_directory() to read_dir() to avoid name collision with dir.c:read_directory()
>>
>> Signed-off-by: Akshay Aurora <akshayaurora@yahoo.com>

Hmm, the original mail never made it through to me, and gmane doesn't
seem to have it either.  What happened here?  The headers suggest you
used git-send-email, which should avoid these problems.  Can you dig up
the command and configuration you used to send it (but be careful to not
post your password!)?

On the patch itself:

> Subject: Re: [PATCH] Rewrite diff-no-index.c:read_directory() to use is_dot_or_dotdot() and rename it to read_dir()

The subject line is very long.  Aim for 50 characters, but certainly no
more than 72.

You are also conflating two separate things into one patch.  Try to
avoid doing that.

Furthermore I am unconvinced that renaming a function from
read_directory() to read_dir() is a win.  What are you trying to improve
by the rename?  Renames are good if they improve clarity and/or
consistency, but read_dir() just risks confusion with readdir() and I
cannot see any gain in consistency that would compensate for it.

>> I have renamed diff-no-index.c:read_directory() to read_dir() to avoid name collision with dir.c:read_directory()

Please stick to the style outlined in SubmittingPatches:

  The body should provide a meaningful commit message, which:

    . explains the problem the change tries to solve, iow, what is wrong
      with the current code without the change.

    . justifies the way the change solves the problem, iow, why the
      result with the change is better.

    . alternate solutions considered but discarded, if any.

  Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
  instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
  to do frotz", as if you are giving orders to the codebase to change
  its behaviour.  Try to make sure your explanation can be understood
  without external resources. Instead of giving a URL to a mailing list
  archive, summarize the relevant points of the discussion.

Also, please wrap your commit messages at 72 characters.

>> ---
>>  diff-no-index.c | 9 +++++----

The microproject idea said

  Rewrite diff-no-index.c:read_directory() to use
  is_dot_or_dotdot(). Try to find other sites that can use that
  function.

Are there any others?

-- 
Thomas Rast
tr@thomasrast.ch
