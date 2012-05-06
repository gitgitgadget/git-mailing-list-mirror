From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH 4/4] allow recovery from command name typos
Date: Mon, 7 May 2012 00:04:54 +0800
Message-ID: <CALUzUxqzi7aJ30q16+dwSnu_ULoC2zM-EDp1+BHTu2cPU9ihnQ@mail.gmail.com>
References: <1336287330-7215-1-git-send-email-rctay89@gmail.com>
	<1336287330-7215-2-git-send-email-rctay89@gmail.com>
	<1336287330-7215-3-git-send-email-rctay89@gmail.com>
	<1336287330-7215-4-git-send-email-rctay89@gmail.com>
	<1336287330-7215-5-git-send-email-rctay89@gmail.com>
	<CAOBOgRaDEgAqXWmdC6hrudkL5OwzeMffbj2RtKMxf2TsYWzotA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Angus Hammond <angusgh@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 18:05:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SR3xF-0002fF-Ug
	for gcvg-git-2@plane.gmane.org; Sun, 06 May 2012 18:05:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753941Ab2EFQE4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 May 2012 12:04:56 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:62430 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab2EFQEz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2012 12:04:55 -0400
Received: by werb10 with SMTP id b10so815547wer.19
        for <git@vger.kernel.org>; Sun, 06 May 2012 09:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=B0fqPlb3wQaBd6zSStSBJjTaAwzK3xIw/5smNvEKDK4=;
        b=IhIP+UYfKATPaIJmmd08ykKrDB88bRRfHHxRDoixXA+qtfy1fn5ktdDS83yW7I9p5e
         j611eDpkW4Gfe7JXuIRnKKXIWyfmLkFIhOgnOHzSPavzAvbh75nsRGCXjyrQVYDZK/AA
         MoFtG6oXlNlq7cvIy8Oljop2FTim4A4nBlnMu0Y/h0DpRB4GVIzS0VTUxE0DlDyPeXOb
         VUTi3RT6bMiYX0IAI2Arx7keEZlT1PA+Kd/WA4bYgqyOq/qmQQYaqE1JMYEFTzQOmOxv
         iuvk0IgF4XTrh+qpXyLM5hNc5Hie90k/nzFf2kWer+k/JdMNMyd9kNov+YusB9GlzzzG
         h5jA==
Received: by 10.216.142.38 with SMTP id h38mr1015544wej.54.1336320294701; Sun,
 06 May 2012 09:04:54 -0700 (PDT)
Received: by 10.223.156.136 with HTTP; Sun, 6 May 2012 09:04:54 -0700 (PDT)
In-Reply-To: <CAOBOgRaDEgAqXWmdC6hrudkL5OwzeMffbj2RtKMxf2TsYWzotA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197200>

On Sun, May 6, 2012 at 4:40 PM, Angus Hammond <angusgh@gmail.com> wrote=
:
> On 6 May 2012 07:55, Tay Ray Chuan <rctay89@gmail.com> wrote:
>>
>> In the case where there is a single suggestion, present the prompt
>> "[Y/n]", such that "", "y" and "Y" as input leads git to proceed
>> executing the suggestion, while everything else (possibly "n") leads=
 git
>> to terminate.
>>
>
> Minor point, as well as ensuring this is configurable=A0behavior, if
> terminating is the default, then the prompt should be "[y/N]", so tha=
t the
> default action is clearly marked. Not=A0capitalising=A0at all would b=
e
> reasonable, but making the 'Y' uppercase is actively confusing.

I believe you were referring to the 1/2/.../n case, since for the y/n
case, terminating is not the default.

If so, then yes, the "n" there should be in caps, since terminating is
the default; my bad.

> Secondly, if we're at a tty, I suspect this behavior would be totally
> unnecessary. Making close suggestions rather than just a complete lis=
t is
> neat, but if people want to use one of them all they have to do is co=
py
> paste the old command down and modify it, which I suspect would be mu=
ch
> faster than actually considering and responding to a prompt.

I believe that there would be very few options to choose from - in
fact, I was trying very hard to get the number of suggestions to equal
or exceed 5. I guess one would have better luck than I if they studied
the Levenshtein distance algorithm, which I didn't.

In other words - the time to consider is small.

In fact I was hoping this would be faster than copy-paste - typing the
option (1 key) and enter (1 key) makes a total of 2 keys only.

--=20
Cheers,
Ray Chuan
