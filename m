From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: Unable to build git on Lion - missing config.h from Perl header
 files
Date: Fri, 19 Aug 2011 17:57:24 -0500
Message-ID: <3TtrXbFVbVBpoFp03GzorAbFk1nah9JWGbzZoev7ibqE4phUwUuQOxugdF7MaGB4A7t5rxO6zbw9rxO2xRnaY15F4dNLwBGhb-XCgbYKZ1E@cipher.nrlssc.navy.mil>
References: <611AB1F99D784B92B1F7278139D6EED5@gmail.com> <9B588F2F-ACDF-4DA7-BE30-E075CA729731@gmail.com> <CAGDPfJoG_ksfL5vqzGWe5jqW646CKB=Qxm9_G5d=ZHMWfixweA@mail.gmail.com> <201108200012.17580.trast@student.ethz.ch> <AB9XcTjejfHZgS1f-niUuA8LXYrYI2Jhg8PT6m_2MG8pJDSqNg1wgQ@cipher.nrlssc.navy.mil> <CAGDPfJpSVknybUjUsHkb1Mb8_SqQxJB2idRTxxfsT8eRSA91CQ@mail.gmail.com> <7vk4a910rd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Sorin Sbarnea <sorin.sbarnea@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	David Aguilar <davvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 00:57:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuY0Q-0008G6-3y
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 00:57:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755493Ab1HSW5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 18:57:33 -0400
Received: from mail3.nrlssc.navy.mil ([128.160.11.249]:36163 "EHLO
	mail3.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752685Ab1HSW5d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 18:57:33 -0400
Received: by mail3.nrlssc.navy.mil id p7JMvO3f001323; Fri, 19 Aug 2011 17:57:25 -0500
In-Reply-To: <7vk4a910rd.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 19 Aug 2011 22:57:24.0776 (UTC) FILETIME=[5C574A80:01CC5EC3]
X-Virus-Scanned: clamav-milter 0.97.2 at mail3
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179740>

On 08/19/2011 05:42 PM, Junio C Hamano wrote:
> Sorin Sbarnea <sorin.sbarnea@gmail.com> writes:
> 
>> On Fri, Aug 19, 2011 at 23:19, Brandon Casey
>>> Probably MakeMaker.
>>>
>>> Setting NO_PERL_MAKEMAKER may help:
>>>
>>>   rm perl/perl.mak
>>>   make NO_PERL_MAKEMAKER=1
>>>
>> I confirm that this workaround solved the problem. Now the question is
>> what should be changed so git will be installed (and build) without
>> problems by homebrew?
> 
> If the user's distro does not have packaged makemaker, or if the user
> chooses not to install it, then the build procedure of git can be told to
> avoid using it, which is what you did. So there is nothing to fix there.
> 
> If you are not going to tell git to avoid makemaker, in other words, if
> you want to use makemaker, then installing it before starting the build
> procedure would help, too. But that is outside the scope of git project.

I got the impression that his system did have makemaker, and that it
created the perl.mak file, but then building git failed because some
header files were missing from his perl installation.

Earlier he said:

>> The only files existing in
>> /System/Library/Perl/5.12/darwin-thread-multi-2level/CORE/ are
>> libperl.dylib andperl.h.

I don't have access to a mac, but on my system I have many header files
in .../x86_64-linux-thread-multi/CORE/ including config.h.  These files
are part of the base perl installation rpm (i.e. not some -devel rpm).

But like you said, there is nothing to fix on the git side of things.

-Brandon
