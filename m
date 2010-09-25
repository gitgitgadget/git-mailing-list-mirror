From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v4 2/4] rev-parse: add tests for git rev-parse --flags.
Date: Sun, 26 Sep 2010 02:19:59 +1000
Message-ID: <AANLkTimW6shzyLqW-Ok_+kopjnq5t+AVxW0WRrmjkgQp@mail.gmail.com>
References: <1285421633-22684-1-git-send-email-jon.seymour@gmail.com>
	<1285421633-22684-3-git-send-email-jon.seymour@gmail.com>
	<AANLkTimj--jZdX++=ZjF3A0HE11FbkgVb2gs3ADVEGvx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, robbat2@gentoo.org, casey@nrlssc.navy.mil
To: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 18:20:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzXTr-0002R9-IA
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 18:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754997Ab0IYQUA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Sep 2010 12:20:00 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:49438 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab0IYQUA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Sep 2010 12:20:00 -0400
Received: by qwh6 with SMTP id 6so2445930qwh.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 09:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=b6kr4kOPTvvrcGjv4eFHuQRGiFpGGnNXhX0Jq2SV6LI=;
        b=YKfARbGNWXXFEv0eoUhL9jnoxAS2T2qs8tBtLzJOV8AM0chUHwQwMGGlHGXoOL78qp
         PQWxDYiJ98xAESEyEET9g8xyBC1InmOiu0zwJI8S7ZkOltQJ34AyVF2JY21u95vwS2rP
         QNprnOZnp/Zr65FS4o1DYen0Pr23nNZUKpCdU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=izN9PWpzsDFAifoTic5p5hkyqB8/B69K86apLnfePh5ARZJP1RHU6aWKPhktD62zp7
         srezYP2jhcrW74eseqxh10rGi4DO1DHzOH9jWT3fO9vdVVQD7DdhwaSjU5/CAwgqkHh9
         RA+hVUZwvFdsv3m2u+7qB6v50ZH0AyyaE/dMg=
Received: by 10.229.71.69 with SMTP id g5mr3738582qcj.176.1285431599378; Sat,
 25 Sep 2010 09:19:59 -0700 (PDT)
Received: by 10.229.219.196 with HTTP; Sat, 25 Sep 2010 09:19:59 -0700 (PDT)
In-Reply-To: <AANLkTimj--jZdX++=ZjF3A0HE11FbkgVb2gs3ADVEGvx@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157164>

On Sun, Sep 26, 2010 at 12:27 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n
<avarab@gmail.com> wrote:
> On Sat, Sep 25, 2010 at 13:33, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
>
>> + =C2=A0 =C2=A0 =C2=A0 : >expected &&
>
> We've been dropping the ":>foo" style in favor of ">foo" in other
> tests. There's no need for the ":".
>
>> + =C2=A0 =C2=A0 =C2=A0 echo -X > expected &&
>> + =C2=A0 =C2=A0 =C2=A0 echo -q > expected &&
>> + =C2=A0 =C2=A0 =C2=A0 echo -X > expected &&
>> + =C2=A0 =C2=A0 =C2=A0 echo --no-flags > expected &&
>
> Maybe some echo implementations don't like flag-like params, and we n=
eed:
>
> =C2=A0 =C2=A0printf "%s\n" "-X"
>
> here. I don't know whether that's the case.
>

Thanks for the review.

My latest revision incorporates this feedback, although I didn't use
extra quotes around -X. (e.g. I wrote printf "%s\n" -X)

jon.
