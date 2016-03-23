From: Stefan Beller <sbeller@google.com>
Subject: Re: Issue with git submodule update --init --depth=1 submodA
Date: Wed, 23 Mar 2016 10:19:43 -0700
Message-ID: <CAGZ79kaTACBvBNwAumK035fWG8qooh31JpoooyUmGZEL+4mpOg@mail.gmail.com>
References: <CAECUmHo8Q=N_rTP7NnYaQJ24g9SVrgCmpq1NHVXe1icD6xn7vw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jared Davison <jared@medical-objects.com.au>
X-From: git-owner@vger.kernel.org Wed Mar 23 18:20:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aimSB-0001px-Sh
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 18:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100AbcCWRUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 13:20:12 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:34787 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756078AbcCWRUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 13:20:11 -0400
Received: by mail-io0-f173.google.com with SMTP id m184so52574354iof.1
        for <git@vger.kernel.org>; Wed, 23 Mar 2016 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=BVrausPNKVq1L7U3cNtuA8x9kYbLQRSqjGeeSWUjl/0=;
        b=kKQATJjFotvHUY6gb75HYrPbx/B8iln3HpUL/jamb27JC6B/+mGLdadQ9ZHWWHh01Q
         sALKSzhsJtyGg0Isq8XDq1F3ctVvLf6REVHZNKZK6j2+v3wGJZ94i/Dx/7E9H7veLT+G
         AqoQ72Oem2bzm+UBfkRmafpGfqE8wMwYdT+2Erx5DRwp6IBPEXEX2ptiERHB4FkYVyVD
         dfh3w+atSTz2PVYXP+6t8JDKxzhGMfAXeaczUbKKRKPk0dyCJtc3krR2M6IfN1oDjiE7
         4BMnRV3wMXUTwz4VCCcZ/N26l38C5yAQNsK6PPcVh82jScNjp7d/74JQZWGPiHrrzIJP
         UEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=BVrausPNKVq1L7U3cNtuA8x9kYbLQRSqjGeeSWUjl/0=;
        b=T/6qup8MKWTJAU8JB2UYr5hSYhUR0e+97YCMyYHBz/RdajWcrWx9t4DZnPpBnqZ+Ts
         A71Ap1e21KEZKAWGINEASGYKrnYgd8YbyJg4aMJBUWA+tJwC5OyVqX0u85KAPfHuvbkt
         Lrb+mJtKFfwRlU/+Ji/DhWy63mNM0vjfoCM4/2oU1/F+Q/yhpCSoqj5m4QE6hlOxW7Im
         GOEiCyyE8wKAEiFMTBPtY9zk8ptLxf6MVHycwvj8v/M63cKrUj7LNEzWt39PMdYdefsu
         z+WsqG3XCozFdykO7tlex2Vup+pkeZKiOIe0ywCYZ80LsvEB6J6+ahfFL20LyPeC5Bpn
         UOaw==
X-Gm-Message-State: AD7BkJKlwqbO3aqb7E9oR9K5UQyYu5jijhTEksViDB+lBp8g2Jkimrp0tyg5NZ2/Li2YNd2zuLe6WVgE+pqtpXEx
X-Received: by 10.50.28.105 with SMTP id a9mr10414723igh.94.1458753583242;
 Wed, 23 Mar 2016 10:19:43 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Wed, 23 Mar 2016 10:19:43 -0700 (PDT)
In-Reply-To: <CAECUmHo8Q=N_rTP7NnYaQJ24g9SVrgCmpq1NHVXe1icD6xn7vw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289669>

On Wed, Mar 23, 2016 at 1:28 AM, Jared Davison
<jared@medical-objects.com.au> wrote:
> Hello all,
>
> I have encountered a problem with using submodules.
>
> The problem occurs when using
>
> repo-parent$ git submodule update --init --depth=1 submodA
>
> Submodule 'submoduleA' (.../submoduleA.git) registered for path 'submoduleA'
> Cloning into 'submoduleA'...
> Fetched in submodule path 'submoduleA', but it did not contain
> 8a1c22151b510160d7b41a019d7642ab2cd5e085. Direct fetching of that
> commit failed.
>
> Note the --depth=1 argument.

This is somewhat expected. The depth argument tells Git to cut off the commit
graph such that there is only 1 commit, the rest should not be there.
If you reference a commit in the missing rest, you have an issue as that commit
cannot be found.

As a workaround we try to fetch the missing sha1 if the remote allows it.
(You remote doesn't, so "Direct fetching of that commit failed.")

>
> This all works fine if the head of the submodA master branch is the
> revision required by the repo-parent as shown in "git submodule list"
>
> However, if submodA's history has progressed by one commit, then
> --depth=2 is required and this works fine. --depth=1 will no longer
> work and gives the error as above.
>
> Does depth always have to be counted from the head or most recent
> commit in the submodule branch?

The way it currently works, it is always counted from the most recent commit
in the branch.

>
> Could depth be counted from the required commit reference by the
> parent repo instead of the most recent? If so then --depth=1 could
> work I think.

That sounds interesting. :)
But it may get confusing fast:
* Which reference commit do you mean in the parent? (The topmost commit
  I would assume?)
* Up to now the submodule is a self sufficient repository, i.e. it doesn't need
  to know about the parent project and could still work great as a standalone
  repository. By making depth dependent on the parent project, would there be
  a difference in
    cd <submodule> && git fetch --depth 12
  and
    git submodule update --depth 12 <submodule>
  ?

I thought about adding a new commandline flag instead of overloading depth.
--submodule-enclosure=<n> or such to mean "get all commits the parent is
referencing in its topmost <n> commits".

>
> The reason I would like to do this is that the history actually
> contains some fairly large files and I wish to clone only the history
> for the current version of the files in that most recent commit. This
> all works great until someone pushes a commit into the submodule. I am
> using this as part of a continuous integration process which will
> build branches that reference submodules where the referenced commit
> may go back a long way back in history.
>
> Trying to determine the correct depth parameter value to use is
> impossible as with time it will be a growing amount as commits are
> added to the submodule branch.

Yeah you would rather want a --since=<sha1-or-tag> instead of a --depth
argument I'd assume?

>
> Another user found the same issue:  http://stackoverflow.com/a/25875273
>
> I have just compiled the git from "next" branch source, "git version
> 2.8.0.rc4.233.g1aaf96d" and have confirmed this is still the
> behaviour.
>
> Thanks for reading my enquiry and for your thoughts on this topic.
>
> Jared
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
