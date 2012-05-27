From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH] t7403-*.sh: Avoid use of the nonportable '==' operator
Date: Sun, 27 May 2012 17:01:44 +1000
Message-ID: <CAH3AnrrbsQYvwUuEEwb-E7sV_odGPE7pEFXNZd+SbbGs+1-vLQ@mail.gmail.com>
References: <4FC10A0B.5080407@ramsay1.demon.co.uk>
	<7vfwamp11u.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 27 09:02:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYXUi-0007kw-8A
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 09:02:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014Ab2E0HBs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 May 2012 03:01:48 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:35995 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2E0HBr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2012 03:01:47 -0400
Received: by wibhn6 with SMTP id hn6so771124wib.1
        for <git@vger.kernel.org>; Sun, 27 May 2012 00:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XlA+PBvkWfFCZIrm0/++R2GpoZulmK0OZDCG3HydCmY=;
        b=CIYKa5Rre1m1WeQ+gEczy7aiKFcvda1pYp+J9OblUt7s2SzHi3ayaJEHe2CYN46e2n
         N/4iKFBY63FBDYcywX4R/IIt+rrujtzocY2qHpgGA9Kcrz1TlWtNMaLypRSLqJnZdkAe
         mix4PlhyogqTF3EgMsrtAptKDtNrj+6WHCw3O8PhXhaXt+0JjmIyo1gcGx0jsDn7JptW
         2u5Wr0G+kTq6hwquS8GbMYgL2AKUGWfGKq0dZcECgWJDqzCnkGxIvgE9owtihAF1V6b4
         1L1lqyzJyNJLBwAEKQCmsCHU9+4748W18TWg07MeGOKt3z2nLCzIJM0NpF/dxP4gZrrz
         YPcA==
Received: by 10.180.93.196 with SMTP id cw4mr7293788wib.11.1338102105009; Sun,
 27 May 2012 00:01:45 -0700 (PDT)
Received: by 10.180.146.166 with HTTP; Sun, 27 May 2012 00:01:44 -0700 (PDT)
In-Reply-To: <7vfwamp11u.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198582>

On Sun, May 27, 2012 at 4:53 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>
>> Some shells, including dash, do not support using the '=3D=3D' strin=
g
>> equality operator. This results in the failure of tests 7-12 with
>> 'test' complaining of an "unexpected operator".
>
> Thanks. =C2=A0You do not have to single-out dash.
> A shell script that uses "test $a =3D=3D $b" is *buggy* and not confo=
rming to
> POSIX.

Yep. This slipped through because I happen to have reconfigured my
/bin/sh to point to bash (frrom Ubuntu's default of dash) because of
an issue with a product installation script. This shouldn't have been
a problem if bash's POSIX mode was strict about rejecting =3D=3D but ba=
sh
doesn't seem to be strict about this.

Anyway, I have reverted /bin/sh to refer to dash so hopefully I won't
be caught by this in future.

jon.
