From: Christian Couder <christian.couder@gmail.com>
Subject: Re: Option for git bisect run to automatically clean up
Date: Sat, 29 Sep 2012 18:51:27 +0200
Message-ID: <CAP8UFD21eCSzjJ3a0SxPTzzi2z4KMFr=1xE3j8fPz38AJrrJTQ@mail.gmail.com>
References: <CAOMwXhN=SpwGPaSr1p8K_y4yinuWA0hhynwpqi=5+xT-ZMVbYQ@mail.gmail.com>
	<CAOMwXhOv7oGXhtWu0apmDD7x+Vnh0jkc2QrnSPmc-=KCQQ08Yg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>
To: Laszlo Papp <lpapp@kde.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 18:52:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TI0Gz-0006Oi-5l
	for gcvg-git-2@plane.gmane.org; Sat, 29 Sep 2012 18:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756551Ab2I2QwC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2012 12:52:02 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:38181 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755816Ab2I2QwA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2012 12:52:00 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so1888989wib.1
        for <git@vger.kernel.org>; Sat, 29 Sep 2012 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Qw+enetvNF3BYA5cdmDTLYMQSG1ublrp3wbxLAfsuH4=;
        b=n8aBPV0Aq6A0gRRCvnt+ZVokwA5ByUP1mApz6DwkCBSShqZ6QuzQqv13Q0URe2oE1g
         rYXm0tkWPhD7kHQmSmSkBBuyI88KmPbZUOZ/dOv8RT2eZaqfhNUSm1PmYHozB+RmO47X
         avzJjyZUvbpAv3nnhwMNohabMYGusYvDhBPXO51RpcBlZVvYSnww+do8/c8xCNa3hQYp
         iWkLiP6G/MFmKP1oibb3E2Tn2zM4KyoT/ABtQAy7qWCbIU8QlyJJ0Bfl/n0k0OGOtKXv
         cpufG89rnuOUI1do7bKNq3FJtxWSFNtSzk0f0xnjmmHXnLADk3uCgfiEg+Qf9z/hVn6M
         qCrg==
Received: by 10.180.103.4 with SMTP id fs4mr4422630wib.16.1348937487183; Sat,
 29 Sep 2012 09:51:27 -0700 (PDT)
Received: by 10.223.200.201 with HTTP; Sat, 29 Sep 2012 09:51:27 -0700 (PDT)
In-Reply-To: <CAOMwXhOv7oGXhtWu0apmDD7x+Vnh0jkc2QrnSPmc-=KCQQ08Yg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206655>

Hi,

On Thu, Sep 27, 2012 at 6:55 PM, Laszlo Papp <lpapp@kde.org> wrote:
> Hi everybody,
>
> I have just run into a problem when I had to issue an explicit cleanup for
> tracked files after a configure run in the Qt5 project. I have tried to
> suggest to the people to bring up this idea on the mailing list in order to
> get this further on. Unfortunately I did not have time to do so, especially
> for the follow-up. I have also been told it is not a good way of asking on
> IRC which surprised me a bit, but I am now bringing this up, and I try to
> also make the follow-up. Hope it is ok.

At first I thought that your idea was to have an option to "git bisect
run" so that a "git bisect reset" is run automatically after the
bisection is finished.
But I search the IRC log and found the discussion here:

http://colabti.org/irclogger/irclogger_log/git?date=2012-09-27

and I found that you said:

"there should be an option for git bisect run which executed the
"whatever clean command git has like git clean -fdx"./"

I understand that, but I wonder what we should do if some people need
a "git reset --hard" and if some other people need other options than
-dfx.
We would need both a --reset and a --clean, or perhaps even a
--reset[=(hard|mixed|soft|merge|keep) and a --clean[=<clean-opts>].
And then what if people want to clean only a subdirectory and not everything?
And this does not take into account the fact that many people
will/should clean using "make clean" or "make distclean" or "rake
clean" or something like that, so that a --clean option will not help
them.

Best,
Christian.
