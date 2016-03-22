From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [RFC/GSoC] Introduction
Date: Tue, 22 Mar 2016 17:51:23 -0000
Organization: OPDS
Message-ID: <0ACDA16D9F234D9F97783A82A17B95B2@PhilipOakley>
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
X-From: git-owner@vger.kernel.org Tue Mar 22 20:29:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiRzu-00078b-Lk
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 20:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751773AbcCVT3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 15:29:43 -0400
Received: from smtp-d-3.talktalk.net ([78.144.6.131]:28612 "EHLO
	smtp-d-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751569AbcCVT3k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 15:29:40 -0400
Received: from PhilipOakley ([92.22.60.12])
	by smtp.talktalk.net with SMTP
	id iRrpaMRAcavFfiRrraAGJb; Tue, 22 Mar 2016 19:21:27 +0000
X-Originating-IP: [92.22.60.12]
X-Spam: 0
X-Authority: v=2.1 cv=M9ntU3Es c=1 sm=1 tr=0 a=N5WQhPxwIJU6fDAmqiwHsA==:117
 a=N5WQhPxwIJU6fDAmqiwHsA==:17 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10
 a=s5jvgZ67dGcA:10 a=8nJEP1OIZ-IA:10 a=xtxXYLxNAAAA:8 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=VwQbUJbxAAAA:8 a=SWqtVER8qSs355yyWaQA:9 a=wPNLvfGTeEIA:10
 a=x8gzFH9gYPwA:10
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfGNXAjzaSvRB0un8bgEveg+MG4IUczJaaibYRKWfHMl9Zy8c7C9MGWXpb9V4E/aF99rM4h8qokvpPZEUvMJ5hzbydlXY/OQ907lTBwR3eXJTkPOQrCGo
 9gqsrLg6R2m30LDWn4jifkNIVKyhZj32y4ex4crKzExmyfqOgTOOCkoWrpYyT2q6WS2lLDTyZapk7iVSJMntMJiEm5D7xXGo41yhtkOsjSTTfZ7H9emfrCEw
 afLiixolO2aRtTAXFcGMFlPXrWhrcy8/53BQuOValAU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289547>

From: "Philip Oakley" <philipoakley@iee.org> Sent: March 14, 2016 9:08 PM
> From: "Lars Schneider" <larsxschneider@gmail.com>
>>
>> On 14 Mar 2016, at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Lars Schneider <larsxschneider@gmail.com> writes:
>>>
>>>> I thought a while about this requirement and I wonder if a wrapper
>>>> called
>>>> 'ggit' (guarded Git) could be a solution. The wrapper would pass all
>>>> command line arguments to 'git' and check for potentially destructive
>>>> commands. If such a command is detected then the user would see a
>>>> warning.
>>>
>>> I recall back in the days when people said that Hg's command set was
>>> so much more pleasant to use that some people thought about building
>>> Hg's command line UI on top of low level implementation of the Git's
>>> data structure.  Even before that time, there was an effort "Cogito"
>>> to build an alternate UI on top of Git core.  If "ggit" can be made
>>> reasonably feature complete in such a way that it lets beginners do
>>> all what they need to do, omitting many advanced/hairy features core
>>> Git may let users use (i.e. making trade-off between power and risk
>>> of misuse differently from core Git), that may be a reasonable way
>>> to offer a "beginner mode".
>>>
>>> The beauty of such an approach is that as long as "ggit" correctly
>>> talks the same on-wire protocol when interacting with other people's
>>> repositories, nobody needs to even know or care that you are using
>>> "ggit" exclusively.  Two systems can talk without problems.
>>>
>>> If "ggit" is made too limited, there is an issue.  Beginners may at
>>> some point need to transition to the real thing to fully exploit the
>>> power of Git, and they may need to unlearn "ggit" and learn Git.
>>
>> I think a "ggit" wrapper should not introduce any new commands or new
>> parameters. Everything should be passed unmodified to Git. The wrapper
>> would only add additional warnings such as "You are about to do X which
>> will permanently destroy Y. Do you want to continue?". Therefore
>> a transition from "ggit" to "git" would not require any learning effort.
>>
>> Maybe "ggit" could also be interpreted as "guided Git" (sounds more
>> friendly than "guarded Git"). I have the impression that many Git
>> beginners make mistakes because they don't have a mental model of Git,
>> yet. A "guided" Git version could explain the commands a bit more
>> detailed as they use Git (e.g. with ASCII graph examples).
>
> +1 on "guided" as a softer more (beginner) friendly term.
>
>>        I know
>> that's what man pages are for but I've encountered many users
>> (especially on Windows) that are not aware of man pages.
>
> In previous discussion it has been said that that (teaching and
> explaining) is not the purpose of man pages. Rather, the man pages are for
> reference for those who already have a reasonable idea of what they are
> doing, and use the man page to check on details.
>
> Whether the man pages should have more examples (or a makefile option to
> include them) may be part of the beginner mode mix, and may come out of
> (or go into) the guidance examples.
>
> The Git data model is very powerful and it does take a lot of 'unlearning'
> of old expectations (which is very hard) before the capabilities of the
> git model become well established in the users mind.

>    For example, remote tracking branches are not remote but local, and are
> a reverse polish description (a local branch which keeps track of a
> remote's branch, from the last time you looked).

This just came up on the $gmane/289454 thread "When does git check for
branch-X being uptodate with origin/branch-X?" (21 Mar '16).

In that case, the issue was that the 'tracking' is not active, instead it's
a passive status that can become out of date, resulting in confusion about
the true status. This also is a issue because of the lack of a common, in a
broad world view, set of words for the problem.

Perhaps a 'have you fetched recently?' could be added for the beginner mode.

>
> Different people get different parts of the model in different orders and
> different rates. Identifying the many issues (in model understanding) may
> be a start for identifying which command/options should be targeted.
>
>>
>>
>>> This approach, if it wants to become successful in helping users,
>>> would take quite a lot of thinking and work to avoid omitting too
>>> much to necessitate users to migrate to Git.  But I can very well
>>> imagine that a new "Cogito 2" project (I am not saying that the UI
>>> Cogito tried to achieve were superiour or anything of that sort--I
>>> just needed a name, and picked one name that came to my mind) may
>>> get done by those who interact rarely with the core Git community
>>> and may live as one of many independent and viable third-party
>>> projects you find on GitHub.
>>>
>>> There however are two questions I do not offhand have good answers
>>> to: (1) if that kind of effort is of suitable size for GSoC, and (2)
>>> if it is suitable to be supported by the Git project proper.
>>
>> Good questions. I have no previous experience with GSoC Git projects
>> and therefore I am not qualified for an answer. However, my gut feeling
>> would be that a proof of concept implementation of a "ggit" wrapper
>> that does not add any new commands and only adds warnings for destructive
>> commands could be in the GSoC scope. However, Sidhant must be aware of
>> the fact that this is a controversial topic and therefore any future work
>> on this topic might be never merged into Git.
>>
>> I also thought about (2). The obvious advantage of having something like
>> "ggit" as part of Git core is that it would be shipped with the standard
>> Git distribution. That would especially help beginners. However,
>> maintenance is a very strong counter argument. Maybe "ggit" could
>> start as a separate project and if it picks up then Git core can still
>> decide to merge it?
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
