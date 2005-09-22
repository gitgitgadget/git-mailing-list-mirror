From: Wolfgang Denk <wd@denx.de>
Subject: Re: cg-export incompatible with older versions of GNU tar
Date: Thu, 22 Sep 2005 14:43:38 +0200
Message-ID: <20050922124338.246D535267B@atlas.denx.de>
References: <20050922120841.GH21019@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 14:45:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIQQx-0003Tb-AD
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 14:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVIVMoM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Sep 2005 08:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751465AbVIVMoM
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Sep 2005 08:44:12 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:6578 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751100AbVIVMoL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Sep 2005 08:44:11 -0400
Received: from fwd24.aul.t-online.de 
	by mailout05.sul.t-online.com with smtp 
	id 1EIQQl-0000jW-07; Thu, 22 Sep 2005 14:44:03 +0200
Received: from denx.de (Z2KTgmZBZeePar9jxezb8qvHCUQ4bbj59kyKvqL517mz0Rja7KJJ02@[84.150.102.249]) by fwd24.sul.t-online.de
	with esmtp id 1EIQQT-0bzUwK0; Thu, 22 Sep 2005 14:43:45 +0200
Received: from atlas.denx.de (atlas.denx.de [10.0.0.14])
	by denx.de (Postfix) with ESMTP
	id 6402242AF4; Thu, 22 Sep 2005 14:43:44 +0200 (MEST)
Received: from atlas.denx.de (localhost.localdomain [127.0.0.1])
	by atlas.denx.de (Postfix) with ESMTP id 246D535267B;
	Thu, 22 Sep 2005 14:43:38 +0200 (MEST)
To: Petr Baudis <pasky@suse.cz>
In-reply-to: Your message of "Thu, 22 Sep 2005 14:08:41 +0200."
             <20050922120841.GH21019@pasky.or.cz> 
X-ID: Z2KTgmZBZeePar9jxezb8qvHCUQ4bbj59kyKvqL517mz0Rja7KJJ02@t-dialin.net
X-TOI-MSGID: 23cc0f6d-ec2c-4736-9f01-723a81052b2f
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9115>

In message <20050922120841.GH21019@pasky.or.cz> you wrote:
>
> > -> tar jxf foo.tar.bz2 
> > tar: pax_global_header: Unknown file type 'g', extracted as normal file
> > ...

> It is unclear if the tar actually extracts the archive or not, though.
> Does it just complain with those warnings, or are they fatal errors?

In this case extraction went fine, except for the warning message.

I had other error reports from customers befroe, where unpacking  the
tarballs failed - instead of the origianl source tree just a bunch of
*.data  and  *.paxheader  were created; error messages in these cases
looked like this:

tar: pax_global_header: Unknown file type 'g', extracted as normal file
tar: ea1efd7f213469bcde030e00ac9f89ed16256869.paxheader: Unknown file type 'x', extracted as normal file
tar: a9cb6572db37b1260205ff3b931a8a29f8d5d0fd.paxheader: Unknown file type 'x', extracted as normal file
tar: 7cf505b98f5bceacbe4d4e5aca0c76beade1ba58.paxheader: Unknown file type 'x', extracted as normal file
tar: 01a2ae2195da20744b04d31a4cf701bc1ac43be0.paxheader: Unknown file type 'x', extracted as normal file
tar: d1cfe8f0c1806741d1723666db431331cb4ac74b.paxheader: Unknown file type 'x', extracted as normal file
tar: 6f78ecf8a87f103864dea6bdfa9b767bc606a96c.paxheader: Unknown file type 'x', extracted as normal file
tar: f6e986640b35d634574d14126402e09ef912d6f4.paxheader: Unknown file type 'x', extracted as normal file
tar: 5064e2fad29381384227a47404b1b9ef1dbf18cb.paxheader: Unknown file type 'x', extracted as normal file
tar: 29264b9d7d344b3908c8ebfea2d88b1319f18603.paxheader: Unknown file type 'x', extracted as normal file
...


[But this was with older versions of git / cogito, so I'm not sure if
this still applies.]

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I think animal testing is a terrible idea; they get all  nervous  and
give the wrong answers.
