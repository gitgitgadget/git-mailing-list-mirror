From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 08:06:58 +0200
Message-ID: <81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com>
References: <200905112208.21017.Hugo.Mildenberger@namir.de>
	 <200905121557.18542.Hugo.Mildenberger@namir.de>
	 <81b0412b0905120759u15f1ec73k73625a7904515792@mail.gmail.com>
	 <200905121900.00625.Hugo.Mildenberger@namir.de>
	 <81b0412b0905121018lbccda1fvf6c4c19417cdde00@mail.gmail.com>
	 <20090512172452.GA32594@blimp.localdomain>
	 <7vws8l7w0d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>,
	Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 13 08:07:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M47cR-00064n-9X
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 08:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbZEMGG7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 02:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752356AbZEMGG7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 02:06:59 -0400
Received: from fk-out-0910.google.com ([209.85.128.186]:49755 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbZEMGG6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 02:06:58 -0400
Received: by fk-out-0910.google.com with SMTP id 18so210895fkq.5
        for <git@vger.kernel.org>; Tue, 12 May 2009 23:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=2UNKMeILQ2Gt1MiOs4Y2DBbDdnIuzfD6Cw8Tq0oSESY=;
        b=OCsFnBKl7sEiiUBrJWykfJtoxsTdGC6BIkvVvs/TC1fipyVLxTM0Z4TqLh3rxZB7Pp
         96ixay8+CJc9bzu7TXSCq8Z6qCRHv7ZYOagAuX0fI5T+sq4o3X4iktCHhDHVxMswIxbO
         hOGkErg3KDWsPcZQ674RC2OrU2jhn97Faax9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rNl0QZF2wZWgUBDHatnIT9cOG+smvlEUiX5yUE8mn8jfzLWSEETVfJH2uT61R53AIP
         qBnEIvHqzx44GZ4K/HqaJOn1VfiAFTh7nzWCuf0oT2mwRDJcS5s4XoSIOP6mMajOmtW1
         rjdW57bMotMJCqCzBI3GgFvchGlCXYIKqsJCU=
Received: by 10.204.72.15 with SMTP id k15mr570974bkj.14.1242194818234; Tue, 
	12 May 2009 23:06:58 -0700 (PDT)
In-Reply-To: <7vws8l7w0d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118984>

2009/5/13 Junio C Hamano <gitster@pobox.com>:
> Alex Riesen <raa.lkml@gmail.com> writes:
>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < url_le=
n; ++i)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if ('\n' =3D=3D url[i])
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fputs("\\n", fp);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fputc(url[i], fp);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fputc('\n', fp);
>
> This ad-hoc quoting feels _very_ wrong. =C2=A0Who is on the reading s=
ide and
> how does it unquote?

git fmt-merge-msg. It does not unquote. The url is purely informational=
 here.
OTOH, the \n shouldn't be in url text at all, so treat it as slightly
less annoying
warning.

> If it is just informational use only, then it might make more sense t=
o
> drop this ugly "quoted \n" silently. =C2=A0I dunno.

That'd mean to loose the information completely. Which is just as bad
as putting the LF in the url in the first place.
