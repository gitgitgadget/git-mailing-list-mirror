From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Tue, 30 Nov 2010 09:22:20 +0100
Message-ID: <AANLkTik-OKsUK2aJCDR0Q-FyQM=rrFQmx=Hwdyr5NzYt@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
 <AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
 <AANLkTimec0prJ29MR3N7GtHJ1FCkk+7=1UJtqiaLZqhK@mail.gmail.com> <AANLkTik9R2dRDDBUHBZ_OKPKto0wDAxr1V0uL=q4bU+4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 09:22:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNLU7-0001A5-QD
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 09:22:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754493Ab0K3IWm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 30 Nov 2010 03:22:42 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37883 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754455Ab0K3IWl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 30 Nov 2010 03:22:41 -0500
Received: by iwn5 with SMTP id 5so1197348iwn.19
        for <git@vger.kernel.org>; Tue, 30 Nov 2010 00:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WFuGXfHN0ywcCCGO2FwaBE+fm2Q5BARZzkBGhkfAaBk=;
        b=lWcP57ofO8SpkIE2/PgAVT0ug+X+c4/DHuImC5xNMXY1jcv0105ex2f36yJQ4sC0uK
         AAx9HsfM0PNcWYvEKaRmuvEKuxpFht46Yi6YzAKIKJRx3b6gIFkFbfCeE1MwkCeUZ4Vd
         wz6wG1GWWglgX7DH5y9G96aC0k9tGoQQEWDc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Godap2k3OXV1cirWFim2EtRH96Cuun4kKx49nbdEQrq6WFchbu09Q+Fej92T17eL9Z
         aRr29PvoVhLePGk3VqRXF4zWs/95tlfrOUwwqv2Jh3258PqKAQl+KOjMNaJ834t/0zsU
         YT11Kh/PhMPiAg2z5J0gAdC7wX24VhYdNjRxk=
Received: by 10.231.144.21 with SMTP id x21mr989511ibu.126.1291105360869; Tue,
 30 Nov 2010 00:22:40 -0800 (PST)
Received: by 10.231.153.203 with HTTP; Tue, 30 Nov 2010 00:22:20 -0800 (PST)
In-Reply-To: <AANLkTik9R2dRDDBUHBZ_OKPKto0wDAxr1V0uL=q4bU+4@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162480>

On Tue, Nov 30, 2010 at 5:02 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Mon, Nov 29, 2010 at 8:05 PM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> On Mon, Nov 29, 2010 at 5:18 PM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> Hi,
>>>
>>> On Mon, Nov 29, 2010 at 3:47 PM, Giuseppe Bilotta
>>> <giuseppe.bilotta@gmail.com> wrote:
>>>>
>>>> +# Debian and derivatives use x-www-browser or www-browser to set
>>>> +# the default browser for the system
>>>> +if test -z "$browser" ; then
>>>> + =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/www-browser"
>>>> + =A0 =A0 =A0 if test -n "$DISPLAY"; then
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/x-www-browser=
 $wwwbrowser"
>>>> + =A0 =A0 =A0 fi
>>>> + =A0 =A0 =A0 for i in $wwwbrowser; do
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -x $i ; then
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$($i --=
version 2> /dev/null | head -n 1)"
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$(echo "$=
verstring" | cut -f1 -d' ' | tr A-Z a-z)"
>>>
>>> Stupid questions:
>>>
>>> Did you check that all the browser we support accept the --version =
option?
>>
>> I don't have all of them readily available, so I checked with
>> Mozilla-based browsers, Opera, Chromium, elinks, lynx, w3m. I'm
>> missing konqueror and dillo.
>>
>>> What if we add support for a new one that doesn't ?
>>
>> I think that the worse issue would be (x-)www-browser linking to
>> something that doesn't support --version regardless of wether we
>> support it or not.
>>
>>> Shouldn't we add something like :
>>>
>>> test -z "$browser" && browser=3D"$(readlink $i)"
>>
>> My first idea was to go for something like browser=3D"$(basename
>> $(readlink $i))" (not sure why you would need test -z before).
>
> We would need "test -z" before if we add it after:
>
> browser=3D"$(echo "$verstring" | cut -f1 -d' ' | tr A-Z a-z)"
>
> so that we have a fallback if it doesn't support "--version".

Oh, I see what you mean here. I thought you wanted to use it as an
alternative to the --version.

>> We allow valid_tool to be false in the x-www-browser case, in which
>> case we test www-browser, and if it's still not valid we go on and u=
se
>> the previous paths. So we cannot die in case of an invalid
>> (x-)www-browser.
>
> Yeah, you are right, but we could die after the "for i in $wwwbrowser=
"
> loop if both are invalid.

Why? If both are invalid, proceeding with the previous strategy of
looking for a browser we _should_ be looking for any browser we know
about, even if it's not set as the default system browser.

>> But there's a bug in the www-brower testing, it needs
>> an else that resets browser to the empty string.
>
> I thought it was by design that you did not reset it...
> So yeah it is clearer and nicer for the user if you either reset
> browser or just die if both (x-)www-browser are invalid. If you decid=
e
> to reset browser, perhaps a warning or an information message telling
> that both are unknown would be nice.

I can do that. Should it be a warning about reporting the lack of
support to us, or just a warning that we are not going to use it even
if it's defined?

While we're at it: I was considering adding support for the BROWSER
env var (a colon-separated list of browsers executables or "browser
%s" strings).

All of this is going to make the web--browse script very similar to
the sensible-browser script in Debian, with the difference that we go
at length to ensure that stuff is opened in a new tab, whereas
Debian's sensible-browser doesn't. Should we just support
sensible-browser instead of (x-)www-browser/BROWSER, and let it open
anything?


--=20
Giuseppe "Oblomov" Bilotta
