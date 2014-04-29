From: =?UTF-8?B?SmVhbi1Ob8OrbCBBdmlsYQ==?= <avila.jn@gmail.com>
Subject: Re: Tagging  a branch as "not fitted for branching" ?
Date: Tue, 29 Apr 2014 09:37:06 +0200
Message-ID: <535F56A2.9020900@gmail.com>
References: <535E4507.2070805@gmail.com> <xmqqoazlm3ji.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 09:37:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wf2bP-0002kl-0v
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 09:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932793AbaD2HhM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Apr 2014 03:37:12 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:54074 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932621AbaD2HhK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 03:37:10 -0400
Received: by mail-wi0-f182.google.com with SMTP id d1so6863669wiv.15
        for <git@vger.kernel.org>; Tue, 29 Apr 2014 00:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ostayBynKjdZ5c4y7wk+9iRk2n6jI6LsUtVobgSvNC4=;
        b=TknisgoWi2IvhmR79j3l4Hy6WPEUBXA9rEsEjcWxLelWv7cS3Q8+u6zVsssyUpTnZC
         X/cShY/XRABC6pmrIVyYQsDlxXkE9oQtmEZVyHVtg/JjWDJFwyxyIevbfxY6FJKyGWTD
         rOJFSrGmS331voTGHJF8CGv0cwr8I1hIp5EevfDztfwxVIZNHLTHFoXi/6lZbZr7MBTC
         SWbyGFgv2xJOweA+quAGJDjlOymMl5hLHnNb0ASDWPCi29R4JOVCmDhXNKmuDlHwergK
         PGTvRXtgNQjSSeqaWYm+D0s6O5yV5o/Da4wb+hjVjs5FkDke3W6J9Ios/eThkN9z+LfT
         m75w==
X-Received: by 10.180.228.42 with SMTP id sf10mr19159791wic.48.1398757028512;
        Tue, 29 Apr 2014 00:37:08 -0700 (PDT)
Received: from [192.168.1.95] (static-csq-cds-097114.business.bouyguestelecom.com. [164.177.97.114])
        by mx.google.com with ESMTPSA id bq12sm8312553wib.0.2014.04.29.00.37.07
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 29 Apr 2014 00:37:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqqoazlm3ji.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247525>

Le 29/04/2014 01:34, Junio C Hamano a =C3=A9crit :
> Jean-No=C3=ABl Avila <avila.jn@gmail.com> writes:
>
>> Most manuals on git state that it is bad practice to push -f a branc=
h
>> after have meddled with its history, because this would risk to upse=
t
>> the repositories of the coworkers. On the other hand, some workflows
>> use branches to propose modifications, and need some rewritting of t=
he
>> history after some review steps. In this case, the branch should onl=
y
>> be seen as a mere pile of patches. Having this two-sided discourse i=
s
>> often misunderstood by casual git users.
>>
>> The proposed solution would be to be able to flag the branches with =
a
>> special tag "not fitted for branching" that a collaborator could use
>> when pushing it. This tag would be passed on to any pulled
>> remote. When another collaborator would then issue a "git checkout
>> -b", the command would fail with a warning message, unless forced wi=
th
>> -f'.
>>
>> Is this feature already present? If not, would it be of any interest=
?
> Since nobody seems to be responding...
>
> I do not think there is anything like that.  I am not personally
> interested in it very much without seeing much details on how we go
> about implementing such a feature.  Note that I am not speaking on
> behalf of the project, or as its maintainer, but just as one of the
> active contributors to the project, so my "not interested" is in no
> way final.
>
> There are ways other than "checkout -b" to end up having your
> commits on top of a forbidden commit.  Are you going to cover all of
> them and at what point?  You may rebase your work based on 'master'
> (which is not one of these forbidden branches) onto it.  You may
> start your WIP on top of 'master', realize that you need something
> that is cooking only in 'pu' (which is a forbidden-to-be-built-on
> branch), and then do a "git checkout -m pu^0" in order to further
> experiment with it in an ideal world in which that prerequiste of
> yours already has graduated, and then decide to keep the WIP on a
> branch that you are not going to publish with "git branch wip" after
> commiting it on a detached HEAD.  Requiring "-f" during such an
> exploratory, idea-forming programming exercise might be a bit too
> much, and I cannot offhand see where the good place is to require
> "-f" in the first place.  At the final "git branch wip" step is too
> late, as you have already expended a lot of effort to build that
> WIP, and your saying "git branch wip" should be an enough clue for
> Git that you do mean to save it.
>
> At the first glance, I do agree (and to only this part I can say "I
> am interested in") that it might be a good idea if we had a bit more
> formal way to convey that branch 'pu' is not something you may want
> to base your final work on, but I am not sure if such a tag would
> help very much in practice or would be seen as a mere unnecessary
> roadblock that prevents them from freer experiments once the
> developers get used to the convention of their projects.

Thank you for your reply.

I had not looked at other scenarios and the use cases that you bring up=
=20
show that this feature would be far more complex than first estimated. =
I=20
was more focused on the simplest case that is the broadest in the githu=
b=20
fashion. Basing a work on a remote 'pu' branch when using advanced=20
branch management commands may not raise any warning, or these warnings=
=20
could be muffled with a config property.

After thinking a bit more on this, the initial idea encompassed another=
=20
feature: enable people to push without "-f" when they have created thes=
e=20
kind of branches. In your daily management of the pu branch for git, do=
=20
you have to use the -f flag a lot? Would it be helpful to just tell git=
=20
"I know what I am doing on this branch"? In this feature, the tagging=20
would only be local.
