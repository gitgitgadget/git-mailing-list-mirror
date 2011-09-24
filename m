From: Chris Harris <chris.harris123@gmail.com>
Subject: Fwd: git svn with non-standard svn layout
Date: Sat, 24 Sep 2011 14:37:27 -0400
Message-ID: <CANPpUWxnp3-ySO3oBEsWTQA=oWXEzKS1bddP9LjAsR1EyPxbVQ@mail.gmail.com>
References: <CANPpUWyX+n7kMKZpCV=Oy=UmJb=9H=uZseYzU2-h1FLh2nzg8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 24 20:37:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R7X6U-0004uV-Ko
	for gcvg-git-2@lo.gmane.org; Sat, 24 Sep 2011 20:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752277Ab1IXSh3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 24 Sep 2011 14:37:29 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41805 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab1IXSh2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Sep 2011 14:37:28 -0400
Received: by wyg34 with SMTP id 34so4849532wyg.19
        for <git@vger.kernel.org>; Sat, 24 Sep 2011 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=qc+xpmZ/zxEqsWce7450IwchOXpNtTYrtzOBuIz0z/o=;
        b=Xwt74p8JlD6UAoYtpOQIU4JBWQUFE0yB2WmGPC/kvHhUdCoYkk0JU0AK8Mf2z7CwAR
         i+unKQB7rJR9pYKmcgOSynCdMYJwdOUuv7QwARgH0MsFFYt3gMlyJA7SXPRdQQ95cROm
         uTGLPoDKOD+h6Vb6vqGwXvxM1kJyRIZflIdI0=
Received: by 10.216.176.142 with SMTP id b14mr5068593wem.70.1316889447596;
 Sat, 24 Sep 2011 11:37:27 -0700 (PDT)
Received: by 10.216.155.208 with HTTP; Sat, 24 Sep 2011 11:37:27 -0700 (PDT)
In-Reply-To: <CANPpUWyX+n7kMKZpCV=Oy=UmJb=9H=uZseYzU2-h1FLh2nzg8w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182036>

I am using =A0git version 1.7.6.4 built from the latest stable source o=
n
github. =A0 Running Ubuntu with kernel 2.6.38-11-generic

I can't seem to git git svn to see my branches correctly.
Unfortunately my svn repository is not open source, so I can not post
it here, but I will try to explain my issue.
We use a non standard svn layout like the following
branches
=A0 =A0 =A0 =A0 V4.1
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4.1.0
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 V4.1.1
dev


dev is our trunk, and our branches have 2 levels.
I first use git init, then=A0setup my config as follows
[svn-remote "svn"]
url =3D file:///home/chris/svnrepo
fetch =3D dev:refs/remotes/trunk
branches =3D branches/V4.1/{V4.1.1}:refs/remotes/branches/*
=46or this example I am just trying to make a single branch work.
After a fetch all revisions are ok. master correctly points to
remotes/trunk,but gitk shows the following:

o remotes/branches/V4.1.1
|
o some commit
|
|
| =A0 =A0o master - remotes/trunk
| =A0 =A0|
| =A0 =A0o another commit
| =A0 =A0/
|
etc
( sorry for the bad ascii art. )
My issue is that trunk ( master ) appears to be a =A0branch from V4.1.1
instead of =A0V4.1.1 being a branch from trunk ( master )
git log --graph shows the same structure.
Any suggestions on how to configure this so git svn maps my
non-standard layout correctly?
Thank you
Chris
