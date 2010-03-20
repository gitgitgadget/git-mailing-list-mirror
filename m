From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/5] tag -v: use =?utf-8?q?=E2=80=98git_verify-tag=E2=80=99_without?= dash
Date: Sat, 20 Mar 2010 17:01:16 +0100
Message-ID: <201003201701.16820.j6t@kdbg.org>
References: <20100320050953.GA24746@progeny.tock> <20100320051148.GA24791@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Carlos Rica <jasampler@gmail.com>,
	Santi =?iso-8859-1?q?B=E9jar?= <santi@agolina.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 20 17:03:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nt191-00038W-8t
	for gcvg-git-2@lo.gmane.org; Sat, 20 Mar 2010 17:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235Ab0CTQDS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 20 Mar 2010 12:03:18 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:24630 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753003Ab0CTQDR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Mar 2010 12:03:17 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B07502C400D;
	Sat, 20 Mar 2010 17:03:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id E639419F5C0;
	Sat, 20 Mar 2010 17:01:16 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <20100320051148.GA24791@progeny.tock>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142722>

On Samstag, 20. M=E4rz 2010, Jonathan Nieder wrote:
> -	const char *argv_verify_tag[] =3D {"git-verify-tag",
> +	const char *argv_verify_tag[] =3D {"git", "verify-tag",
>  					"-v", "SHA1_HEX", NULL};
> -	argv_verify_tag[2] =3D sha1_to_hex(sha1);
> +	argv_verify_tag[3] =3D sha1_to_hex(sha1);
>
>  	if (run_command_v_opt(argv_verify_tag, 0))
>  		return error("could not verify the tag '%s'", name);

This should rather be changed to run_command_v_opt(..., RUN_GIT_CMD). S=
ee=20
other examples in the code.

Oh, you remove this in a later patch. Then why have this patch at all?

-- Hannes
