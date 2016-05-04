From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed, 4 May 2016 21:07:23 +0200
Message-ID: <CAP8UFD2qoCPkbDid+k6Lydh7JTM5VhQzxTSuJuRa40sw54_aZw@mail.gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
	<1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
	<1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
	<CAPig+cQxpZXKqykFoa2kzCZSC2YqpPXnGocs2YttcJ+rCxmzgQ@mail.gmail.com>
	<CAP8UFD1+kEwFhAoveOTYt8NEOK=98W-00nNF+Yoe6kQAYJa6SQ@mail.gmail.com>
	<alpine.DEB.2.20.1605041304050.9313@virtualbox>
	<CAP8UFD2k=JMYUg1SPE1TP6uD1bUnheYs8YhFDrzgEny85ocQFw@mail.gmail.com>
	<alpine.DEB.2.20.1605041416030.9313@virtualbox>
	<CAP8UFD0QeZqLaPwFe5wo0n1fdtSppJmYdUDc+Yo1duH1uyWbpw@mail.gmail.com>
	<alpine.DEB.2.20.1605041654300.9313@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 21:07:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay28w-0006oh-3t
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752560AbcEDTH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:07:26 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36354 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbcEDTHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:07:25 -0400
Received: by mail-wm0-f49.google.com with SMTP id n129so201461406wmn.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 12:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=A4ixhGnVc9EycrB3ZF3pezZH24BlPkcU3Qg26I+t0qs=;
        b=tmysGcfbUXJiSp7wVUBg84HdBfVFIYSbEbqxsbWbZePwvdysYXAJUx92t/Sx2Lo7kY
         C/YkOngBHu8xT3wzZufky8akcl4xbgAVOMqoVGPYHoxZZdbxG1GQ2NinZFYnF+MWC5rj
         wEfYqtKI9Bn5A4q2Q8rnzllTv95qSUmB+IXUYaf9eus89Gk6Hazdcpd49wqetPHcAnga
         dqC0OpyB7/jqb/Rxa94MvYh3OqfxszwtNT4NZaxFh5pwoHt8kuWAK7WkAtay3UXQkiq9
         6/tV7JC+E0wjf3EEVbwYuN+467FWCDwqb/ShB4Z1/tARgfRKDbGeGn8mq6Yyh3FjCPFA
         3HBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=A4ixhGnVc9EycrB3ZF3pezZH24BlPkcU3Qg26I+t0qs=;
        b=YNiNurENRIoPW2Q07qqF3k07ze3vvasMO2R5cRLbnvQi8UaaPbZ0OH2PWWYNeFZB+W
         vpZgy+0Z681DKTRTmdVK+9atFNLv5WdbH0+p9f6YogXnfBYxQK3XYzGBZpcrVzH4uXlw
         NJWZhuDCQslXX15g0Fx3Uobfj9Gn+Z1gADsqSoifMZMh/EB66n0+DqFaplSObpKqdUV8
         eC4lRDaE6V60Gid58x3ufeTAl+ahPDDDuCMXZTQj6FFxBkGxHJn5+kYHqd+o/Xsw/C6l
         dfI8cfj0HON5gqouEJaqphKplqHb0IIJApn4XpSCsMngqBAZFkWm834y5Q01E7FSUctc
         OkkA==
X-Gm-Message-State: AOPr4FUWvm3M4u9iF7ZGTSy2Wt+sc16CL87qChxg+5FX/WokK90lHYtoOI3Sf/SYXGQI5Hb7D76AReo03Vthfw==
X-Received: by 10.28.151.133 with SMTP id z127mr10336965wmd.79.1462388843726;
 Wed, 04 May 2016 12:07:23 -0700 (PDT)
Received: by 10.194.246.4 with HTTP; Wed, 4 May 2016 12:07:23 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605041654300.9313@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293569>

Hi Dscho,

On Wed, May 4, 2016 at 4:56 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Christian,
>
> On Wed, 4 May 2016, Christian Couder wrote:
>
>> My intent was to try to show that there is some important value to make
>> the subject close to the "low level" thing the patch actually does.
>
> I disagree. The place to describe low-level details that are not
> immediately obvious from the patch is the commit message. Way, way down on
> the bottom.
>
> The commit message should start with a subject that gives me a good clue
> why this is a good change. A low-level detail won't do that very often.

Let me give you another example.

You want to do X and you discover that you need to tweek knob foo to
do X, and also that tweeking knob foo is a good thing to do in general
(for example it could be a refactoring that save some lines of code).
So you create a patch that tweeks knob foo and call it "prepare to do
X", and then send it so that it can be merged. Then you want to do X
but you are interupted by an event, for example you boss tells you to
do Y instead of X right away because of an urgent business need. So
you do Y instead of X. And then sometimes later (it could be weeks,
months or years later), when you are finished with Y, you now want to
go back to your previous work on X. At that time you discover that you
need to tweek knob bar (it could be another refactoring of another
part of the code), but you forgot about your previous patch that
tweeked knob foo, so you call your new patch that tweeks knob bar
"prepare to do X". As your previous patch that was also called
"prepare to do X" has already been integrated, you now have too
patches that do different things that are called the same, and you can
easily mistake the first one for the second one.

If you had just called your first patch "tweek knob foo" and the
second patch "tweek knob bar", it would be much clearer which patch
does what.
