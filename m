From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 003/160] gettext: fix bug in git-sh-i18n's eval_gettext()
 by using envsubst(1)
Date: Sun, 14 Nov 2010 23:26:25 +0100
Message-ID: <AANLkTik4ds++er=MpLOZZ9DbhADbBrckyW3u0ydxbiv+@mail.gmail.com>
References: <1289747245-23263-1-git-send-email-avarab@gmail.com>
	<1289747245-23263-3-git-send-email-avarab@gmail.com>
	<20101114181605.GI26459@burratino>
	<7vmxpb1ztf.fsf@alter.siamese.dyndns.org>
	<AANLkTinh_Nkxvw7Z5HU=TbJHHFRZeWgr0COJ+N96OeTd@mail.gmail.com>
	<20101114212757.GD10150@burratino>
	<AANLkTim-j6TLwz0PugZvaEf1x3hW=76vT1gALC=w3DOu@mail.gmail.com>
	<20101114214731.GA16413@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 23:26:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHl1s-0006ub-N3
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 23:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932331Ab0KNW01 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 17:26:27 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53108 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751912Ab0KNW00 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Nov 2010 17:26:26 -0500
Received: by fxm6 with SMTP id 6so1344621fxm.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 14:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i/iDuNv9r75ASZ7nsXiKusSQNsZfhrUhdO8H++p7e2U=;
        b=I3EIHauuASat5xg4ZUR7DlRRr22FuJs2dgYckIv4YFjtjJ2shBt/3g90lLukQYUTRs
         FyfEL24GfeioC2Egyc1s2wYIg2IzKlqUl3vuD/ExmpC+Lz2rvu2f+ikZem5ksRqhX85Q
         N8lPM2fq9+VSzsS7EN5G10JDrI9Kz36+koAZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=aR1/P6ks0Obpz+/EFOSBdAMFiwBCoktdZ/dsctIYWdikSvElOTcpOZh4KaoBDM3ce5
         K5bJ1W/qYERTAXY9vSIKRCmYwOCADifkWnhJXpPqsT3/mgJckaagktzyeKt7Iv+LAxOA
         /y1sQsuk6GevcVpSFHeO444Uv9D36DylCY/AY=
Received: by 10.223.86.197 with SMTP id t5mr4083210fal.38.1289773585546; Sun,
 14 Nov 2010 14:26:25 -0800 (PST)
Received: by 10.223.105.78 with HTTP; Sun, 14 Nov 2010 14:26:25 -0800 (PST)
In-Reply-To: <20101114214731.GA16413@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161458>

On Sun, Nov 14, 2010 at 22:47, Jonathan Nieder <jrnieder@gmail.com> wro=
te:

> Yes, that is what $gmane/160842 is about (also see $gmane/137738 for
> background). =C2=A0In this case, a simple local stub xmalloc/xrealloc=
 etc
> to take care of checking for NULL seems fine, indeed.

Indeed. The problem is that even if I did that I couldn't convince the
Makefile in cooperating with creating my binary in a special
way. That's what I needed help with.

Then again I'm not a Makefile wiz and only tried to poke it for 20
minutes or so. So I might be missing something obvious.
