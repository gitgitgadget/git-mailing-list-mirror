From: demerphq <demerphq@gmail.com>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 10:44:05 +0100
Message-ID: <CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
	<20120201184020.GA29374@sigill.intra.peff.net>
	<CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
	<7v62fq2o03.fsf@alter.siamese.dyndns.org>
	<CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
	<7vliom13lm.fsf@alter.siamese.dyndns.org>
	<CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
	<7v7h06109t.fsf@alter.siamese.dyndns.org>
	<CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
	<20120202023857.GA11745@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 02 10:44:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RstDE-00042A-RV
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 10:44:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754943Ab2BBJoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 04:44:10 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:54556 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754297Ab2BBJoG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 04:44:06 -0500
Received: by yenm8 with SMTP id m8so960283yen.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 01:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IksvrMjJfqCcGUSXQSP6LJAaOPeA3/hTE3ienQp2zag=;
        b=IPyMtLuO9EWm8OtS7uFSEsilWjjoYedsAeYvqhuUvWaqoD33VfHXC1tuWU1q/w96MW
         irVsHwaZPi98lHoJgwbuvs3JzxhaCPq2z0dCHHWiqMUzPfGpp4sqEhKs+YBxk2/aBqf4
         +vpbUPvvrogChKMVVHg6hqMA+E8PJgyunwf0U=
Received: by 10.236.191.5 with SMTP id f5mr2502756yhn.122.1328175845511; Thu,
 02 Feb 2012 01:44:05 -0800 (PST)
Received: by 10.236.63.2 with HTTP; Thu, 2 Feb 2012 01:44:05 -0800 (PST)
In-Reply-To: <20120202023857.GA11745@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189609>

On 2 February 2012 03:38, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 02, 2012 at 02:57:14AM +0100, demerphq wrote:
>
>> > Not really.
>> >
>> > I do not think whatever "utility" value outweighs the hassle of having to
>> > think through the ramifications (including but not limited to security) of
>> > running arbitrary user command every time a value is looked up.
>>
>> Why is that your problem? If I have to enable it then isn't that my choice?
>
> From a security perspective, you want to make sure that people who
> aren't interested in your feature don't accidentally trigger it. E.g.,
> imagine I currently run a locked-down git repo but execute some commands
> on your behalf, and I allow you to set a few "known safe" config options
> like user.email. Even though I am not interested in your feature,
> respecting "!rm -rf /" in the user.email you give me would be a bad
> thing.

Like I said, I do not think this should be enabled by default, I think
it should be possible to enable it config wide. So unless this
scenario involves getting the owner of the locked down repo to enable
a config option they know nothing about, in which case I would say
there are easier attacks -- someone that stupid probably could be
talked into telling you their root password. :-)

> It's not an insurmountable problem. There could be options to turn it
> on, or turn it off, or whatever.

My thought exactly. Anyone paranoid about security would never enable
this feature. Those who are comfortable with the security issues
could.

> Or we could shrug and say that config
> is already dangerous to let other people set (which it is already, but
> only for some options).

I think that since it could be set up to be determined by the user,
that it would be no more dangerous than any other option.

> But those are the sorts of ramifications that
> need to be thought through.

I understand that. All I can say is $work uses git on a pretty large
scale, 100+ devs etc, and we use it to manage our rollout processes
which we use a lot (I cant say how often but a lot). So if it would be
useful to us it probably would be useful to others.

> (Another one is that with our current strategy, we actually read and
> parse the config files multiple times. Should your program get run many
> times?).

Again I would say this is not git's problem. If it should not be run
multiple times it is up to the user to figure out an alternative.

The general design of git seems to me to be based around providing
building blocks that people can use to build new and interesting tools
on top of, and so it seems counter to that philosophy to reject an
feature based on speculative security issues that really can't be
decided in advance but must instead be decided on a case by case
basis.

cheers,
Yves





-- 
perl -Mre=debug -e "/just|another|perl|hacker/"
