From: Albert Dvornik <dvornik@gmail.com>
Subject: Re: [msysGit] Re: [PATCH] compat: Add another rudimentary poll() 
	emulation
Date: Thu, 27 May 2010 10:14:32 -0400
Message-ID: <AANLkTimn3kxLajKI69E-aE8QInrPArBjEmFxVTWVFUKW@mail.gmail.com>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
	<1274948384-167-2-git-send-email-abcd@gentoo.org>
	<20100527101043.GA4390@progeny.tock>
	<AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
	<AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
	<AANLkTil_dqbXChKpMJ_ZFTuNrF8tQRwJd5j4SkLOaPaJ@mail.gmail.com>
	<AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Marko Kreen <markokr@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Thu May 27 16:14:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHdr6-0007cX-TN
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 16:14:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab0E0OOg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 10:14:36 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38211 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118Ab0E0OOf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 10:14:35 -0400
Received: by pwi7 with SMTP id 7so16274pwi.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=wxQmvai5T3lZFRwwbloECcA0SGL1RGBn8LE3NSNaqrQ=;
        b=Oa8mG9/IAkvqgkPn/zKgiOOQjA0BiJfTXGMb9nT9wbzTTHAhgbOmUYTkqheDEhFP5q
         fy/0mhqECXK2zQsjJSivJbFL89scOodsi7EP0mAga2gwm9I/PtCAojyPZMlOjogwbcJ9
         zgZs2DWcU12z88iO6Ohm5y+NmB9Gu186NiYIE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=nTaMcAY2Ds06ZYqt/XwUyhrqOATPN3Vt5jlQxtJ8S1J+Qi/sLW3Q1t9sCN8nXS+z2W
         45fh4EsCpr/CeWx47plctjNron/9wV1kGxR0ELR2/VZXkvMDoNiApfjaQU0kLqjDWAuC
         4jqEeGF2PM15kq/Fh1ddaezzDrIFFejwQs1Ss=
Received: by 10.229.186.139 with SMTP id cs11mr2289815qcb.19.1274969672853; 
	Thu, 27 May 2010 07:14:32 -0700 (PDT)
Received: by 10.229.74.193 with HTTP; Thu, 27 May 2010 07:14:32 -0700 (PDT)
In-Reply-To: <AANLkTik2UAA51BZWIKadAcIg8t2xg1u980Gq_IOSyz6o@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147861>

On Thu, May 27, 2010 at 9:46 AM, Erik Faye-Lund
<kusmabite@googlemail.com> wrote:
> On Thu, May 27, 2010 at 3:29 PM, Marko Kreen <markokr@gmail.com> wrote:
[...]
>> Well, per your own FD_SET example, the FD_SETSIZE on windows
>> means different thing than FD_SETSIZE on old-style bitmap-based
>> select() implementation.

Yes, it sure does.  Once again, Windows seems to be a special, unique
snowflake. =)

>> On Unix, it's max fd number + 1, on windows it's max count.
>>
>
> Are you sure this applies for all Unix, not just some given Unix-y system?

While I can't make statements about "all UNIX" since there are many
obscure flavors, this is true on Linux, Solaris and various BSD
derivatives.  It's also what's specified by POSIX:

http://www.opengroup.org/onlinepubs/000095399/functions/select.html

--bert
