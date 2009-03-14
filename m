From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] config: --replace-all with one argument exits properly 
	with a better message.
Date: Sat, 14 Mar 2009 23:34:55 +0200
Message-ID: <94a0d4530903141434w2fb8aa28we087465482a12e41@mail.gmail.com>
References: <1236998552.9952.2.camel@luis-desktop>
	 <7vtz5vakrp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Carlos Rica <jasampler@gmail.com>, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 14 22:36:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LibXA-0004sT-B0
	for gcvg-git-2@gmane.org; Sat, 14 Mar 2009 22:36:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbZCNVfA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Mar 2009 17:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751379AbZCNVe7
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Mar 2009 17:34:59 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:54313 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242AbZCNVe7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2009 17:34:59 -0400
Received: by fg-out-1718.google.com with SMTP id 16so1002313fgg.17
        for <git@vger.kernel.org>; Sat, 14 Mar 2009 14:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WsQdW2dHB8n8zxegICu8UAvFrRULxKyOAbKVpQ+XiNI=;
        b=UT+D36EzEtmrsQmC/rCIWe4u2lwF+Ld8joYcrI8lCfhc+thg/xBaI63UjyLJD8SeVG
         KIdrMasWcqC2yPLnXKElWrLVdYPtX450vUP9BDlSegjfu5Mi1Z+nJuEZ44q622CRtuHS
         CRmxZj0bhVAbjXpUSDMQCwQDh5F5VIAMHCgH0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=nqJijZgasywK4B2Fd2Usm3g7x2qt7niBGhgH3W7clweJWdO0V0y/bndC3H5MWztMQt
         Ko0k40jU6WdflmtgFmo8HYP0ySYbjSyTb5y6iZBAH0m+98iqOOJXzC1hUq2tIkrT9x0t
         RN07eFkAgxRIP9YiCstecrag9AYP7e/Pa6/n8=
Received: by 10.86.61.13 with SMTP id j13mr1886438fga.59.1237066495516; Sat, 
	14 Mar 2009 14:34:55 -0700 (PDT)
In-Reply-To: <7vtz5vakrp.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113268>

On Sat, Mar 14, 2009 at 10:53 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Carlos Rica <jasampler@gmail.com> writes:
>
>> 'config --replace-all ONE_ARG' was being treated as 'config NAME VAL=
UE',
>> showing the error "key does not contain a section: --replace-all".
>
> Hmm, I am getting "error: wrong number of arguments" followed by the =
long
> and somewhat annoying "usage" from the parseopt table dump.

If you find it annoying why don't you remove the usage?

> Ahh, that is because I am running the version from 'next', which cont=
ains
> the fc/parseopt-config topic that rewrites the option parser and erro=
r
> checking almost completely.
>
> Can you work with Felipe to see if this is still needed, or needs to =
be
> fixed in a different way? =C2=A0It could be that your tests may alrea=
dy pass
> over there on 'next'. =C2=A0I didn't check.

The new code is already checking correctly that --replace-all needs at
least two arguments. However, the "usage" is incorrect and of course
the test will come in handy.

Cheers.

--=20
=46elipe Contreras
