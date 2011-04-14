From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: What's cooking in git.git (Apr 2011, #04; Tue, 12)
Date: Thu, 14 Apr 2011 17:21:31 +0200
Message-ID: <4DA710FB.7060808@alum.mit.edu>
References: <7vaafvnl9t.fsf@alter.siamese.dyndns.org> <BANLkTi=7YSfKe=Pc5n-BNr30=ADM-jRXrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 17:22:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAONS-0000N6-Fh
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 17:22:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537Ab1DNPWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 11:22:33 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:40877 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab1DNPWc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 11:22:32 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p3EFLWse025284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 14 Apr 2011 17:21:32 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Lightning/1.0b2 Thunderbird/3.1.8
In-Reply-To: <BANLkTi=7YSfKe=Pc5n-BNr30=ADM-jRXrg@mail.gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171523>

On 04/14/2011 03:38 PM, Piotr Krukowiecki wrote:
> On Wed, Apr 13, 2011 at 12:43 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * mh/git-svn-automkdirs (2011-04-01) 1 commit
>>  (merged to 'next' on 2011-04-03 at 7fa4978)
>>  + git-svn: add an option to skip the creation of empty directories
>>
>> Should be safe, but I'd like an Ack from git-svn folks.
> 
> I wanted to test performance of this change - what's the best way to do it?
> 
> I tried some ideas, but rebase was too fast for performance measurements.
> I did not have new commits, but just some old, already in trunk changes, which
> I tried to rebase - probably it was just fast forward?

The unhandled.log.gz file for trunk of our main project is 14 Mb and
uncompresses to 233 Mb.  About 90% of it consists of svn:mergeinfo
properties for file that were copied or renamed within the repository;
most of the rest is other random SVN file properties.

With such a huge unhandled.log file, "git svn mkdirs" took about 10s for
me.  I believe that "git svn rebase" should take at least as long, even
if it is a fast-forward.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
