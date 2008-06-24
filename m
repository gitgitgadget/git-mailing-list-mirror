From: Robert Haines <rhaines@manchester.ac.uk>
Subject: Re: git-clone works with ssh but not with http/https/git
Date: Tue, 24 Jun 2008 13:35:26 +0100
Message-ID: <A3460448-8007-4E02-AC20-85C1A8C85786@manchester.ac.uk>
References: <ce513bcc0806240415h669d1725uf7b6e495995ab459@mail.gmail.com> <1214306517.6441.10.camel@localhost> <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "Matthias Kestenholz" <mk@spinlock.ch>, git@vger.kernel.org
To: Erez Zilber <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 14:36:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB7l7-0000MQ-Gg
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 14:36:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbYFXMfe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 08:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbYFXMfd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 08:35:33 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:49429 "EHLO
	serenity.mcc.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750935AbYFXMfc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 08:35:32 -0400
Received: from gomwe.mcc.ac.uk ([10.2.18.2])
	by serenity.mcc.ac.uk with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1KB7k6-000DgV-Ai; Tue, 24 Jun 2008 13:35:26 +0100
Received: from leela.rcs.manchester.ac.uk ([130.88.1.66]:51635)
	by gomwe.mcc.ac.uk with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69 (FreeBSD))
	(envelope-from <rhaines@manchester.ac.uk>)
	id 1KB7k6-000GTw-7f; Tue, 24 Jun 2008 13:35:26 +0100
In-Reply-To: <ce513bcc0806240445x6d00323g303f218504d2df53@mail.gmail.com>
X-Mailer: Apple Mail (2.924)
X-Authenticated-Sender: Robert Haines from leela.rcs.manchester.ac.uk [130.88.1.66]:51635
X-Authenticated-From: Robert.Haines@manchester.ac.uk
X-UoM: Scanned by the University Mail System. See http://www.itservices.manchester.ac.uk/email/filtering/information/ for details.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86046>

> I ran git-daemon on the server side like this:
>
> sudo git-daemon --base-path=/pub/git/ --export-all --listen=kites

So your clone address for git:// is wrong, you don't need the /pub/git:
git clone git://erez.zilber@kites/erez.zilber/my_test.git
As you've moved the root of the filesystem as far as git-daemon is  
concerned to /pub/git with the --base-path option. I suspect a similar  
problem for http[s] depending on how you've mapped /pub/git into your  
webserver.

rather than:
git clone ssh://erez.zilber@kites/pub/git/erez.zilber/my_test.git
for ssh which does start at the root of the filesystem.

Cheers,
Rob
