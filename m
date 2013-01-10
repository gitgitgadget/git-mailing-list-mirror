From: bryanlarsen <bryan@larsen.st>
Subject: Re: bugreport: stgit cannot export empty patch
Date: Thu, 10 Jan 2013 15:16:57 -0800 (PST)
Message-ID: <1357859817532-7574691.post@n2.nabble.com>
References: <CAPk5vtzpUHgL_dfJLJHgKsaNPZodx1jbTRQpRdoj01RRPRoBfg@mail.gmail.com> <xmqqboll2nl0.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 11 00:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TtRN8-0002hK-Eg
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jan 2013 00:17:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754419Ab3AJXQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2013 18:16:58 -0500
Received: from 216-139-250-139.aus.us.siteprotect.com ([216.139.250.139]:34149
	"EHLO joe.nabble.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754012Ab3AJXQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2013 18:16:58 -0500
Received: from jim.nabble.com ([192.168.236.80])
	by joe.nabble.com with esmtp (Exim 4.72)
	(envelope-from <bryan@larsen.st>)
	id 1TtRMn-00078Y-HZ
	for git@vger.kernel.org; Thu, 10 Jan 2013 15:16:57 -0800
In-Reply-To: <xmqqboll2nl0.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213161>

Junio C Hamano writes:

> Stepan Koltsov &lt;stepan.koltsov@&gt; writes:
>> stgit fails to export empty patches:
>>
>> % stg new empty-patch -m 'asasas'
>> Now at patch "empty-patch"
>> % stg export empty-patch
>> Checking for changes in the working directory ... done
>> fatal: unrecognized input
>> stg export: git failed with code 128
>> zsh: exit 2     stg export empty-patch
>>
>> % stg --version
>> Stacked GIT 0.16-3-g67cf
>> git version 1.7.9.1
>> Python version 2.7.1 (r271:86832, Jul 31 2011, 19:30:53)
>> [GCC 4.2.1 (Based on Apple Inc. build 5658) (LLVM build 2335.15.00)]

> I don't use (or read the sources to) StGIT, but isn't the whole point of
> "stg export" to "convert your StGIT patches into patch files"?  For an
> empty commit, what is an appropriate output?  IOW, is it reasonable to
> have an empty commit in your history if you are planning to "stg export"
> it?

Here's another example where the functionality is useful: 
https://github.com/Hobo/agility-gitorial-patches is used to build
http://cookbook.hobocentral.net/tutorials/agility

Each commit/patch becomes a step in the tutorial.  Some tutorial steps don't
have any code attached to them.

In the past, an export of an empty commit would yield a patch where the last
three lines were

> ---
>  0 files changed, 0 insertions(+), 0 deletions(-)
>

The latest version of stgit along with git v1.6 eliminates the error.  A
bisection identifies cc64b318f26c9e176c4f07b1a459a86e7a04c4eb as the source
of the problem.

Thanks,
Bryan




--
View this message in context: http://git.661346.n2.nabble.com/bugreport-stgit-cannot-export-empty-patch-tp7559494p7574691.html
Sent from the git mailing list archive at Nabble.com.
