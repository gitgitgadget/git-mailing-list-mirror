From: "J.H." <warthog9@kernel.org>
Subject: Re: problems installing git docs and gitweb on centos 5.5
Date: Wed, 29 Sep 2010 22:27:40 -0700
Message-ID: <4CA41FCC.8050704@kernel.org>
References: <4CA3EFE6.2010306@brainstorm-digital.com> <20100930024059.GA2373@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Dennis Huynh <dennis@brainstorm-digital.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 30 08:06:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1CHj-00020d-Tg
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 08:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753666Ab0I3GGW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Sep 2010 02:06:22 -0400
Received: from shards.monkeyblade.net ([198.137.202.13]:53868 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753533Ab0I3GGV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Sep 2010 02:06:21 -0400
X-Greylist: delayed 2318 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Sep 2010 02:06:21 EDT
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id o8U5Re2F007465
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Wed, 29 Sep 2010 22:27:40 -0700
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.7
In-Reply-To: <20100930024059.GA2373@burratino>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Wed, 29 Sep 2010 22:27:41 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157631>

On 09/29/2010 07:40 PM, Jonathan Nieder wrote:
> (-cc: security@centos)
> 
> Hi Dennis,
> 
> Dennis Huynh wrote:
> 
>> Am I the only one having issues installing git docs?
> 
> Here's my advice:
> 
>  1. Breathe in, breathe out.
>  2. Look at the INSTALL file, section beginning "To build and install
>     documentation suite".  Among other things, it describes how to
>     retrieve pre-formatted documentation from the git.git repository
>     itself.  So you can try:
> 
> 	git clone git://git2.kernel.org/pub/scm/git/git.git

For the love of monkeys do *NOT* point people at specific git machines
like that.  Use git://git.kernel.org/pub/scm/git/git.git using a
specific machine causes a giant amount of headaches for me and
completely ruins any attempt at load balancing I might be able to
accomplish.

Couple that with the fact it will steer people to the wrong server if
they aren't in North America, it's just not a good idea.  Period.

> 	cd git
> 	make quick-install-doc
> 
>     after installing git, which should be relatively painless.
>  3. Look at gitweb/INSTALL.  The moment something seems unclear, note
>     that, so we can come up with a patch to make it clearer for the
>     next person.

As an overall note, git and gitweb, including my caching version of
gitweb are available in Fedora EPEL as rpm packages.  These are official
packages for Redhat / CentOS / Distro based on those things.  You
shouldn't need to compile your own really.

Unless you need the latest and greatest I would try those.  If you
really need the latest you might be better off grabbing the latest
.src.rpm from here:

http://www.kernel.org/pub/software/scm/git/RPMS/SRPMS/

http://www.kernel.org/pub/software/scm/git/RPMS/SRPMS/git-1.7.3.1-1.fc11.src.rpm

and doing an rpmbuild --rebuild git-1.7.3.1-1.fc11.src.rpm on it and
installing the rpm that it builds.

I'm not saying doing it completely from source is bad, but deviating
from what your distro uses / provides can cause other headaches and
maintenance issues down the line.

Bonus to going the RPM rebuild route is that it will tell you what your
missing to do the rebuild with.

- John 'Warthog9' Hawley
