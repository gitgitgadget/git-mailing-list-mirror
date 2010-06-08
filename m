From: Eugene Sajine <euguess@gmail.com>
Subject: Re: origin/branchname and tracking branch pointing to different 
	commits?
Date: Tue, 8 Jun 2010 13:50:51 -0400
Message-ID: <AANLkTilfBqc3Qww-4MbAcxuqBIj0LdbW9R3QXjCiy_J4@mail.gmail.com>
References: <76c5b8581001070903i3810f63crd764d451f7454584@mail.gmail.com>
	<201001071813.01187.trast@student.ethz.ch>
	<76c5b8581001070925g21ac3136x2928f12dc43437e5@mail.gmail.com>
	<76c5b8581001071550g31e9f5a3n15ebdb10a806ab2e@mail.gmail.com>
	<7v7hrtzbau.fsf@alter.siamese.dyndns.org>
	<AANLkTinLVd483-ki6tVb545PgpOFeOLYLR_GiKM5xAl7@mail.gmail.com>
	<7vljaptp1j.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 19:51:18 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM2xH-0007oK-HA
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 19:51:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756097Ab0FHRux convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jun 2010 13:50:53 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:48896 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756040Ab0FHRuw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 Jun 2010 13:50:52 -0400
Received: by pwj5 with SMTP id 5so1482150pwj.19
        for <git@vger.kernel.org>; Tue, 08 Jun 2010 10:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ewuUdlWeSn41BETyC0Qg+3N5LZdaabmALv6JbAo+F10=;
        b=hQxBizohE1tnromKFAqPrmb3u6MFL1F5XDyp48QydwBwXt9GSDQtvRvDEG5p6jgWz6
         CqztDhM4obTuSVdFvWnBKydGz7SUASKaj4RC4zQbZDv35+sSH0gXBBXtVCDr1NgZ8Hd0
         X+tDlTfKc1XfsTak4h/8Pwb8VN6qGJjhODPaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oYxeBYAJdgpGjvDIImxkGh6ZEXGBfSQnbUHFuNiVbJaSvTMMa0ObJDY0FPYdnfsUR8
         fYclGDx+4x5B8X+90u0Nw+zEUzJNrstsEIqQNIAeHlfZC+sxZOhukN2p2i8qmHCcLvCL
         UELE4Me+JGUffcdRt4yCC2916sXkB1DxWmdm8=
Received: by 10.229.186.212 with SMTP id ct20mr6129669qcb.39.1276019451920; 
	Tue, 08 Jun 2010 10:50:51 -0700 (PDT)
Received: by 10.229.239.210 with HTTP; Tue, 8 Jun 2010 10:50:51 -0700 (PDT)
In-Reply-To: <7vljaptp1j.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148696>

>
> In your transcript, they can say "git fetch" (or "git fetch origin") =
and
> branch is copied to origin/branch, so instead of doing:
>
> =C2=A0 =C2=A0$ git fetch origin branchname
> =C2=A0 =C2=A0$ git log FETCH_HEAD ;# or whatever inspection using FET=
CH_HEAD
>
> they can do
>
> =C2=A0 =C2=A0$ git fetch ;# or git fetch origin
> =C2=A0 =C2=A0$ git log origin/branch ;# or whatever inspection using =
it
>
> In short, teach them that they no longer have reason to learn or run =
"git
> fetch origin branchname".
>
>

Junio,

Yes, that's pretty much what we are doing. we are using "git fetch
origin" to update local remote branches (remote/branch) and then use
the information in there to inspect what are the incoming changes. I
was never teaching anybody to use "git fetch origin branch" So, we are
on the same page here with you.

The confusion though is that "git pull origin master" uses FETCH_HEAD
to store the information about remote master branch instead of
origin/master branch.
Therefore when people are using pull - they get confused why this
branch (origin/master) was not updated. Do you think that FETCH_HEAD
usage for pull still makes sense?

Thanks,
Eugene
