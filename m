From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Repo with only one file
Date: Fri, 09 Aug 2013 08:25:31 +0200
Message-ID: <52048B5B.5060009@viscovery.net>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com> <520224E0.5060206@viscovery.net> <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com> <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: shawn wilson <ag4ve.us@gmail.com>, Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 08:25:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7g8r-0007hw-Lb
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 08:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030292Ab3HIGZh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 02:25:37 -0400
Received: from so.liwest.at ([212.33.55.14]:60319 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030199Ab3HIGZg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 02:25:36 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1V7g8h-000547-W1; Fri, 09 Aug 2013 08:25:32 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 9931B1660F;
	Fri,  9 Aug 2013 08:25:31 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231956>

Am 8/8/2013 23:11, schrieb Phil Hord:
> On Wed, Aug 7, 2013 at 5:07 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
>> On Wed, Aug 7, 2013 at 6:43 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Am 8/7/2013 8:24, schrieb shawn wilson:> ... create a repo for one of
>>>> these scripts and I'd like to keep the commit history.
>>>>
>>>> Ok, so:
>>>> % find -type f ! -iname "webban.pl" | while read f; do git
>>>> filter-branch -f --index-filter "git rm --cached --ignore-unmatch $f"
>>>> HEAD ; done
>>>>
>>>> Which basically did it. But, I've got this one commit that seems to be
>>>> orphaned - it doesn't change any files.
>>>
>>> Try this:
>>>
>>>   git filter-branch HEAD -- webban.pl
>>>
>>
>>  % git filter-branch HEAD -- webban.pl
>> Cannot create a new backup.
>> A previous backup already exists in refs/original/
>> Force overwriting the backup with -f
>>  % git filter-branch -f HEAD -- webban.pl
>> Rewrite 1e04b18c256c996312f167be808733bcc755f1e3 (9/9)
>> WARNING: Ref 'refs/heads/master' is unchanged
> 
> I think you can ignore the warning.  Maybe you want to create a new
> branch which only has this file in it now.
> 
>    $ git checkout -b webban

I'm not sure. On second thought, my suggested command is not sufficient.
It does remove the empty commits, but it does not remove the other files.
So, Shawn's original filter-branch invocations are still needed.

-- Hannes
