From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH 0/3] Reject non-ff pulls by default
Date: Thu, 5 Sep 2013 22:30:34 +0100
Organization: OPDS
Message-ID: <BC4EB62C5077409384A225ECD96D04E1@PhilipOakley>
References: <1377988690-23460-1-git-send-email-felipe.contreras@gmail.com><xmqqd2opu8hr.fsf@gitster.dls.corp.google.com><CAMP44s2NzzS48BBpD_oQ24t2SYETte7_U4+O+32SOo5qhooQew@mail.gmail.com><xmqqfvtlpm2l.fsf@gitster.dls.corp.google.com><20130904081047.GB2582@serenity.lan><xmqqa9jso69u.fsf@gitster.dls.corp.google.com><7DC052455C7C4B50A4EAFC1EF63D006C@PhilipOakley> <xmqqr4d4jird.fsf@gitster.dls.corp.google.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "John Keeping" <john@keeping.me.uk>,
	"Felipe Contreras" <felipe.contreras@gmail.com>,
	"Git List" <git@vger.kernel.org>, "Andreas Krey" <a.krey@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 23:30:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHh8L-0006T6-VP
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 23:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab3IEVaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 17:30:25 -0400
Received: from out1.ip07ir2.opaltelecom.net ([62.24.128.243]:22276 "EHLO
	out1.ip07ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754241Ab3IEVaY (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Sep 2013 17:30:24 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AskLAIf2KFJOl3GZ/2dsb2JhbABbgweJbrhbBAQBgSoXdIIfBQEBBAEIAQEuHgEBIQUGAgMFAgEDFQwlFAEEGgYHCQENBgoJCAIBAgMBC4dgCro5jg4TgT+DJIEAA4h9hhKaTIMhO4Es
X-IPAS-Result: AskLAIf2KFJOl3GZ/2dsb2JhbABbgweJbrhbBAQBgSoXdIIfBQEBBAEIAQEuHgEBIQUGAgMFAgEDFQwlFAEEGgYHCQENBgoJCAIBAgMBC4dgCro5jg4TgT+DJIEAA4h9hhKaTIMhO4Es
X-IronPort-AV: E=Sophos;i="4.90,849,1371078000"; 
   d="scan'208";a="84366557"
Received: from host-78-151-113-153.as13285.net (HELO PhilipOakley) ([78.151.113.153])
  by out1.ip07ir2.opaltelecom.net with SMTP; 05 Sep 2013 22:30:21 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233994>

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> From: "Junio C Hamano" <gitster@pobox.com>
>>> John Keeping <john@keeping.me.uk> writes:
>>>
>>>> I think there are two distinct uses for pull, which boil down to:
>>>>
>>>>     (1) git pull
>>> ...
>>> Peff already covered (1)---it is highly doubtful that a merge is
>>> "almost always wrong".  In fact, if that _were_ the case, we should
>>> simply be defaulting to rebase, not failing the command and asking
>>> between merge and rebase like jc/pull-training-wheel topic did.
>>>
>>> We simply do not know what the user wants, as it heavily depends on
>>> the project, so we ask the user to choose one (and stick to it).
>>
>> We only offer a limited list. It won't be sufficient for all use
>> cases. It wasn't for me.
>
> Very interesting. Tell us more.
>
What I do now is avoid Pull because of the hassle of fixing anything
that may have gone wrong.

Instead I now use a 'git fetch', followed by a 'push . (+etc:etc)' once 
I understand what I've got, or what I need to do different if wasn't a 
simple fast forward 'pull'.

> When "git pull" stops because what was fetched in FETCH_HEAD does
> not fast-forward, then what did _you_ do (and with the knowledge you
> currently have, what would you do)?  In a single project, would you
> choose to sometimes rebase and sometimes merge, and if so, what is
> the choice depend on?  "When I am on these selected branches, I want
> to merge, but on other branches I want to rebase?"
>

In my case I have two home machines (main Windows machine and an 
occasional Linux laptop, though not directly networked together) and 
github as my level group, and have MSysGit and git/git (on github) as 
true upstreams, though they haven't been named that way [Aside: we are 
short of a good name for one's 'across-stream server' that one uses for 
backup/transfer such as github].

I general now use a forced update to bring my local machine up to date 
relative to whatever is upstream or on my across stream server, such as 
when transferring development from one machine to the other (where 
overwrite is the desired action) - e.g. when testing on the Linux laptop 
and a few corrections, before patch preparation on the Windows machine 
(different levels of familiarity).

I occasionally will need to rebase my topic onto an updated git/master 
or git/pu if it is to be submitted upstream (patches to the list) or if 
upstream has moved, though I want to choose where I will rebase the 
topic onto. I don't need merging in that scenario, as I see those via 
your git repo ;-)

It's not clear to me that a single default that uses a merge or rebase, 
without a 'stop if' criteria would be of any help in my situation.

My thoughts are that the options on a fetch-pull are for the branch to 
be:
* Overwritte (--force) (i.e. a conflict scenario)
* Stop if not-ff (conflict scenario, this patch series)
* rebase existing onto tracked [not a conflict in terms of initiation]
* merge existing into tracked [not a conflict in terms of initiation]
* fast-forward (bring tracked onto existing) [desired]

Philip
