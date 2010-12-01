From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: Re: [PATCH] commit: Remove backward goto in read_craft_line()
Date: Wed, 1 Dec 2010 22:40:55 +0100
Message-ID: <AANLkTikoh01_gQAZ3Js4cTfdRioKrR6GHAPDBvUOZm8P@mail.gmail.com>
References: <1291230959-3894-1-git-send-email-ralf.thielow@googlemail.com>
	<20101201194441.GB27347@burratino>
	<7vaakputxs.fsf@alter.siamese.dyndns.org>
	<20101201203132.GB27845@burratino>
	<AANLkTinLuF74UKaTMNX84FJt+PNoKkkOr3LaXDSCFqdz@mail.gmail.com>
	<7vwrnttcm3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 22:41:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNuQA-0001rH-JT
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 22:41:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab0LAVk5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 16:40:57 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44521 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751637Ab0LAVk4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 16:40:56 -0500
Received: by eye27 with SMTP id 27so3880470eye.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 13:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Bs6mTubA7HraKUUo5Xm0UryAjn2V8XAFpi0fYbnaqCg=;
        b=KJg/M3Jrz0b7TUtORrRzmbI8LXmAQnyB1AsvBbb/UdMKhseE9KdKEYRfw8BlQyE0sg
         t49ldgj0qQPKBswx8/V9AIysOuq3zsnl73N07obqL4W9fp5zcCre9Ad/G22KK73Ds7i+
         djlvwXHF1aq7r4DwweiWejm688RlP7O2v/ArE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=grxeib2MW3NQfxjnqkDPPc79wW2wtCOJ9jesWp58XEToaqy1Y5A4ePPxCn1cIQa9iV
         fIdDRW4zzGzLjrBDajajDVwGXXPJLR/WbwqZq4P5+5Sdevn/zKMqMCv/qKAZIQxYhdgk
         bjy9pH5mfJzCcfHzDH+pC+0R8Jwm9U7pusBnc=
Received: by 10.213.31.74 with SMTP id x10mr5187446ebc.49.1291239655432; Wed,
 01 Dec 2010 13:40:55 -0800 (PST)
Received: by 10.213.9.83 with HTTP; Wed, 1 Dec 2010 13:40:55 -0800 (PST)
In-Reply-To: <7vwrnttcm3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162617>

I remember about a peoble (not on this project) who sad that
also a little change like this should includes in the sources because
it's make the code better without fixing a bug or add a new feature.
But in my experience these patches are not very popular.
But sure, I understand your reasons, Junio.
The statement from above is not even true.

2010/12/1 Junio C Hamano <gitster@pobox.com>:
> Ralf Thielow <ralf.thielow@googlemail.com> writes:
>
>>> If "--show-c-function" output is the problem, perhaps we should kno=
w a bit
>>> better about what C function header looks like?
>>
>> In fact the "--show-c-function" output is the problem. But I think t=
hat
>> a change can't be rejected because of another issue.
>
> Well, I never said anything about rejection nor acceptance.
>
>> The style of placing "goto"-statements, which leave a function to th=
e
>> end of that is used in many other projects. And I think
>> it's very usefull.
>
> It is a good discipline to follow in general to place an exceptional =
case
> at the end if you jump out of the general flow. =C2=A0But because the=
 affected
> function was so small, its readability doesn't benefit very much from=
 the
> discipline (in other words, you knew about a good discipline, but app=
lied
> it to a wrong function). =C2=A0The patch was small and obviously corr=
ect, so it
> will not hurt, but it will not make the world greatly a better place,
> either.
>
> IOW, it was a "Meh" topic for me.
>
> It was more important to discuss Jonathan's "leave SP at the beginnin=
g of
> a goto label to please --show-c-function" from the maintainer's point=
 of
> view, as people may remember it as a rule and start sending patches t=
hat
> follow it, which I will need to deal with in the future. =C2=A0I do n=
ot think
> that one is a good rule.
>
> Now that we have dealt with that more important business of letting p=
eople
> know that protecting goto labels with a leading SP is _not_ the rule =
;-),
> I am happy with this discussion.
>
> And often I forget about the original issue when a discussion reaches=
 this
> stage of happiness. =C2=A0So thanks for reminding me.
>
> As I said, even though I do not think the particular function you tou=
ched
> badly needs the discipline applied, it would not hurt, and it obvious=
ly is
> the right thing to do (iow, if the function were written from day one=
 in a
> way your patch reorganized it, we would never accept a patch to chang=
e it
> into today's shape of jumping backwards). =C2=A0For one thing, it wou=
ld remove
> an example from the codebase people can point at to make excuses when
> responding to a review of their patch that adds a backward goto to a =
much
> larger function.
>
> Will queue after massaging the log message somewhat. =C2=A0Thanks.
>
