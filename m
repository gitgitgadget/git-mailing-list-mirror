From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 03/10] i18n: mark relative dates for translation
Date: Wed, 25 Apr 2012 17:46:45 +0700
Message-ID: <CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-4-git-send-email-pclouds@gmail.com> <xmqqd36wgam5.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 12:47:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SMzko-0005mz-VZ
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 12:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757172Ab2DYKrS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 06:47:18 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56464 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756861Ab2DYKrS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 06:47:18 -0400
Received: by wibhq7 with SMTP id hq7so1669584wib.1
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=9De32kwlSJLsRA75h8s2DJP9gP5us5wBeleuhZvE9i8=;
        b=BYE+5FuwHZzFBIc9XX2cMr1KH8WTMqyaqZJTFLkzGlLCx4wEXX99aG0j5eFSDbsWm9
         Ubi2vW6gHXV2OOU+rqG+mhYWcKhOYdpVb4gzMc7c4h+GYSU180BZLC/PKmlTv7aBHJmk
         2JDsGPn3hTmvx1ByuB8uSWK56H/0Ds28cD/LDe9EGReRs1WhoRmMNkYh3fOgGNYZOuKF
         tit6YSMH8sdDQtkX+Jm1N3ar2vLNbYsVFvz3yceZYX3X9NPLGUZX2CKnVifWKd3rlExW
         BQ33FvhU2cBIoMS1YZq053zjsxkD2rCt0+ym7ukxnNuIdZIGhR5+ZmV+azO6Qf4eniPE
         GHQg==
Received: by 10.216.135.105 with SMTP id t83mr1301353wei.105.1335350836707;
 Wed, 25 Apr 2012 03:47:16 -0700 (PDT)
Received: by 10.223.16.194 with HTTP; Wed, 25 Apr 2012 03:46:45 -0700 (PDT)
In-Reply-To: <xmqqd36wgam5.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196305>

2012/4/25 Junio C Hamano <gitster@pobox.com>:
>> =C2=A0 =C2=A0 =C2=A0 /* Give years and months for 5 years or so */
>> =C2=A0 =C2=A0 =C2=A0 if (diff < 1825) {
>> ...
>> =C2=A0 =C2=A0 =C2=A0 }
>> =C2=A0 =C2=A0 =C2=A0 /* Otherwise, just years. Centuries is probably=
 overkill. */
>> - =C2=A0 =C2=A0 snprintf(timebuf, timebuf_size, "%lu years ago", (di=
ff + 183) / 365);
>> - =C2=A0 =C2=A0 return timebuf;
>> + =C2=A0 =C2=A0 strbuf_addf(timebuf,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Q_("%lu year ago",=
 "%lu years ago", (diff + 183) / 365),
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(diff + 183) / 365=
);
>> =C2=A0}
>
> This is just a tangent, but could we possibly come here and say "1 ye=
ar
> ago"?

Nice catch. Singular form here is unnecessary. If you plan to revert
that, please put a comment so nobody will attempt to convert it to
Q_() again next time while searching for possible candidates.
--=20
Duy
