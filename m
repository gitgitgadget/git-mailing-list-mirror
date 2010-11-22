From: Pascal Obry <pascal@obry.net>
Subject: Re: Can't build doc anymore (v1.7.3.2)
Date: Mon, 22 Nov 2010 22:01:09 +0100
Organization: Home - http://www.obry.net
Message-ID: <4CEADA15.1020502@obry.net>
References: <m2oc9hkurl.fsf@gmail.com>
Reply-To: pascal@obry.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 22 22:02:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKdWU-0000FD-Os
	for gcvg-git-2@lo.gmane.org; Mon, 22 Nov 2010 22:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753602Ab0KVVBQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 16:01:16 -0500
Received: from smtp12.smtpout.orange.fr ([80.12.242.134]:27060 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263Ab0KVVBP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 16:01:15 -0500
Received: from [192.168.0.100] ([83.204.249.233])
	by mwinf5d23 with ME
	id aM191f00M52tS8K03M1ALq; Mon, 22 Nov 2010 22:01:12 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; fr-FR; rv:1.8.1.22) Gecko/20090605 Thunderbird/2.0.0.22 Mnenhy/0.7.5.0
In-Reply-To: <m2oc9hkurl.fsf@gmail.com>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161912>

Francis,

>       XMLTO git-fetch.1
>   xmlto: /home/fmoreau/git/Documentation/git-fetch.xml does not validate (status 3)
>   xmlto: Fix document syntax or use --skip-validation option
>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>   /home/fmoreau/git/Documentation/git-fetch.xml:2: warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>   D DocBook XML V4.5//EN" "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>                                                                                  ^
>   I/O error : Attempt to load network entity http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd
>   warning: failed to load external entity "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>   validity error : Could not load the external subset "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd"
>   Document /home/fmoreau/git/Documentation/git-fetch.xml does not validate
>   make[1]: *** [git-fetch.1] Error 13
>   make[1]: Leaving directory `/home/fmoreau/git/Documentation'
> 
> Could anybody tell me what's now wrong ?

I had a similar problem on Cygwin at some point. The fix was to add some
rewrite rule in the docbook catalog (/etc/xml/catalog):

I had added this:

  <rewriteSystem
     systemIdStartString="http://www.oasis-open.org/docbook/xml/4.5/"
     rewritePrefix="/usr/share/sgml/docbook/xml-dtd-4.4/"/>

You may have to adjust...

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|    http://www.obry.net  -  http://v2p.fr.eu.org
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver keys.gnupg.net --recv-key F949BD3B
