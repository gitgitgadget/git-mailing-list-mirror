From: Christoph Miebach <christoph.miebach@web.de>
Subject: Localization: Timestamps get wrong if using different locales
Date: Sun, 05 Aug 2012 11:08:56 +0200
Message-ID: <501E3828.40708@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 11:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sxwuu-0003sc-Oa
	for gcvg-git-2@plane.gmane.org; Sun, 05 Aug 2012 11:14:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754155Ab2HEJOU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 05:14:20 -0400
Received: from mout.web.de ([212.227.15.4]:53050 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754090Ab2HEJOH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 05:14:07 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sun, 05 Aug 2012 05:14:07 EDT
Received: from [192.168.168.63] ([89.0.184.116]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MbhFJ-1TEnQR1kN3-00IoGw for <git@vger.kernel.org>;
 Sun, 05 Aug 2012 11:09:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:14.0) Gecko/20120713 Thunderbird/14.0
X-Provags-ID: V02:K0:yqYT8RE31iu4p+9RVeZzWQOAUU/AspHOOP4ylBSaB01
 fefgfV9NbFvVoXw5Hh1PbmWQtNnjQVbRQfQd9oulkLl6tWP4PG
 koo0M8NaDvh1yweMfhY/uuiVdMlx+NmLoce8gxwt8vreSXqpvo
 tjsVo9KUtwOic098svpV/VIg78ZMEryOPWYEWpc3WdwbLAkGjO
 Ay/DWDAFuOrsUhnMxM38t/KMry5EDaQNjBnSWxgj8I=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202905>

Hello!

Running this commands locally (german locale) lead to some wrong dates 
for the patches upstream.

git format-patch -o patches origin

git send-email --compose --no-chain-reply-to --to some@address.com 
--suppress-cc=author patches/0001-l10n-Turkish-update.patch


The local
Date: Sat, 4 Aug 2012
became
       Wed, 8 Dec 2004

So it looks like matching  DD=04=YY  MM=08=DD  and  YY=12=MM

German date format usually looks DD.MM.YYYY

A workaround for me was running the lines with LANGUAGE=en



I am using
git-send-email 1.7.10.4
with the patch from here
http://www.mail-archive.com/git@vger.kernel.org/msg05240.html
but I do not expect this to do any harm here.

Shall I provide more information?

Regards

Christoph
