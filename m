From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/9] count_pathspec(): return number of elements in pathspec
Date: Tue, 10 May 2011 20:29:29 +0700
Message-ID: <BANLkTiniUzKM2P4PzqYaaVunN7-WjpkYmw@mail.gmail.com>
References: <1304852906-29272-1-git-send-email-pclouds@gmail.com>
 <1305006678-4051-1-git-send-email-gitster@pobox.com> <1305006678-4051-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 10 15:30:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJn1C-0006tw-Sm
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 15:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807Ab1EJNaV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2011 09:30:21 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37400 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755707Ab1EJNaS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 May 2011 09:30:18 -0400
Received: by fxm17 with SMTP id 17so4301633fxm.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 06:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ABDMBqxyk1PVU1HiCOxWQbMEI+/3WeOMrtdyiRSUpe4=;
        b=xSL917EcBB2QJqpVoQKdKhY0JLX1FOKz/w7tyVbXgAVDNmF0UHxKqsDzjFt2ektTYu
         A/Nx1dopmAMc/BgSo3En67v5EtnU2+64Y2xhxdvl/Lxt1tvZMcxspSXmWGqZ1b4rVPEx
         M4RLvUNBtu/VaoFI5bbRiR18GlBQjnR/G3GcE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=t/1D8ZXvnheXVjZUbde0TfzP+nQGhraMWsloJdPmxaIUEzttemcFnrb3pUI9aOriQu
         qwcW6EoRLc0b2GHw1xSnQWWRUlcoYCPTEne36xAENKGA1daer+WJIPcmkqfrt2ht7OM5
         AsdZIbRWeWBvTaQLhaeppvN6r9SMl2lvCGlpI=
Received: by 10.223.75.15 with SMTP id w15mr1227734faj.134.1305034217035; Tue,
 10 May 2011 06:30:17 -0700 (PDT)
Received: by 10.223.126.145 with HTTP; Tue, 10 May 2011 06:29:29 -0700 (PDT)
In-Reply-To: <1305006678-4051-4-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173334>

On Tue, May 10, 2011 at 12:51 PM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> When fed a non-empty argv[], get_pathspec(prefix, argv) used to alway=
s
> return an array of string that has the same number of elements as arg=
v[]
> had, but with ":" (work at toplevel without any path limit) magic pat=
hspec
> it can return zero elements. =C2=A0Passing the result from get_pathsp=
ec() to
> this function will always give the correct number of pathspec element=
s.

And use the new function in builtin/rm.c too? A good cleanup while
you're touching cmd_rm()..
--=20
Duy
