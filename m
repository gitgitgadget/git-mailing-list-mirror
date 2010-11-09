From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH] checkout: do not switch branch during a rebase unless -f
 is given
Date: Tue, 9 Nov 2010 15:11:42 +0100
Message-ID: <AANLkTi=2q1-1zmR=JquN75DP9sGGuPVkAu4mVs1U9DZo@mail.gmail.com>
References: <1285649564-24737-1-git-send-email-pclouds@gmail.com>
 <1285649702-24773-1-git-send-email-pclouds@gmail.com> <AANLkTinUudOXmhKW-+rkcpzb-VNnSBLZwGZcjrS6UdMu@mail.gmail.com>
 <AANLkTin19PREB3B68s+ejsgtXwe3CBxZF-caCvRp4UXv@mail.gmail.com>
 <AANLkTinKNF6OEX=k1aepD-Zrm2_4GzHaB+SVHdfTMG-j@mail.gmail.com> <20101109140615.GA18960@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?RnLDqWTDqXJpYyBCcmnDqHJl?= <fbriere@fbriere.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 09 15:12:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFovl-0005Cc-8G
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 15:12:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753262Ab0KIOMG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Nov 2010 09:12:06 -0500
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33840 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955Ab0KIOME convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 09:12:04 -0500
Received: by yxe1 with SMTP id 1so78224yxe.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 06:12:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=hZa20oc2tlOuHRKfZkV4+LHn2QabfDqRvtcOcY2M0SY=;
        b=PKoJfmKQ3lHN6RL93/Bds7VT/1FALbk+tJemmvgt3BDyV92jbsngkQRdF7iv6/Sllk
         afM6DCALQxHR1022z8W/23cjjUGBtIqQcuUphtu8mtehePd2TyDHMCVR/kN6Y4kyhoZF
         8oZX/zD/rQnisTOqqS1SCQ2ozbhxa1T9S/PgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=ENmtVBO38bTl6ct5BtdFSeghZTjsj86vhRRJUlFWd7FtzA9r6H12OqyZlePiSZ33v3
         UGjg5WYVsmv+NRo+LSnFHSQgqgKadr0yks8xNo88b7ajoNUCUbD+eFsbh0mLzWFw/0DR
         hDqiiQH15VAhqWSnC+apyl+L41LtnQYKPkqlc=
Received: by 10.150.144.19 with SMTP id r19mr4622787ybd.141.1289311922861;
 Tue, 09 Nov 2010 06:12:02 -0800 (PST)
Received: by 10.150.53.4 with HTTP; Tue, 9 Nov 2010 06:11:42 -0800 (PST)
In-Reply-To: <20101109140615.GA18960@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161049>

Heya,

2010/11/9 Jonathan Nieder <jrnieder@gmail.com>:
> I like it. =C2=A0Would it be possible to make sure the (widespread?) =
practice
> of using
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0rm -fr .git/rebase-merge

Awr, and here I was, all hopeful reading your message up to here.

> to terminate a rebase without going back to the original branch
> still works? =C2=A0I think it should be.

And then here you smash my hopes that you were suggesting we stop
asking the user to mess around in the .git directory :(. After all, if
we let that rm be handled by some 'git rebase' mode, it could also
unlock any branches it has locked.

--=20
Cheers,

Sverre Rabbelier
