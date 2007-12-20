From: Pascal Obry <pascal.obry@gmail.com>
Subject: Re: Problem with git-svn
Date: Thu, 20 Dec 2007 21:34:22 +0100
Organization: Home - http://www.obry.net
Message-ID: <476AD1CE.1080408@obry.net>
References: <4764FE2C.1010103@obry.net> <20071219082751.GA17787@muzzle> <47690031.7090409@obry.net> <20071220183007.GA26767@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 21:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5S6d-0005DE-SW
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 21:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759314AbXLTUe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 15:34:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759202AbXLTUe3
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 15:34:29 -0500
Received: from fg-out-1718.google.com ([72.14.220.159]:29823 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758958AbXLTUe1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 15:34:27 -0500
Received: by fg-out-1718.google.com with SMTP id e21so8265fga.17
        for <git@vger.kernel.org>; Thu, 20 Dec 2007 12:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        bh=p7ILP9AhI7Mie5tdGCQIQyUtQ9IyNcI63XSxk8+flsE=;
        b=SlLLeJpytJFgWZ1PDiUfkZGJthACYu+k2Dt4rjAVEnOLO0/Ck+9s7deHQG9EjWxiQVVRnpjh01XvODdhMPaS5xvy4lFOH1OUBsYJOnpZU59RMt/48O7ZQ2wtrDxnYTM0gjehIA/hZc01LDMqPe1LZvjNglvWNQLmjStLwVoRdYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding:from;
        b=KrWObQhSy76r9B0S70ndfW3bgBFfLvBZ33CyY5el9H/A2v1Z8IVBWdYpUW+Z/7ML6AwsU57JnCkArMn21soxLtRpXPRTPxeq6/jkzYacNQ61cLXbHCF7U/4k2boZ+FE0yFn/g85SqG/DKzmlXgIFHh9SdVpAOabDDsvvYNa3Y7g=
Received: by 10.86.54.3 with SMTP id c3mr351329fga.64.1198182866143;
        Thu, 20 Dec 2007 12:34:26 -0800 (PST)
Received: from ?192.168.0.100? ( [82.124.126.249])
        by mx.google.com with ESMTPS id d4sm210921fga.2.2007.12.20.12.34.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Dec 2007 12:34:25 -0800 (PST)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <20071220183007.GA26767@untitled>
X-Enigmail-Version: 0.95.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69016>

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
