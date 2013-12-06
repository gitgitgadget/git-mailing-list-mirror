From: Muzaffer Tolga Ozses <tolga@ozses.net>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 21:19:43 +0200
Message-ID: <CAMAQ3nLgnpDo1jWFL1rqtEvmQm8LeEpZ41Uxo0GTQOk8ttpSZA@mail.gmail.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
	<20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
	<20131206210958.59f553060e3802d56f4a53b8@domain007.com>
	<CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
	<20131206215334.1a9031a1450d9c436943ce3d@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 20:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vp0wK-0000Ru-1M
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 20:19:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753652Ab3LFTTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 14:19:47 -0500
Received: from mail-we0-f180.google.com ([74.125.82.180]:57223 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753223Ab3LFTTq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 14:19:46 -0500
Received: by mail-we0-f180.google.com with SMTP id t61so1096527wes.25
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 11:19:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=C15uEx3qCrmA3nZaalrIEKDYQWqzzM24DQutESr31lQ=;
        b=HQM9Scj5DAmwtJrJOCkmAmGBiyeWFJd7q2AjTNt3iMXjdIzEIlQTB7UYRZM/13Lvy0
         X+tlRHzozAFnHj6JnUBUFG3ncnCOGEwA0hf1SVu9g36nY7NnaA55m+brZ+QElGdYRsMr
         O0AN8cnLnNGse6AEyGFTvBpV9kAhib4pRmwEgD+UnemtcJw22YsqO4qIPF7gYZWZ9jPZ
         kbO9PjD6XM/r2/mWUTUAw39SxOyDgxWUbVksOGRxgbsgzRFCKjg7X7iN0GGH5tqxYWkB
         HyUPjq3Su5ggy7GymeZPsM7r9+MvaZpJQrewqx5/RVLPMxdk/pvXYl6k3DMcA59Q3ZvE
         1RZQ==
X-Gm-Message-State: ALoCoQkkZbYMqxrVtdKZ++zbwIMSjNgn3DNySd40tRUqDi85tZUi6qp5rvjppPoI8PC8x0/r4/UO
X-Received: by 10.180.90.65 with SMTP id bu1mr3915992wib.15.1386357583305;
 Fri, 06 Dec 2013 11:19:43 -0800 (PST)
Received: by 10.216.174.70 with HTTP; Fri, 6 Dec 2013 11:19:43 -0800 (PST)
X-Originating-IP: [46.196.57.29]
In-Reply-To: <20131206215334.1a9031a1450d9c436943ce3d@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238944>

Hi,

> What protocol/transport are you using (http, ssh, git)?
I am cloning over http

> Can you try running with:

 GIT_TRACE_PACKET=$PWD/trace.out git clone ...
GIT_TRACE_PACKET=$PWD/trace.out git clone
http://git.webciniz.im/project/night_pharmacy.git
Cloning into 'night_pharmacy'...
Checking connectivity... done

That's all I get. No trace.out was written.

> So let's do the next test: does

    echo test >&2

print "test" on the box where Git does not report progress?

Yes it does.

> Another one: does Git report progress if you explicitly pass --progress
to it?

git clone --progress http://git.webciniz.im/project/night_pharmacy.git
Cloning into 'night_pharmacy'...
Checking connectivity... done

That's all I get

> Does it work if you do

    git clone $URL 2>&1

git clone http://git.webciniz.im/project/night_pharmacy.git 2>&1
Cloning into 'night_pharmacy'...
Checking connectivity... done

That's all I get.

Regards
mto

On 6 December 2013 19:53, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Fri, 6 Dec 2013 19:44:21 +0200
> Muzaffer Tolga Ozses <tolga@ozses.net> wrote:
>
> [...]
>> >> > Resolving deltas: 100% (369/369), done.
>> >> >
>> >> > whereas I don't get those with my own. What could I be doing
>> >> > wrong?
> [...]
>> >> So it might turn out on your own server Git for some reason fails
>> >> to figure out its standard error stream is connected to a terminal.
>> >> Or, the error stream of your shell process is redirected somewhere
>> >> (and hence inherited by Git).
> [...]
>> > So you might face a misbehaving shell logon script for instance.
>> >
>> > As to whether Git senses the TTY -- what does running
>> >
>> >   stty
>> >
>> > tells you?  Does it fail with something like "inappropriate ioctl
>> > for device" or prints a couple of settings?
>> stty tells me
>> speed 38400 baud; line = 0;
>> eol = M-^?; eol2 = M-^?; swtch = M-^?;
>> ixany iutf8
>>
>> And I run identical commands on both servers, only URL changes.
>
> OK, so we could supposedly rule out the possibility Git does not sense
> it's connected to a terminal.
>
> So let's do the next test: does
>
>     echo test >&2
>
> print "test" on the box where Git does not report progress?
>
> Another one: does Git report progress if you explicitly pass --progress
> to it?
>
> Does it work if you do
>
>     git clone $URL 2>&1
>
> ?
>
> What Git and OS versions are on both machines?
