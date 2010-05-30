From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/7] Add API for string-specific memory pool
Date: Sun, 30 May 2010 11:38:33 +0200
Message-ID: <AANLkTil6dK82ydjjBqKlHEuDMHbgOlVAUXNQZGHZzCYM@mail.gmail.com>
References: <1274650832-7411-1-git-send-email-artagnon@gmail.com> 
	<1274650832-7411-6-git-send-email-artagnon@gmail.com> <20100529113800.GA7925@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 11:39:00 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIeyx-0003qK-Qu
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 11:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752835Ab0E3Jiy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 05:38:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52846 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab0E3Jix convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 May 2010 05:38:53 -0400
Received: by vws11 with SMTP id 11so909669vws.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 02:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=U6HOilxT/JEN2Ckn2ezcyGGmnYuNJQjdMETJ6Bp55w8=;
        b=v3DXksy36MANu9cy4/5wuLj0nSxpVCI/PAJ6hJI9WO2Pv7G3ZkfLmI95Rj+vQ+Ade0
         PZ7GQVvUe5+FNiDnKvFBjT2zEUIGjPcF+G3bTldjhXtMeVNK/yETHsaM/8bIOgOz2Bd0
         rBUhLPsoaI7HYiEgIjkWAmXQ+zjuQKVsqZs6o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z6k/+RgHniWiNvyEPOvWR1xD/dzPqzT+eyCRVzfWxUofcCkG0xpSOn29CmVVcbSJly
         QUb4CV2x5OF2iBi16xc3ixGRltKEVdhOxM6baoDNLv4i6kFmyhi3A0ie39aHIq0A8pnz
         pmpAfsSPImuaz5xQSChzkw0qHIAqvmJcMNrbQ=
Received: by 10.229.215.134 with SMTP id he6mr437854qcb.128.1275212333077; 
	Sun, 30 May 2010 02:38:53 -0700 (PDT)
Received: by 10.229.50.3 with HTTP; Sun, 30 May 2010 02:38:33 -0700 (PDT)
In-Reply-To: <20100529113800.GA7925@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147995>

Hi Jonathan,

Jonathan Nieder wrote:
> This interns strings so they can be compared by address. =C2=A0Intere=
sting.
> The use of offsets instead of pointers here mean it is possible to
> back the pool by a file, if I understand correctly.

Exactly. The future plan is to use file backing to support incremental =
dumps.

> Missing From: and sign-off.

Right, I'll fix this in all the patches in the series in the re-send.

> nitpick: could use fewer parentheses.

Ok.

> so I guess it is safer to keep the casts.

Right. I don't want compiler warnings either- Sverre and I had to work
quite hard to eliminate many of them (commit seen in master now).

> style nitpick: should use space instead of tab

Quick doubt: Does running whitespace-cleanup (Emacs) on all the files
before generating patches suffice?

> Should use "../git-compat-util.h" for portability: unfortunately, som=
e
> platforms git supports still don=E2=80=99t have stdint.h iirc.

Oh. What do we do about stdint.h then?

-- Ram
