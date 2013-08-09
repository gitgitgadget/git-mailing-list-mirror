From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Repo with only one file
Date: Fri, 09 Aug 2013 08:50:09 +0200
Message-ID: <52049121.2080604@viscovery.net>
References: <CAH_OBid8SO3ydpjhRHa68s+54CScLh=jactxTQhwQPo-jcnAvA@mail.gmail.com> <520224E0.5060206@viscovery.net> <CAH_OBicysTTu9YdHsHz0H6x3umU5va68J3nT1qHA9-CJY9+E=A@mail.gmail.com> <CABURp0o_07HdB2o0knPABtAiiuHQ6-fYgemvdCYOsdSghO7v1w@mail.gmail.com> <52048B5B.5060009@viscovery.net> <CAH_OBicF3xn8+MsKH0nTg-HnPg58T-TWHW20r7GqXOm3Nbutfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 08:50:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7gWg-00013C-P0
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 08:50:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967231Ab3HIGuN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 02:50:13 -0400
Received: from so.liwest.at ([212.33.55.14]:10653 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754549Ab3HIGuM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 02:50:12 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1V7gWX-0006d4-Px; Fri, 09 Aug 2013 08:50:10 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 8FD0C1660F;
	Fri,  9 Aug 2013 08:50:09 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <CAH_OBicF3xn8+MsKH0nTg-HnPg58T-TWHW20r7GqXOm3Nbutfg@mail.gmail.com>
X-Enigmail-Version: 1.5.2
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231960>

Am 8/9/2013 8:33, schrieb shawn wilson:
> On Fri, Aug 9, 2013 at 2:25 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>> Am 8/8/2013 23:11, schrieb Phil Hord:
>>> On Wed, Aug 7, 2013 at 5:07 PM, shawn wilson <ag4ve.us@gmail.com> wrote:
>>>> On Wed, Aug 7, 2013 at 6:43 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>>> Am 8/7/2013 8:24, schrieb shawn wilson:> ... create a repo for one of
>>>>>> these scripts and I'd like to keep the commit history.
>>>>>>
>>>>>> Ok, so:
>>>>>> % find -type f ! -iname "webban.pl" | while read f; do git
>>>>>> filter-branch -f --index-filter "git rm --cached --ignore-unmatch $f"
>>>>>> HEAD ; done
>>>>>>
> 
>> I'm not sure. On second thought, my suggested command is not sufficient.
>> It does remove the empty commits, but it does not remove the other files.
>> So, Shawn's original filter-branch invocations are still needed.
>>
> 
> Yeah, I have tried this and haven't gotten any closer. I can either
> remove all of the history or that one commit that has nothing to do
> with my file is there. This is also reproducable in a new repo.
> 
> Is this a bug with filter-branch or git? This doesn't seem like a
> feature (or how things should act).

Let's check: After running your command above to remove other files, does
the command

   git filter-branch -f HEAD webban.pl

remove the empty commit (if necessary, replace HEAD by the branch name
that you are interested in)?

-- Hannes
