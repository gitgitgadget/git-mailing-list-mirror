From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Problem with git-svn
Date: Thu, 20 Dec 2007 21:33:47 +0100
Organization: Home
Message-ID: <476AD1AB.8040406@gmail.com>
References: <4764FE2C.1010103@obry.net> <20071219082751.GA17787@muzzle> <47690031.7090409@obry.net> <20071220183007.GA26767@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 21:34:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5S5y-0004w6-7C
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 21:34:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbXLTUdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 15:33:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXLTUdz
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 15:33:55 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:29088 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510AbXLTUdy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 15:33:54 -0500
Received: by fg-out-1718.google.com with SMTP id e21so8187fga.17
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 12:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        bh=p7ILP9AhI7Mie5tdGCQIQyUtQ9IyNcI63XSxk8+flsE=;
        b=M9V3ix6tCWkd8DF+IdkuMEt3F6ZPL5Ku8J/HJ0145eh3CMLWzzWAiQGGb7qLEsaGCXWrmrGRQ0y0cTSUnwMLPMLi5ly6SVoecPlnIb3evTYTFRhWE6Rd9Z0DLEIb2PR+DIVolXFh9XuSxQDPMBbAHkkjn8YNyv+klmm/Ib8M6+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=CPSKeeEjII1Kl6wO9GJiDKxs5bZjMeyNT0vkDgMZ2cZSH8Qd2dlD2gDSZq0RMyYMCHJzOM7UVa4K2gHp5mNjRABaabodZW+sS+6GeaL6nyE/Fes4z4a+KEhHqUgjnFe9ir+P9GoD9eZAifNwa+od8hOPjIt8n9L7W7Caxo7StMs=
Received: by 10.86.80.5 with SMTP id d5mr359107fgb.20.1198182832022;
        Thu, 20 Dec 2007 12:33:52 -0800 (PST)
Received: from ?192.168.0.100? ( [82.124.126.249])
        by mx.google.com with ESMTPS id e11sm212366fga.5.2007.12.20.12.33.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Dec 2007 12:33:50 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071220183007.GA26767@untitled>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69015>

Eric,

> Ah, oops, I was off-by-one with the revision number.  But git-svn does
> look to be doing the right thing here, because it followed history into
> /importfromcvs/trunk/ and file.el was part of it.

Yes part of it but before the creation of the /importfromcvs/trunk/ that
was moved later as /trunk/PROJ.

In /importfromcvs/trunk/ there was many projects imported. One per one,
each time moving it into /trunk/PROJ.

If I look at history of /trunk/PROJ:

   $ svn log svn+ssh://myserver/trunk/PROJ

The last revision is 45775, so I think git-svn should not look past this
revision. So I'm very surprised by the current behavior and think it is
a bug to import file.el at revision 9458. Note that the workaround for
me is to use:

   $ git svn clone svn+ssh://myserver/trunk/PROJ --revision=45775:HEAD

But it would be lot cleaner to have git-svn handling this properly I think.

Thanks,
Pascal.

-- 

--|------------------------------------------------------
--| Pascal Obry                           Team-Ada Member
--| 45, rue Gabriel Peri - 78114 Magny Les Hameaux FRANCE
--|------------------------------------------------------
--|              http://www.obry.net
--| "The best way to travel is by means of imagination"
--|
--| gpg --keyserver wwwkeys.pgp.net --recv-key C1082595
