From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH 5/6] web--browse: use (x-)www-browser if available
Date: Wed, 1 Dec 2010 12:46:57 +0100
Message-ID: <AANLkTikfAr-KUVyqeTooxYKvKWYM4pRmw51if+349dpJ@mail.gmail.com>
References: <1291042075-19983-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291042075-19983-6-git-send-email-giuseppe.bilotta@gmail.com>
 <AANLkTinGustedMv9rm+RgGMQckfxgbTPA+Yqpz7vqTfm@mail.gmail.com>
 <AANLkTimec0prJ29MR3N7GtHJ1FCkk+7=1UJtqiaLZqhK@mail.gmail.com>
 <AANLkTik9R2dRDDBUHBZ_OKPKto0wDAxr1V0uL=q4bU+4@mail.gmail.com>
 <AANLkTik-OKsUK2aJCDR0Q-FyQM=rrFQmx=Hwdyr5NzYt@mail.gmail.com> <AANLkTinzCeaiFoL4a-+c6wuJoUQ68zC9vE8AoHfmvN-F@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 01 12:47:27 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNl9g-0006PV-HE
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 12:47:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754203Ab0LALrT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Dec 2010 06:47:19 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56897 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab0LALrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Dec 2010 06:47:18 -0500
Received: by iwn2 with SMTP id 2so81006iwn.19
        for <git@vger.kernel.org>; Wed, 01 Dec 2010 03:47:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=8fJga9DW8deT1nenqVqX0Yr4ZnM2N1ihb6vd9sbVvOg=;
        b=RrMxXPfxUNfD6kpHU0uVkliYETbB4FW8bE9M64e3g2yY3l0ex+Auj2P+lC7zaD2Mjv
         HzAf2KJZMp7fYWPagwiZdcDQA/89CmskMHqZjDjC2+O/H2G2q5OWy2qXYvtKtcx61isq
         034eNcArsjGKHZyaM1UVj+NFUKOPRaWABATNE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Bsq394IiTbIiBX52GcKn8uPMv6igHK4ebNAgUg1EeFt1WqN/OnWCcmHzD9Sdbz3in/
         V30JycwtW2rB0jf11QU3jRj17AZkmWOHCc6fy5B/ql66SpkYrSnDedOfQj/KdaEA9qxb
         DRZoLenvtBNQeDZNYOSEdwplTqXEoPpUwYqo4=
Received: by 10.231.17.203 with SMTP id t11mr8833598iba.1.1291204037795; Wed,
 01 Dec 2010 03:47:17 -0800 (PST)
Received: by 10.231.153.203 with HTTP; Wed, 1 Dec 2010 03:46:57 -0800 (PST)
In-Reply-To: <AANLkTinzCeaiFoL4a-+c6wuJoUQ68zC9vE8AoHfmvN-F@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162499>

On Wed, Dec 1, 2010 at 11:59 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> On Tue, Nov 30, 2010 at 9:22 AM, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>> On Tue, Nov 30, 2010 at 5:02 AM, Christian Couder
>> <christian.couder@gmail.com> wrote:
>>> On Mon, Nov 29, 2010 at 8:05 PM, Giuseppe Bilotta
>>> <giuseppe.bilotta@gmail.com> wrote:
>>>> We allow valid_tool to be false in the x-www-browser case, in whic=
h
>>>> case we test www-browser, and if it's still not valid we go on and=
 use
>>>> the previous paths. So we cannot die in case of an invalid
>>>> (x-)www-browser.
>>>
>>> Yeah, you are right, but we could die after the "for i in $wwwbrows=
er"
>>> loop if both are invalid.
>>
>> Why? If both are invalid, proceeding with the previous strategy of
>> looking for a browser we _should_ be looking for any browser we know
>> about, even if it's not set as the default system browser.
>
> Currently we have:
>
> 97 =A0 =A0 if test -n "$browser" && ! valid_tool "$browser"; then
> 98 =A0 =A0 =A0 =A0 echo >&2 "git config option $opt set to unknown br=
owser: $browser"
> 99 =A0 =A0 =A0 =A0 echo >&2 "Resetting to default..."
> 100 =A0 =A0 =A0 =A0 unset browser
> 101 =A0 =A0 fi
>
> So if we want to be consistent with that behavior, we should probably=
 do the
> same thing if (x-)www-browser is set but we don't support it.

The (x-)www-browser code is used when the user did _not_ define a
browser. It is not a browser option (git web--browse
--tool=3Dwww-browser).
IOW, this is not about the user selecting an unsupported browser, but
about the system default browser not being a supported one.  I don't
think it should be treated the same way.

>>>> But there's a bug in the www-brower testing, it needs
>>>> an else that resets browser to the empty string.
>>>
>>> I thought it was by design that you did not reset it...
>>> So yeah it is clearer and nicer for the user if you either reset
>>> browser or just die if both (x-)www-browser are invalid. If you dec=
ide
>>> to reset browser, perhaps a warning or an information message telli=
ng
>>> that both are unknown would be nice.
>>
>> I can do that. Should it be a warning about reporting the lack of
>> support to us, or just a warning that we are not going to use it eve=
n
>> if it's defined?
>
> I think it should be a warning that we are not going to use it even
> if it's defined, to be consistent with the code pasted above.

Ok.

> If you think of something better or want to remove the warnings, plea=
se do
> it in another patch.

I think the warning is fine.

>> While we're at it: I was considering adding support for the BROWSER
>> env var (a colon-separated list of browsers executables or "browser
>> %s" strings).
>>
>> All of this is going to make the web--browse script very similar to
>> the sensible-browser script in Debian, with the difference that we g=
o
>> at length to ensure that stuff is opened in a new tab, whereas
>> Debian's sensible-browser doesn't. Should we just support
>> sensible-browser instead of (x-)www-browser/BROWSER, and let it open
>> anything?
>
> I think most users prefer to open stuff in a new tab if possible.

I will look into adding support for the BROWSER environment variable
to select the browser if no browser is defined, then, but not consider
sensible-browser.

--=20
Giuseppe "Oblomov" Bilotta
