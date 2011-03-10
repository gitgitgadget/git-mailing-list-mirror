From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 2/2] i18n: avoid conflict with ngettext from libintl
Date: Thu, 10 Mar 2011 10:21:18 +0100
Message-ID: <AANLkTimkVrbosOZeCDxcgRvzRDqYiiz72M0_zQ4_NSvi@mail.gmail.com>
References: <4D7165A3.5080308@colin.guthr.ie>
	<7vlj0u5wyw.fsf@alter.siamese.dyndns.org>
	<4D7223A9.6080105@colin.guthr.ie>
	<7vsjuz520w.fsf@alter.siamese.dyndns.org>
	<7vhbbf50vu.fsf@alter.siamese.dyndns.org>
	<20110306225641.GB24327@elie>
	<AANLkTikctSrfqKCdeYUyvUmAZjr=i7kaFhPeB-LfwgUz@mail.gmail.com>
	<20110309103104.GA30980@elie>
	<20110309105236.GC30980@elie>
	<7vfwqw9g9b.fsf@alter.siamese.dyndns.org>
	<20110309205155.GC22292@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 10:21:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pxc3l-0000DV-4e
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 10:21:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337Ab1CJJVW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Mar 2011 04:21:22 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58192 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751989Ab1CJJVT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Mar 2011 04:21:19 -0500
Received: by ewy4 with SMTP id 4so434732ewy.19
        for <git@vger.kernel.org>; Thu, 10 Mar 2011 01:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nVphiMn/W4E30VXhF+37SteW5Dn5nX0PcrO5tJ/z2WM=;
        b=qHNjxaN0fLtgtGblwnbX5dRM8R1EFEuj1SEgp29lu9sG61jgtKDFZu+Uwi/8jvVKBX
         Kr/qgtF3U74ZvGvcYEnOWGcDlLW80IR7s0tQh3kHIDgdEoenH72I2t83SoLlgHqzTIsC
         Yqk67Q2hgv16cCzpr1f8je0Robmuv7I4RLUlM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=tECQgNd0BO2s5OhViuNmEAYilHlDdqjP7XMt79sYnf/AwYVXB27arptb9nchn937Lx
         CJQx+p6fjEL5YKUT0MMjIiPJ4TB6fJvmczNm6tYypXZILd/g4GYCR5CVmSfsxCy71E5f
         yCFfLiV8Qtvd54aWkZ2yiWnbq0Qt0PaKkGfm4=
Received: by 10.223.127.210 with SMTP id h18mr6400687fas.46.1299748878291;
 Thu, 10 Mar 2011 01:21:18 -0800 (PST)
Received: by 10.223.108.130 with HTTP; Thu, 10 Mar 2011 01:21:18 -0800 (PST)
In-Reply-To: <20110309205155.GC22292@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168800>

On Wed, Mar 9, 2011 at 21:51, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> Junio C Hamano wrote:
>
>> Hmph. =C2=A0An obviously safer alternative would be to use git_ngett=
ext() in
>> our source all over the place, and it would by even more peace of mi=
nd but
>> that is even longer.
>
> Right. =C2=A0That is tempting.
>
> =C3=86var, is there some usual or obvious abbreviated form for ngette=
xt we
> could use to avoid this fuss altogether?

I was looking yesterday but I couldn't find a common. I think your
Q_() is fine.

I see GNU Make uses S_() internally, netcat uses PL_(). There seems to
be no common convention for it like for gettext().

Personally I'd have chosen n_(), although confusing with our existing
N_() we could add dn_(), dcn_() etc for dngettext() and dcngettext()
later.

But I don't think it matters. Let's use your patch as-is.
