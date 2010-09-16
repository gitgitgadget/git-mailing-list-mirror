From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 3/7] gitweb: separate heads and remotes lists
Date: Thu, 16 Sep 2010 10:19:00 +0000
Message-ID: <AANLkTi=N=jyj8ueVNu601N9qtBktmC-kVv9+0jSA=Sv-@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1284629465-14798-4-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 12:19:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwBYb-0000xL-BL
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 12:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753642Ab0IPKTD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 06:19:03 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:41787 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab0IPKTB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 06:19:01 -0400
Received: by yxp4 with SMTP id 4so342589yxp.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 03:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lC79kki7982Pfa7Cb06DzjX55GhW+SEEq2eZdoUlZTU=;
        b=vK/L3KLtGCTjFDRL3KzxhrD8Yhg7L3pC/g6wCS1/bq8KzhCatnNK/IRN8QujbSeHUz
         Xa7nla628SLJJH2a/LyLPKu5X7taMC42WjIkfb0lpIXu2vXicgphozHI6IJuc0oF7Yg8
         twHWHT0RC8xm7CbmXHX6yJycs6EYeanuUmP+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ub1+TxRgEHUCyzFM/qDGvfN9B8ArME3m5dYZUECIJSa3lsEG2sDJKWI69JbA2LjilF
         9qCI2uUmeQG58a5VH5Tdp9EhnfGSvPWX1zBZr3+EiWugkcdZxNACKiQ5jEcphGiRz917
         x8xqCFdjBPm/MYKwr/g8mz7JDhj7rWcGxA1qM=
Received: by 10.90.99.5 with SMTP id w5mr513654agb.207.1284632340346; Thu, 16
 Sep 2010 03:19:00 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 03:19:00 -0700 (PDT)
In-Reply-To: <1284629465-14798-4-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156311>

On Thu, Sep 16, 2010 at 09:31, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:

> + =C2=A0 =C2=A0 =C2=A0 if (@remotelist) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_print_header_d=
iv('remotes');
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_heads_body(\@r=
emotelist, $head, 0, 15,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$#remotelist <=3D 15 ? undef :
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cgi->a({-href =3D> href(action=3D>"=
remotes")}, "..."));
> + =C2=A0 =C2=A0 =C2=A0 }

Nit: The $# syntax is pseudo-deprecated, and since you use 16 as a
constant above this would be clearer anyway:

    @remotelist <=3D 16 ? undef : ...
