From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-svn troubles with calendarserver SVN repo
Date: Mon, 2 Dec 2013 18:00:54 +1100
Message-ID: <CAH3Anroi65OrZZQ0MvmPxgWZXB_eG=1aA-cxqdR=y-uAXsFaNA@mail.gmail.com>
References: <52991FE0.6040503@redhat.com>
	<CAH3Anro=vM2JLLZhdJ4nnO3qLhw4yV2JFT8EwC3jcbbGrj4H=g@mail.gmail.com>
	<529C229F.2030504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@redhat.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 08:01:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnNV6-0006YK-KA
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 08:01:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753025Ab3LBHA4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 02:00:56 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:40578 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753001Ab3LBHA4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Dec 2013 02:00:56 -0500
Received: by mail-la0-f50.google.com with SMTP id el20so8029841lab.37
        for <git@vger.kernel.org>; Sun, 01 Dec 2013 23:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=MOyPd/9ytNwLixXcflIPPd6AD6piyUuNHG4sWnDRMYk=;
        b=AdrhoAycE5bOnu/jBAyPljShdF4i3JXMLwsQl9vhaJKoAPA6gLBCkIjVXQtcVVSp/X
         NAApOz/7E1h/+4v/tkKz86HAH8A0mOoEkhckpSHqVxR3v/JqmMaY33ogHIo+uDMhX+qB
         r9ep4ZC+HRM8/THZdWEvNtNH9v0I7YutdYGgEBzjEkgaWBxDz5HWMFwuQvpkSfAhDHxz
         kF7g7z+x1Lx1M0P2GiWsFUW5MqY+kNCjFDB14xoWjyHnEHDruCucuoQ5t35hDixkjU5l
         0xqFcoH4VKyAeyxP+v3wWyC7mYFFE1+R5XBYwpDBr1FbbJrdIjrlFLoB0V4LtXqqhUO7
         OwOA==
X-Received: by 10.152.238.34 with SMTP id vh2mr91995lac.50.1385967654803; Sun,
 01 Dec 2013 23:00:54 -0800 (PST)
Received: by 10.114.26.73 with HTTP; Sun, 1 Dec 2013 23:00:54 -0800 (PST)
In-Reply-To: <529C229F.2030504@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238615>

My experience is that the fetch will be atomic - it either fetches an
SVN commit or it doesn't.

=46ailure during dcommit is more painful and I usually find it is
necessary to manually use a git rebase to rebase the commits that
didn't make it to SVN on top of the commits that did.

jon.

On Mon, Dec 2, 2013 at 5:03 PM, Mat=C4=9Bj Cepl <mcepl@redhat.com> wrot=
e:
> On 30/11/13 09:54, Jon Seymour wrote:
>> I have seen this behaviour, though never determined the root cause
>> .Probably the simplest thing you can do without access to the server
>> is to put your git svn fetch into a bash while loop, like so:
>>
>> while ! git svn fetch; do :; done;
>
> Of course, I did this, but still I wonder how much is the resulting g=
it
> repository http://luther.ceplovi.cz/git/CalendarServer.git/ faithful
> representation of the original SVN one http://trac.calendarserver.org=
/.
> Would not be something missing?
>
> Best,
>
> Mat=C4=9Bj
>
> --
> http://www.ceplovi.cz/matej/, Jabber: mcepl@ceplovi.cz
> GPG Finger: 89EF 4BC6 288A BF43 1BAB  25C3 E09F EF25 D964 84AC
>
> They that can give up essential liberty to obtain a little
> temporary safety deserve neither liberty nor safety.
>     -- Benjamin Franklin, Historical Review
>        of Pennsylvania, 1759.
>
