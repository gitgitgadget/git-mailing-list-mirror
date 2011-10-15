From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Sat, 15 Oct 2011 12:39:30 +0530
Message-ID: <CAMK1S_gkB49qhnt8U=3G3UPnjo2vzFx5mL4cOM1Ubu68ySJrDA@mail.gmail.com>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
	<1317678909-19383-1-git-send-email-pclouds@gmail.com>
	<20111012200916.GA1502@sigill.intra.peff.net>
	<20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
	<20111013182816.GA17573@sigill.intra.peff.net>
	<7vvcrs181e.fsf@alter.siamese.dyndns.org>
	<20111014131041.GC7808@sigill.intra.peff.net>
	<20111014192326.GA7713@sigill.intra.peff.net>
	<20111014210251.GD16371@elie.hsd1.il.comcast.net>
	<20111014211244.GA16429@sigill.intra.peff.net>
	<20111014211921.GB16429@sigill.intra.peff.net>
	<CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com>
	<7vk486x0hq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 09:09:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REyNK-0003bL-D3
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 09:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379Ab1JOHJc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Oct 2011 03:09:32 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:53317 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab1JOHJb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 15 Oct 2011 03:09:31 -0400
Received: by ggnb1 with SMTP id b1so1045498ggn.19
        for <git@vger.kernel.org>; Sat, 15 Oct 2011 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=woq2sUu7iQXSsMRwmsCNbqataXTVi/Vh+/tNOP951lk=;
        b=uxe4dpR4jJQAMRdEkIvmn2aoTeUHBCxqi7Fjt3hBlTDpnFBdEM7XNuxWyLmqh4g+ZY
         DSsVsZgpd6SSDNZ6L+4tGS3Hk6fAYCGZzM2g832tJ0MSNIMh11zzkIDTSQzdw/PV1Zdp
         1MTtWJxQF85kGF3dT6ApVGS8Q2ej9f4TKjOUA=
Received: by 10.182.73.7 with SMTP id h7mr6845520obv.51.1318662570878; Sat, 15
 Oct 2011 00:09:30 -0700 (PDT)
Received: by 10.182.53.73 with HTTP; Sat, 15 Oct 2011 00:09:30 -0700 (PDT)
In-Reply-To: <7vk486x0hq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183645>

On Sat, Oct 15, 2011 at 11:25 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
>
>>> Because there is a risk of leaking information about
>>> non-exported repositories, by default all errors simply say
>>> "access denied". Sites which don't have hidden repositories,
>>
>> I suggest that even the "secure" version of the message say somethin=
g
>> like "access denied or repository not exported". =C2=A0You're still =
not
>> leaking anything, but it reduces confusion to the user, who otherwis=
e
>> may not realise it *could be* the latter.
>
> I kind of like the suggestion, but I am afraid that "access denied,
> repository nonexistent or not exported" can soon easily get long enou=
gh to
> be unmanageable.

When someone who *does* have access makes a typo, "access denied"
makes it harder to realise it, because it subtly implies the repo
*does* exist and it's an ACL issue.  I've seen lots of frustrating
back-and-forth between admin and user before someone eventually
noticed the typo.

"Access denied or no such repo" is much better.  (The "not exported"
nuance is not relevant in this context; you can safely ignore it.)

regards

--=20
Sitaram
