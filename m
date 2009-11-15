From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: Question about "git pull --rebase"
Date: Sun, 15 Nov 2009 15:34:23 +0100
Message-ID: <m2my2noo0g.fsf@gmail.com>
References: <38b2ab8a0911141239w2bab7277o66350bc742d985dd@mail.gmail.com>
	<4AFF3D4D.7000308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan 't Hart <johanthart@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 15:34:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9gBU-0002jY-So
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 15:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753124AbZKOOeV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 09:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZKOOeV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 09:34:21 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:63683 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752950AbZKOOeU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 09:34:20 -0500
Received: by fxm21 with SMTP id 21so1893616fxm.21
        for <git@vger.kernel.org>; Sun, 15 Nov 2009 06:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=HkSt8qFxUwkmoptP0yhiLXXXCmiG2toqmHjZNyB9Dh0=;
        b=fJe+SV3ur8ZvYCm7LbwpOCYwsyhh6+dV3ZKt+iHPLDaJrXE3wCEgYR0oyRltGupL3j
         kbXIAQ2MRTSaYXg8mUsmDvc7jppxOwMLNwwGnFT3B9JOZV93BYdGJ6OwabkwU8l3vR8+
         IHh/B4FkIMyDAMVmrT7ygQgjycAS/yik3+HLA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=UHJUrieAoAA+ORK5xMWuJs00O1hDf8T/DsC0Yi0VpRMM1vb++RkR08oFfcWZj6QxNQ
         stXB2nSgeFwnGWOBQPkBRRr/4K1/V9P7NuJ/Gw8uXTIxyuLNJGMwRzyEia3QwJ2l7zt1
         G3A9HyTfLf0OwIHOS6i91huyd/gXnWhKx66Jw=
Received: by 10.216.88.15 with SMTP id z15mr2267330wee.113.1258295665912;
        Sun, 15 Nov 2009 06:34:25 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id 5sm2864436eyf.10.2009.11.15.06.34.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Nov 2009 06:34:24 -0800 (PST)
In-Reply-To: <4AFF3D4D.7000308@gmail.com> (Johan t. Hart's message of "Sun, 15
	Nov 2009 00:29:17 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132942>

Johan 't Hart <johanthart@gmail.com> writes:

> Francis Moreau schreef:
>> hello,
>>
>> Let's say I'm on a branch called 'foo'.
>>
>> I tried to rebase this branch by using 'git pull --rebase'.
>>
>> I first tried the following command:
>>
>>     $ git pull --rebase origin master:foo
>>     remote: Counting objects: 5, done.
>>     remote: Total 3 (delta 0), reused 0 (delta 0)
>>     Unpacking objects: 100% (3/3), done.
>>     From /dev/shm/git/A
>>     ! [rejected]        master     -> foo  (non fast forward)
>
> When using a refspec, you usually mean to update a remote tracking
> branch, like refs/remotes/origin/master. Internally the refspec
> parameter is passed to git fetch, which fast-forwards your local
> tracking branch to match the remote branch.
>
> With this command, you make git clear you want to fast-forward your
> branch refs/foo to match the remotes master branch, and then rebase
> your current branch on that foo branch.
>
> Foo probably is also your current branch. So what you probably want is
> to fetch the remotes master branch and rebase your current branch foo
> on it. You could do it this way:
>
>> Then I tried:
>>
>>     $ git pull --rebase origin master
>>
>> which worked.
>
> This does not update any remote tracking branches, but it will rebase
> your foo branch on the remote master branch (which is what you want)
> It could also be done with:
>
> git pull --rebase origin master:origin/master
>
> This will also update your remote tracking branch
> refs/remotes/origin/master to match the master branch on the remote
> repo. Your foo branch will then be rebased onto it.
>
>>
>> Reading the man git-pull I would assume the 2 commands are equivalent
>> but obviously they're not.
>>
>> So the question is: why ?
>
> So, thats why :) They're not the same. Many words... Hope you
> understand... I hope I understood it well too..?
>

Looks like you did :)

I've been somehow confused by the git-pull man page, which says:

  A parameter <ref> without a colon is equivalent to <ref>: when
  pulling/fetching, so it merges <ref> into the current branch without
  storing the remote branch anywhere locally

So I thought that both of the commands were equivalent for 'git pull
--rebase'.

Thanks for the explanation.
-- 
Francis
