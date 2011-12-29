From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH] Submodules always use a relative path to gitdir
Date: Thu, 29 Dec 2011 23:48:41 +0100
Message-ID: <CAJmizVZ_n9KmKWwDeLuYxBTWvndh5cTcvUbFduOtEcOPL=_WeQ@mail.gmail.com>
References: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Antony Male <antony.male@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 29 23:49:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RgOmS-0004RO-Kx
	for gcvg-git-2@lo.gmane.org; Thu, 29 Dec 2011 23:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785Ab1L2Wso convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Dec 2011 17:48:44 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:56267 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754742Ab1L2Wsn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Dec 2011 17:48:43 -0500
Received: by wibhm6 with SMTP id hm6so6597656wib.19
        for <git@vger.kernel.org>; Thu, 29 Dec 2011 14:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w2Cru6wjBIxsNInwPD8rgPcvSdBmkCFzbO6EdPLJ7Y4=;
        b=kHBqoGlnV6n5DjaiEwDN8I45+Xzm7XBMny1GlorX/wNmshVA48JYRoCvig7K2dW7Uv
         giUAXI5NNVCze1sXdtvkCe1ZjFolMJU2uaVmf+lVJa4xRgyAnOeMB4Tuehb7H7gza71l
         NEm+3XID7VScZ7BMQwDKjqwOKtQHIkN30BEw0=
Received: by 10.181.12.43 with SMTP id en11mr81891528wid.6.1325198922017; Thu,
 29 Dec 2011 14:48:42 -0800 (PST)
Received: by 10.227.197.205 with HTTP; Thu, 29 Dec 2011 14:48:41 -0800 (PST)
In-Reply-To: <1325192426-10103-1-git-send-email-antony.male@gmail.com>
X-Google-Sender-Auth: AuMsWk09qhALDhRPbOdNLC4j4BI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187787>

2011/12/29 Antony Male <antony.male@gmail.com>:
<snip>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die "$(eval_ge=
ttext "Clone of '\$url' into submodule path '\$path' failed")"
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
> + =C2=A0 =C2=A0 =C2=A0 echo "gitdir: $rel_gitdir" >"$path/.git"

This will replace an already created file. Is it really the best
solution to create a gitfile with an absolute path and after that
replace it with a relative path. Why not write the relative path from
the beginning?

The patch also breaks two tests:
t7406 and t5526.

Regards
=46redrik
