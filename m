From: Bruce Korb <bkorb@gnu.org>
Subject: Re: failed to push
Date: Mon, 01 Mar 2010 14:00:05 -0800
Organization: FSF
Message-ID: <4B8C38E5.7090305@gnu.org>
References: <4B8C2E68.3020507@gnu.org> <4B8C303E.7050605@gmail.com> <a038bef51003011342j3d761d0cmd96d8641f96ed15@mail.gmail.com>
Reply-To: bkorb@gnu.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: GIT <git@vger.kernel.org>, bkorb@gnu.org
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 23:00:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmDf1-0008Nd-9n
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 23:00:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752880Ab0CAWAN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 17:00:13 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:60312 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752891Ab0CAWAK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 17:00:10 -0500
Received: by bwz4 with SMTP id 4so2248566bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 14:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :reply-to:organization:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=P5xPV8K+CcQ1CaaRddPn3xEYO46H6VS6Gpstp87R4kA=;
        b=wZNZ82wNZAQURnmGhE9H3u687TQdk3pBGrU4Kh5oAK8SbYdTQH3/L/5cwQ1g8sHCeG
         3/5k52yai+KniVQdXFqibwyqJH3Rb9SpH3WmFf5/4Gs//+HmyUgxAqwlSosh4RpFtKAZ
         3HNpXqWAF+s/H8wKVkCNJaxF4lq1RH2bhqq5g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:reply-to:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=A3F1HlHAjrZKAvLccgVKsTgNQ9qb8GvL60X+gKujT178KJsTKzvI1kxp78KbQiVUG4
         OdEXJZOcH7n3Ct8oLQ5pPKiJbVDGr/NZj543vGNzeTmdKoFSOct6LUjvfReuz/Z2pNIp
         fa1+xg43itpsQy7vfRdfxxrsAyu92i0+y38N0=
Received: by 10.204.33.216 with SMTP id i24mr3540040bkd.154.1267480808617;
        Mon, 01 Mar 2010 14:00:08 -0800 (PST)
Received: from ?10.10.1.101? (adsl-75-0-176-14.dsl.pltn13.sbcglobal.net [75.0.176.14])
        by mx.google.com with ESMTPS id 16sm2397270bwz.9.2010.03.01.14.00.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 14:00:07 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <a038bef51003011342j3d761d0cmd96d8641f96ed15@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141361>

Hi,

Thank you-all for your replies.

Chris Packham wrote:
>>> To ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen
>>>  ! [rejected]        master -> master (non-fast forward)
>>> error: failed to push some refs to 'ssh://bkorb@autogen.git.sourceforge.net/gitroot/autogen/autogen'

CF:
> It tells you right there at the end of the rejected line. The push
> would have resulted in a non-fast-forward update of the branch.

"non-fast forward" is not very helpful either.

> This basically means that the push you have attempted is not a simple
> fast forward. This basically means that the commit your work is based
> on is not present in the remote or that there have been other pushes
> to the remote and you need to pull them into your repository to handle
> any merging.

Since the sequence was:
  git commit
  git push
  <more editing>
  git commit --amend
  git push

the neophyte (me) is not going to know that this produces an un-pulled
delta.

> OK that kind of sheds some light. I take it you've just switch from a
> centralized VCS?

"just switched"?  No, I've been using BitKeeper for four years
and just recently converted my open source stuff to GIT.  GIT
is harder to work with.

> In a DVCS like git all commits happen locally, the only time commits
> are sent to the remote repo are when you've pushed so 'git commit
> --amend' or 'git gui' with the amend box ticked only makes the change
> locally it won't implicitly figure out that a commit has been pushed
> out into the ether. One rule of thumb with git (I think it applies to
> most DVCSes) is not to amend a commit that has been pushed for this
> very reason.

Then please be kind enough to put a *CAUTION* button next to
the amend button and have it bring up something that gives you
a little warning.  GIT *could* have been written in a way that
causes the remote repo to become synced with my local repo,
but apparently it was not and there was not adequate warning.

> Strictly speaking all commits are immutable, when you
> amend a commit you actually create a whole new commit and your old one
> is marked for garbage collection (if nothing else is based off it).
> 
> In terms of recovering from your present situation I'd try the
> following (Disclaimer: maybe you shouldn't try these based solely on
> my advice. I'm still learning too)
> 
>   git pull
>   <resolve merge issue, 'git mergetool' is your friend>
>   git push
> 
>   I think this will basically sort things out but you may need to hand
> hold a few things through a merge depending on how different the 2
> commits are.

I will be trying this procedure momentarily.  Meanwhile, since I am
the only person on the planet authorized to commit to the public repo:

>  - or -
> 
>   git push -f

This fails with the same "non-fast forward" rejection message.  :(
