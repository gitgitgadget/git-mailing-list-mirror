From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: File Systems and a Theory of Edits
Date: Sun, 31 Jul 2011 17:13:11 -0400
Message-ID: <CADo4Y9i=PYBv33Jnu2osQX_FL97ng9FZ8TFeMMuc5CDGUhu1Gg@mail.gmail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
	<CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
	<4E350F15.9050009@lsrfire.ath.cx>
	<CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
	<CADo4Y9gECLJ45g_r-uZBRnfEVXBRw2EoF2HkRu=0-eJ2YCuBLA@mail.gmail.com>
	<CAMOZ1BtrgO1XhJfR2-1Mpd8Ytrz4pjVyhbPdbNxDP84hhiip+A@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 31 23:13:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QndK2-0007Vx-Bu
	for gcvg-git-2@lo.gmane.org; Sun, 31 Jul 2011 23:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752638Ab1GaVNN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 31 Jul 2011 17:13:13 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51961 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490Ab1GaVNM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2011 17:13:12 -0400
Received: by ewy4 with SMTP id 4so2581027ewy.19
        for <git@vger.kernel.org>; Sun, 31 Jul 2011 14:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=SEbE38WOC8eSHdvRcsbsBUzutUXFMzgRxdnKdjkkj0E=;
        b=ezC1nUALuxl51wSg5brz6SUgK340FmndYcul5M4UaZM6gQMhwLLlTboXFMImIy4ycN
         SiPH1kaGId2wK4KK6zfkck6LiWMf4pXGKOoNhwejoBhnwAFRd32axOU4ooz6TNsVmqHF
         oIxn+9QdlnAGiVFDfmS3yx7VNKYz5eQK5O85c=
Received: by 10.14.16.231 with SMTP id h79mr1370955eeh.0.1312146791321; Sun,
 31 Jul 2011 14:13:11 -0700 (PDT)
Received: by 10.14.53.3 with HTTP; Sun, 31 Jul 2011 14:13:11 -0700 (PDT)
In-Reply-To: <CAMOZ1BtrgO1XhJfR2-1Mpd8Ytrz4pjVyhbPdbNxDP84hhiip+A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178278>

Why not "git mount" indeed!

At work, I have 3 very active branches and a slow build system.  Right
now, when I switch to a new branch, I have to rebuild everything.
Being able to "git mount" 3 snapshots in 3 directories with three
different build outputs would make switching branches faster.

3 working trees would be even better.  I've been wondering if I can
make another working trees by creating a .git/ directory and
symlinking to the .git/objects and ./git/refs of my current
repository.  (I could use the environment variables GIT_INDEX_FILE and
GIT_WORKING_TREE, but that would require setting and resetting them.
Or using a different shell.)

So a true "git mount" that allowed mounting editable branches would be
very useful to me.  (Although, if it wasn't for that crappy build
system, I prefer a single working tree.)

Mike Nahas


On Sun, Jul 31, 2011 at 1:21 PM, Michael Witten <mfwitten@gmail.com> wr=
ote:
> On Sun, Jul 31, 2011 at 14:15, Michael Nahas <mike.nahas@gmail.com> w=
rote:
>> I believe the solution for xargs may be John D.'s solution - to
>> "mount" the snapshot as a file system.=A0 And the "mount" command in=
 git
>> is "git checkout".=A0 (Now, I almost want to rename "git checkout" t=
o
>> "git remount"!)
>
> Why not just `git mount', though? We could have different mount point=
s
> too, so that it's easy to work with multiple `snapshots' at once (in
> the spirit of bazaar and mercurial, as well).
>
> Perhaps `git umount' could be used to make the repository bare.
>
> In any case, I always find myself wishing that the standard interface=
s
> would make it easier to base an operation on a snapshot that is not
> yet mounted as the working tree. It can be quite cumbersome to switch
> the contents of the working tree.
>
