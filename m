From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: move highlight config out of guess_file_syntax()
Date: Mon, 26 Jul 2010 22:48:34 +0200
Message-ID: <201007262248.35341.jnareb@gmail.com>
References: <1280000767-31895-1-git-send-email-asedeno@mit.edu> <201007260135.35059.jnareb@gmail.com> <4C4CCE60.1080301@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Alejandro R. =?utf-8?q?Sede=C3=B1o?=" <asedeno@mit.edu>
X-From: git-owner@vger.kernel.org Mon Jul 26 22:49:08 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdUbk-0008JJ-9K
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 22:49:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab0GZUtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Jul 2010 16:49:00 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:37157 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917Ab0GZUtA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 16:49:00 -0400
Received: by fxm14 with SMTP id 14so317809fxm.19
        for <git@vger.kernel.org>; Mon, 26 Jul 2010 13:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=1k3ZD5fzOqzsk9m41mjWhGjTwTn5SczwdBZelEo/YF8=;
        b=lMHJjTGLkXSQeK3edV2ZDiiu5QA+ZAiU6MF1FBEXe9N6hbbI2UUbBbg8MiShbpYPrP
         9fBGB40zv5W6W3UCPoVGRPgwSqzAKsEPtw6ukS080GdSEJe4Sau/2qcnvuVn+dETciKk
         ip9KkXsZjwjsI9okDItArfZEedXpPQYGEpsjA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=FqLDtKQVRaOGVLIbQwoJuq6QkBv+580oyg4HdsCSgWOVdO87gN1I7mjh3WDbf8ZlNW
         TRsOP7k8n/SBhicCzMcskMa0Dgbgr1ZaaFTxf9SHUe7jKJegRn+4SwUn5oAEFHNrTIiB
         JDJGSbWBw6IirJiy2IzFE2kqizFa99Np13Dqo=
Received: by 10.223.126.84 with SMTP id b20mr6886372fas.98.1280177338664;
        Mon, 26 Jul 2010 13:48:58 -0700 (PDT)
Received: from [192.168.1.13] (abwn25.neoplus.adsl.tpnet.pl [83.8.237.25])
        by mx.google.com with ESMTPS id b9sm1594943faq.7.2010.07.26.13.48.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 26 Jul 2010 13:48:49 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <4C4CCE60.1080301@mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151894>

On Mon, 26 Jul 2010, Alejandro R. Sede=C3=B1o wrote:
> On 7/25/2010 7:35 PM, Jakub Nar=C4=99bski wrote:

> > BTW. is this something _you_ needed (and what did you need to confi=
gure
> > / to put in $GITWEB_CONFIG file), or just a generalization?
>=20
>=20
> This is something I was using in previous versions of gitweb, though
> with the older (pre-592ea41) syntax. (I had applied the older
> highlighting patches, and was quite happy to see them merged.)
>=20
> Before, $GITWEB_CONFIG contained lines like:
>=20
>   $highlight_type{'\.lisp$'} =3D 'lisp';
>=20
> As of 1.7.2, with syntax highlighting merged and refactored (592ea41)=
,
> access to the hashes that define syntax highlighting mappings was los=
t.
> Moving the hashes out into the config area lets $GITWEB_CONFIG contai=
n
> lines like:
>=20
>   $highlight_ext{'lisp'} =3D 'lisp';
>   $highlight_basename{'GNUmakefile'} =3D 'mak';

O.K., I don't think we want to put all possible languages that 'highlig=
ht'
supports in %highlight_ext, so you might want to add support for less
common languages, or languages introduced in newer versions of tool.


Note that you can write here

    $highlight_basename{'GNUmakefile'} =3D 'make';

which might be slightly more readable.

--=20
Jakub Narebski
Poland
