From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v3 3/5] Move offset_1st_component() to path.c
Date: Mon, 15 Feb 2010 20:43:41 +0100
Message-ID: <4B79A3ED.4090308@kdbg.org>
References: <1266162285-10955-1-git-send-email-pclouds@gmail.com> <1266162285-10955-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Sm/Do28gQ2FybG9zIE1lbmRlcyBMdcOtcw==?= 
	<jonny@jonny.eng.br>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 20:44:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nh6rO-0004Rx-QK
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 20:43:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271Ab0BOTnx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 14:43:53 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:30529 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756246Ab0BOTnw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 14:43:52 -0500
Received: from [77.119.192.246] (77.119.192.246.wireless.dyn.drei.com [77.119.192.246])
	by bsmtp.bon.at (Postfix) with ESMTP id D67861000B;
	Mon, 15 Feb 2010 20:43:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <1266162285-10955-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140026>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
> +int offset_1st_component(const char *path)
> +{
> +	if (has_dos_drive_prefix(path))
> +		return 2 + (path[2] =3D=3D '/');
> +	return *path =3D=3D '/';
> +}

I'd have expected that you future-proofed this function by using=20
is_dir_sep() or even use your previous implementation of is_root_path=20
(because this implementation is a bit cryptic).

But if the new callers of this function will only pass the results of=20
normalize_path_copy() and getcwd() (both return only forward-slashes on=
=20
Windows), then I'm fine with this version. Do they?

-- Hannes
