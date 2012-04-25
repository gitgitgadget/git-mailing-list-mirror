From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 03/10] i18n: mark relative dates for translation
Date: Wed, 25 Apr 2012 10:25:58 -0500
Message-ID: <20120425152558.GC31026@burratino>
References: <1335184230-8870-1-git-send-email-pclouds@gmail.com>
 <1335184230-8870-4-git-send-email-pclouds@gmail.com>
 <xmqqd36wgam5.fsf@junio.mtv.corp.google.com>
 <CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jiang Xin <worldhello.net@gmail.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 17:26:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN46x-0006Pi-0z
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 17:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754098Ab2DYP0Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 11:26:25 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:34681 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753938Ab2DYP0Y convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Apr 2012 11:26:24 -0400
Received: by yhmm54 with SMTP id m54so200921yhm.19
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 08:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NDMHfTMB87f4olUvmyq4dQNJ6Cs1prg1RPXG238YNwE=;
        b=y0KKzybor2xZltKTyKnlIHWBxcvSDKvWKjvWbeeCBzBemnPok7TfkEmyZX1dmJZJAV
         bw+twD6ZMwbRDD9+knGsw11q3tjlRTz7kQcndbiDB3segxd63w97J/WVKsRMGc5KjTZ5
         1rj4c4SEisS+ktVcTcvgb81keQZTtKS+++ZzVUwEswoqjZENVMAAnZV75KHFU5KB0TlL
         N+Crcjp4Wnq9epRDOm7uvxDQA13q1rLom3yPrDl0UZ5uO+rubYLXOUEVW3rXhE/P3c0p
         mQibOwMMD6+O0ebrpiNstm6S1+Dy0HvPl+q0YK3YOZfrOy8FNHnYDCe/0u1K+bas5hCz
         OwtQ==
Received: by 10.60.4.170 with SMTP id l10mr3869051oel.67.1335367584045;
        Wed, 25 Apr 2012 08:26:24 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id w4sm19810803oeg.12.2012.04.25.08.26.03
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 08:26:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8Ae_9wEoNmP81Gqu5kOMGrEKSN9PMvoRXbKh8TnwGVt0A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196318>

Nguyen Thai Ngoc Duy wrote:
> 2012/4/25 Junio C Hamano <gitster@pobox.com>:

>>> + =C2=A0 =C2=A0 strbuf_addf(timebuf,
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Q_("%lu year ago"=
, "%lu years ago", (diff + 183) / 365),
>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(diff + 183) / 36=
5);
>>> =C2=A0}
>>
>> This is just a tangent, but could we possibly come here and say "1 y=
ear
>> ago"?
>
> Nice catch. Singular form here is unnecessary.

I think Junio meant

			Q_("1 year ago", "%lu years ago", ...)

That sound reasonable to me.  My only worry is a small one: what
happens if we want to change the %lu to some other format specifier
some day?  Will xgettext be smart enough to let translators know
without the msgid changing?
