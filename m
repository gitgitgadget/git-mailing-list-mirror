From: Magnus =?iso-8859-1?Q?B=E4ck?= <baeck@google.com>
Subject: Re: more git weirdness (git rebase, merge conflicts
Date: Thu, 28 Mar 2013 12:04:32 -0400
Message-ID: <20130328160431.GB23946@google.com>
References: <51533FB9.7070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 28 17:31:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULFjZ-0003DU-Nb
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 17:31:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab3C1Qa5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Mar 2013 12:30:57 -0400
Received: from mail-la0-f74.google.com ([209.85.215.74]:43785 "EHLO
	mail-la0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756350Ab3C1Qay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 12:30:54 -0400
Received: by mail-la0-f74.google.com with SMTP id fo13so709594lab.1
        for <git@vger.kernel.org>; Thu, 28 Mar 2013 09:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xLgB+NUJP9aKGiW3R8k7zk/H2Pa9m+PTdVJs8eHk4i8=;
        b=YRrHfry/0vJq3eebRgk7wPr0Or9PeUGyubYmFOlh2bTY6yXPwl64fHP4zyei6sjXvj
         tTiqZVmVgoSyuMLT711kbC4UdLcRnxhhJXyYFWtqbZLwkOuPadXbcnrZNPZezPFdiqVT
         zGGx+cjh+gjmf6WtuUA8xsjevRzSNcmkwWkAf0P0qvPN+I8un6FkpXNKgcl+Z41u0kCd
         vSa70EWAf74Rovce4/0CMhx9ss0PX9Blv8qZ1rwpvKMGA9YXebTf7yDVfYI5qWui/RNl
         S0jpzzZJj7urL9osLWN6SDIzzzpyzV/wGtC5sZZZixY6i/LIqSOdJWBjo+fVd4KAHY2S
         gQrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent:x-gm-message-state;
        bh=xLgB+NUJP9aKGiW3R8k7zk/H2Pa9m+PTdVJs8eHk4i8=;
        b=hctA5ylawjoc/kRRbkk3sedl1pDfet8Idp2UIr/5rLZF6UJf47Jjg7hJua4ciG2uvR
         94tqKPn2g+WV5+0RSbKWgxgqk+aSygkkjX10lqgtT2p4O+y9VCNUzRLJPhDy/1CPcjFk
         P+gnMK2eTm9yCyRedwIReYDYW4Ctb64Jb/CGgKGngFSs7XghsUd+Tkli3NHbke3e8+X+
         0K8dsYuTRtMvx2mGB/GDfy3qADwe+DyDcC+CyrrBMwwdD68uSteO4U/al40NMLO7w8Pc
         QPddJjMYFCyPlBCOM/gv3bfM7G7OPUWFaEx21qJCijU63sjEN3DO7tw+gcZ3PS7bzU9h
         fnPw==
X-Received: by 10.15.33.2 with SMTP id b2mr23538227eev.7.1364486673865;
        Thu, 28 Mar 2013 09:04:33 -0700 (PDT)
Received: from corp2gmr1-1.eem.corp.google.com (corp2gmr1-1.eem.corp.google.com [172.25.138.99])
        by gmr-mx.google.com with ESMTPS id 6si5643007eej.0.2013.03.28.09.04.33
        (version=TLSv1.1 cipher=AES128-SHA bits=128/128);
        Thu, 28 Mar 2013 09:04:33 -0700 (PDT)
Received: from valle.nyc.corp.google.com (valle.nyc.corp.google.com [172.26.78.170])
	by corp2gmr1-1.eem.corp.google.com (Postfix) with ESMTP id AACA51CA15E;
	Thu, 28 Mar 2013 09:04:33 -0700 (PDT)
Received: by valle.nyc.corp.google.com (Postfix, from userid 159662)
	id BD0594073E; Thu, 28 Mar 2013 12:04:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <51533FB9.7070307@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnreXIdzG9YILO/hFEQt2D1RK/J8JMSD/a7skdVaGPS8f8nfq0JTJhWO8oI3hbnsdN8VutJe6DOayQDnqPid9w4IjiDVsRvD5PzFTg83ePmodo/EIwG+8TIlm+LwrLoT7EffRMk5Gb+NPOI9HyIJEks4twlJcGUKh/48wfCQVwBUCYhIrwIxSdeppjUSSUd3lIzoWs5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219423>

On Wednesday, March 27, 2013 at 14:51 EDT,
     "J.V." <jvsrvcs@gmail.com> wrote:

> I have a local/development branch tracked to origin/development.  I
> made no changes to local/dev and did a git pull with rebase, I did
> not expect any conflicts.
>=20
> I got a conflict and was thrown onto another branch.  I attempted a
> merge (using IntelliJ) accepting everything from the server but a
> variable definition was missing for some odd reason and the merge
> was not successful (merge was resolved but the file would not
> compile) so I decided to simply go back to my dev branch and figure
> out how to do a git pull -f (force overwrite of all local files so
> that I could get my local/dev back into sync with origin/dev.
>=20
> On my screwed up branch that I was thrust onto:
> I typed:
>     $git rebase --skip            <=3D I was stuck in a rebase (rebas=
e
> failed, was thrown onto a tmp branch and thought this would get me
> out of there)

The --skip option makes Git skip one commit in the rebase. To bail out
completely and restore the original state, use --abort.

> Now I have been sitting here for an hour watching  "Applying:
> <message" scroll by and it looks like the messages are going
> backwards into the past one by one.  What the hell is happening?
>=20
>     Applying: add log information
>     Applying: <previous message
>     .... and it goes on and on and on.

You initated a rebase with an incorrect base, so Git is rebasing all
past history onto a new base. Say the upstream repository looks like
this, with uppercase letters denoting commits found on the upstream
and lowercase letters being your local commits (if any):

           ----------C
          /
     A----B---
              \
               ------------D----E
                           \
                            --a--b

In this example, you've made two commits since you started working on
commit D. The expected result for a rebase is for Git to rebase the two
commits you've made since D (a, b) and put them on top of E, the new
baseline fetched from the upstream. However, because of how you invoke
the rebase, Git actually thinks that C is the base of your local branch
and computes all the commits you've made since C and finds all commits
between B and b, which it now tries to rebase on top of C.

> All I want to do at this point is to get back to my dev branch and
> force pull from origin/dev while keeping all local files that have
> not been added to my local repo.
>=20
> How do I stop this madness and get back to local dev and force pull
> from origin/dev     <=3D which is our master.

Start with "git rebase --abort" to get out of the rebase loop. To delet=
e
all your local uncommitted changes made to tracked files while keeping
local/untracked files, run "git reset --hard". If you haven't made any
local commits a correctly invoked rebase (or pull) will be a trivial
fast-forward.

--=20
Magnus B=E4ck
baeck@google.com
