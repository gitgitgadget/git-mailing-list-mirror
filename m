From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 3/5] Move offset_1st_component() to path.c
Date: Tue, 16 Feb 2010 20:47:49 +0100
Message-ID: <4B7AF665.5030207@kdbg.org>
References: <1266162285-10955-1-git-send-email-pclouds@gmail.com> <1266162285-10955-3-git-send-email-pclouds@gmail.com> <4B79A3ED.4090308@kdbg.org> <20100216052208.GA18438@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Sm/Do28gQ2FybG9zIE1lbmRlcyBMdcOtcw==?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 20:48:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhTP8-0001ZK-UD
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 20:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091Ab0BPTsH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 14:48:07 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:24626 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756994Ab0BPTsF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 14:48:05 -0500
Received: from [77.117.240.139] (77.117.240.139.wireless.dyn.drei.com [77.117.240.139])
	by bsmtp.bon.at (Postfix) with ESMTP id AC21CCDF84;
	Tue, 16 Feb 2010 20:47:55 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100216052208.GA18438@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140150>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>   > is_dir_sep() or even use your previous implementation of is_root_=
path=20
>   > (because this implementation is a bit cryptic).
>   >
>   > But if the new callers of this function will only pass the result=
s of=20
>   > normalize_path_copy() and getcwd() (both return only forward-slas=
hes on=20
>   > Windows), then I'm fine with this version. Do they?
>=20
>   They do. But future-proofing can never be a bad thing.

Thanks, but...

> +int offset_1st_component(const char *path)
> +{
> +	int len =3D 0;
> +	if (has_dos_drive_prefix(path))
> +		len +=3D 2;
> +	if (is_dir_sep(path[len]))
> +		return len++;

oops, does this work at all for you? You must not have 'return' here.

> +	return len;
> +}

-- Hannes
