From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 06/10] i18n: remote: mark strings for translation
Date: Thu, 26 Apr 2012 08:12:34 +0700
Message-ID: <CACsJy8BNbRFKqBKYLR5OKOEPL3iMdjzfSrSAxSZ489nNNW6rVw@mail.gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-7-git-send-email-pclouds@gmail.com> <xmqqaa1zbexh.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 26 03:13:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNDH3-00054V-Tb
	for gcvg-git-2@plane.gmane.org; Thu, 26 Apr 2012 03:13:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab2DZBNH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 21:13:07 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:60950 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751156Ab2DZBNF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 21:13:05 -0400
Received: by wejx9 with SMTP id x9so422557wej.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 18:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=3ZeMaqAMOHb/5w/GmQofnZZi1UH/n98Ir9Ccxo90j44=;
        b=NFbMOy2ZWDvjb11UWxqMFqrEww5yhSYil1+/4M/bhYI0OSPR198RaKKWY9+7O1aJ5/
         6O/eUNo3FwXwjHlzs3jatjVlb8jcDnXuehxtZ2NEQOczP6s+4AKMUlOviYVgV2Wp/gGh
         HvQZpXvw+v8XghE/3ilDlZioirGkhl8MZ49aKlEyGoF041qeHwpRE466oQzIQk/kt76R
         e1RUyHQy+USePj+LlMsMFIOLWDFJUenJMu8sCq96ewEP2PGgLjkuqwKcqSmiMyOXbjrv
         iowuFVuwTwfVMA/A0L+jawb1/iP2GFSlUZHTR6RFO04SrnHH652GDAFzC+c4D3zraHpc
         uzMQ==
Received: by 10.180.75.241 with SMTP id f17mr11482059wiw.11.1335402784526;
 Wed, 25 Apr 2012 18:13:04 -0700 (PDT)
Received: by 10.223.14.193 with HTTP; Wed, 25 Apr 2012 18:12:34 -0700 (PDT)
In-Reply-To: <xmqqaa1zbexh.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196346>

2012/4/26 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> @@ -761,7 +761,7 @@ static int remove_branches(struct string_list *b=
ranches)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned char *sha1=
 =3D item->util;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (delete_ref(refn=
ame, sha1, 0))
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 result |=3D error("Could not remove branch %s", refname);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 result |=3D error(_("Could not remove branch %s"), refname);
>> =C2=A0 =C2=A0 =C2=A0 }
>
> This is an issue in the original, but almost all messages in this
> utility use sq around names of 'stuff' that can be specified by the e=
nd
> user when it appears as part of a sentence, but not here.

If we are going to make a style consistency patch, should we also
agree on (at least for this command) whether to write initial letter
in capital or not?
--=20
Duy
