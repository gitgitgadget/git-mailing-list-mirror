From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git log decipher
Date: Thu, 21 Jul 2011 04:41:50 -0700 (PDT)
Message-ID: <m3wrfbsvxv.fsf@localhost.localdomain>
References: <1311212351172-6605124.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gbhumphrey <greg_spam@gbhumphrey.com>
X-From: git-owner@vger.kernel.org Thu Jul 21 13:42:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjrdf-0007H8-Fo
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jul 2011 13:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab1GULly convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Jul 2011 07:41:54 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:44693 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926Ab1GULlx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jul 2011 07:41:53 -0400
Received: by fxd18 with SMTP id 18so3466611fxd.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2011 04:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=r1B1qdZ/UG5v0Dhc93YiwK92UOX4KW1xM42Dt4UOA9E=;
        b=T1XqsPX5p5FO0aUVVkcZRCxSLnuPqn0VsNJtlckdN8tO/YADiy/mU0XK9a8g63chc6
         /J6nOKBncKz8CZXC9oM5kt5vn92DnMeFZgD6bcZ8W6ulEf6BdeUX6Tzbkz2L0WKetmB6
         5RZdxFtoJnZ8Duq/HM/7tbVoqeOzwGEA0e8s4=
Received: by 10.223.144.194 with SMTP id a2mr154212fav.138.1311248512372;
        Thu, 21 Jul 2011 04:41:52 -0700 (PDT)
Received: from localhost.localdomain (aeho180.neoplus.adsl.tpnet.pl [79.186.196.180])
        by mx.google.com with ESMTPS id 21sm1352375fay.21.2011.07.21.04.41.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jul 2011 04:41:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p6LBfH6Q031764;
	Thu, 21 Jul 2011 13:41:27 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p6LBf0u6031760;
	Thu, 21 Jul 2011 13:41:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1311212351172-6605124.post@n2.nabble.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gbhumphrey <greg_spam@gbhumphrey.com> writes:

> Hi so in the .git/logs/refs/heads there are log files, i'm tryign to =
decipher
> the timestamp, at least I think it's a time stamp. An entry looks lik=
e this:
> a391d7a96af8c06a626eec23565ceccef81bc350
> fdfb6d8c87521d56d8a6034e8575304013ecdd6c Greg Humphrey &lt;XXX@XXXX.c=
om&gt;
> 1307594233 -0700	merge US199: Merge made by recursive.
>=20
> The "1307594233 -0700" seems to be a timestamp, but I'm not sure what
> format, anyone have any ideas how to convert to a human readable?

If you want to *view* this information, why not use "git reflog" or
"git log -g" instead of reading raw files?

If you want to *parse* this information:
 - "1307594233" is Unix epoch, i.e. number of seconds since
   '00:00:00 1970-01-01 UTC'; it is independent on timezone
 - "-0700" is RFC-2822 style numeric timezone; informational

=46rom RFC-2822 (http://tools.ietf.org/html/rfc2822#section-3.3)

   The zone specifies the offset from Coordinated Universal Time (UTC,
   formerly referred to as "Greenwich Mean Time") that the date and
   time-of-day represent.  The "+" or "-" indicates whether the
   time-of-day is ahead of (i.e., east of) or behind (i.e., west of)
   Universal Time.  The first two digits indicate the number of hours
   difference from Universal Time, and the last two digits indicate the
   number of minutes difference from Universal Time.  (Hence, +hhmm
   means +(hh * 60 + mm) minutes, and -hhmm means -(hh * 60 + mm)
   minutes).  The form "+0000" SHOULD be used to indicate a time zone a=
t
   Universal Time.  Though "-0000" also indicates Universal Time, it is
   used to indicate that the time was generated on a system that may be
   in a local time zone other than Universal Time and therefore
   indicates that the date-time contains no information about the local
   time zone.

--=20
Jakub Nar=EAbski
