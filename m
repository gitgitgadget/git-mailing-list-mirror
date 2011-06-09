From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Command-line interface thoughts
Date: Fri, 10 Jun 2011 01:02:19 +0200
Message-ID: <4DF150FB.9070304@alum.mit.edu>
References: <BANLkTikTWx7A64vN+hVZgL7cuiZ16Eobgg@mail.gmail.com> <20110609200403.GA3955@sigill.intra.peff.net> <4DF13D00.2060000@alum.mit.edu> <201106100004.58040.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 10 01:02:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUoFJ-0001YT-T5
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 01:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756763Ab1FIXCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 19:02:32 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60514 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756696Ab1FIXCb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 19:02:31 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p59N2KCZ025479
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Fri, 10 Jun 2011 01:02:20 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17) Gecko/20110424 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <201106100004.58040.jnareb@gmail.com>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175588>

On 06/10/2011 12:04 AM, Jakub Narebski wrote:
> On Thu, 9 Jan 2011, Michael Haggerty wrote:
>> On 06/09/2011 10:04 PM, Jeff King wrote:
>>> I'm less sure about these new tokens, for a few reasons:
>>>
>>>   1. You get less useful answers in some situations by treating each
>>>      stage as a separate tree (e.g., lack of combined diff). So why
>>>      would I want to use them?
>>
>> Wouldn't it be nice to be able to do a combined diff between *any* two
>> trees?  Then the nonuniform merge behavior of "git diff" would be a
>> special case of a general concept:
>>
>>     git diff3 OURS NEXT THEIRS
>                 ^^^^^^^^^^^^^^^^ -- ???
> 
> First, it is unnecessary power, unnecessary complication.  WTF. you are
> doing comparing _abitrary_ trees?
> 
> Second, for files with merge conflicts "git diff" is the same as
> "git diff3 OURS THEIRS WTREE", not "git diff3 OURS NEXT THEIRS".
> As you can see it is very easy to construct wrong options to git-diff,
> and end up with nonsense!

Since there is currently no "git diff3" command, I decided to orient the
hypothetical "git diff3" command based on diff3(1), which uses

    diff3 [OPTION]... MYFILE OLDFILE YOURFILE

By using a new command (diff3) that is somewhat familiar to some users,
we could reduce the amount of overloading of "git diff".  I, for one,
was surprised and confused the first few times I typed "git diff" during
a merge and got a three-way diff rather than what I expected, namely the
two-way diff that is called "git diff NEXT WTREE" in the proposed notation.

> I won't repear the THIRD time simple and around *three times shorter*
> explanation on _when_ to use which form: "git diff" for your own remaining
> changes that can be "git add"-ef, "git diff --staged" for which changes
> are staged i.e. what you have "git add"-ed, and "git diff HEAD" to compare
> current with last.

You don't need to repeat for my benefit the existing version of the
commands; I knew them long before this discussion started.  And
repeating them does not make them more obvious.

For a beginner, the main goal is not brevity.  It is discoverability and
memorability.  Obviously our priorities and tastes differ and we will
not come to agreement.  I would be very interested what people with a
fresh memory of struggling to learn the git CLI think would have been
easier to learn.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
