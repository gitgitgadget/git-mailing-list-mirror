From: Wincent Colaiuta <win@wincent.com>
Subject: Re: gitweb bug: broken "next" and other links
Date: Tue, 12 Feb 2008 14:34:49 +0100
Message-ID: <2BAB20FB-3FDF-4133-A41A-55BB2AB32603@wincent.com>
References: <B0EC9FB3-DDDE-4BC5-92D8-20487CBD6725@wincent.com> <200802111630.29159.jnareb@gmail.com> <E16BED2E-C146-44D8-BD90-ECF0DF89CA35@wincent.com> <200802121410.58208.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=UTF-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 14:36:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOvIp-0000Vc-7Q
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 14:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762230AbYBLNe5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Feb 2008 08:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762286AbYBLNe5
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 08:34:57 -0500
Received: from wincent.com ([72.3.236.74]:48259 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761476AbYBLNe4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Feb 2008 08:34:56 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id m1CDYoaS023692;
	Tue, 12 Feb 2008 07:34:51 -0600
In-Reply-To: <200802121410.58208.jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73660>

El 12/2/2008, a las 14:10, Jakub Narebski escribi=C3=B3:

> Dnia wtorek 12. lutego 2008 13:24, Wincent Colaiuta napisa=C5=82:
>> El 11/2/2008, a las 16:30, Jakub Narebski escribi=C3=B3:
>>>
>>> I'm sorry. You are right. I haven't seen breakage because it shows
>>> only when you use 'pathinfo' feature and pathinfo URLs.
>>>
>>> Below there is a fix for that; actully only second part mentioned
>>> (and first in patch) is needed, i.e. moving setting =20
>>> $params{'project'}
>>> before dealing with -replay is needed I think to fix this bug.
>>>
>>> Could you test it please?
>>
>> Your patch fixes the "next" links in the shortlog and log views.
>>
>> It doesn't fix the broken "raw" links in the commitdiff view. I'm
>> still seeing links like:
>>
>> http://example.com/ARRAY(0x8c97f64)?a=3Dcommitdiff_plain;h=3Df29d562=
69a1c3bd4a970897397470f41553a64f9
>
> Could yu please give an URL for the page containing broken
> link

Any commitdiff page on repo.or.cz:

eg.

http://repo.or.cz/w/git.git?a=3Dcommitdiff;h=3D94bf9f7c37cca0241785a5f4=
e54e5cc98e175244

Any commitdiff page on my own gitweb install:

eg.

http://git.wincent.com/wikitext.git?a=3Dcommitdiff;h=3Df29d56269a1c3bd4=
a970897397470f41553a64f9

> relevant parts of gitweb configuration (gitweb_config.perl),
> and gitweb parts of repository configuration, if there are any?

Obviously I can't comment about the repo.or.cz config, but in my local =
=20
install gitweb was built with:

make prefix=3D/usr/local \
  GITWEB_PROJECTROOT=3D/pub/git/path_to_public_repos \
  GITWEB_LIST=3D/pub/git/conf/gitweb-projects \
  GITWEB_STRICT_EXPORT=3D1 \
  GITWEB_CSS=3D"/gitweb.css" \
  GITWEB_LOGO=3D"/git-logo.png" \
  GITWEB_FAVICON=3D"/git-favicon.png" \
  GITWEB_CONFIG=3D"/pub/git/conf/gitweb.conf" \
  gitweb/gitweb.cgi

And gitweb.conf contains:

$feature{'search'}{'default'} =3D [undef];
$feature{'blame'}{'default'} =3D [undef];
$feature{'pickaxe'}{'default'} =3D [undef];
$feature{'grep'}{'default'} =3D [undef];
$feature{'pathinfo'}{'default'} =3D [1];
$my_uri =3D "http://git.wincent.com";
$home_link =3D "http://git.wincent.com/";
$site_name =3D "git.wincent.com";

So all pretty stock standard, I think.

Cheers,
Wincent
