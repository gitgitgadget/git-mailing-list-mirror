From: Michael Nahas <mike.nahas@gmail.com>
Subject: Re: File Systems and a Theory of Edits
Date: Mon, 1 Aug 2011 08:01:18 -0400
Message-ID: <CADo4Y9gtsKS660GCXObMeKztED+EJLBtHDHregvbMyR3S2_gUQ@mail.gmail.com>
References: <CADo4Y9hG=-Bye5g7OWROJNbbUOcnH0hj0f3csws5V+YzEUKAMg@mail.gmail.com>
	<CACBZZX48aDN_Njm+qMvovfz1tjdhnmXe5-bbJe=0_Q3LbLWoPA@mail.gmail.com>
	<4E350F15.9050009@lsrfire.ath.cx>
	<CADo4Y9gU_Z73gCPCESvVZhLOJUJg+mTqHkeqpNv2L8xLJvKxEQ@mail.gmail.com>
	<CADo4Y9gECLJ45g_r-uZBRnfEVXBRw2EoF2HkRu=0-eJ2YCuBLA@mail.gmail.com>
	<CAMOZ1BtrgO1XhJfR2-1Mpd8Ytrz4pjVyhbPdbNxDP84hhiip+A@mail.gmail.com>
	<CADo4Y9i=PYBv33Jnu2osQX_FL97ng9FZ8TFeMMuc5CDGUhu1Gg@mail.gmail.com>
Reply-To: mike@nahas.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Michael Witten <mfwitten@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 14:01:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnrBU-0007xA-32
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 14:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035Ab1HAMBU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 08:01:20 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43919 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab1HAMBS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Aug 2011 08:01:18 -0400
Received: by gwaa12 with SMTP id a12so1329203gwa.19
        for <git@vger.kernel.org>; Mon, 01 Aug 2011 05:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        bh=RX/zOCugNxszXvFUv8DTlPFnMr31eL7Oveuc4ZwmKP0=;
        b=O49tUZjwl/ttl/XA05hU/W7QlljZhtWuEQAPf9n2WAwUJEY8SXVG2Bnu+2Aiw1cVA0
         x2Kf4IfyZis/UpR5488lITgdMiqM96gv+sTrbmwOPb7oJ4HGX/SqqmuFWKQxWCNevU/T
         X4G1YOQ9Ve5sNIBifQwFteNGFocO5tefhSCgE=
Received: by 10.151.131.20 with SMTP id i20mr718529ybn.145.1312200078289; Mon,
 01 Aug 2011 05:01:18 -0700 (PDT)
Received: by 10.150.199.6 with HTTP; Mon, 1 Aug 2011 05:01:18 -0700 (PDT)
In-Reply-To: <CADo4Y9i=PYBv33Jnu2osQX_FL97ng9FZ8TFeMMuc5CDGUhu1Gg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178344>

Michael,

I've been thinking about it and "git mount" is the right idea.  I like
it a lot.  In fact, the most common usage of "git checkout" can be
totally replaced by "git mount".

The other usage of "git checkout -- file" can be replaced by "git cp".

Mike


On Sun, Jul 31, 2011 at 5:13 PM, Michael Nahas <mike.nahas@gmail.com> w=
rote:
> Why not "git mount" indeed!
>
> At work, I have 3 very active branches and a slow build system. =A0Ri=
ght
> now, when I switch to a new branch, I have to rebuild everything.
> Being able to "git mount" 3 snapshots in 3 directories with three
> different build outputs would make switching branches faster.
>
> 3 working trees would be even better. =A0I've been wondering if I can
> make another working trees by creating a .git/ directory and
> symlinking to the .git/objects and ./git/refs of my current
> repository. =A0(I could use the environment variables GIT_INDEX_FILE =
and
> GIT_WORKING_TREE, but that would require setting and resetting them.
> Or using a different shell.)
>
> So a true "git mount" that allowed mounting editable branches would b=
e
> very useful to me. =A0(Although, if it wasn't for that crappy build
> system, I prefer a single working tree.)
>
> Mike Nahas
>
>
> On Sun, Jul 31, 2011 at 1:21 PM, Michael Witten <mfwitten@gmail.com> =
wrote:
>> On Sun, Jul 31, 2011 at 14:15, Michael Nahas <mike.nahas@gmail.com> =
wrote:
>>> I believe the solution for xargs may be John D.'s solution - to
>>> "mount" the snapshot as a file system.=A0 And the "mount" command i=
n git
>>> is "git checkout".=A0 (Now, I almost want to rename "git checkout" =
to
>>> "git remount"!)
>>
>> Why not just `git mount', though? We could have different mount poin=
ts
>> too, so that it's easy to work with multiple `snapshots' at once (in
>> the spirit of bazaar and mercurial, as well).
>>
>> Perhaps `git umount' could be used to make the repository bare.
>>
>> In any case, I always find myself wishing that the standard interfac=
es
>> would make it easier to base an operation on a snapshot that is not
>> yet mounted as the working tree. It can be quite cumbersome to switc=
h
>> the contents of the working tree.
>>
>
