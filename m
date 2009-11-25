From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb.js: Harden setting blamed commit info in incremental blame
Date: Thu, 26 Nov 2009 00:28:18 +0100
Message-ID: <200911260028.19383.jnareb@gmail.com>
References: <1258659887-5244-1-git-send-email-bebarino@gmail.com> <200911252155.59318.jnareb@gmail.com> <7vd436s2r8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stephen Boyd <bebarino@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:28:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRHk-0007Yp-Gy
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759567AbZKYX2V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 18:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934886AbZKYX2V
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:28:21 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:64879 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759552AbZKYX2U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 18:28:20 -0500
Received: by bwz27 with SMTP id 27so186540bwz.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 15:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=rszlu/wggJaYbL76D2SItkJyu2g62Cff/rZNvz3L8io=;
        b=pva8Dsk0rVozF5vDlwjTKFO+9J/yJTaZN3cqctpiyw8GV7gMxgsNMBF4kr9t0DDaiP
         7rKQXO8M0e87YAxIsqTdmh3c+qfoJxye+eTr5UN7kd51Qo12SdiGpLXUowaBUdb4BUXy
         BwAsE3olQAM7zaZ5mcS612ntvgeu3lyVVCXt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jjoVZLiQCAHwQb02zncYb5SzJ0ftHQ8ATPGNq86EGaxLqEsPpC3y8WEKUZiaNQsS+C
         GXQdrM6dzGSRROoBC+6ty8Ku03S/Tce3F5iQRV5mEC68At1xPZ4DjDRh87O2k5xZqfno
         jsZkhRZo85GrdSLQ2hzbs+/adEfrFT33zDdpE=
Received: by 10.204.3.220 with SMTP id 28mr2972321bko.4.1259191705163;
        Wed, 25 Nov 2009 15:28:25 -0800 (PST)
Received: from ?192.168.1.13? (abvf67.neoplus.adsl.tpnet.pl [83.8.203.67])
        by mx.google.com with ESMTPS id b17sm152694fka.16.2009.11.25.15.28.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 25 Nov 2009 15:28:23 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vd436s2r8.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133701>

On Wed, =B6roda 25. listopada 2009 22:39, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:
>=20
> > It was 'Unspecified error.' shown in xhr watch.  Accessing xhr.stat=
us
> > causes an error.
>=20
> As to the topic, it does not seem to break _existing_ features; if th=
at is
> not the case, please let me know.

With the single exception of "Create links leading to 'blame_incrementa=
l'
using JavaScript" all commits are about opt-in features: either need to
be enabled in gitweb config ('timed' feature), or you need to handcraft
URL ('blame_incremental' as action parameter).

The commit that makes 'blame' links to use 'blame_incremental' view if
JavaScript is enabled might break 'blame' view for IE8 users.

> Otherwise I'm inclined to merge the entire series to 'master' by 1.6.=
6-rc1.
>=20
>     6821dee gitweb.js: fix padLeftStr() and its usage
>     6aa2de5 gitweb.js: Harden setting blamed commit info in increment=
al blame
>     e42a05f gitweb.js: fix null object exception in initials calculat=
ion
>     63267de gitweb: Minify gitweb.js if JSMIN is defined
>     c4ccf61 gitweb: Create links leading to 'blame_incremental' using=
 JavaScript
>     e206d62 gitweb: Colorize 'blame_incremental' view during processi=
ng
>     4af819d gitweb: Incremental blame (using JavaScript)
>     aa7dd05 gitweb: Add optional "time to generate page" info in foot=
er
>     -aef3768 gitweb: Use light/dark for class names also in 'blame' v=
iew
>=20
> and treat it as a new feature with known breakages, to give it wider
> audience.  That way you will hopefully get more people who are willin=
g to
> help debug/fix things for you.

Perhaps then it would be better to put commit that creates links to=20
'blame_incremental' action last, and have it in 'next' and not in maste=
r?

Below there is request-pull with reordered series, unless you want me
to resend this series as a set of patches, as reply to this email.

-- >8 --
The following changes since commit b073b7a990deb1cb3425db45642fa18c8b3c=
b65c:
  Benjamin Kramer (1):
        Explicitly truncate bswap operand to uint32_t

are available in the git repository at:

  git://repo.or.cz/git/jnareb-git.git gitweb/web

  7bc7e38 gitweb: Create links leading to 'blame_incremental' using Jav=
aScript
  aa1ff3d gitweb.js: Harden setting blamed commit info in incremental b=
lame
  da51a3c gitweb.js: fix padLeftStr() and its usage
  a253a2c gitweb.js: fix null object exception in initials calculation
  fbebd29 gitweb: Minify gitweb.js if JSMIN is defined
  8ba6343 gitweb: Colorize 'blame_incremental' view during processing
  0e14278 gitweb: Incremental blame (using JavaScript)
  c4c6645 gitweb: Add optional "time to generate page" info in foot

Jakub Narebski (6):
      gitweb: Add optional "time to generate page" info in footer
      gitweb: Incremental blame (using JavaScript)
      gitweb: Colorize 'blame_incremental' view during processing
      gitweb: Minify gitweb.js if JSMIN is defined
      gitweb.js: Harden setting blamed commit info in incremental blame
      gitweb: Create links leading to 'blame_incremental' using JavaScr=
ipt

Stephen Boyd (2):
      gitweb.js: fix null object exception in initials calculation
      gitweb.js: fix padLeftStr() and its usage

 Makefile           |   26 ++-
 git-instaweb.sh    |    7 +
 gitweb/README      |    5 +
 gitweb/gitweb.css  |   25 ++
 gitweb/gitweb.js   |  870 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 gitweb/gitweb.perl |  311 ++++++++++++++-----
 6 files changed, 1157 insertions(+), 87 deletions(-)
 create mode 100644 gitweb/gitweb.js

--=20
Jakub Narebski
Poland
