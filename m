From: Muzaffer Tolga Ozses <tolga@ozses.net>
Subject: Re: Git reports
Date: Fri, 6 Dec 2013 19:44:21 +0200
Message-ID: <CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
	<20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
	<20131206210958.59f553060e3802d56f4a53b8@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 06 18:44:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VozRz-0001NR-85
	for gcvg-git-2@plane.gmane.org; Fri, 06 Dec 2013 18:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756767Ab3LFRoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Dec 2013 12:44:23 -0500
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35432 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753456Ab3LFRoW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Dec 2013 12:44:22 -0500
Received: by mail-wi0-f173.google.com with SMTP id hn9so1225363wib.6
        for <git@vger.kernel.org>; Fri, 06 Dec 2013 09:44:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=EGcG+vF7+Ezuft2unC0xBJgP7sFhbtuRF68lZAO3pr8=;
        b=auDIkF5ztG5957w0Wj7dEHzeTrK1N0sjXc2yoDY57bWWB+gE6Z9qZBEG1Ps0qcO0Mv
         JbCyg/syjF5Per0bFCvIX8njhVj8MzO82ZVKzJlkpF8OBpsQ3WrHt/FrGgQGtvO/kQx9
         hwDGx8FCq3uzBG8wejQhn6iqzTafyuvgIg+CXDBKOQ8DgGNuD2hCALFFK9KHQIVQT3d/
         MaVQU32ShXCIX5Ek+uXDFDJ3La8JwyKa9IbFaKT9KI4miGOADhRoG7s9IG0fyWH2YXMf
         +qVjgja+Tz1noiUKSbj8fKWRkDBQIDmGhNoMKXhn5BBY/33xTMOU30GFPbE0+jv/Hx5i
         ko/g==
X-Gm-Message-State: ALoCoQmzKdyrknQ0AWXGd9wUZGuI/foPq/ZvO6Jni/gBNXIE2dV/gVPeKgUBN49QATg6wefnPdXO
X-Received: by 10.181.12.20 with SMTP id em20mr3667087wid.0.1386351861878;
 Fri, 06 Dec 2013 09:44:21 -0800 (PST)
Received: by 10.216.174.70 with HTTP; Fri, 6 Dec 2013 09:44:21 -0800 (PST)
X-Originating-IP: [46.196.57.29]
In-Reply-To: <20131206210958.59f553060e3802d56f4a53b8@domain007.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238938>

stty tells me
speed 38400 baud; line = 0;
eol = M-^?; eol2 = M-^?; swtch = M-^?;
ixany iutf8

And I run identical commands on both servers, only URL changes.

On 6 December 2013 19:09, Konstantin Khomoutov
<flatworm@users.sourceforge.net> wrote:
> On Fri, 6 Dec 2013 21:00:35 +0400
> Konstantin Khomoutov <flatworm@users.sourceforge.net> wrote:
>
> [...]
>> > Resolving deltas: 100% (369/369), done.
>> >
>> > whereas I don't get those with my own. What could I be doing wrong?
>>
>> The documentation on `git push` states:
>>
>>   --progress
>>
>>     Progress status is reported on the standard error stream by
>> default when it is attached to a terminal, unless -q is specified.
>> This flag forces progress status even if the standard error stream is
>> not directed to a terminal.
>>
>> So it might turn out on your own server Git for some reason fails to
>> figure out its standard error stream is connected to a terminal.
>> Or, the error stream of your shell process is redirected somewhere
>> (and hence inherited by Git).
>
> To underline the fact this is not all too unlikely, you're able to
> completely silence error reports in your shell prompt by executing
>
>   exec 2>/dev/null
>
> (you can regain it back by doing `exec 2>&1`).
>
> So you might face a misbehaving shell logon script for instance.
>
> As to whether Git senses the TTY -- what does running
>
>   stty
>
> tells you?  Does it fail with something like "inappropriate ioctl for
> device" or prints a couple of settings?
