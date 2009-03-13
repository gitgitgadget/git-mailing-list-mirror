From: John Tapsell <johnflux@gmail.com>
Subject: Re: [RFC/PATCH] git push usability improvements and default change
Date: Fri, 13 Mar 2009 10:07:15 +0000
Message-ID: <43d8ce650903130307u2944ca8n3191ca7c9fb7e30f@mail.gmail.com>
References: <1236638151-6465-1-git-send-email-finnag@pvv.org>
	 <7vfxhmdyvn.fsf@gitster.siamese.dyndns.org>
	 <20090310100400.GC11448@pvv.org>
	 <7v7i2v4x2v.fsf@gitster.siamese.dyndns.org>
	 <20090312120109.6117@nanako3.lavabit.com>
	 <20090312102243.GA27665@pvv.org>
	 <buomybrqahe.fsf@dhlpc061.dev.necel.com>
	 <20090312122047.GA14157@pvv.org>
	 <buohc1xddxa.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Finn Arne Gangstad <finnag@pvv.org>, '@pvv.org,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 11:08:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li4Jt-0002b4-D0
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 11:08:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752169AbZCMKHU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 13 Mar 2009 06:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751798AbZCMKHT
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 06:07:19 -0400
Received: from wf-out-1314.google.com ([209.85.200.169]:10406 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750901AbZCMKHR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Mar 2009 06:07:17 -0400
Received: by wf-out-1314.google.com with SMTP id 28so350940wfa.4
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 03:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8/ZDgLj31teJ+EzpaBXGuM67lSEHnoSA8rfTZ2QNjrI=;
        b=U9XUgBNXYvWsw6KMNRbs26R6z5fbEwTwzpPWc+W5Ivnd7LB5JPk/zYMlF2HXkRpRBv
         qgBU89g6bhKTn0Nb71mKGlEasqfOrbFrz1PurWOcXIEd1geymzRZFELvbRpciV+FeQJ3
         wJ+cEyK43lKqiGTUXcNnt9IncsNeTgYGsCD/0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=wXXNyB2na8XfzjLYzv9rGjgR4s1Kl9ZlFkz5NApSQA+lGZ6JeGk/xaPUmqBehKSqrH
         ypfcn+x9XfVkPBK2EmNQX6I88k9IEWtntHWUfL+D0S3j33X+BWtAuNQNvvkR7DGZ60X2
         u9kQrNd+t+4/zCYE7OqBgSaG/3ZE2EY9dktSA=
Received: by 10.142.88.4 with SMTP id l4mr519226wfb.112.1236938835245; Fri, 13 
	Mar 2009 03:07:15 -0700 (PDT)
In-Reply-To: <buohc1xddxa.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113162>

Hi,

   What's the status of these patches?  Will be commited?

John

2009/3/13 Miles Bader <miles@gnu.org>:
> Finn Arne Gangstad <finnag@pvv.org> writes:
>>> Presumably the push --track option would be used with an explicit b=
ranch
>>> name given to push anyway, right? =C2=A0Then it can use that info t=
o set up
>>> the tracking flexibly (and with sane defaults).
>>>
>>> E.g.,, simple case:
>>> =C2=A0 =C2=A0 git push --track SOME_REMOTE BRANCH_NAME
>>>
>>> complex case:
>>> =C2=A0 =C2=A0 git push --track SOME_REMOTE MY-BRANCH:REMOTE-BRANCH
>>
>> Yes, git push --track ... would typically do the same thing to the
>> config as git checkout -b MY-BRANCH SOME_REMOTE/REMOTE-BRANCH, which
>> is enough for push --tracking to do its thing.
>>
>> I am not sure if you mean that git push --track could do something
>> extra to make --tracking unecessary for git push, currently it canno=
t
>> do that since the push configuration is per remote, not per branch.
>
> Hmm, now I'm confused... I was just thinking about --track, but am no=
t
> sure what --tracking is ... need to go grovel past posts...
>
> -Miles
>
> --
> Happiness, n. An agreeable sensation arising from contemplating the m=
isery of
> another.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
>
