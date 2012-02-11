From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: User authentication in GIT
Date: Sat, 11 Feb 2012 10:47:02 +0530
Message-ID: <CAMK1S_gOhaX4SaUZk8RrByDa_HPuMLDs=T2M2djXDhvESJu1Vg@mail.gmail.com>
References: <1328595129258-7261349.post@n2.nabble.com>
	<1328615262741-7262113.post@n2.nabble.com>
	<CALKQrgdvOhfhTPg+g+LqCb6XOQczcz-nYC61B9x4W5dB4Up5oA@mail.gmail.com>
	<1328632848471-7262934.post@n2.nabble.com>
	<CAMK1S_i=QUxf1CPDwdDn0+2-7fL5xxMZ67rHvR63a-vU1uq39Q@mail.gmail.com>
	<1328893056653-7273350.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: supadhyay <supadhyay@imany.com>
X-From: git-owner@vger.kernel.org Sat Feb 11 06:17:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rw5Kh-0005cc-RR
	for gcvg-git-2@plane.gmane.org; Sat, 11 Feb 2012 06:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127Ab2BKFRF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 11 Feb 2012 00:17:05 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:55334 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750779Ab2BKFRC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Feb 2012 00:17:02 -0500
Received: by obcva7 with SMTP id va7so4612057obc.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 21:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=uu951uB4uJTzuzrlKt+FF8fR3qgKCirRU0K7xALhjgg=;
        b=abnUGL7pbAnv87JZFwenIb5mm4VIerOXmd4UA5UVMxZlZPBzWa2UYA01bhch6VC+AM
         U2A9JVymyoq7e6SuJmqp3DooVmn1JI40VIyASbqNzcJZQK57B8bXDGilerO3ZdVHb0v4
         bcJxYBq0Pwk7pOtPU1Kifc678y/53JNV3NAFA=
Received: by 10.182.216.101 with SMTP id op5mr5712583obc.54.1328937422081;
 Fri, 10 Feb 2012 21:17:02 -0800 (PST)
Received: by 10.182.28.161 with HTTP; Fri, 10 Feb 2012 21:17:02 -0800 (PST)
In-Reply-To: <1328893056653-7273350.post@n2.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190484>

On Fri, Feb 10, 2012 at 10:27 PM, supadhyay <supadhyay@imany.com> wrote=
:

> Now my confusion is my existing source code repository directory path=
 during
> migration /home/GITAdmin/migration/<repository.git> and now through g=
itolite
> I want to manage both users and repositories =C2=A0but through gitoli=
te it add
> repository in different path /home/GITAdmin/repositories/<repository.=
git>.
>
>
> Can you please help how through gitolite I can add new repository on =
to the
> same my exisitng migrated repository directory?

gitolite keeps all its repos in whatever directory is pointed to by
$REPO_BASE in the rc file.  This is $HOME/repositories by default but
you can change it to whatever you want.  Instructions for changing it
are in the 4th bullet of
http://sitaramc.github.com/gitolite/rc.html#gitolite_rc_rarely_changed_=
variables_

If you are moving existing repos into gitolite, be sure to read
http://sitaramc.github.com/gitolite/moverepos.html -- if you do it
wrong you may end up without the crucial "update" hook and then all
access control will fail.
