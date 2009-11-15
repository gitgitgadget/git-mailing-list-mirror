From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about "git pull --rebase"
Date: Sun, 15 Nov 2009 15:31:06 +0100
Message-ID: <m2r5rzoo5x.fsf@gmail.com>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
	<20091115081649.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 15:31:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9g8M-0001Ps-M6
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 15:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753140AbZKOObG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 09:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753134AbZKOObG
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 09:31:06 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:23820 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753124AbZKOObE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 09:31:04 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1627398eyd.19
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 06:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=spWaWUrOdMBzLn4/jAau6I5GhvWNQ8hQvH2GhxNgiLw=;
        b=WsiMg9h4EGRAM08G2NrCpANESVpvmw/ZbxXea+zMk1lAkFOjHkVScIvNnLHKCPz9hT
         pWrxk5b17ntDmUru6fiEmXJ7lMMH6U1LVlu1o3kGnuklKcgvFbSsdeH9jyPgHZETSNY9
         H4AeWRrq0N1gHohDQstyJa1mBspSmZ8kqAQto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=VlZo44oNy/ONwkJc0tDuXf/gvC3QqfTYyHau6puEIFvdgg4HXEoO1S/u7146iYdfng
         sPbPXYNqR6SvUow/bGStyfZpD/FNhi///88ZI6hTKfold4RI91bTYgLPCW6qms5++gqz
         4kl30G/CSRBCoVG+XOOTt3eKInfSdvTD6+Klg=
Received: by 10.213.104.5 with SMTP id m5mr480124ebo.40.1258295469729;
        Sun, 15 Nov 2009 06:31:09 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id 23sm4859397eya.12.2009.11.15.06.31.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 06:31:07 -0800 (PST)
In-Reply-To: <20091115081649.6117@nanako3.lavabit.com> (Nanako Shiraishi's
	message of "Sun, 15 Nov 2009 08:16:49 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132941>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Francis Moreau <francis.moro@gmail.com>
>
>> Let's say I'm on a branch called 'foo'.
>> ...
>>     $ git pull --rebase origin master:foo
>
> With this command line, you are asking:
>
>  1) Please first fetch master from origin and update the local 
>     'foo' with it, but please fail if this doesn't fast forward;
>
>  2) If the first step was successful, please rebase the current 
>     branch on top of that commit.
>
> If your current branch 'foo' doesn't fast forward, the first step 
> should fail, and that is the failure you saw.
>
> Your request doesn't make any sense. The first step would succeed 
> only when your 'foo' doesn't have anything to replay on 'master' 
> from origin, and the second step either isn't executed (when 'foo' 
> has some commits), or it doesn't do anything (when 'foo' doesn't 
> have any commit).
>
>>     $ git pull --rebase origin master
>
> With this command line, you are asking:
>
>  1) Please first fetch master from origin, but don't store it anywhere;
>
>  2) Then on top of that fetched commit, please rebase the current branch.
>
> That is a much saner request.

I see thanks.

Actually I've been confused by the following part of the git-pull man
page:

    A parameter <ref> without a colon is equivalent to <ref>: when
    pulling/fetching, so it merges <ref> into the current branch without
    storing the remote branch anywhere locally

So it sounds that both of the pull commands were equivalent whereas
they're not.

-- 
Francis
