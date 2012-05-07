From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git svn dcommit <branch> committed to trunk anyway
Date: Mon, 7 May 2012 17:08:56 +0530
Message-ID: <CAH3Anrq5SGZZsTpKd1MFBRVD8xzsUvckt6d-BxtTYYce--F1+g@mail.gmail.com>
References: <CAH3AnroP+ckzgijibPDEupBCfUFu5Bwsq8YP58h+igXoJyJEyg@mail.gmail.com>
	<87txzsba0o.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon May 07 13:39:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRMHZ-0002vj-55
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 13:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442Ab2EGLjA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 07:39:00 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:48706 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756395Ab2EGLi5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 07:38:57 -0400
Received: by wibhj6 with SMTP id hj6so3339188wib.1
        for <git@vger.kernel.org>; Mon, 07 May 2012 04:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=B0pD/zGEMwi3rwXzBEhM0OwnfMhFsmUoBgxExqX89YE=;
        b=zRrEzIyTPCMLHNQZjRQI0rOLLgzVbNIxVPk9gXQWphp2Jih7MMcsuB9IAqAdJBWABM
         Kwqe+wsMI3XlDrLW4uMXkVlLQfU1gtF376hiGxO0b1Wjb9H6iliN+gHlzmHYxno3eDTE
         7wLgMS7AhIEwfT6Zf/iicB/bXYgqWvvGDjJXd+eoutQbz/63TvZSlOvQ5OWljfiF47x/
         xlgySJ/u3vOGesllLV2sVGS7tc5BJdHDitGMT9U0I1rc46BTojJ6Sx+ptPH8q9mqTD1+
         rBSOfrugoD6jcKqeSefPZd7CTNrcBIuJOubmQESCaR4fkOCDFqAT+Nz87C/TRloZ8eCS
         DvXA==
Received: by 10.216.208.41 with SMTP id p41mr9471101weo.21.1336390736034; Mon,
 07 May 2012 04:38:56 -0700 (PDT)
Received: by 10.180.82.35 with HTTP; Mon, 7 May 2012 04:38:56 -0700 (PDT)
In-Reply-To: <87txzsba0o.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197261>

On Mon, May 7, 2012 at 3:14 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> I expected git svn dcommit <branch> to push commits into the svn
>> branch called <branch> (a repo relative URL of
>> /branches/foobar1/foobar2/<branch>)
>>
>> However, it decided to push into trunk instead, which was not the
>> intended effect.
>>
>> What have I misunderstood about how git svn dcommit is supposed to w=
ork?
>
> Did the commits you dcommitted have any git-svn-id lines? =C2=A0It dc=
ommits
> (or at least it's supposed to :-) in the directory listed in the
> git-svn-id line found by (roughly)
>
> =C2=A0git log --first-parent -1 --grep=3D^git-svn-id:
>

None of the commits that dcommit committed to svn had such lines, but
the immediately preceding commit did, and that commit referred to the
trunk URL, rather than the branch URL.

I guess I am confused by this guidance in git-svn(1) in the section on =
dcommit:

    "An optional revision or branch argument may be specified, and
causes git svn to do all work on that revision/branch instead of
HEAD":

I had assumed that dcommit would respect the optional (SVN branch)
argument that I had specified, but it seems that this is not the case.
What do the words in the man page actually mean, if they don't mean
what I thought they meant.  Do the words "optional revision or branch"
actually refer to the git commit/branch rather than the SVN
revision/branch?

Regards,

jlon.


> --
> Thomas Rast
> trast@{inf,student}.ethz.ch
