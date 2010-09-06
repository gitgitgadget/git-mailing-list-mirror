From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 14/15] gettextize: git-revert split up "could not
 revert/apply" message
Date: Mon, 6 Sep 2010 20:25:49 +0000
Message-ID: <AANLkTi=V01_OP+6pxrUakF=cTGFL=nOv=9C5meQU2H8C@mail.gmail.com>
References: <1283638229-14199-1-git-send-email-avarab@gmail.com>
	<1283775704-29440-15-git-send-email-avarab@gmail.com>
	<20100906185547.GF25426@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?Jan_Kr=C3=BCger?= <jk@jk.gs>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 22:25:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsiGJ-00075u-Jz
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 22:25:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482Ab0IFUZv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 16:25:51 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36665 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942Ab0IFUZu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 16:25:50 -0400
Received: by gxk23 with SMTP id 23so1725875gxk.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 13:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=my58wz+S2ORB1pc6OTKpudNyWWKE4zCDgNzsLtSAmWc=;
        b=PniBI8ErP/0n7qjggtfRf/JKzhmq0fDLWNnN+EWvA/Y8lLTcW1fHSfZw20GJXPqnTw
         muq1bybAMMWmsnQKg6jtLe8aq0UbVoh8c0e/0Oznjvo5COe6KHPfwFGzFCQzaY+kbOgq
         lnbu/uBJNXXdvePcscmrmJ8rM4wT+nrkADRDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h4bfWlbvUYCwYI8ASALbKlsmYG3lpJnTJhAaxkRfuE+RlRIH11QKx0KYb2u6eg9QWK
         ElXphTXXI0P0StbLIqIqHlQYkRyquWyiyqaR/r8eCcZBuv0q+1u1ettUqBpzPLIQ4lmQ
         r6h0Z83/DgZYqQC9LTAQdwR5xqmZgQL2paZ8E=
Received: by 10.151.17.31 with SMTP id u31mr40963ybi.194.1283804749474; Mon,
 06 Sep 2010 13:25:49 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Mon, 6 Sep 2010 13:25:49 -0700 (PDT)
In-Reply-To: <20100906185547.GF25426@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155611>

On Mon, Sep 6, 2010 at 18:55, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> (+cc: Christian)
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Split up the "could not %s %s... %s" message into "could not revert
>> %s... %s" and "could not apply %s... %s". This makes it easier for
>> translators to understand the message.
>
> Right, parts of speech can be a pain. =C2=A0So:
> Acked-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

>> --- a/t/t3507-cherry-pick-conflict.sh
>> +++ b/t/t3507-cherry-pick-conflict.sh
>> @@ -38,7 +38,7 @@ test_expect_success 'failed cherry-pick does not a=
dvance HEAD' '
>> =C2=A0 =C2=A0 =C2=A0 test "$head" =3D "$newhead"
>> =C2=A0'
>>
>> -test_expect_success 'advice from failed cherry-pick' "
>> +test_expect_success NO_GETTEXT_POISON 'advice from failed cherry-pi=
ck' "
>
> An idea (it may or may not be a good one ;-)): what if we made the ge=
ttext
> poison into an automatically generated .po file? =C2=A0Then testing p=
oison
> would be a special case of running tests with an arbitrary locale:
>
> =C2=A0$ TEST_LANGUAGE=3Dpoison prove t[0-9]*.sh
>
> and this test prerequisite could be more intuitively named LOCALE_C o=
r
> similar.

The issue with that is that gettext depends on setlocale(), which
requires a *valid* locale. This is why I skip the t/lib-gettext.sh
tests unless `locale -a` says is_IS is there, because even if we
compile is.po using it won't work without the locale.

So to do this we'd have steal some locale.

Also, the set of tests we want to skip under POISON (i.e. automated
garbage) is slightly different from the tests we want to skip under
TEST_LOCALE=3D, because some of those tests are checking for the %s in
"file failed: %s". So they'll fail under POISON, but shouldn't fail
under any translation.
