From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [RFC] submodule: fix handling of supermodules with relative
 origin URLs.
Date: Fri, 18 May 2012 22:16:57 +1000
Message-ID: <CAH3AnrpKg0vU_T8vWMfqagQkYvpFpzF3f6qoYEq9-H8GZ6pA2w@mail.gmail.com>
References: <AH3Anrr6mLVedBPcgfVwy=5KRjUgdp5W8P0DQ3qaX_UjH-npDw@mail.gmail.com>
	<1337343220-26717-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 18 14:17:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVM7I-0004xn-Dl
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 14:17:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295Ab2ERMQ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 08:16:59 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:41331 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755367Ab2ERMQ6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 08:16:58 -0400
Received: by wgbds11 with SMTP id ds11so802590wgb.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 05:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=WSKn8zR+Zw1oc6MTzxYA5CW054QavPEX2d2zMjD3YMw=;
        b=PSI/OT+7GMdKFg7Fg1d2wKkRLX8jUvPNw4b2U2gatjluaU+O8WwK0oFJog17dPdsrG
         jAM/pEz4jqv1Z4erMqwtyCJRTmfN4GnKEUffKZsk4akClsruz1mibYKPW2YDnlypre71
         XYP//ApMCHo+4ZZiDBv124oO2KxIbdrVcH/BadBA+rzCN1twtx7MdG2ObOyVbdivUYvu
         7SDH10NBDO91K7Xw9juYX38eCNOhrkMiMhiAgFzk4A3L6N3dEsYBKeiu9Vm22hp1Si0G
         SwWaq3wit9puKW96mdMMnmTexky8pHA3ty4taxLcN8c7oyakDn1UQQxZCVY6CftQUPtL
         yLiQ==
Received: by 10.181.11.137 with SMTP id ei9mr987842wid.21.1337343417915; Fri,
 18 May 2012 05:16:57 -0700 (PDT)
Received: by 10.180.83.131 with HTTP; Fri, 18 May 2012 05:16:57 -0700 (PDT)
In-Reply-To: <1337343220-26717-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197950>

On Fri, May 18, 2012 at 10:13 PM, Jon Seymour <jon.seymour@gmail.com> w=
rote:
> - =C2=A0 =C2=A0 =C2=A0 remoteurl=3D${remoteurl%/}
> + =C2=A0 =C2=A0 =C2=A0 up_path=3D"$(echo "$2" | sed "s/[^/]*/../g")"
> + =C2=A0 =C2=A0 =C2=A0 remoteurl=3D${remoteurl%/*}

Oops - didn't mean to change remoteurl here.


> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 remoteurl=3D"${up_path%/}/${remoteu=
rl%/*}"

Meant up_path%/ to be up_path%/*

jon
