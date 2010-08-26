From: Eric Blake <eblake@redhat.com>
Subject: Re: setting working dir in posix_spawn() (Re: Fix 'git log' early
 pager startup error case)
Date: Thu, 26 Aug 2010 08:13:22 -0600
Organization: Red Hat
Message-ID: <4C767682.7030700@redhat.com>
References: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org> <20100825013625.GC10423@burratino> <4C74BFA7.1090907@viscovery.net> <4C752739.3010808@redhat.com> <20100826061815.GH9708@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthias Lederhofer <matled@gmx.net>,
	=?ISO-8859-1?Q?J=FCrgen_R=FChle?= <j-r@online.de>,
	austin-group-futures-l@opengroup.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 26 16:16:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OodFx-0000gx-MM
	for gcvg-git-2@lo.gmane.org; Thu, 26 Aug 2010 16:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753813Ab0HZOPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 10:15:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25136 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753512Ab0HZOPA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 10:15:00 -0400
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7QEDPaq011405
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 26 Aug 2010 10:13:25 -0400
Received: from [10.3.113.81] (ovpn-113-81.phx2.redhat.com [10.3.113.81])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7QEDNr3022080;
	Thu, 26 Aug 2010 10:13:23 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Mnenhy/0.8.3 Thunderbird/3.1.2
In-Reply-To: <20100826061815.GH9708@burratino>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154540>

On 08/26/2010 12:18 AM, Jonathan Nieder wrote:
> Do you think there would be any interest in a posix_spawn() variant
> that takes a dir parameter?  I am imagining something like this:

Of your variants, I would most prefer:

>   int posix_spawn_file_actions_addchdir(posix_spawn_file_actions_t
> 	*file_actions, int dirfd);

For that matter, it may also be worth adding 
posix_spawn_file_actions_addopenat, which mirrors the recent addition of 
openat() semantics.

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
