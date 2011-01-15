From: Severin Gehwolf <jerboaa@gmail.com>
Subject: Re: [Not a] [Bug] Gitweb corrupting files?
Date: Sat, 15 Jan 2011 10:39:35 -0500
Message-ID: <AANLkTinY8_maXxP_19hiugiNck=2HELZmurERgwry5H0@mail.gmail.com>
References: <AANLkTim84sSWr=WRgjiY=Y3Mq7Tgojv9CpLrNjQMJfHR@mail.gmail.com>
	<m3hbdeatgn.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 15 16:39:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pe8EB-0006gB-En
	for gcvg-git-2@lo.gmane.org; Sat, 15 Jan 2011 16:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab1AOPji convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Jan 2011 10:39:38 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54868 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753228Ab1AOPjh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Jan 2011 10:39:37 -0500
Received: by eye27 with SMTP id 27so1956959eye.19
        for <git@vger.kernel.org>; Sat, 15 Jan 2011 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vRKTZHg9h0DndS3lKh/fcRuPtjKnoCyo1EDfSy9pMw0=;
        b=A4iMUkDog+BbaXyrO2yFnm4XB41u8MmJ73LpZBUAC8TYKrIrr4C9nMyrol7FpxbkRh
         aBot0f0sY0MelmsLbh5Yz9tNH4lhWfqsbQ2jvOTkL0FWVxNLxQ8S9ITVKT/pOxslbLTs
         lD1ereWBCjXqFYUg4piLZGhf7CpY0RshSHwPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=fzdUGESW3Ze+G4m71lkulYVqRvyIpGQRX4enAJNhBx0HvnJ0Lq7GEIe+ilh4mHgRr2
         yb5ceJxS4ohM5F3hbV0lzh/sIccJ4mnxVBuDTgN7ZXKg6iargxwgQ8LA6f9diBGiyF58
         jB6/jJPXVqDNWWWTSORse1HPp7oEmo9jcBn18=
Received: by 10.14.45.15 with SMTP id o15mr978110eeb.46.1295105975206; Sat, 15
 Jan 2011 07:39:35 -0800 (PST)
Received: by 10.14.124.15 with HTTP; Sat, 15 Jan 2011 07:39:35 -0800 (PST)
In-Reply-To: <m3hbdeatgn.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165147>

On Wed, Jan 12, 2011 at 1:05 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> Severin Gehwolf <jerboaa@gmail.com> writes:
>
>> It appears that Gitweb corrupts files when it is being used for
>> creating compressed tarballs of sources.
>
> E.g. http://egit.eclipse.org/w/?p=3Degit.git;a=3Dsnapshot;h=3D6b52844=
5c3e543688b990e0a631c5f0238b02741;sf=3Dtbz2
> error in egit/org.eclipse.egit.ui/src/org/eclipse/egit/ui/internal/di=
alogs/BranchSelectionDialog.java
>
>> A more precise description of the behaviour I'm experiencing is here=
:
>> https://bugs.eclipse.org/bugs/show_bug.cgi?id=3D317882
>
> Couldn't you post summary of the above here?
>
>> Unfortunately I have no knowledge about the version in use at eclips=
e.org.
>
> It's git and gitweb version 1.6.4.4.
>
>
> From original bugreport:
>
> =A0 And it built fine. Then, I tried checking out sources from comman=
d line using
> =A0 the git client:
>
> =A0 git clone git://egit.eclipse.org/egit.git egit
> =A0 cd egit
>
> =A0 git checkout 6b528445c3e543688b990e0a631c5f0238b02741
> =A0 cd ..
> =A0 tar -cjf egit_test.tar.bz2 egit
>
> This should be
>
> $ git archive --format=3Dtar 6b528445c3e543688b990e0a631c5f0238b02741=
 |
> =A0bzip2 > egit_test.tar.bz2

I did some digging and it looks like somehow those files are indeed
corrupt in the Git repo and it's not a Git or gitweb problem.

Thanks for responding!

--Severin
