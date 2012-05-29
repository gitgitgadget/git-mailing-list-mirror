From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: "docs: stop using asciidoc no-inline-literal" breaks asciidoc 8.2.5
Date: Tue, 29 May 2012 14:31:38 +0200
Message-ID: <CACBZZX5iOB5PCZUCX5ksR4hpw+DTLTaP4jOnyHAJ8hZVe9xo5w@mail.gmail.com>
References: <CACBZZX7Y-NTzRP1KYy=eEHTsLHTrzxGms61anXSHVbyCSPgurw@mail.gmail.com>
 <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@elego.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Tue May 29 14:32:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZLan-0000iH-HB
	for gcvg-git-2@plane.gmane.org; Tue, 29 May 2012 14:32:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950Ab2E2McA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 May 2012 08:32:00 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:58567 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750715Ab2E2Mb7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 May 2012 08:31:59 -0400
Received: by obbtb18 with SMTP id tb18so6809778obb.19
        for <git@vger.kernel.org>; Tue, 29 May 2012 05:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=I+svPrtkqHH58pFRhhN/bAny09BbhpA106q5Q8sfDKE=;
        b=M4K1aWxMAoxwDz7jMBscykAlQvjQa1DWCqjfjzxwHKuJHFPXyrrzwQK0OE+hmAyXR8
         kJhnCoVOgxWbeXyN9L2rD56OA521MGLNKMohlG4+QiA3xZzMIFDE2dKt1l2ge+CZ9A5d
         N0UJAwIXL2gk9M+DfCiPboGczvbOytDHA1v6LqVIqRGksIKBAM4f0JzzTSzfoQwFQnPL
         gYceAP4E22LbyfXgAxOR+qS1UX7WUgtIIy7eNHP1GmPHrL51l72is4AYNysXE12KVI0n
         01Nl1vr/wDP6AfO/4/9P5hwtavZWnTIZQdLhvA95+b6mwJ4+sCLyQ5GeBErfW4pBzDdI
         /phA==
Received: by 10.60.14.169 with SMTP id q9mr11339723oec.19.1338294718939; Tue,
 29 May 2012 05:31:58 -0700 (PDT)
Received: by 10.182.167.65 with HTTP; Tue, 29 May 2012 05:31:38 -0700 (PDT)
In-Reply-To: <87ehq3mbxg.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198738>

On Tue, May 29, 2012 at 2:03 PM, Thomas Rast <trast@inf.ethz.ch> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>> Jeff King's 6cf378f0cbe7c7f944637892caeb9058c90a185a broke my Git
>> build on CentOS 5.5. The patch suggests that it only breaks
>> compatibility with asciidoc 7 but that isn't actually the case.
>
> The commit message of 6cf378f0 is not correct in that respect. =C2=A0=
My
> ancient 71c020c5 has the right numbers: asciidoc 8.4.1 is the one tha=
t
> introduced the new inline-literal behavior. =C2=A0Based on my little =
survey
> in
>
> =C2=A0http://thread.gmane.org/gmane.comp.version-control.git/191738/f=
ocus=3D191790
>
> we decided that "nobody" really uses such an old asciidoc any more.
> Evidently you are a counterexample.

Well, me and and others using current production RHEL releases:

    $ cat /etc/redhat-release && yum info asciidoc.noarch|grep Version
    CentOS release 5.5 (Final)
    Version    : 8.1.0
    $ cat /etc/redhat-release && yum info asciidoc.noarch|grep Version
    CentOS release 5.5 (Final)
    Version    : 8.2.5

I can't quite recall how I ended up with 8.2.5 on one of the boxes,
but it seems 8.1.0 may actually be the stock version.

>> I suggest just ejecting this patch and trying again, these RedHat
>> systems are still used in a lot of environments, especially by vario=
us
>> companies.
>
> Do you/they have to *build* the docs, as opposed to using the prebuil=
t
> ones coming from Junio? =C2=A0Perhaps we can make it so 'make man' re=
fuses to
> run if asciidoc is too old, and give a message to the effect that you
> should 'make quick-install-man' instead.
>
> Otherwise we'll be working around the f{asterisk}{asterisk}{asterisk}=
ing
> quoting rules for years to come.

I could personally change my build process to do something else, but
the reason I'm running "all doc" occasionally on this older toolchain
is to smoke out issues like these for other users on slightly older
toolchains as well.

I think it's too soon to break the stock toolchain on systems as
recent as RHEL 5.5 in the name of slightly nicer asciidoc syntax.

We could also keep the nice syntax and have some simple sed-based
pre-processor that converts the syntax to the older and more widely
supported version.

Or we could just decide to break RHEL 5 and systems released at a
similar time, but that isn't what the patch suggested it was doing, so
we should probably step back and ponder whether that's something we
want to do.

Personally I think having a hard dependency on a version of a software
package released more recently than 2007 (8.2.5 came out on
2007-11-18) is way too soon, it would be similar to breaking on a GCC
older than 4.2.0 which came out around the same time.
