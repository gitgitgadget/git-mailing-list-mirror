From: Rustom Mody <rustompmody@gmail.com>
Subject: Re: git workflow for fully distributed mini-teams
Date: Thu, 17 Sep 2009 12:33:49 +0530
Message-ID: <f46c52560909170003l61a2e1a3kf62c94ffd7ed9710@mail.gmail.com>
References: <f46c52560909160035o6b09800eh5219d49e7569cf23@mail.gmail.com>
	 <20090916164356.GB24893@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 17 09:03:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoB24-0005Ht-QP
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 09:03:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756145AbZIQHDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Sep 2009 03:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755976AbZIQHDr
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 03:03:47 -0400
Received: from mail-pz0-f190.google.com ([209.85.222.190]:33552 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756006AbZIQHDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Sep 2009 03:03:46 -0400
Received: by pzk28 with SMTP id 28so1079340pzk.5
        for <git@vger.kernel.org>; Thu, 17 Sep 2009 00:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=apd63CT9HRJKvwE3c+7zd2ttWRYdoiKc5ymMwq+0lqE=;
        b=PS/OkOdIXtaLiqXvFL9vtRO5agpdKICCvVkBWhkf+ToAglj5DszYwUXAV5kyGjQtq/
         VvxRAFDKkS7In9qlWDKczKS66mQM9BOzrZrd0D7oXJL2EOOeg9bWJt7vOfXjorCCJt2b
         ouVSb5KlnLn+PZHKKOPVvYBUK26OmpTkw+wDg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        b=VXosJ39CE0pJ1ouXkqDV/fk4OOMzY1lhJZFzTX4duww0s1VxCYM5/VnQOPthT/u3UE
         UmiVhb8m39+/IcujkonwxKQvA5GeRB4tqkEVLVUSLVlkrDYglAq0lHpJWqwSn3Odx5YI
         cDlkgBZKZybB295CzEvr+2wqURIyWqrV13zXY=
Received: by 10.114.18.4 with SMTP id 4mr17971349war.137.1253171029403; Thu, 
	17 Sep 2009 00:03:49 -0700 (PDT)
In-Reply-To: <20090916164356.GB24893@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128717>

Rustom Mody wrote:
> By fully distributed I mean theres no central repo -- not for pushing
> or even pulling; all communication is by email.
> By mini-team I mean: Not more than 5 programmers.

On Wed, Sep 16, 2009 at 10:13 PM, Nicolas Sebrecht <nicolas.s.dev@gmx.f=
r> wrote:
>
>
> Also, I see a duplication of the same work for all the developers in =
a
> team: "merge my topics with topics from others". This could be solved
> with one more common repository wich could stand as a "virtual
> maintainer repository" where each developer could release any topic.
> Topics that don't need any more work would have to be merged in a
> dedicated public branch ("next"?) for testing, and topics that aren't
> good enough into another dedicated branch ("pu"?). So, each developer
> would have to push publishable merges into this repository. This way,
> everyone could use the merges done by another developer (by doing a
> fetch and rebasing of his current work on top of it).

Push? Fetch? How without a common repo?  [Sorry if this is totally noob=
!]
>
> Notice that this is all about "everybody uses the same base for his
> current work" (to avoid per-developer scratch on merges) and "don't l=
et
> everyone do the same work on his own" (to avoid duplicate work).
>
>> What about checkpointing and restoring from botches?
>
> I think this is be easily doable (against your described workflow) wi=
th
> good conventions in branch names. Topics like "pending-topicA",
> "pending-topicB", etc that would have to be merged (using a script) i=
nto
> a "all pending topics" branch should do what you want, no? =A0Restori=
ng
> from botches would mean removing the crappy branch and re-execute the
> script.

I am really concerned about things like:

A commited something on the B branch, received a patch from B. That
patch did not apply (or worse it applied -- on top of A's!)
So ideally there should be an option that says (when A is on B branch
and tries to commit) "Sorry buddy -- No commits here!"
