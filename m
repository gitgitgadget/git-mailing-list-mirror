From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Tue, 30 Nov 2010 05:02:28 +0100
Message-ID: <AANLkTik9R2dRDDBUHBZ_OKPKto0wDAxr1V0uL=q4bU+4@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
	<AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
	<AANLkTimec0prJ29MR3N7GtHJ1FCkk+7=1UJtqiaLZqhK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 30 05:02:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNHQP-0007yl-BI
	for gcvg-git-2@lo.gmane.org; Tue, 30 Nov 2010 05:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278Ab0K3ECc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 23:02:32 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:51379 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751024Ab0K3ECb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 23:02:31 -0500
Received: by wyb28 with SMTP id 28so5224512wyb.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 20:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=j/kON4FHKUYuXdJbWssBgODGGij5uln3cNuOgDhzzWA=;
        b=qQWRV8bZa4d57jJe92dTyNpFI+9ph0rHqo8oYp0/qowSQKBjp3cwF+xpsYlo9CzFfE
         BQojV0sj0IlcRVXJUgRJQUvfkUvfVZSvpdqYRSZ7uEMHBT0nyfBGPP7WK+L4Vycz98cZ
         BjqeIXY1FJz57UlVhEQCzyaSWsNgNvIE32ZDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=JKiONuf0oZaKv4/Ca2kCOvFHMByO+rHhM3sV9+7aFntRJfxltgXgVco9pRLcPR+4o8
         h4fGe9Hb1OuTTsx+GkLlS6KfYfWJxVYhGexl2yz2BXg185bT690Dpsztu5x+K1G0yujN
         z+nQm35aB9beY+b+4zEuY8ZK3Qo28D2stQiq8=
Received: by 10.216.242.78 with SMTP id h56mr5900285wer.47.1291089748734; Mon,
 29 Nov 2010 20:02:28 -0800 (PST)
Received: by 10.216.85.213 with HTTP; Mon, 29 Nov 2010 20:02:28 -0800 (PST)
In-Reply-To: <AANLkTimec0prJ29MR3N7GtHJ1FCkk+7=1UJtqiaLZqhK@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162470>

On Mon, Nov 29, 2010 at 8:05 PM, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:
> On Mon, Nov 29, 2010 at 5:18 PM, Christian Couder
> <christian.couder@gmail.com> wrote:
>> Hi,
>>
>> On Mon, Nov 29, 2010 at 3:47 PM, Giuseppe Bilotta
>> <giuseppe.bilotta@gmail.com> wrote:
>>>
>>> +# Debian and derivatives use x-www-browser or www-browser to set
>>> +# the default browser for the system
>>> +if test -z "$browser" ; then
>>> + =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/www-browser"
>>> + =A0 =A0 =A0 if test -n "$DISPLAY"; then
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/x-www-browser =
$wwwbrowser"
>>> + =A0 =A0 =A0 fi
>>> + =A0 =A0 =A0 for i in $wwwbrowser; do
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -x $i ; then
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$($i --v=
ersion 2> /dev/null | head -n 1)"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$(echo "$v=
erstring" | cut -f1 -d' ' | tr A-Z a-z)"
>>
>> Stupid questions:
>>
>> Did you check that all the browser we support accept the --version o=
ption?
>
> I don't have all of them readily available, so I checked with
> Mozilla-based browsers, Opera, Chromium, elinks, lynx, w3m. I'm
> missing konqueror and dillo.
>
>> What if we add support for a new one that doesn't ?
>
> I think that the worse issue would be (x-)www-browser linking to
> something that doesn't support --version regardless of wether we
> support it or not.
>
>> Shouldn't we add something like :
>>
>> test -z "$browser" && browser=3D"$(readlink $i)"
>
> My first idea was to go for something like browser=3D"$(basename
> $(readlink $i))" (not sure why you would need test -z before).

We would need "test -z" before if we add it after:

browser=3D"$(echo "$verstring" | cut -f1 -d' ' | tr A-Z a-z)"

so that we have a fallback if it doesn't support "--version".

> Since
> it would need special-casing anyway (e.g. chromium-browser ->
> chromium), I opted out for the --version way so that (1) we could
> catch one of our friendly cases even if the binary was called
> something else and (2) some invocation paths try to get the version
> anyway, so we could do it once and for all.
>
>> And are you sure that when they support --version, the first word of
>> the output is
>> better than "$(readlink $i)"?
>
> Probably depends on the metric used for 'better' ;-)
>
>> What if we add support for a new one?
>
> Then when adding it we should also look at its --version output and
> see if it needs special treatment.
>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$browser" in
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mozilla)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brows=
er=3D"$(echo "$verstring" | cut -f2 -d' ' | tr A-Z a-z)"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 google)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 brows=
er=3D"google-chrome"
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if valid_tool "$brows=
er" ; then
>>
>> valid_tool "$browser" is called once here...
>>
>>> -else
>>> +else if test -z "$browser_path"; then
>>> =A0 =A0 =A0 =A0valid_tool "$browser" || die "Unknown browser '$brow=
ser'."
>>
>> ...valid_tool "$browser" is called again here if it failed above, an=
d
>> here we die,
>> so isn't it clearer to die as soon as we call it and it fails?
>
> We allow valid_tool to be false in the x-www-browser case, in which
> case we test www-browser, and if it's still not valid we go on and us=
e
> the previous paths. So we cannot die in case of an invalid
> (x-)www-browser.

Yeah, you are right, but we could die after the "for i in $wwwbrowser"
loop if both are invalid.

> But there's a bug in the www-brower testing, it needs
> an else that resets browser to the empty string.

I thought it was by design that you did not reset it...
So yeah it is clearer and nicer for the user if you either reset
browser or just die if both (x-)www-browser are invalid. If you decide
to reset browser, perhaps a warning or an information message telling
that both are unknown would be nice.

Thanks,
Christian.
