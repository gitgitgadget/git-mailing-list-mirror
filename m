From: Auguste Mome <augustmome@gmail.com>
Subject: Re: can't create a branch on remote
Date: Mon, 12 Oct 2009 09:19:20 +0200
Message-ID: <17cb70ee0910120019pb9ba3fxaf2a47957d36d09e@mail.gmail.com>
References: <17cb70ee0910091435l4c4d1736hf4d403a2fe6331a2@mail.gmail.com>
	 <m363aogqz9.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 09:22:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxFEI-0000il-Ot
	for gcvg-git-2@lo.gmane.org; Mon, 12 Oct 2009 09:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbZJLHVK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Oct 2009 03:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754324AbZJLHVK
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 03:21:10 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:3716 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753655AbZJLHVJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Oct 2009 03:21:09 -0400
Received: by fg-out-1718.google.com with SMTP id 16so362526fgg.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2009 00:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=DX3DyBbv4RMd1EM0g0eAnidoyZZ1q2sNTXmbHh3SplU=;
        b=oXvKzUZmgoB5JWWcgMt5M2Wji0GzK79UJ6lCkzXbiAUPqIOGSomYgniRCCOCoQU1+R
         dnT5CmOi09dHobnod1KOQ1noN+bRgfjGWYq0Noj24NZ+W9gklw0e2Icc66k2n0Kl10Hk
         9BPiqwd6I5zlXLUTbTaf7ymJ39/y4z5oEzOpA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WmmKE9qbXCo3XUDG6trKZQWY4gZ3yqEC0YuwhYGLEYJlF99wVFzu3lOjSNNu9T9uEQ
         GqzvcWQ34fk4Rd0Kvgs8bm80AVNgDdkvAC6YHLwgY+ahF5RNPIeodOb1TMsfInSTPwkL
         lLjfElePfwKTgK9IJWUej3l89hACKmyvmAY6g=
Received: by 10.86.254.17 with SMTP id b17mr4966401fgi.65.1255331960679; Mon, 
	12 Oct 2009 00:19:20 -0700 (PDT)
In-Reply-To: <m363aogqz9.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129992>

OK thanks I'm going to try this out, let me ask a question because it
sounds my work flow is not good.
I don't want to push the work done in my local branch to head/master,
I want to push this work into
"long-live" branch of a central repository, which belongs to "admin",
and eventually this branch does not exist yet.
my-central-repo: master, origin =3D linux-2.6.git
                        branch1, branched at v2.6.21.7
                        branch2, branched at v2.6.21.7
-> I want (not admin) people to clone my-repo and work on branch1
and/or branch2.
-> I want some people to add a new branch3 at v2.6.21.7 into my-central=
-repo.
    (This will not happen very often, can be restricted to admin)

Maybe in this case it is common to define more "public" repositories:
 repo-branch1/ and repo-branch2/
I guess people could then clone repo-branchX and push the work done,
and up to owner of my-central-repo
to merge repo-branchX/master into my-central-repo/branchX?

Auguste.



2009/10/10 Jakub Narebski <jnareb@gmail.com>:
> Auguste Mome <augustmome@gmail.com> writes:
>
>> Hi,
>> I have two repositories=A0 /home/user/linux and /home/user/dev/linux=
,
>> same user on same machine.
>> Here is how I create a local branch at v2.6.21.7 in /home/user/dev/l=
inux,
>> #pwd
>> /home/user/dev/linux
>> # git remote add l2621
>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-2.6.21.y.=
git
>> # git fetch l2621
>> # git branch mylocal26217=A0 v2.6.21.7
>>
>> Now I would like to do the same from the other repository /home/user=
/linux:
>> # pwd
>> /home/user/linux
>> # git remote add other /home/guerin/dev/git/linux-2.6
>> # git fetch other
>> # git push /home/user/dev/git/linux-2.6
>> =A0=A0=A0 v2.6.21.7:refs/heads/new_feature_name26217
>> Total 0 (delta 0), reused 0 (delta 0)
>> error: Trying to write non-commit object
>
> =A0^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>> 170684ef0557d4b711a86595d31dcbebcb9d4ba2 to branch
>> refs/heads/new_feature_name26217
>> To /home/user/dev/git/linux-2.6
>> =A0! [remote rejected] v2.6.21.7 -> new_feature_name26217 (failed to=
 write)
>> error: failed to push some refs to '/home/user/dev/git/linux-2.6'
>>
>> Maybe something to configure to authorize the creation of branch?
>
> You can't push tag to branch.
>
>
> I'm not sure if what you are trying to do makes sense at all, but the
> commit pointed by v2.6.21.7 is v2.6.21.7^{}
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
