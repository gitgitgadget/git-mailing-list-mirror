From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [RFC/PATCH 0/1] cygwin: Remove the Win32 l/stat() functions
Date: Tue, 25 Jun 2013 21:23:18 +0200
Message-ID: <51C9EE26.9010006@kdbg.org>
References: <51C5FD28.1070004@ramsay1.demon.co.uk> <51C7A875.6020205@gmail.com> <7va9mf6txq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: dpotapov@gmail.com, Mark Levedahl <mlevedahl@gmail.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, tboegi@web.de,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 25 21:23:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UrYpw-0006MZ-St
	for gcvg-git-2@plane.gmane.org; Tue, 25 Jun 2013 21:23:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751718Ab3FYTXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jun 2013 15:23:25 -0400
Received: from bsmtp3.bon.at ([213.33.87.17]:9411 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751347Ab3FYTXX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jun 2013 15:23:23 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 9FC3513004D;
	Tue, 25 Jun 2013 21:23:19 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7918D19F5F7;
	Tue, 25 Jun 2013 21:23:18 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7va9mf6txq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228983>

Am 25.06.2013 00:10, schrieb Junio C Hamano:
> Mark Levedahl <mlevedahl@gmail.com> writes:
> 
>> On 06/22/2013 03:38 PM, Ramsay Jones wrote:
>>> Also, apart from running the git test-suite, I have the Win32
>>> l/stat functions disabled on all of my repos. In particular, I have
>>> core.filemode set to true. (At one point, I used to build git with
>>> NO_TRUSTABLE_FILEMODE reset so that I wouldn't have to remember to
>>> reset core.filemode by hand after a git-clone or git-init). I should
>>> also note that I run MinGW git on the same laptop and, using git.git
>>> as an example, it does not seem that much faster (if at all) than
>>> cygwin git.
>>
>> After applying your patch to master, I've had the test-suite running
>> in a VM using WinXP + current cygwin (v1.7.x) for about 8 hours, no
>> failures so far but it could take another day to complete.
>>
>> I never found any real speed up using the Win32 stat/lstat functions,
>> and the lack of Posix compatibility breaking cross-platform projects,
>> links, etc.,  made this function a mis-feature in my opinion for
>> years. As I found no positive benefit from the Win32 lstat, I modified
>> git for local use years ago to set core.filemode=true when cloning /
>> initing to avoid as many issues as possible.
> 
> So that's two votes to use the vanilla Cygwin stat/lstat,
> essentially reverting adbc0b6b (cygwin: Use native Win32 API for
> stat, 2008-09-30), which was added by Dmitry and Shawn while I was
> away.
> 
> Let's wait and see if people give us more data points and decide.

That'll be more productive if we let the list know ;-)

Some context: This is about a patch by Ramsay that removes the
"schizophrenic lstat" hack for Cygwin. Junio, can you please queue that
patch in pu?

-- Hannes
