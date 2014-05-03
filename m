From: John Szakmeister <john@szakmeister.net>
Subject: Re: Pull is Mostly Evil
Date: Sat, 3 May 2014 06:00:44 -0400
Message-ID: <CAEBDL5USVuFDXQk7Cb9cJ8Lm4RJNeJB0DwZBCB1cXmkroD8w3g@mail.gmail.com>
References: <5363BB9F.40102@xiplink.com>
	<xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 03 12:00:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgWkT-0002GN-Ji
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 12:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751148AbaECKAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2014 06:00:46 -0400
Received: from mail-yk0-f175.google.com ([209.85.160.175]:56919 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121AbaECKAp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2014 06:00:45 -0400
Received: by mail-yk0-f175.google.com with SMTP id q200so4690432ykb.34
        for <git@vger.kernel.org>; Sat, 03 May 2014 03:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=M7+dB0wtKiJvuizIeqIhPCAlj5llcFblUsdFlzpiqWE=;
        b=lc3jHj1YE0g04h0uKgU96enRAmSMvIA4+U4wIyDYRqaBusOfLWkaL0CKsa/GwgqW5o
         wkxgAu98jQ55Qu2tcLiR0yiLhYpfQSpUHsbc4QVFZkUvG8sFGzB0bjqfMOLjtCXbnlBc
         KV2Lxs+7LKzK8btJJ2bcCiBeC6sZkyOyXf4REqG6JLKj8PHyWJPk2GC7ViPdnJvHyawc
         a5Sg8XEbsNUwv4JlKA3+UxD4q1W9CNLUZTCcWhtqeLmvE5ZqPNVqCKo06ehEIJMm39tO
         ATYA7Fb7lcRaPUyTzX+cGtYpp7RcvIlBHIdw8azWOgqX5WIYxystaPglg+S028+XnVVz
         xvUA==
X-Received: by 10.236.81.6 with SMTP id l6mr30742437yhe.29.1399111244555; Sat,
 03 May 2014 03:00:44 -0700 (PDT)
Received: by 10.170.172.69 with HTTP; Sat, 3 May 2014 03:00:44 -0700 (PDT)
In-Reply-To: <xmqqoazgaw0y.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: RtjiH6SyAf5Dh0bM5Hn61S9cAqo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248032>

On Fri, May 2, 2014 at 2:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
[snip]
> Your earlier long-hand, together with the two examples that pulls
> into the same "maint" branch Brian gave us, may give us a better
> starting points to think about a saner way.
>
> To me, the problem sounds like:
>
>     Tutorials of Git often says "use 'git pull' to catch up your
>     branch with your upstream work and then 'git push' back" (and
>     worse yet, 'git push' that does not fast-forward suggests doing
>     so), but 'git pull' that creates a merge in a wrong direction is
>     not the right thing for many people.

Yes, that's a good portion of the problem.

> And proposed solutions range from "let's write 'pull' off as a
> failed experiment" to "let's forbid any merge made by use of 'pull'
> by default, because it is likely that merge may be in reverse".

FWIW, at my company, we took another approach.  We introduced a `git
ffwd` command that fetches from all remotes, and fast-forwards all
your local branches that are tracking a remote, and everyone on the
team uses it all the time.  It should be said this team also likes to
use Git bare-metal, because they like knowing how things work
out-of-the-box.  But they all use the command because it's so
convenient.

I had started making a C version a while back, but never completed it.
 I could take a stab at doing so again, if there's interest.

-John
