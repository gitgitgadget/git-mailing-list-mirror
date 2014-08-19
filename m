From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Relative submodule URLs
Date: Tue, 19 Aug 2014 11:50:08 -0500
Message-ID: <CAHd499B9Wa=Y6P+OD8Ea-6dA4yZSkGZZSR9CwZAM45evDL_Qiw@mail.gmail.com>
References: <CAHd499CRNjp-UzXiTt=xgDJWGOEqew+AuPFmrF3-VsEGefXiuA@mail.gmail.com>
	<20140818205505.GA20185@google.com>
	<20140819102421.GA5012@book.hvoigt.net>
	<CAHd499CJfX_n_KnQScTFueCSkj6i0x0ozwwD8Oe_2a-VH2oq1w@mail.gmail.com>
	<xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git <git@vger.kernel.org>, Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 18:50:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmby-0004zW-AV
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbaHSQuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:50:12 -0400
Received: from mail-vc0-f176.google.com ([209.85.220.176]:36653 "EHLO
	mail-vc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625AbaHSQuK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:50:10 -0400
Received: by mail-vc0-f176.google.com with SMTP id id10so7716482vcb.35
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6hyNTIzUZ6Hlo5uvyErqK4oHYo813lraXxUD1Cp3SH8=;
        b=R6vVvQQQMMQ5FthIvxyiqPNoyp+1awUGo38xJyAIAG7OG/0+O1sxypePDs8nlWztOY
         YuN1+H5VuF98Zsqa0lUkau8eJCEgkSEWA+DS1ctWyUKC8Uovx4rY82ADtQZXTyL7Dh73
         DYOpdwicX+LF8+ITr3/koY2Sa63Ei/HI8m6qtMFxjSOvbD+UC/MvGns93MldKlXTEfhS
         p0V0+AUKb3BwyMiQSGqjnUQXnPgvwVKHvzK7Jl3P3pBRtrQUAbAFQmJbgZC/Wt/1TWQn
         wvT5ZgvFuHjBItlKb7tx7yn7H1gB8FWnJe4zy072hccFwy21t5SPIEeazqdGcIH0roXZ
         E+yQ==
X-Received: by 10.220.96.137 with SMTP id h9mr1634117vcn.46.1408467008387;
 Tue, 19 Aug 2014 09:50:08 -0700 (PDT)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.220.102.201 with HTTP; Tue, 19 Aug 2014 09:50:08 -0700 (PDT)
In-Reply-To: <xmqqiolowi1f.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: RG4HTLKP0QBXUPFNfp1UEkpYmAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255500>

On Tue, Aug 19, 2014 at 11:39 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Dailey <rcdailey.lists@gmail.com> writes:
>
>> The way I set up my remote tracking branch will be different for each
>> of these commands:
>>
>> - git pull :: If I want convenient pulls (with rebase), I will track
>> my upstream branch. My pushes have to be more explicit as a tradeoff.
>
> Keeping 'origin' pointing at the repository where you cloned from,
> without doing anything funky (i.e. "set up my remote") would give
> you convenient pulls.
>
>> - git push :: If I want convenient pushes, track my origin branch.
>> Pulls become less convenient. My relative submodules will now need to
>> be forked.
>
> You need to configure your pushes to go to a different place, if you
> want them to go to a different place ;-).
>
> Long time ago, it used to be that you have to affect the URL used in
> both direction, making pulls less conveninent, but hasn't this been
> made an non-issue for triangular workflows with the introduction of
> remote.pushdefault long time ago?
>
>> - git submodule update :: I track upstream to avoid forking my
>> submodules. But pushes become more inconvenient.
>
> If 'submodule update' follows the same place as 'pull' goes by
> default, I would imagine that there is no issue here, no?  Am I
> oversimplifying the issue by guessing that the root cause of is that
> you are not using remote.pushdefault from your configuration
> toolchest and instead setting the 'origin' to a wrong (i.e. where
> push goes) place?


Maybe I'm misunderstanding something here and you can help me out.

All the reading I've done (mostly github) says that 'upstream' points
to the authoritative repository that you forked from but do not have
permissions to write to. 'origin' points to the place you push your
changes for pull requests (the fork).

Basically the workflow I use is:

- Use 'upstream' to PULL changes (latest code is obtained from the
authoritative repository)
- Use 'origin' to push your branches. Since I never modify the
branches that exist in 'upstream' on my 'origin' (I do everything
through separate personal branches).

That means if I have a branch off of 'master' named 'topic', I will
track 'upstream/master' and get latest with 'git pull'. When I'm ready
for a pull request, I do 'git push origin' (I use push.default =
simple).

According to my understanding, relative submodules work here. But not
everyone on my team uses this workflow. Sometimes they track
"origin/topic" (if we use my example again). Won't the submodule try
to find itself on the fork now?

Basically it seems like what you're advocating is that I need to
enforce a policy of "always track upstream" and "never track origin"
and "always set remote.pushdefault". Seems a bit error prone...
