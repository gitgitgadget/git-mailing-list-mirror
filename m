From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Be nice with compilers that do not support runtime paths at all.
Date: Wed, 3 Oct 2007 21:08:11 -0400
Message-ID: <FC9DDD6F-14A5-4B73-9192-042EA107ED77@silverinsanity.com>
References: <7vsl4rdgf4.fsf@gitster.siamese.dyndns.org> <1191450052-23619-1-git-send-email-tsuna@lrde.epita.fr> <47041C7A.9090003@midwinter.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Benoit Sigoure <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Oct 04 03:08:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdFCE-00062H-UO
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 03:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362AbXJDBIA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 21:08:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbXJDBH7
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 21:07:59 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:60605 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbXJDBH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 21:07:59 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 6B55F1FFC013;
	Thu,  4 Oct 2007 01:07:56 +0000 (UTC)
In-Reply-To: <47041C7A.9090003@midwinter.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59913>


On Oct 3, 2007, at 6:49 PM, Steven Grimm wrote:

> Benoit Sigoure wrote:
>> On Darwin for instance, there is no -R or -Wl,-rpath thing to  
>> fiddle with,
>> it's simply not supported by the dynamic loader.  This patch  
>> introduces a
>> NO_RPATH define which is enabled by default for Darwin.
>>
>
> I compile git on a MacBook Pro (OS X 10.4, gcc 4.0.1 build 5367  
> from the normal Xcode install that comes on the OS install DVD) on  
> a regular basis. The makefile works fine for me. I suspect there's  
> something else going on here.

The rpath code is only used if you define one of the following options:

CURLDIR
ZLIB_PATH
OPENSSLDIR
ICONVDIR

The default Darwin options don't define any of these, it just relies  
on finding those libraries in the library path (including /sw or /opt/ 
local if you have them installed).

~~ Brian G.
