From: Thiago Farina <tfransosi@gmail.com>
Subject: Re: [PATCH 5/5] tag: recognize rfc1991 signatures
Date: Sat, 6 Nov 2010 15:46:51 -0200
Message-ID: <AANLkTi=ZmBdJWKj1z0HE=tFoftzDSJaU5=Ji_1ywcA8+@mail.gmail.com>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
	<4CAB90EC.1080302@drmicha.warpmail.net>
	<553a88c4ac00e681e605b81f3ce10342a881ac2f.1289041051.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat Nov 06 18:47:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEmqy-0004Ue-0w
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 18:47:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751825Ab0KFRqy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Nov 2010 13:46:54 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:36888 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751739Ab0KFRqx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 13:46:53 -0400
Received: by bwz11 with SMTP id 11so3623198bwz.19
        for <git@vger.kernel.org>; Sat, 06 Nov 2010 10:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KC8nLUnHCEcOPvzWPdPAfelaWsGTbzADgf+KxE45zyo=;
        b=D9DlxLVSGH2g6c+sbNBHt7vd8qIG8KNEJSqvTrAY7HZki1EZT3Ip4gDzuAYfjPtnMz
         Q9fRM4uHkKCh7T/KCg3aX6pfRX3JlGySlRlPO2vdPRaE3JHjs+T02zJMNO9s7sFfb6Iu
         felNBCEVqNx5egLEliJOgbVNnUs4WwfkqpoVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xbgFFJMY1LEnjYnbXjvyp0kRHG+mC102LMZql/xhA5Ocjv+fEMdrcAY11ut3DmoKac
         PyW/A8uMegRMnTFJYJgkCJKz6DaBWqau9cHE0Fx0TjVR8emAtaoDcGbgPtGQ5UuLAEEZ
         NNSIxRo6ixLdinUrmtDCFUiRH2vWJ6QDrtY9s=
Received: by 10.204.121.83 with SMTP id g19mr3144187bkr.13.1289065611904; Sat,
 06 Nov 2010 10:46:51 -0700 (PDT)
Received: by 10.204.58.71 with HTTP; Sat, 6 Nov 2010 10:46:51 -0700 (PDT)
In-Reply-To: <553a88c4ac00e681e605b81f3ce10342a881ac2f.1289041051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160852>

On Sat, Nov 6, 2010 at 9:04 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> diff --git a/tag.c b/tag.c
> index 5f9626c..18a5142 100644
> --- a/tag.c
> +++ b/tag.c
> @@ -138,7 +138,8 @@ size_t parse_signature(const char *buf, unsigned =
long size)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *eol;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t len =3D 0;
> - =C2=A0 =C2=A0 =C2=A0 while (len < size && prefixcmp(buf + len, PGP_=
SIGNATURE)) {
> + =C2=A0 =C2=A0 =C2=A0 while (len < size && prefixcmp(buf + len, PGP_=
SIGNATURE)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 && prefixcmp(buf + len, PGP_MESSAGE)) {

nit: I think this && should be in the end of the previous line. (Not
sure what is the preferred style though, comments?).
