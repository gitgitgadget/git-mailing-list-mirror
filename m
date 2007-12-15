From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 0/3 (resend)] gitweb: Miscelanous fixes
Date: Sat, 15 Dec 2007 15:34:50 +0100
Message-ID: <200712151534.50951.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 15:42:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3YDr-0004XE-Jp
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 15:42:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757222AbXLOOmH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Dec 2007 09:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754212AbXLOOmH
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 09:42:07 -0500
Received: from fk-out-0910.google.com ([209.85.128.188]:53520 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989AbXLOOmE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 09:42:04 -0500
Received: by fk-out-0910.google.com with SMTP id z23so399045fkz.5
        for <git@vger.kernel.org>; Sat, 15 Dec 2007 06:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        bh=c2y/xq3HZuOpYNfg2/MNI6XsvGHf2UwLzVDa35zmCH0=;
        b=qU+An1+BndMeHe7amWdmVC3ReQR7PzGJ9rVX+uF445a0ENvslPPNoroOJKD/wWqfVIBkSYb+cq6Ezm5u+zBBl1YGXecKlncg9TgZa8natE/ZeJkn5JujXgIRiYD/qQ+gmPMACLiyqKD7Ymx6BtQbu1X8NnnQPh201EoAi9u8JQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=AyiCYMXc2ay2bGatQ7u8o/flelJPNncd5X9KweEk4ARz234UGKAyvsw8JnNLoJu/zugiJrQs13D8xaMHecbx18xWECziy48Q6Jgrrn3kcQDY4rl6MIWbi19qg6Q+HNE+S1pfh2iOW1oWp0NJrJ1FoF5EHsea2sBH5Xz6NYSdz2E=
Received: by 10.86.86.12 with SMTP id j12mr4241941fgb.68.1197729722497;
        Sat, 15 Dec 2007 06:42:02 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.240.142])
        by mx.google.com with ESMTPS id b17sm14288867fka.2007.12.15.06.41.59
        (version=SSLv3 cipher=OTHER);
        Sat, 15 Dec 2007 06:42:00 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68386>

There were a few gitweb patches which were send (and seemed to
be accepted) before 1.5.4-rc0 (and before feature freeze request),
but are not in 'master'; it is not even in 'offcuts' (what is this
branch for by the way?).

All those patches are simple bugfixes (well, perhaps exept last one,
but even it can be treated as bugfix). All passes the gitweb test:
t9500-gitweb-standalone-no-errors (not that it says much).

Patches are independent conceptually, and should be textually
independent. Apply to 'master'

Table of contents:
 [PATCH] gitweb: Make config_to_multi return [] instead of [undef]
 [PATCH] gitweb: disambiguate heads and tags withs the same name
 [PATCH] gitweb: Teach "a=3Dblob" action to be more lenient about
         blob/file mime type

Diffstat:
 gitweb/gitweb.perl                     |   38 ++++++++++++++++--------=
-------
 t/t9500-gitweb-standalone-no-errors.sh |   25 +++++++++++++++++++++
 2 files changed, 45 insertions(+), 18 deletions(-)


P.S. I could not check if gitweb shows correct output as my Apache
has very mysteriously stopped working and refused to restart. It might
have been cause by an incident when runaway program filled whole disk
space with log, leaving no space on device... but it might not.

# /etc/rc.d/init.d/httpd status
httpd is stopped
# /etc/rc.d/init.d/httpd configtest=20
Syntax OK
# /etc/rc.d/init.d/httpd start    =20
Starting httpd:                                            [FAILED]
# cat /var/log/httpd/error_log
Configuration Failed
$ rpm -q httpd
httpd-2.0.54-10.3

--=20
Jakub Nar=C4=99bski
Poland
