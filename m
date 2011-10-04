From: =?ISO-8859-2?Q?Zbigniew_J=EAdrzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: Unable to remove a file
Date: Tue, 04 Oct 2011 16:08:29 +0200
Message-ID: <4E8B135D.8090507@in.waw.pl>
References: <CAAZ43xa2upWQ2LWJRVcOPew3kF0W7gSz9UgQ=g0gnMHKQB3Y4A@mail.gmail.com>	<m262k6jc2c.fsf@igel.home>	<CAAZ43xa43YjO7Vqw87cYnXhJWvsZT_ocPpLuJ81jCPc8KKRczw@mail.gmail.com>	<4E8ABC85.7090705@in.waw.pl>	<CAEBDL5U4gU9C0De42Sgqv1ODLwQBuOdYdhfTBCMUziCZrhK9dA@mail.gmail.com> <CAAZ43xZo8cyE_ASz1Hc4yYoUjmH1OnVogOj6mtqFzmAUSBptFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: John Szakmeister <john@szakmeister.net>,
	Andreas Schwab <schwab@linux-m68k.org>, git@vger.kernel.org
To: robert mena <robert.mena@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 04 16:07:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB5ex-0007wv-PJ
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 16:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757351Ab1JDOHn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Oct 2011 10:07:43 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:53157 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757286Ab1JDOHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 10:07:43 -0400
Received: from beck.fuw.edu.pl ([193.0.82.235])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1RB5em-0005oQ-1t; Tue, 04 Oct 2011 16:07:40 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.21) Gecko/20110831 Icedove/3.1.13
In-Reply-To: <CAAZ43xZo8cyE_ASz1Hc4yYoUjmH1OnVogOj6mtqFzmAUSBptFw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182771>

On 10/04/2011 01:36 PM, robert mena wrote:
> Hi John,
>
> I understand that.   For the other that have cloned the repository in
> the past (no one has committed anything locally) is there any special
> procedure to be performed or a simply git fetch/pull will make their
> local repositories in sync?

git fetch updates the remote references, always. If the remote is rebas=
ed,
as in this case, the only difference is that git fetch's message will b=
e
a little bit different.

git pull cannot be used in this case! It would "merge" the old history
with the new rewritten history... One should do 'git fetch' and then
'git reset --hard origin/master' or something like that.

-
Zbyszek


> 2011/10/4 John Szakmeister<john@szakmeister.net>:
>> 2011/10/4 Zbigniew J=EAdrzejewski-Szmek<zbyszek@in.waw.pl>:
>> [snip]
>>>> git filter-branch --index-filter 'git rm -q --ignore-unmatch --cac=
hed
>>>> scripts/\\' HEAD
>>>> Rewrite 5ac83187fa298add60cf81fd1d54b194da7ae783 (57/57)
>>>> Ref 'refs/heads/master' was rewritten
>>>> git push
>>>>   ! [rejected]        master ->    master (non-fast-forward)
>>>> error: failed to push some refs to 'git@myserver:repository'
>>>>
>>>> Should I do anything special?
>>>
>>> git push -f
>>
>> I assume you understand that you're rewriting history Robert, and th=
at
>> has some consequences?  You're master branch is now divergent, since
>> the commit ids changed.
>>
>> -John
>>
>
