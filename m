From: Pete Harlan <pgit@pcharlan.com>
Subject: Re: git-mv redux: there must be something else going on
Date: Wed, 03 Feb 2010 12:12:07 -0800
Message-ID: <4B69D897.2060908@pcharlan.com>
References: <ron1-32BD5F.10255403022010@news.gmane.org> <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Ron Garret <ron1@flownet.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 03 21:12:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NclaC-0003kr-1u
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 21:12:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757826Ab0BCUMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 15:12:10 -0500
Received: from caibbdcaaaaf.dreamhost.com ([208.113.200.5]:41243 "EHLO
	swarthymail-a1.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757822Ab0BCUMI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Feb 2010 15:12:08 -0500
Received: from [192.168.0.119] (031.132-78-65.ftth.swbr.surewest.net [65.78.132.31])
	by swarthymail-a1.g.dreamhost.com (Postfix) with ESMTP id 083738F172;
	Wed,  3 Feb 2010 12:12:07 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
In-Reply-To: <32541b131002031048i26d166d9w3567a60515235c34@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138882>

On 02/03/2010 10:48 AM, Avery Pennarun wrote:
>> [ron@mickey:~/devel/gittest]$ git mv file2 file3
>> [ron@mickey:~/devel/gittest]$ git commit -m 'letters->numbers'
>> [master ae3f6d4] letters->numbers
>>  1 files changed, 0 insertions(+), 0 deletions(-)
>>  rename file2 => file3 (100%)
> 
> Whoops.  You didn't 'git add file2' (before the mv) or 'git add file3'
> (after the mv), or use commit -a, so what you've committed is the
> *old* content of file2 under the name file3.  The *new* content of
> file2 is still uncommitted in your work tree under the name file3.

It may be reasonable for "git mv foo bar" to print a helpful message to
the user if foo has un-checked-in changes, similarly to what "git rm" does.

Unlike "git rm", "git mv" could still perform the operation even without
"-f", but the semantics of "git mv" differ enough from plain "mv" that a
short blurb from Git in that case might help.

--Pete
