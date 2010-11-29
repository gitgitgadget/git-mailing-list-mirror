From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Mon, 29 Nov 2010 20:05:01 +0100
Message-ID: <AANLkTimec0prJ29MR3N7GtHJ1FCkk+7=1UJtqiaLZqhK@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com> <AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 29 20:05:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN92f-00053h-21
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 20:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088Ab0K2TF0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Nov 2010 14:05:26 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50092 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751992Ab0K2TFX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Nov 2010 14:05:23 -0500
Received: by iwn5 with SMTP id 5so474660iwn.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 11:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=E7+KIb142WMMwwcNRF9g7BMy6T6JOl7HDoVOIaaZAl4=;
        b=RNtRIByoCnQ1tXzhuAHgWDN7V+pte4/Z/DqnRFlevsRiTidbfmHdm5jQpdtEHGkB1q
         0NuNUYlYO+p09Ft2kRVysgA/eXyt9YBVxH5n1nFcgxjG1++aCOkmxG2tEleQ7avGQUpV
         jFXLWHjOK7zqE9xvVweMwCIzIt6WUheyib/tU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Gdx1GgURnFkaduMrcILOB3qQclFOLNQaciRwk2ANsxAKd8d0SwViN6jghOe16VBJW2
         6FrHYqC1h3srlN3kDUGXVE2ey2MFCWCdNgHC1E/9ndxKCS/cR5M1aihqDujPj9ZVZCau
         Fisy0D9rRTGZqr/wrvtuuCS9vP73iI5ljnOH0=
Received: by 10.231.20.65 with SMTP id e1mr2796166ibb.32.1291057522230; Mon,
 29 Nov 2010 11:05:22 -0800 (PST)
Received: by 10.231.17.135 with HTTP; Mon, 29 Nov 2010 11:05:01 -0800 (PST)
In-Reply-To: <AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162415>

On Mon, Nov 29, 2010 at 5:18 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Hi,
>
> On Mon, Nov 29, 2010 at 3:47 PM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>>
>> +# Debian and derivatives use x-www-browser or www-browser to set
>> +# the default browser for the system
>> +if test -z "$browser" ; then
>> + =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/www-browser"
>> + =A0 =A0 =A0 if test -n "$DISPLAY"; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wwwbrowser=3D"/usr/bin/x-www-browser $=
wwwbrowser"
>> + =A0 =A0 =A0 fi
>> + =A0 =A0 =A0 for i in $wwwbrowser; do
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if test -x $i ; then
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 verstring=3D"$($i --ve=
rsion 2> /dev/null | head -n 1)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browser=3D"$(echo "$ve=
rstring" | cut -f1 -d' ' | tr A-Z a-z)"
>
> Stupid questions:
>
> Did you check that all the browser we support accept the --version op=
tion?

I don't have all of them readily available, so I checked with
Mozilla-based browsers, Opera, Chromium, elinks, lynx, w3m. I'm
missing konqueror and dillo.

> What if we add support for a new one that doesn't ?

I think that the worse issue would be (x-)www-browser linking to
something that doesn't support --version regardless of wether we
support it or not.

> Shouldn't we add something like :
>
> test -z "$browser" && browser=3D"$(readlink $i)"

My first idea was to go for something like browser=3D"$(basename
$(readlink $i))" (not sure why you would need test -z before). Since
it would need special-casing anyway (e.g. chromium-browser ->
chromium), I opted out for the --version way so that (1) we could
catch one of our friendly cases even if the binary was called
something else and (2) some invocation paths try to get the version
anyway, so we could do it once and for all.

> And are you sure that when they support --version, the first word of
> the output is
> better than "$(readlink $i)"?

Probably depends on the metric used for 'better' ;-)

> What if we add support for a new one?

Then when adding it we should also look at its --version output and
see if it needs special treatment.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case "$browser" in
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mozilla)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browse=
r=3D"$(echo "$verstring" | cut -f2 -d' ' | tr A-Z a-z)"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 google)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 browse=
r=3D"google-chrome"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 esac
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if valid_tool "$browse=
r" ; then
>
> valid_tool "$browser" is called once here...
>
>> -else
>> +else if test -z "$browser_path"; then
>> =A0 =A0 =A0 =A0valid_tool "$browser" || die "Unknown browser '$brows=
er'."
>
> ...valid_tool "$browser" is called again here if it failed above, and
> here we die,
> so isn't it clearer to die as soon as we call it and it fails?

We allow valid_tool to be false in the x-www-browser case, in which
case we test www-browser, and if it's still not valid we go on and use
the previous paths. So we cannot die in case of an invalid
(x-)www-browser. But there's a bug in the www-brower testing, it needs
an else that resets browser to the empty string.

--=20
Giuseppe "Oblomov" Bilotta
