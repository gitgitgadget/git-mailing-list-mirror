From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Git exhausts memory.
Date: Wed, 6 Apr 2011 11:51:26 -0400
Message-ID: <BANLkTinOzkHMpr5Yg7dixMyTSHBXCsO7Qw@mail.gmail.com>
References: <BANLkTin=yUtzbZjs_92FHDfs62VFFuLHwg@mail.gmail.com>
 <alpine.LFD.2.00.1104021103130.28032@xanadu.home> <BANLkTikRGQ45xvWvisMhXi4Hu2r_0GS=Gg@mail.gmail.com>
 <alpine.LFD.2.00.1104031110150.28032@xanadu.home> <BANLkTinCwZG3+0Ss8o9ODptg=L8LKKN7aQ@mail.gmail.com>
 <BANLkTinU7x16yp+y-HW9UhkVn9SftOJCcA@mail.gmail.com> <4D9B47D2.6050909@ira.uka.de>
 <BANLkTikanSa3D1Bd8kSySPWQhcj1y8N+qA@mail.gmail.com> <7vzko4mw44.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Shawn Pearce <spearce@spearce.org>,
	Holger Hellmuth <hellmuth@ira.uka.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Git Mailing List <git@vger.kernel.org>,
	Alif Wahid <alif.wahid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 17:56:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7V5n-0000J5-V7
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 17:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756421Ab1DFP4X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2011 11:56:23 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40353 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756325Ab1DFP4W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Apr 2011 11:56:22 -0400
Received: by bwz15 with SMTP id 15so1262124bwz.19
        for <git@vger.kernel.org>; Wed, 06 Apr 2011 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=we32or79e0mwJkOGWxUpP/omjcijpR/L5AAVnkT/w/8=;
        b=NKBK9wQc36XmimhGrYaalecfGY0432yF6ygHlA1p7QC6ufTXL2s7XTijir5PGZaYZu
         mCWOsHo0I/V0T5sHg+LjMtGNAP4wtYE8YY6icGkXZpZtVq85SSbE/qv5xcGLo2Ti3pJO
         BZhE5r6Rl9dI1ttJl6hRWs4xWIZsClHJR/1JA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aF7xcjXpFkGqJ7bwobAOA0iGnzBjSRedkzflw6H8nBs84SPdRAbLTeUV9yYcBAy3qG
         D+isJB4984+hdKD4vGvm9J2FY4SqjneeD0pdwizfTpdPRqEgIFyD2t398t9DBt+wTXDZ
         9NNeQSVpcBlH3qu4+Myj3o/GNxQ8geCh7Qc5w=
Received: by 10.204.20.65 with SMTP id e1mr1677bkb.149.1302105116224; Wed, 06
 Apr 2011 08:51:56 -0700 (PDT)
Received: by 10.204.126.17 with HTTP; Wed, 6 Apr 2011 08:51:26 -0700 (PDT)
In-Reply-To: <7vzko4mw44.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170987>

On Tue, Apr 5, 2011 at 1:44 PM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> =C2=A0builtin/pack-objects.c | =C2=A0 =C2=A08 ++++++--
> =C2=A0cache.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
| =C2=A0 =C2=A01 +
> =C2=A0config.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A06 ++++++
> =C2=A0environment.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
1 +
> =C2=A0fast-import.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0=
5 -----
> =C2=A05 files changed, 14 insertions(+), 7 deletions(-)

This will be white-spaced damaged by Gmail, but anyway:

diff --git i/Documentation/config.txt w/Documentation/config.txt
index 750c86d..91aa9be 100644
--- i/Documentation/config.txt
+++ w/Documentation/config.txt
@@ -443,7 +443,6 @@ be delta compressed, but larger binary media files =
won't be.
 +
 Common unit suffixes of 'k', 'm', or 'g' are supported.
 +
-Currently only linkgit:git-fast-import[1] honors this setting.

 core.excludesfile::
 	In addition to '.gitignore' (per-directory) and


j.
