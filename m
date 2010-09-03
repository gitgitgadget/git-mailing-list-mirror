From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/3] gettext: add NO_GETTEXT_POISON prerequisite to tests
Date: Fri, 3 Sep 2010 23:41:07 +0000
Message-ID: <AANLkTinqTom7mKKs7+H0cwRFjQAYYv0wYqa-cO_VbdAc@mail.gmail.com>
References: <AANLkTi=6ctLp-8FeqOGMZuhwvM_7DbaEp7+LK4nXfCaE@mail.gmail.com>
	<1283556296-7365-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 04 01:41:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Orfsm-0001pJ-4c
	for gcvg-git-2@lo.gmane.org; Sat, 04 Sep 2010 01:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913Ab0ICXlO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 19:41:14 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63339 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107Ab0ICXlN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 19:41:13 -0400
Received: by iwn5 with SMTP id 5so1956280iwn.19
        for <git@vger.kernel.org>; Fri, 03 Sep 2010 16:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Sc/V0K/WH3p0za+UFRyRhTD4ja3kawdD0jt/FsO3/rU=;
        b=sLr9yfRfz7YquqSXf/BfcLF5Gxl1UlifvM75qW4ilqPmN13iMWbI63qyjqlzR1AwjZ
         tjIiBDbs7hyoPMLIWgsrYRY5RhWI+tTvs0wwqqKPdI9nMnVEMuSGhaeEeMyVhMr/xt/S
         88fim8sZ29ow+HMiv7rZKy3ALRhYdb/dS8EuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gqYeZnHpqXKAue4rb0ygLdWZAkBYXr5VMylU76akLIm+rSYWE0fywV2AyKoNpn0P/4
         3m5lvg1Zl4KoXUIXubflK30Me4HeFLDKz8LmTD3aslkoFm1FJGsvlEEaW1lT6yoAleK2
         rMY1LoGE1QqbAbWaQ+aZWrLNvSocJO2GYx5TI=
Received: by 10.231.39.195 with SMTP id h3mr1546436ibe.88.1283557267390; Fri,
 03 Sep 2010 16:41:07 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 3 Sep 2010 16:41:07 -0700 (PDT)
In-Reply-To: <1283556296-7365-4-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155288>

On Fri, Sep 3, 2010 at 23:24, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <a=
varab@gmail.com> wrote:

> diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> index 8297cb4..9dfa31e 100755
> --- a/t/t7501-commit.sh
> +++ b/t/t7501-commit.sh
> @@ -13,9 +13,12 @@ test_tick
>
> =C2=A0test_expect_success \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0"initial status" \
> - =C2=A0 =C2=A0 =C2=A0 "echo 'bongo bongo' >file &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0git add file && \
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0git status | grep 'Initial commit'"
> + =C2=A0 =C2=A0 =C2=A0 "echo 'ngo bongo' >file &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0git add file"

This needs this trivial fixup:

    @@ -16 +16 @@ test_expect_success \
    -       "echo 'ngo bongo' >file &&
    +       "echo 'bongo bongo' >file &&

Otherwise the test doesn't pass when *not* using the poison
feature. Sorry about that. The fixed up version will be on my ab/i18n
branch on GitHub.
