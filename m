From: Matthew Persico <matthew.persico@gmail.com>
Subject: Re: GIT_CONFIG - what's the point?
Date: Sun, 3 Apr 2016 16:11:55 -0400
Message-ID: <CAL20dLAK953vmqO2E1Aw-4aDOCthJYu+xP=0GUX2DTmajLxi8A@mail.gmail.com>
References: <CAL20dLDkmjpXdmHv0MdoUEe43s9TjqrOLS2ud8HHGCF2vahWNQ@mail.gmail.com>
 <1459531705-31906-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Sun Apr 03 22:12:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amoNg-0004W2-JZ
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 22:12:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751986AbcDCUMR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2016 16:12:17 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33027 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcDCUMQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Apr 2016 16:12:16 -0400
Received: by mail-vk0-f51.google.com with SMTP id k1so157600274vkb.0
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 13:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=8bMKzkX5uBgQtvV/cCPDpvSj6jmRybmbOPLEZrhclic=;
        b=bUnNVcjWe4T5EtXF9uyjEdqsqd27lUPWhlKmwApO1JVa0VPdOKs31JmpQmb8tu5W0O
         MFiJXYbLRJ4qguS4H5KBqDMqryBEkoA27k4T1h1QZGBHvB70DabxPlm+bw7iQ5ePhdwn
         HsQzwaESaVMWN58obZF4f9PvFmuwhcC1TxHCB06mwE/rifJilOUjvtHfVniUUbHEgDRG
         /ril0T9WMvPo4OS1792P+wT0gk8QkTsTXiQcwpslZ7+lUvu58XQS2uUGcBHchy/vWQdJ
         p/NJhL+ZmeA0elSWXRbxNW7NmA6gxad9V/fAylAGBi4xKcJHooffTuo+XCl5bUNA3d9m
         grNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=8bMKzkX5uBgQtvV/cCPDpvSj6jmRybmbOPLEZrhclic=;
        b=QY9Id4C3RDs4lPj+smsL5ZCWa8oQCDAovWoTRedJpjvwTQIDtkA9CIcb9Zf0unoykh
         VwOcW+vKVyoGxelf18lUt+kUfACJy23quHUfYnabi6fun/N18sIU78yo1SEN9J1SZ61/
         nEqXaMxUNJhjIA5p75FOCyb/sxdIK5tdPE2uJuHkfTk6EHM7a8daGMbbXPSwPBd3aQjh
         1eKuGhrGf3WRR/+224gbUMOyx4o/m7KgI6XSFim5BJuBqP5B/O+CcTUZZRyBliIOevv1
         DR7MWatNUvn/W1MXreoFDX3iYgVS0SdOg/fRVJjvWevASq5H7R8u1a+4mXVawV7PFMtb
         9axw==
X-Gm-Message-State: AD7BkJIDHbvCn/qQqWCdGwyQTk5a1fZ31K3NGGHu+zO4lEkCeMfRDRYltyZab9DjMewF69TmF4cqV/NpxgW+zw==
X-Received: by 10.176.2.85 with SMTP id 79mr7106467uas.32.1459714335263; Sun,
 03 Apr 2016 13:12:15 -0700 (PDT)
Received: by 10.159.54.228 with HTTP; Sun, 3 Apr 2016 13:11:55 -0700 (PDT)
In-Reply-To: <1459531705-31906-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290652>

On Fri, Apr 1, 2016 at 1:28 PM, SZEDER G=C3=A1bor <szeder@ira.uka.de> w=
rote:
>> Let me explain my scenario. I have an nfs mounted home directory. It
>> is used across multiple machines. I use different colored xterms for
>> each machine. But that means that the one set of colors in my one
>> .gitconfig file don't work against all my screen backgrounds. I'm
>> trying to find a way to tune the git colors per login. The ability t=
o
>> set colors in an environment variable (like most UNIX utils support)
>> would be the easiest way to do this. Failing that, I was hoping that
>> by setting GIT_CONFIG per login, I could tune the color schemes with
>> different config files.
>>
>> Since that is not how GIT_CONFIG is used, I have simply decided to
>> squint where necessary, or open up a neutral colored xterm for the
>> diff, regardless of machine.
>>
>> Yes, I could probably do diffs in many other ways, but git diff at t=
he
>> command line is usually the most expedient.
>>
>> Unless I wanted to define a GIT_CONFIG_OVER environment variable upo=
n
>> login, place inside it the appropriate -c<name>=3D<value> overrides =
for
>> colors, and then define a bash function git as
>>
>> git () {
>>    $(which git) $GIT_CONFIG_OVER "$@"
>>    return $?
>> }
>>
>> which seems silly.
>
> Yeah, that 'return $?' at the end of the function does indeed seem
> silly :)  (sorry, couldn't resist...)
Part OCD, part OAC. :-)

>
> You could use machine-specific config includes instead of that
> GIT_CONFIG_OVER environment variable.  I.e. store machine-specific
> color configuration in ~/.gitcolors.<machine> or something and define
> the shell function as:
>
> git () {
>         command git -c include.path=3D~/.gitcolors.$HOSTNAME "$@"
> }
BINGO! THAT was the redirection I needed! One thing I was trying to
figure out early one was how to put HOSTNAME-based include.path-s in
the .gitconfig. So I put them OUTSIDE the .gitconfig like this.

Much obliged. Next time you are in NYC - I owe you a beer!

>
> The impact on your .bashrc would be much smaller than with the
> GIT_CONFIG_OVER approach.
> You could even turn this into an alias, if you want.
>
>



--=20
Matthew O. Persico
