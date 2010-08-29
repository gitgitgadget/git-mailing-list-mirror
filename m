From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 01/13] fast-import: add the 'done' command
Date: Sun, 29 Aug 2010 16:28:14 -0500
Message-ID: <AANLkTik_kPy8p-OTy8E7fcLFMfKFHex2ppw4Oy7BesUX@mail.gmail.com>
References: <1283053540-27042-1-git-send-email-srabbelier@gmail.com>
 <1283053540-27042-2-git-send-email-srabbelier@gmail.com> <20100829212419.GC1890@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 29 23:28:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OppQf-000372-0I
	for gcvg-git-2@lo.gmane.org; Sun, 29 Aug 2010 23:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab0H2V2g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 Aug 2010 17:28:36 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44647 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753292Ab0H2V2f convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Aug 2010 17:28:35 -0400
Received: by gwj17 with SMTP id 17so1770488gwj.19
        for <git@vger.kernel.org>; Sun, 29 Aug 2010 14:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ONUpGy6l6DSoQT1wRx5ByhboUuQf5Io4+JvW/yC1bEI=;
        b=r25WUntfM2hp5ELWd7laeDM5v93w6pen329LNY6NFQ7mNPZRIh9Th0xDCTNPWgVqQH
         QbvzDPE52RVLPSPgakOllmanm81hveFkABzMsKVz+/8i98yoGmejAL8rzP43FTT8d3/C
         s2oO6V4kR9Cp65tAi2NhHS0IbBbv2nbQTg2IU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=IQRUlf8eP2+dTmtLG7rDxIYI/SPslye+jfbocoNiQr9ZgtzX3INH2R2I6z856x/1bD
         t4vahTalLG5kaHW8MxsEv44AtrmFkLNp1fXmkVCYK0pgZm42eey489UcyyFJ/RFuIaaS
         u/y4a4k+bKhmtGSQUUoTjWXvuPd/AQPp4SB+k=
Received: by 10.150.12.21 with SMTP id 21mr4369637ybl.295.1283117315315; Sun,
 29 Aug 2010 14:28:35 -0700 (PDT)
Received: by 10.151.49.17 with HTTP; Sun, 29 Aug 2010 14:28:14 -0700 (PDT)
In-Reply-To: <20100829212419.GC1890@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154719>

Heya,

On Sun, Aug 29, 2010 at 16:24, Jonathan Nieder <jrnieder@gmail.com> wro=
te:
> It is tempting to make the 'done' command mandatory when the "done"
> feature is used, to prevent confusion from streams that are cut off
> early. =C2=A0What do frontends currently do to handle that?

If the stream ends with an EOF at the end of a command, they would act
as if that was the end of the stream. If it ends mid-stream (e.g.,
while parsing a 'commit'), they would error out.

--=20
Cheers,

Sverre Rabbelier
