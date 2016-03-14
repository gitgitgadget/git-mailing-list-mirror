From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/GSoC] Introduction
Date: Mon, 14 Mar 2016 21:08:57 -0000
Organization: OPDS
Message-ID: <2F4E620D0B79497F837DC1D045B0467E@PhilipOakley>
References: <56E3BE3E.9070105@gmail.com> <1924FEBB-46F2-46EE-B190-5289588D4BED@gmail.com> <xmqqk2l58s2a.fsf@gitster.mtv.corp.google.com> <FB2E0900-A77E-4AE2-A580-9192746A8ABA@gmail.com>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Sidhant Sharma" <tigerkid001@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Lars Schneider" <larsxschneider@gmail.com>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 22:09:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afZje-0006yL-Qx
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 22:09:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbcCNVJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 17:09:00 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:16999 "EHLO
	smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932387AbcCNVI7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 17:08:59 -0400
Received: from PhilipOakley ([92.22.74.143])
	by smtp.talktalk.net with SMTP
	id fZjUaIzhLrhpnfZjUarj7X; Mon, 14 Mar 2016 21:08:57 +0000
X-Originating-IP: [92.22.74.143]
X-Spam: 0
X-Authority: v=2.1 cv=UqXDT7EB c=1 sm=1 tr=0 a=Xg0eXAnvs+o2/zmRCj3v+g==:117
 a=Xg0eXAnvs+o2/zmRCj3v+g==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8 a=ybZZDoGAAAAA:8
 a=VwQbUJbxAAAA:8 a=Tu2AlBILDdGIsXIDP5UA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfOv6mCztiwD0bQTLWt3QCq/DGFCbG8uOk0xhYtWlGKrg+JH1ndczJfMflu2x2U4Df5bnRbx4FVaTkgA/CBQIoyBNbpSChbcVyLVCwyoDuPeeRGvftsf7
 ILLDs4BLz47qC8GYHUN0GqdxWjrYhgPwkrR/4NgHAy+LBbz2W6hWJOR9xlbGjjliTEOHUOo8PE1QNt+c7fQQVsasAITpKFRk6rhKXTAuci3fyq+UA6qSracB
 gpy8jl4Ow6qpy7cUTYpmNa7/0iCIlc4rzopGMSoDeE0=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288812>

From: "Lars Schneider" <larsxschneider@gmail.com>
>
> On 14 Mar 2016, at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
>
>> Lars Schneider <larsxschneider@gmail.com> writes:
>>
>>> I thought a while about this requirement and I wonder if a wrapper 
>>> called
>>> 'ggit' (guarded Git) could be a solution. The wrapper would pass all
>>> command line arguments to 'git' and check for potentially destructive
>>> commands. If such a command is detected then the user would see a 
>>> warning.
>>
>> I recall back in the days when people said that Hg's command set was
>> so much more pleasant to use that some people thought about building
>> Hg's command line UI on top of low level implementation of the Git's
>> data structure.  Even before that time, there was an effort "Cogito"
>> to build an alternate UI on top of Git core.  If "ggit" can be made
>> reasonably feature complete in such a way that it lets beginners do
>> all what they need to do, omitting many advanced/hairy features core
>> Git may let users use (i.e. making trade-off between power and risk
>> of misuse differently from core Git), that may be a reasonable way
>> to offer a "beginner mode".
>>
>> The beauty of such an approach is that as long as "ggit" correctly
>> talks the same on-wire protocol when interacting with other people's
>> repositories, nobody needs to even know or care that you are using
>> "ggit" exclusively.  Two systems can talk without problems.
>>
>> If "ggit" is made too limited, there is an issue.  Beginners may at
>> some point need to transition to the real thing to fully exploit the
>> power of Git, and they may need to unlearn "ggit" and learn Git.
>
> I think a "ggit" wrapper should not introduce any new commands or new
> parameters. Everything should be passed unmodified to Git. The wrapper
> would only add additional warnings such as "You are about to do X which
> will permanently destroy Y. Do you want to continue?". Therefore
> a transition from "ggit" to "git" would not require any learning effort.
>
> Maybe "ggit" could also be interpreted as "guided Git" (sounds more
> friendly than "guarded Git"). I have the impression that many Git
> beginners make mistakes because they don't have a mental model of Git,
> yet. A "guided" Git version could explain the commands a bit more
> detailed as they use Git (e.g. with ASCII graph examples).

+1 on "guided" as a softer more (beginner) friendly term.

>        I know
> that's what man pages are for but I've encountered many users
> (especially on Windows) that are not aware of man pages.

In previous discussion it has been said that that (teaching and explaining) 
is not the purpose of man pages. Rather, the man pages are for reference for 
those who already have a reasonable idea of what they are doing, and use the 
man page to check on details.

Whether the man pages should have more examples (or a makefile option to 
include them) may be part of the beginner mode mix, and may come out of (or 
go into) the guidance examples.

The Git data model is very powerful and it does take a lot of 'unlearning' 
of old expectations (which is very hard) before the capabilities of the git 
model become well established in the users mind. For example, remote 
tracking branches are not remote but local, and are a reverse polish 
description (a local branch which keeps track of a remote's branch, from the 
last time you looked).

Different people get different parts of the model in different orders and 
different rates. Identifying the many issues (in model understanding) may be 
a start for identifying which command/options should be targeted.

>
>
>> This approach, if it wants to become successful in helping users,
>> would take quite a lot of thinking and work to avoid omitting too
>> much to necessitate users to migrate to Git.  But I can very well
>> imagine that a new "Cogito 2" project (I am not saying that the UI
>> Cogito tried to achieve were superiour or anything of that sort--I
>> just needed a name, and picked one name that came to my mind) may
>> get done by those who interact rarely with the core Git community
>> and may live as one of many independent and viable third-party
>> projects you find on GitHub.
>>
>> There however are two questions I do not offhand have good answers
>> to: (1) if that kind of effort is of suitable size for GSoC, and (2)
>> if it is suitable to be supported by the Git project proper.
>
> Good questions. I have no previous experience with GSoC Git projects
> and therefore I am not qualified for an answer. However, my gut feeling
> would be that a proof of concept implementation of a "ggit" wrapper
> that does not add any new commands and only adds warnings for destructive
> commands could be in the GSoC scope. However, Sidhant must be aware of
> the fact that this is a controversial topic and therefore any future work
> on this topic might be never merged into Git.
>
> I also thought about (2). The obvious advantage of having something like
> "ggit" as part of Git core is that it would be shipped with the standard
> Git distribution. That would especially help beginners. However,
> maintenance is a very strong counter argument. Maybe "ggit" could
> start as a separate project and if it picks up then Git core can still
> decide to merge it?
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
