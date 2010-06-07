From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 1/2] Add infrastructure for translating Git with gettext
Date: Mon, 7 Jun 2010 12:02:58 +0200
Message-ID: <201006071203.00737.jnareb@gmail.com>
References: <1275846453-3805-1-git-send-email-avarab@gmail.com> <1275846453-3805-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff Epler <jepler@unpythonic.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 12:03:20 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLZAt-0006N7-SD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 12:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537Ab0FGKDO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 06:03:14 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34888 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755197Ab0FGKDN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jun 2010 06:03:13 -0400
Received: by fxm8 with SMTP id 8so1906342fxm.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 03:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=vP97ZBK9C96bl6W9ewDvtVDwkv2LRh1yY27tZ7a+18M=;
        b=qcKUAbrriRfzjCtKBNHNKkJOt+ZfpndYVnK38gMKpixRx+9Y21LCwD9cBqxS+/j+03
         1vwUKmGP0X+pTcxgNyddB5NJsA0JUY9ujoCFQ9z9u2smiEHvuGB11vZp1PUGpaNpbE2S
         fd7kOZ0LXk4RQ6uoINJc5tZEg5H9DrtA87PxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=dNy6VApqeqkns2FNdj4SYMG7pmny+aki5scORy03nKtPx1wN3GxF72fMf2COfQyw9C
         dGe/qroUUfcoKzjl9vqdvnSWqWgJ9hA4ANHg0WSgkGGfVny0S061iBkQ74fB3AdM5VXk
         2b2hEnaGpggtxRjmeCQ7TOTY4bNAnuHczZeOU=
Received: by 10.87.68.7 with SMTP id v7mr22392166fgk.71.1275904991701;
        Mon, 07 Jun 2010 03:03:11 -0700 (PDT)
Received: from [192.168.1.15] (abwb99.neoplus.adsl.tpnet.pl [83.8.225.99])
        by mx.google.com with ESMTPS id h2sm5781734fkh.25.2010.06.07.03.03.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 07 Jun 2010 03:03:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <1275846453-3805-2-git-send-email-avarab@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148589>

On Sun, 6 Jun 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> diff --git a/INSTALL b/INSTALL
> index 61086ab..f30d5bd 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -93,6 +93,14 @@ Issues of note:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0history graphi=
cally, and in git-gui. =C2=A0If you don't want gitk or
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0git-gui, you c=
an use NO_TCLTK.
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- The GNU "libintl" librar=
y is used by default for localizing
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0Git. It needs a get=
text.h on the system for C code, gettext.sh
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =C2=A0for shell scripts, =
and libintl-perl for Perl programs.

I think this addresses my concern about mentioning libintl-perl.

--=20
Jakub Narebski
Poland
