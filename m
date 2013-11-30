From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: git-svn troubles with calendarserver SVN repo
Date: Sat, 30 Nov 2013 19:54:49 +1100
Message-ID: <CAH3Anro=vM2JLLZhdJ4nnO3qLhw4yV2JFT8EwC3jcbbGrj4H=g@mail.gmail.com>
References: <52991FE0.6040503@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?Q?Mat=C4=9Bj_Cepl?= <mcepl@redhat.com>
X-From: git-owner@vger.kernel.org Sat Nov 30 09:54:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VmgKF-0005h3-4p
	for gcvg-git-2@plane.gmane.org; Sat, 30 Nov 2013 09:54:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab3K3Iyv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Nov 2013 03:54:51 -0500
Received: from mail-la0-f50.google.com ([209.85.215.50]:51486 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069Ab3K3Iyu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Nov 2013 03:54:50 -0500
Received: by mail-la0-f50.google.com with SMTP id el20so7183409lab.23
        for <git@vger.kernel.org>; Sat, 30 Nov 2013 00:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=LTE21TTHU++Lsz/f8wBwNHiXIu19cRehdBgdZ0g6GLo=;
        b=URX5lw9JgeQDN0udtCiQy+FQcKY731/IK5CMmeS6R5WkIdryJA+REfribbh5nbzCMf
         WAsYIEPslVkBao7LFn8T7Chkx53KUy1Wd0sgu9m8nH1vFmHSoINUijcM0dBrV8jPxavj
         3vCqzVVDcOBzBqUq/yUP9kn8eoFmS0yC47yLbyCGFwK4A5Eeig0AHoy2xZo6yqKitEtj
         zCAyYcJdMhNX1eQccsJTPd9L4Ay2lJXM7FUPkU7/nk2seJZisZrScjgOdbGuAeMTR8Jl
         MxbCjM1CVMlBHVI/bl/GHN2oJg70GkG1e3C10R6WEwvJnDC8nwfTTL9oYKQBqqq3z0Rr
         yqjQ==
X-Received: by 10.112.53.97 with SMTP id a1mr255251lbp.38.1385801689496; Sat,
 30 Nov 2013 00:54:49 -0800 (PST)
Received: by 10.114.185.102 with HTTP; Sat, 30 Nov 2013 00:54:49 -0800 (PST)
In-Reply-To: <52991FE0.6040503@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238548>

I have seen this behaviour, though never determined the root cause
=2EProbably the simplest thing you can do without access to the server
is to put your git svn fetch into a bash while loop, like so:

while ! git svn fetch; do :; done;

jon

On Sat, Nov 30, 2013 at 10:14 AM, Mat=C4=9Bj Cepl <mcepl@redhat.com> wr=
ote:
> Hi,
>
>
>
> I am trying to git-svn clone
> https://svn.calendarserver.org/repository/calendarserver/CalendarServ=
er/
> and I cannot say I am much succesful. Every couple of hundred of comm=
its
> I get this:
>
>
> RA layer request failed: REPORT of
> '/repository/calendarserver/!svn/vcc/default': could not connect to
> server (https://svn.calendarserver.org) at
> /usr/local/share/perl5/Git/SVN/Ra.pm line 290.
>
>
> and git-svn stops. When restarting git svn fetch, it fetches
> another couple of hundred commits and then fails again. Given
> that there are 11000+ commits just in the trunk, I am afraid of
> a long long night. Did anybody managed to clone this repo? Or is
> there some way how to make git-svn more patient (this error
> means the SVN server is a bit flakey, right)?
>
> Best,
>
> Mat=C4=9Bj
> --
> http://www.ceplovi.cz/matej/, Jabber: mcepl@ceplovi.cz
> GPG Finger: 89EF 4BC6 288A BF43 1BAB  25C3 E09F EF25 D964 84AC
>
> A day without sunshine is like night.
>
