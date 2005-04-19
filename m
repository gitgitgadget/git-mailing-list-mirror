From: Kenneth Johansson <ken@kenjo.org>
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Date: Wed, 20 Apr 2005 01:04:59 +0200
Message-ID: <42658E9B.4030609@kenjo.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com> <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419214009.GA25681@kroah.com> <Pine.LNX.4.58.0504191449270.2274@ppc970.osdl.org> <20050419222738.GA14566@nevyn.them.org> <20050419223303.GB25966@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 01:01:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DO1ii-0000ui-Hp
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 01:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVDSXFa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Apr 2005 19:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261732AbVDSXFa
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Apr 2005 19:05:30 -0400
Received: from 1-1-4-20a.ras.sth.bostream.se ([82.182.72.90]:52706 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id S261714AbVDSXFH
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2005 19:05:07 -0400
Received: from power.kenjo.org ([192.168.1.6])
	by garbo.kenjo.org with esmtp (Exim 4.50)
	id 1DO1m9-000887-2e; Wed, 20 Apr 2005 01:05:01 +0200
User-Agent: Mozilla Thunderbird 1.0 (Macintosh/20041206)
X-Accept-Language: en-us, en
Newsgroups: gmane.comp.version-control.git
To: Greg KH <greg@kroah.com>
In-Reply-To: <20050419223303.GB25966@kroah.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Greg KH wrote:
> On Tue, Apr 19, 2005 at 06:27:38PM -0400, Daniel Jacobowitz wrote:
> 
>>On Tue, Apr 19, 2005 at 03:00:04PM -0700, Linus Torvalds wrote:
>>
>>>
>>>On Tue, 19 Apr 2005, Greg KH wrote:
>>>
>>>>It looks like your domain name isn't set up properly for your box (which
>>>>is why it worked for you, but not me before, causing that patch).
>>>
>>>No, I think it's a bug in your domainname changes. I don't think you
>>>should do the domainname at all if the hostname has a dot in it.
>>>
>>>Most machines I have access to (and that includes machines that are
>>>professionally maintained, not just my own cruddy setup) says "(none)" to
>>>domainname and have the full hostname in hostname.
>>>
>>>And even the ones that use domainname tend to not have a fully qualified 
>>>DNS domain there. You need to use dnsdomainname to get that, and I don't 
>>>even know how to do it with standard libc.
>>>
>>>So how about something like this?
>>>
>>>(Somebody who actually knows how these things should be done - please feel 
>>>free to pipe up).
>>
>>The glibc documentation blows for this, but what getdomainname comes
>>from uname(2), not from any DNS-related configuration.  Debian only
>>ever sets this if you're using NIS.
> 
> 
> Well, somehow Gentoo sets this up properly, and I'm not using NIS.  Hm,
> my SuSE boxes on the other hand...

I have to agree with Daniel on this one. The domainname is related to 
nis and can be whatever you want it has nothing to do with DNS domains. 
Similar to a realm in kerberos

This is how it's used both on debian and solaris(don't use much else) 
and is consistent with Linus claim that it's common to have none.


