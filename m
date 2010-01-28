From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: Questions about branches in git
Date: Fri, 29 Jan 2010 00:00:55 +0100
Message-ID: <46a038f91001281500x5088206akb7390dec8839a169@mail.gmail.com>
References: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Mike Linck <mgl@absolute-performance.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 00:01:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NadMH-0004b5-MT
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jan 2010 00:01:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab0A1XA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2010 18:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755355Ab0A1XA6
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jan 2010 18:00:58 -0500
Received: from ey-out-2122.google.com ([74.125.78.24]:29766 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab0A1XA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2010 18:00:58 -0500
Received: by ey-out-2122.google.com with SMTP id d26so322492eyd.19
        for <git@vger.kernel.org>; Thu, 28 Jan 2010 15:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=IO83tTOEL9VlEw1Fc5ZExkapFEIp75A5FcLxWLMx3ag=;
        b=LWVfbo95YWwonNTxVu8SIYqjUObOIuLOIMD0igWviMOmz531cZrnpkT5IZF3gg21jn
         sgN8Y9sh57nEN7PtFzmzUCom9Zf97JrdzqaDotGSwE6XaoXEjkmz5N4uqTMhqL4N5hdt
         5dTEBANrA8/us1/pYx2WPlMZLI6zriwcn4Gc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=M/mnCJV5PjtJDd10tVjVMzfBZwJYY8284/DiB1bDFjHRPNWMCHGI1EmrIX5s2wSQl9
         o+HIT499X3HL0iBB8Gh6klz97D5XpqK9LLsm80BVLK3n/lU0B0lu3NYat5FXmJC/nsRQ
         MB4Upb0kGGxHt7J06a0aFsYnyVPbDowHOBDe8=
Received: by 10.213.50.203 with SMTP id a11mr6365261ebg.76.1264719655589; Thu, 
	28 Jan 2010 15:00:55 -0800 (PST)
In-Reply-To: <69b754db1001281044y39e52f77hcc8f83144776c78f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138282>

On Thu, Jan 28, 2010 at 7:44 PM, Mike Linck
<mgl@absolute-performance.com> wrote:
> I've looked through as much documentation as I can find about git show
> and git log, and I've played around with git rebase to try to apply
> changes to multiple places, but I have not been able to find a way to
> display the commits relevant to a particular bug/topic branch.

I've done a similar job for quite a while, and kernel hackers need
that all the time too. If the branches merge a lot, what you need to
know is what patches are only on one side, and not on the other. Two
things to the rescue:

 - the "3 dots" "..." separator. try with gitk and git log:
    git log mybranch...hisbranch
    git log hisbranch...mybranch

 - git am (which is part of the rebase machinery) does the same as the
"..." operator, but has additional tricks to try and spot commits that
have been cherry picked. So I would often export patches with git am
just to review what' s on one side.

hth,



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
