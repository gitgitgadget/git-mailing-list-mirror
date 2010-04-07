From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] gitk: refresh index before checking for local
 changes
Date: Tue, 6 Apr 2010 20:16:48 -0500
Message-ID: <20100407011647.GA24187@progeny.tock>
References: <l2hc6c947f61004061557x8085600fif5e973077d9eb4f3@mail.gmail.com>
 <20100406233601.GA27533@progeny.tock>
 <n2kc6c947f61004061647ybb6c2f55zc70197362764ef8@mail.gmail.com>
 <20100407004353.GA11346@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Markus Heidelberg <markus.heidelberg@web.de>,
	Avery Pennarun <apenwarr@gmail.com>
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 03:17:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzJt9-00025E-4j
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 03:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372Ab0DGBQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 21:16:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56843 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932370Ab0DGBQ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 21:16:57 -0400
Received: by pwj9 with SMTP id 9so504407pwj.19
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 18:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=e0HsMDqg7yZTI4LpLqHqMw8nCxyREgLghE78v6Yvh0o=;
        b=MeRkgu916ej26xuz7l9+rk87BeNV3jrLcIAqClBaB0SX4gKmCMNvpj5gfoX4Lt5Vxu
         qcJ/F7B0C2xFN6E9KMgFebiHa/REpVb5NXHMrpfQHvyizKvUtMxqFgvj89pHefTI3D4e
         zONmmGmM00vV9ERaGAvCs1/Aq1gL0WsZ0T1MQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=NekhIHxkj+S3zTo3TEkm7Duht5VcTo6gg5q+Tfr1FvrGYLM5sNy5P2+fMAAJOLgbQu
         9yLYL+jetlHxKAUE2r11C49MvvSymd9E0hToUYJHURyuAwLA/hRXS2Uf1mqJ53TKcLAH
         jqqBofq9bTvDVSmin+xUueRUXh2qASt9IfJl4=
Received: by 10.140.56.16 with SMTP id e16mr6395015rva.143.1270603016626;
        Tue, 06 Apr 2010 18:16:56 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id g14sm2886761rvb.23.2010.04.06.18.16.54
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 06 Apr 2010 18:16:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100407004353.GA11346@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144186>

Hi,

I=E2=80=99ll start off the reviewing, too:

Jonathan Nieder wrote:

> +    if {![eof $fd]} {
> +        return 1

Whitespace damage.

> @@ -7504,13 +7540,9 @@ proc getblobdiffs {ids} {
>      global git_version
> =20
>      set textconv {}
> -    if {[package vcompare $git_version "1.6.1"] >=3D 0} {
> -	set textconv "--textconv"
> -    }
> +    set textconv "--textconv"
>      set submodule {}
> -    if {[package vcompare $git_version "1.6.6"] >=3D 0} {
> -	set submodule "--submodule"
> -    }
> +    set submodule "--submodule"
>      set cmd [diffcmd $ids "-p $textconv $submodule  -C --cc --no-com=
mit-id -U$diffcontext"]
>      if {$ignorespace} {
>  	append cmd " -w"

What does this have to do with the topic at hand?  (Sorry, I lumped
in a local fix that still needs to be generalized and submitted
separately.)

So this patch is in good enough shape to try out, but please ping me
for a new one before it is time to send something like it on to the
masses.

Sorry for the noise,
Jonathan
