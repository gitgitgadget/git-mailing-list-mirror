From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: gitweb ignores git-daemon-export-ok and displays all repositories
Date: Wed, 16 Nov 2011 16:47:06 -0600
Message-ID: <20111116224706.GA17851@elie.hsd1.il.comcast.net>
References: <20111113001730.3945.75979.reportbug@gpl.code.de>
 <20111113011932.GA12434@elie.hsd1.il.comcast.net>
 <D765D350-947E-4DB2-8A91-4B9653064F80@code.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Erik Wenzel <erik@code.de>, Jakub Narebski <jnareb@gmail.com>,
	John 'Warthog9' Hawley <warthog9@kernel.org>,
	Matthias Lederhofer <matled@gmx.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 16 23:47:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQoGJ-0007Hg-5E
	for gcvg-git-2@lo.gmane.org; Wed, 16 Nov 2011 23:47:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753898Ab1KPWrT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Nov 2011 17:47:19 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48008 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752238Ab1KPWrS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2011 17:47:18 -0500
Received: by yenq3 with SMTP id q3so282224yen.19
        for <git@vger.kernel.org>; Wed, 16 Nov 2011 14:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=eOd0dldC4J+VdnCwqQZjmgh0HuDOOQnQjoXZVeQZEdI=;
        b=n5cVsl5G4EoDiknpDcPAwxFVOsPdeZbvuMlzYTtMJh+y57KdPHSwh1dzIj/5FeOs0P
         9CAFEiVkM+5AosXFKICgMRl2fmaZOt7M1nc1oC1ICNC9YJIfMLDiyBSkR7xPguWfoY7U
         b9bm2MkHcyZ5x+Vcerhluij0pAhb6A5m7noXw=
Received: by 10.100.240.5 with SMTP id n5mr4145696anh.102.1321483637868;
        Wed, 16 Nov 2011 14:47:17 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id y1sm43685312anj.18.2011.11.16.14.47.15
        (version=SSLv3 cipher=OTHER);
        Wed, 16 Nov 2011 14:47:16 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <D765D350-947E-4DB2-8A91-4B9653064F80@code.de>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185559>

Hi gitwebbers,

Erik Wenzel wrote[1]:
> Am 13.11.2011 um 02.19 schrieb Jonathan Nieder:

>> The git-daemon(1) manpage describes git daemon, not gitweb, so I guess
>> you mean that
>>
>>	# Do not list projects without git-daemon-export-ok in the
>>	# projects list.
>>	our $export_ok = "git-daemon-export-ok";
>>
>>	# Do not allow access to projects not listed in the projects
>>	# list.
>>	our $strict_export = 1;
>>
>> should be the default.
[...]
> Because I think this is the way a user is expecting the behavior of gitweb.
> As I do. Don't let gitweb overwrite the meaning of "git-daemon-export-ok".
> Just act like git-daemon. Keep it simple and stupid.

My first thought was that if we could turn back time, it would
probably be best for both git-daemon and gitweb to look for a file
named git-export-ok.  In the present world, maybe git-daemon-export-ok
is a good substitute for that.

What do you think?  Should the default in the makefile be changed?  If
so, how could we go about it to avoid disturbing existing
installations?  (For example, in a system where no repositories have
the export-ok files and "git daemon" is configured to run with
--export-all, the effect would be to make repos suddenly disappear
from the projects list in gitweb.  Unpleasant.)

Looking forward to your thoughts,
Jonathan

[1] http://bugs.debian.org/648561
