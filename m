From: Jason Merrill <jason@redhat.com>
Subject: Re: git clone sending unneeded objects (was : git gc expanding packed
 data?)
Date: Fri, 25 Sep 2009 14:05:29 -0400
Message-ID: <4ABD0669.7050309@redhat.com>
References: <m2tz0j154o.fsf@igel.home>	<alpine.LFD.2.00.0908082246020.440@xanadu.home> <m2k51dzb39.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>,
	Hin-Tak Leung <hintak.leung@gmail.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Fri Sep 25 20:07:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrFBE-0006Hl-65
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 20:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752154AbZIYSFv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 14:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbZIYSFv
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 14:05:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64727 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752020AbZIYSFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 14:05:50 -0400
Received: from int-mx05.intmail.prod.int.phx2.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.18])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id n8PI5W6x009648;
	Fri, 25 Sep 2009 14:05:32 -0400
Received: from [IPv6:::1] (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx05.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id n8PI5VvQ004028;
	Fri, 25 Sep 2009 14:05:31 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.4pre) Gecko/20090922 Shredder/3.0pre
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <m2k51dzb39.fsf@linux-m68k.org>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.18
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129099>

On 08/09/2009 03:43 AM, Andreas Schwab wrote:
> Nicolas Pitre<nico@cam.org>  writes:
>
>> If you do a clone using the git:// protocol and the server sends you
>> only the ref for the trunk branch,
>
> A clone will fetch all branches from refs/heads/*.
>
>> then it should send you only objects reachable from that branch.
>
> Apparantly this does not work.  I'd guess the extra objects are needed
> due to the delta compression.

I just tried doing a clone of the GCC repository, then git gc 
--prune=now, and another clone specifying --reference to the first, and 
it wanted to download all the unreachable objects again.  So it doesn't 
seem to be a compression issue.

This is with git 1.6.4 on both ends.

Jason
