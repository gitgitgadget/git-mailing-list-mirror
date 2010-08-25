From: Eric Blake <eblake@redhat.com>
Subject: Re: Fix 'git log' early pager startup error case
Date: Wed, 25 Aug 2010 08:22:49 -0600
Organization: Red Hat
Message-ID: <4C752739.3010808@redhat.com>
References: <alpine.LFD.2.00.1008241029530.1046@i5.linux-foundation.org> <20100825013625.GC10423@burratino> <4C74BFA7.1090907@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Matthias Lederhofer <matled@gmx.net>,
	=?ISO-8859-1?Q?J=FCrgen_R=FChle?= <j-r@online.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 25 16:24:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OoGtg-00015n-63
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 16:24:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753201Ab0HYOYD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Aug 2010 10:24:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:62605 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab0HYOYC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Aug 2010 10:24:02 -0400
Received: from int-mx08.intmail.prod.int.phx2.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.21])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7PEMpfi025788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Wed, 25 Aug 2010 10:22:53 -0400
Received: from [10.3.113.104] (ovpn-113-104.phx2.redhat.com [10.3.113.104])
	by int-mx08.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id o7PEMnKS005159;
	Wed, 25 Aug 2010 10:22:50 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.8) Gecko/20100806 Fedora/3.1.2-1.fc13 Mnenhy/0.8.3 Thunderbird/3.1.2
In-Reply-To: <4C74BFA7.1090907@viscovery.net>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.21
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154446>

On 08/25/2010 01:00 AM, Johannes Sixt wrote:
> Am 8/25/2010 3:36, schrieb Jonathan Nieder:
>> Mingw Git uses spawnvpe now, but Cygwin users might still suffer from
>> fork() troubles.  I think it should be possible to work around that by
>> using posix_spawn() from start_command() on such platforms (or
>> someting similar).
>
> Just FYI, posix_spawn() is not sufficiently capable for the demands of
> start_command(): It doesn't allow to set a new CWD for the spawned process.

And even if posix_spawn() were capable, cygwin doesn't yet implement it.

-- 
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org
